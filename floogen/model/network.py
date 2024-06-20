#!/usr/bin/env python3
# Copyright 2023 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Author: Tim Fischer <fischeti@iis.ee.ethz.ch>

import pathlib
from typing import Optional, List, ClassVar
from importlib.resources import files, as_file

import networkx as nx
import matplotlib.pyplot as plt
from mako.lookup import Template
from pydantic import BaseModel, ConfigDict, field_validator, model_validator

from floogen.model.routing import Routing, RouteAlgo, RouteMapRule, RouteRule, RouteMap, RouteTable
from floogen.model.routing import Coord, SimpleId, AddrRange
from floogen.model.graph import Graph
from floogen.model.endpoint import EndpointDesc, Endpoint
from floogen.model.router import RouterDesc, NarrowWideRouter, NarrowWideXYRouter
from floogen.model.connection import ConnectionDesc
from floogen.model.link import NarrowWideLink, XYLinks, NarrowLink
from floogen.model.network_interface import NarrowWideAxiNI
from floogen.model.protocol import AXI4, AXI4Bus
from floogen.utils import clog2, idx_to_sv_idx
import floogen.templates

from copy import deepcopy

class Network(BaseModel):  # pylint: disable=too-many-public-methods
    """
    Network class to describe a network with routers and endpoints.
    """

    model_config = ConfigDict(arbitrary_types_allowed=True)

    # Template for compute_tile_gen=False
    with as_file(files(floogen.templates).joinpath("floo_noc_top.sv.mako")) as _tpl_path:
        tpl: ClassVar = Template(filename=str(_tpl_path))
    
    # Template for compute_tile_gen=True
    with as_file(files(floogen.templates).joinpath("floo_noc_top_compute_tile.sv.mako")) as _tpl_path:
        tpl_top: ClassVar = Template(filename=str(_tpl_path))
    
    with as_file(files(floogen.templates).joinpath("compute_tile.sv.mako")) as _tpl_path:
        tpl_tile: ClassVar = Template(filename=str(_tpl_path))  
    
    with as_file(files(floogen.templates).joinpath("floo_noc_pd_top.sv.mako")) as _tpl_path:
        tpl_noc_pd: ClassVar = Template(filename=str(_tpl_path))  

    with as_file(files(floogen.templates).joinpath("floo_flit_pkg.sv.mako")) as _tpl_path:
        tpl_pkg: ClassVar = Template(filename=str(_tpl_path))
    
    with as_file(files(floogen.templates).joinpath("util_soc_config.py.mako")) as _tpl_path:
        tpl_util_job: ClassVar = Template(filename=str(_tpl_path))
    
    with as_file(files(floogen.templates).joinpath("tb_floo_compute_tile_array.sv.mako")) as _tpl_path:
        tpl_tb: ClassVar = Template(filename=str(_tpl_path))
        
    with as_file(files(floogen.templates).joinpath("floo_testharness.sv.mako")) as _tpl_path:
        tpl_testharness: ClassVar = Template(filename=str(_tpl_path))
    
    with as_file(files(floogen.templates).joinpath("tb_compute_tile_array_test_pkg.sv.mako")) as _tpl_path:
        tpl_tb_pkg: ClassVar = Template(filename=str(_tpl_path)) 

    name: str
    description: Optional[str]
    compute_tile_gen : Optional[bool] = False
    num_snitch_core : Optional[int] = 9
    
    protocols: List[AXI4]
    endpoints: List[EndpointDesc]
    routers: List[RouterDesc]
    connections: List[ConnectionDesc]
    graph: Optional[Graph] = None
    routing: Routing

    def create_network(self):
        """Initialize the network as a graph."""
        self.graph = Graph()
        self.create_routers()
        self.create_endpoints()
        self.create_connections()

    def compile_network(self):
        """Compile the network."""
        self.compile_ids()
        self.compile_links()
        self.compile_endpoints() # May need to edit to create temp AXI4Bus object for is_sub_addr endpoint
        self.compile_nis()
        self.compile_routers()

    @field_validator("endpoints")
    @classmethod
    def validate_endpoints(cls, endpoints):
        """Check that endpoint names are unique."""
        names = set()
        for ep in endpoints:
            if ep.name in names:
                raise ValueError("Endpoint names must be unique")
            names.add(ep.name)
        return endpoints

    @field_validator("routers")
    @classmethod
    def validate_routers(cls, routers):
        """Check that router ids are unique."""
        names = set()
        for rt in routers:
            if rt.name in names:
                raise ValueError("router names must be unique")
            names.add(rt.name)
        return routers

    @field_validator("protocols")
    @classmethod
    def validate_addr_width(cls, protocols):
        """Check that all protocols have the same address width."""
        addr_widths = [prot.addr_width for prot in protocols]
        if len(set(addr_widths)) != 1:
            raise ValueError("All protocols must have the same address width")
        return protocols

    @model_validator(mode="after")
    def set_addr_width(self):
        """Set the address width of the network."""
        self.routing.addr_width = self.protocols[0].addr_width
        return self

    def create_routers(self):
        """Create the routers in the network."""

        for rt_desc in self.routers:
            # handle single router
            match (rt_desc.array, rt_desc.tree):
                # Single router case
                case (None, None):
                    self.graph.add_node(rt_desc.name, obj=rt_desc, type="router")
                # 2D mesh case
                case ((m, n), None):
                    self.graph.add_nodes_as_array(
                        name=rt_desc.name,
                        array=(m, n),
                        node_type="router",
                        edge_type="link",
                        node_obj=rt_desc,
                        connect=rt_desc.auto_connect,
                    )
                    # rt.id = Coord(x=x, y=y)
                # tree case
                case (None, tree_list):
                    self.graph.add_nodes_as_tree(
                        parent=rt_desc.name,
                        tree=tree_list,
                        node_type="router",
                        edge_type="link",
                        node_obj=rt_desc,
                        connect=rt_desc.auto_connect,
                    )
                # Invalid case
                case (_, _):
                    raise ValueError("Invalid router description")

    def create_endpoints(self):
        """Create the endpoints in the network."""

        for ep_desc in self.endpoints:
            # handle single endpoint
            match ep_desc.array:
                # Single endpoint case
                case None:
                    self.graph.add_node(ep_desc.name, obj=ep_desc, type="endpoint")
                    self.graph.add_node(f"{ep_desc.name}_ni", obj=ep_desc, type="network_interface")
                    if ep_desc.is_sbr():
                        self.graph.add_edge(f"{ep_desc.name}_ni", ep_desc.name, type="protocol")
                    if ep_desc.is_mgr():
                        self.graph.add_edge(ep_desc.name, f"{ep_desc.name}_ni", type="protocol")
                # 1D array case
                case (n,):
                    self.graph.add_nodes_as_array(
                        name=ep_desc.name,
                        array=(n,),
                        node_type="endpoint",
                        node_obj=ep_desc,
                        connect=False,
                    )
                    # if ep_desc.is_sub_addr==False:
                    self.graph.add_nodes_as_array(
                        name=f"{ep_desc.name}_ni",
                        array=(n,),
                        node_type="network_interface",
                        node_obj=ep_desc,
                        connect=False,
                    )
                    ep_nodes = self.graph.get_nodes_from_range(ep_desc.name, [(0, n - 1)])
                    ni_nodes = self.graph.get_nodes_from_range(f"{ep_desc.name}_ni", [(0, n - 1)])
                    if ep_desc.is_sbr():
                        for ep_node, ni_node in zip(ep_nodes, ni_nodes):
                            self.graph.add_edge(ni_node, ep_node, type="protocol")
                    if ep_desc.is_mgr():
                        for ep_node, ni_node in zip(ep_nodes, ni_nodes):
                            self.graph.add_edge(ep_node, ni_node, type="protocol")
                # 2D array case
                case (m, n):
                    self.graph.add_nodes_as_array(
                        name=ep_desc.name,
                        array=(m, n),
                        node_type="endpoint",
                        node_obj=ep_desc,
                        connect=False,
                    )
                    # if ep_desc.is_sub_addr==False:
                    self.graph.add_nodes_as_array(
                        name=f"{ep_desc.name}_ni",
                        array=(m, n),
                        node_type="network_interface",
                        node_obj=ep_desc,
                        connect=False,
                    )
                    ep_nodes = self.graph.get_nodes_from_range(
                        ep_desc.name, [(0, m - 1), (0, n - 1)]
                    )
                    ni_nodes = self.graph.get_nodes_from_range(
                        f"{ep_desc.name}_ni", [(0, m - 1), (0, n - 1)]
                    )
                    if ep_desc.is_sbr():
                        for ep_node, ni_node in zip(ep_nodes, ni_nodes):
                            self.graph.add_edge(ni_node, ep_node, type="protocol")
                    if ep_desc.is_mgr():
                        for ep_node, ni_node in zip(ep_nodes, ni_nodes):
                            self.graph.add_edge(ep_node, ni_node, type="protocol")
                # Invalid case
                case _:
                    raise ValueError("Invalid endpoint description")

    def create_connections(self):
        """Initialize the connections in the network."""
        for con in self.connections:
            # Get the source nodes
            match (con.src_idx, con.src_range, con.src_lvl):
                # Explicit node case
                case (None, None, None):
                    srcs = [con.src]
                # Get node from index
                case (idx, None, None):
                    srcs = self.graph.get_nodes_from_idx(con.src, idx)
                # Get node from range
                case (None, rng, None):
                    srcs = self.graph.get_nodes_from_range(con.src, rng)
                # Get node from level
                case (None, None, lvl):
                    srcs = self.graph.get_nodes_from_lvl(con.src, lvl)
                # Invalid case
                case (_, _, _):
                    raise ValueError("src_idx, src_range and src_lvl are mutually exclusive")

            # Get the destination nodes
            match (con.dst_idx, con.dst_range, con.dst_lvl):
                # Explicit node case
                case (None, None, None):
                    dsts = [con.dst]
                # Get node from index
                case (idx, None, None):
                    dsts = self.graph.get_nodes_from_idx(con.dst, idx)
                # Get node from range
                case (None, rng, None):
                    dsts = self.graph.get_nodes_from_range(con.dst, rng)
                # Get node from level
                case (None, None, lvl):
                    dsts = self.graph.get_nodes_from_lvl(con.dst, lvl)
                # Invalid case
                case (_, _, _):
                    raise ValueError("dst_idx, dst_range and dst_lvl are mutually exclusive")

            def get_ni_of_ep(ep):
                """Get the network interface of an endpoint."""
                if self.graph.is_ep_node(ep):
                    return self.graph.get_node_obj(ep).get_ni_name(ep)
                return ep

            srcs = [get_ni_of_ep(src) for src in srcs]
            dsts = [get_ni_of_ep(dst) for dst in dsts]

            # Add edges between the nodes
            match (len(srcs), len(dsts), con.allow_multi):
                # Normal case where srcs and dsts have the same length
                case (n_srcs, n_dsts, _) if n_srcs == n_dsts:
                    pass
                # Multi connection case where srcs is dividable by dsts
                case (n_srcs, n_dsts, True) if n_srcs % n_dsts == 0 and n_srcs > n_dsts:
                    num_multi_con = n_srcs // n_dsts
                    # Duplicate dsts
                    dsts = [dst for dst in dsts for _ in range(num_multi_con)]
                # Multi connection case where dsts is dividable by srcs
                case (n_srcs, n_dsts, True) if n_dsts % n_srcs == 0 and n_dsts > n_srcs:
                    num_multi_con = n_dsts // n_srcs
                    # Duplicate srcs
                    srcs = [src for src in srcs for _ in range(num_multi_con)]
                case (_, _, False):
                    raise ValueError(
                        "srcs and dsts must have the same length \
                        or `allow_multi` must be `True` and lengths \
                        must be dividable by each other"
                    )

            # Add edges between the nodes
            for src, dst in zip(srcs, dsts):
                self.graph.add_edge(src, dst, type="link")
                if con.bidirectional:
                    self.graph.add_edge(dst, src, type="link")

    def compile_ids(self):
        """Infer the id type from the network."""
        match self.routing.route_algo:
            case RouteAlgo.XY:
                for node_name, node in self.graph.get_nodes(with_name=True):
                    if "arr_idx" in self.graph.nodes[node_name]:
                        x, y = self.graph.get_node_arr_idx(node_name)
                    else:
                        x, y = 0, 0
                    node_id = Coord(x=x, y=y)
                    if node.id_offset is not None:
                        node_id += node.id_offset
                    self.graph.nodes[node_name]["id"] = node_id
            case RouteAlgo.ID | RouteAlgo.SRC:
                for ep_name, ep in self.graph.get_ep_nodes(with_name=True):
                    node_id = SimpleId(id=self.graph.create_unique_ep_id(ep_name))
                    if ep.id_offset is not None:
                        node_id += ep.id_offset
                    ni_name = ep.get_ni_name(ep_name)
                    self.graph.nodes[ep_name]["id"] = node_id
                    self.graph.nodes[ni_name]["id"] = node_id

    def compile_links(self):
        """Infer the link type from the network."""
        edges = self.graph.get_link_edges(with_name=True)
        for edge, _ in edges:
            # Check if link is bidirectional
            is_bidirectional = self.graph.has_edge(edge[1], edge[0])
            if not is_bidirectional:
                raise NotImplementedError(
                    "Only bidirectional links are \
                    supported yet inside the network"
                )
            # Get edge parameter
            source_type = self.graph.nodes[edge[0]]["type"]
            dest_type = self.graph.nodes[edge[1]]["type"]
            source_obj = self.graph.nodes[edge[0]]["obj"]
            dest_obj = self.graph.nodes[edge[1]]["obj"]
            source_idx = ""
            dest_idx = ""
            if source_obj.array is not None:
                source_idx = idx_to_sv_idx(self.graph.nodes[edge[0]]["arr_idx"], source_obj.array)
            if dest_obj.array is not None:
                dest_idx = idx_to_sv_idx(self.graph.nodes[edge[1]]["arr_idx"], dest_obj.array)
            # set Export NI flag to not instantiate NI on FlooNoC network
            export_ni = False
            if source_type=="network_interface":
                export_ni = source_obj.export_ni
            if dest_type=="network_interface":
                export_ni = dest_obj.export_ni or export_ni
            link = {
                "source": edge[0],
                "dest": edge[1],
                "source_type": source_type,
                "dest_type": dest_type,
                "source_name": source_obj.name,
                "dest_name": dest_obj.name,
                "source_idx": source_idx,
                "dest_idx": dest_idx,
                "is_bidirectional": is_bidirectional,
                "export_ni": export_ni,
            }
            self.graph.set_edge_obj(edge, NarrowWideLink(**link))

    def compile_routers(self):
        """Infer the router type from the network."""
        for rt_name, _ in self.graph.get_rt_nodes(with_name=True):
            match self.routing.route_algo:
                case RouteAlgo.XY:
                    rt_id = self.graph.get_node_id(rt_name)
                    incoming, outgoing = {}, {}
                    # edge is a connection link that still did't define which port of router to be connected
                    for edge in self.graph.get_edges_to(rt_name):
                        neighbor_id = self.graph.get_node_id(edge.source)
                        incoming_dir = str(Coord.get_dir(rt_id, neighbor_id))
                        if incoming_dir in incoming: # Prevent multiple node connect to the same direction
                            raise ValueError("Incoming direction is already defined")
                        incoming[incoming_dir] = edge
                    for edge in self.graph.get_edges_from(rt_name):
                        neighbor_id = self.graph.get_node_id(edge.dest)
                        outgoing_dir = str(Coord.get_dir(rt_id, neighbor_id))
                        if outgoing_dir in outgoing:
                            raise ValueError("Outgoing direction is already defined")
                        outgoing[outgoing_dir] = edge
                    router_dict = {
                        "name": rt_name,
                        "incoming": XYLinks(**incoming),
                        "outgoing": XYLinks(**outgoing),
                        "id": rt_id,
                    }
                    self.graph.set_node_obj(rt_name, NarrowWideXYRouter(**router_dict))

                case RouteAlgo.ID | RouteAlgo.SRC:
                    router_dict = {
                        "name": rt_name,
                        "incoming": self.graph.get_edges_to(rt_name),
                        "outgoing": self.graph.get_edges_from(rt_name),
                        "degree": len(set(self.graph.neighbors(rt_name))),
                        "route_algo": self.routing.route_algo,
                    }
                    self.graph.set_node_obj(rt_name, NarrowWideRouter(**router_dict))

    def compile_endpoints(self):
        """Infer the endpoint type from the network."""
        for ep_name, ep in self.graph.get_ep_nodes(with_name=True):
            # if ep.is_sub_addr:
            #     continue
            mgr_ports = []
            sbr_ports = []
            if ep.is_mgr():
                for i in ep.mgr_port_protocol:
                    prot = {}
                    protocol = [
                        p for p in self.protocols if p.name == i and p.direction == "manager"
                    ][0]
                    prot["base_name"] = f"{ep.name}_{protocol.name}"
                    prot["source"] = ep_name
                    prot["dest"] = ep.get_ni_name(ep_name)
                    if ep.array is not None:
                        prot["array"] = ep.array
                        prot["arr_idx"] = self.graph.get_node_arr_idx(ep_name)
                    protocol = AXI4Bus(**prot, **protocol.__dict__)
                    mgr_ports.append(protocol)
                self.graph.set_edge_obj((prot["source"], prot["dest"]), mgr_ports)
            if ep.is_sbr():
                for i in ep.sbr_port_protocol:
                    protocol = [
                        p for p in self.protocols if p.name == i and p.direction == "subordinate"
                    ][0]
                    prot = {}
                    prot["base_name"] = f"{ep.name}_{protocol.name}"
                    prot["source"] = ep.get_ni_name(ep_name)
                    prot["dest"] = ep_name
                    if ep.array is not None:
                        prot["array"] = ep.array
                        prot["arr_idx"] = self.graph.get_node_arr_idx(ep_name)
                    protocol = AXI4Bus(**prot, **protocol.__dict__)
                    sbr_ports.append(protocol)
                self.graph.set_edge_obj((prot["source"], prot["dest"]), sbr_ports)
            # Add endpoint object to the node
            self.graph.set_node_obj(
                ep_name, Endpoint(mgr_ports=mgr_ports, sbr_ports=sbr_ports, **ep.__dict__)
            )

    def compile_nis(self):
        """Compile the endpoints in the network."""

        for ni_name, ep_desc in self.graph.get_ni_nodes(with_name=True):
            ni_dict = {
                "name": f"{ni_name}",
                "endpoint": ep_desc,
                "routing": self.routing,
                "addr_range": ep_desc.addr_range.model_copy() if ep_desc.addr_range else None,
                "id": self.graph.get_node_id(ni_name).model_copy(),
                "is_sub_addr": ep_desc.is_sub_addr,
            }

            assert ep_desc

            match ep_desc.array:
                # Single endpoint case
                case None:
                    pass

                # 1D array case
                case (_,):
                    if self.routing.route_algo == RouteAlgo.XY:
                        raise ValueError("Use 2D arrays for XY routing")
                    node_idx = self.graph.get_node_arr_idx(ni_name)[0]
                    ni_dict["arr_idx"] = SimpleId(id=node_idx)
                    ni_dict["addr_range"] = ep_desc.addr_range.model_copy().set_idx(node_idx)

                # 2D array case
                case (_, n):
                    x, y = self.graph.get_node_arr_idx(ni_name)
                    idx = x * n + y
                    ni_dict["arr_idx"] = Coord(x=x, y=y)
                    ni_dict["addr_range"] = ep_desc.addr_range.model_copy().set_idx(idx)

                # Invalid case
                case _:
                    raise ValueError("Invalid endpoint array description")

            sbr_prot_edges = self.graph.get_edges_from(ni_name, filters=[self.graph.is_prot_edge])
            mgr_prot_edges = self.graph.get_edges_to(ni_name, filters=[self.graph.is_prot_edge])
            for protocols in sbr_prot_edges:
                for prot in protocols:
                    match prot.name:
                        case "narrow":
                            ni_dict["sbr_narrow_port"] = prot
                        case "wide":
                            ni_dict["sbr_wide_port"] = prot

            for protocols in mgr_prot_edges:
                for prot in protocols:
                    match prot.name:
                        case "narrow":
                            ni_dict["mgr_narrow_port"] = prot
                        case "wide":
                            ni_dict["mgr_wide_port"] = prot
            
            if ep_desc.is_sub_addr==False:
                ni_dict["mgr_link"] = self.graph.get_edges_from(
                    ni_name, filters=[self.graph.is_link_edge]
                )[0]
                ni_dict["sbr_link"] = self.graph.get_edges_to(
                    ni_name, filters=[self.graph.is_link_edge]
                )[0]

            self.graph.set_node_obj(ni_name, NarrowWideAxiNI(**ni_dict))

    def gen_routing_info(self):
        """Wrapper function to generate all the routing info for the network,
        for a specific routing algorithm."""
        ni_node = self.graph.get_ni_nodes()
        ni_node = [ni for ni in ni_node if ni.is_sub_addr==False]
        self.routing.num_endpoints = len(self.graph.get_ni_nodes())
        self.routing.num_id_bits = clog2(len(self.graph.get_ni_nodes()))
        match self.routing.route_algo:
            case RouteAlgo.XY:
                for info, value in self.gen_xy_routing_info().items():
                    setattr(self.routing, info, value)
            case RouteAlgo.ID:
                self.gen_router_tables()
            case RouteAlgo.SRC:
                self.gen_routes()
            case _:
                raise NotImplementedError(
                    f"Routing algorithm {self.routing.route_algo} is not supported yet"
                )
        self.routing.sam = self.gen_sam()
        # Provide the routing info to the network interfaces
        #for ni in self.graph.get_ni_nodes():
        for ni in ni_node:
            ni.routing = self.routing

    def gen_router_tables(self):
        """Generate the routing table for the network."""
        for rt in self.graph.get_rt_nodes():
            routing_table = []
            ni_sbr_nodes = [ni for ni in self.graph.get_ni_nodes() if ni.is_sbr()]
            for ni in ni_sbr_nodes:
                shortest_path = nx.shortest_path(self.graph, rt.name, ni.name)
                out_edge = (rt.name, shortest_path[1])
                out_link = self.graph.get_edge_obj(out_edge)
                out_idx = rt.outgoing.index(out_link)
                dest = SimpleId(id=out_idx)
                addr_range = AddrRange(start=ni.id.id, size=1)
                routing_table.append(RouteMapRule(dest=dest, addr_range=addr_range, desc=ni.name, \
                                                  mgr_narrow_port=ni.mgr_narrow_port, \
                                                  sbr_narrow_port=ni.sbr_narrow_port, \
                                                  mgr_wide_port=ni.mgr_wide_port, \
                                                  sbr_wide_port=ni.sbr_wide_port))

            # Add routing table to the router
            rt.table = RouteMap(name=rt.name + "_map", rules=routing_table)
            rt.table.trim()

    def gen_xy_routing_info(self):
        """Generate the XY routing info for the network."""
        ni_nodes = self.graph.get_ni_nodes()
        ni_sbr_nodes = [ni for ni in ni_nodes if ni.is_sbr()]
        min_x = min(ni.id.x for ni in ni_nodes)
        min_y = min(ni.id.y for ni in ni_nodes)
        max_x = max(ni.id.x for ni in ni_nodes)
        max_y = max(ni.id.y for ni in ni_nodes)
        max_address = max(ni.addr_range.end for ni in ni_sbr_nodes)
        xy_routing_info = {}
        xy_routing_info["num_x_bits"] = clog2(max_x - min_x + 1)
        xy_routing_info["num_y_bits"] = clog2(max_y - min_y + 1)
        xy_routing_info["addr_offset_bits"] = clog2(max_address)
        xy_routing_info["id_offset"] = Coord(x=min_x, y=min_y)
        border_id = {}
        border_id["north"] = max_y - xy_routing_info["id_offset"].y
        border_id["west"] = min_x - xy_routing_info["id_offset"].x
        border_id["south"] = min_y - xy_routing_info["id_offset"].y
        border_id["east"] = max_x - xy_routing_info["id_offset"].x
        xy_routing_info["border_id"] = border_id
        return xy_routing_info

    def gen_routes(self):
        """Generates the routes for source-based routing."""
        self.routing.num_route_bits = 0
        for ni_src in self.graph.get_ni_nodes():
            routes = []
            for ni_dst in self.graph.get_ni_nodes():
                # Skip if source and destination are the same
                # and for manager-manager and subordinate-subordinate
                # connections
                if (
                    ni_src.name == ni_dst.name
                    or (ni_src.is_only_mgr() and ni_dst.is_only_mgr())
                    or (ni_src.is_only_sbr() and ni_dst.is_only_sbr())
                ):
                    continue
                route = nx.shortest_path(self.graph, ni_src.name, ni_dst.name)
                max_route_bits = 0
                port_lst = []
                for i in range(1, len(route) - 1):
                    out_edge = (route[i], route[i + 1])
                    out_link = self.graph.get_edge_obj(out_edge)
                    rt = self.graph.get_node_obj(route[i])
                    out_port = rt.outgoing.index(out_link)
                    num_port_bits = clog2(len(rt.outgoing))
                    port_lst.append((out_port, num_port_bits))
                    max_route_bits += num_port_bits
                rule = RouteRule(route=port_lst, id=ni_dst.id, desc=f"-> {ni_dst.name}")
                routes.append(rule)
                self.routing.num_route_bits = max(self.routing.num_route_bits, max_route_bits)
            ni_src.table = RouteTable(name=ni_src.name + "_table", routes=routes)
    
    def gen_sam(self):
        """Generate the system address map, which is used by the network interfaces
        to determine the destination of a packet based on the address."""
        addr_table = []
        ni_sbr_nodes = [ni for ni in self.graph.get_ni_nodes() if ni.is_sbr()]
        for ni in ni_sbr_nodes:
            dest = ni.id
            if self.routing.id_offset is not None:
                dest -= self.routing.id_offset
            addr_range = ni.addr_range
            # addr_rule = RouteMapRule(dest=dest, addr_range=addr_range, desc=ni.name, soc_type=ni.endpoint.soc_type, name=ni.endpoint.name, \
            addr_rule = RouteMapRule(dest=dest, addr_range=addr_range, desc=ni.name, name=ni.endpoint.name, \
                                                  mgr_narrow_port=ni.mgr_narrow_port, \
                                                  sbr_narrow_port=ni.sbr_narrow_port, \
                                                  mgr_wide_port=ni.mgr_wide_port, \
                                                  sbr_wide_port=ni.sbr_wide_port)
            addr_table.append(addr_rule)
        return RouteMap(name="sam", rules=addr_table)

    # render output port of wrapper
    def render_ports(self):
        """Render the ports in the generated code."""
        # TODO: Replace filtering of ep_nodes that declared as a port by using self.get_ports()
        ports, declared_ports = [], []
        ep_nodes = self.graph.get_ep_nodes() # All endpoint node
        ep_nodes = [ep for ep in ep_nodes if ep.is_sub_addr==False]
        # Remove node that connect to Eject from the top level interface port for compute tile array structure
        if self.compute_tile_gen:
            ep_eject_nodes = self.graph.get_ep_eject_nodes()
            ep_nodes = [ep for ep in ep_nodes if ep not in ep_eject_nodes]
        
        for ep in ep_nodes:
            # Skip for port that already declared
            # There is a problem if only some node in the node array connected to eject, 
            # cause the program will not filter that out and declared full range of array interface
            if ep.name in declared_ports:
                continue
            if ep.export_ni:
                ports += ep.render_export_ni_ports()
            else:
                ports += ep.render_ports()
            declared_ports.append(ep.name)
        port_string = ",\n  ".join(ports) + "\n"
        return port_string
    
    # render output port of wrapper
    def get_ports(self):
        """Get ports list of the top level wrapper of FlooNoC system."""
        declared_ports = []
        ep_nodes = self.graph.get_ep_nodes() # All endpoint node
        ep_nodes = [ep for ep in ep_nodes if ep.is_sub_addr==False]
        # Remove node that connect to Eject from the top level interface port for compute tile array structure
        if self.compute_tile_gen:
            ep_eject_nodes = self.graph.get_ep_eject_nodes()
            ep_nodes = [ep for ep in ep_nodes if ep not in ep_eject_nodes]
        port_nodes = []
        for ep in ep_nodes:
            # Skip for port that already declared
            # There is a problem if only some node in the node array connected to eject, 
            # cause the program will not filter that out and declared full range of array interface
            if ep.name in declared_ports:
                continue
            port_nodes.append(ep)
            declared_ports.append(ep.name)
        return port_nodes
    
    # Get system parameter for export to Chipletgen
    def get_sys_param(self):
        sys_param_dict = {}
        sys_param_dict["name"] = self.name + "_floo_noc"
        sys_param_dict["xy_route_opt"] = self.routing.xy_route_opt
        sys_param_dict["x_num"] = self.routers[0].array[0]
        sys_param_dict["y_num"] = self.routers[0].array[1]
        for prot in self.protocols:
            if (prot.name=="narrow" and prot.svdirection=="input"):
                sys_param_dict["narrow_in"] = dict()
                sys_param_dict["narrow_in"]["iw"] = prot.id_width
                sys_param_dict["narrow_in"]["uw"] = prot.user_width
                sys_param_dict["narrow_in"]["dw"] = prot.data_width
                sys_param_dict["narrow_in"]["aw"] = prot.addr_width
            elif(prot.name=="narrow" and prot.svdirection=="output"):
                sys_param_dict["narrow_out"] = dict()
                sys_param_dict["narrow_out"]["iw"] = prot.id_width
                sys_param_dict["narrow_out"]["uw"] = prot.user_width
                sys_param_dict["narrow_out"]["dw"] = prot.data_width
                sys_param_dict["narrow_out"]["aw"] = prot.addr_width
            elif(prot.name=="wide" and prot.svdirection=="input"):
                sys_param_dict["wide_in"] = dict()
                sys_param_dict["wide_in"]["iw"] = prot.id_width
                sys_param_dict["wide_in"]["uw"] = prot.user_width
                sys_param_dict["wide_in"]["dw"] = prot.data_width
                sys_param_dict["wide_in"]["aw"] = prot.addr_width
            elif(prot.name=="wide" and prot.svdirection=="output"):
                sys_param_dict["wide_out"] = dict()
                sys_param_dict["wide_out"]["iw"] = prot.id_width
                sys_param_dict["wide_out"]["uw"] = prot.user_width
                sys_param_dict["wide_out"]["dw"] = prot.data_width
                sys_param_dict["wide_out"]["aw"] = prot.addr_width
        return sys_param_dict
    
    def get_export_ni_param(self):
        ni_nodes = self.graph.get_ni_nodes()
        ep_export_ni = self.get_export_ni_name()
        ni_nodes = [ni for ni in ni_nodes if ni.name in ep_export_ni]
        export_ni_dict = {}
        for ni in ni_nodes:
            ni_name = ni.endpoint.name
            actual_ni_id = ni.id - ni.routing.id_offset if ni.routing.id_offset is not None else ni.id # Convert to actual ID
            export_ni_dict[ni_name] = {}
            export_ni_dict[ni_name]["array"] = ni.endpoint.array
            export_ni_dict[ni_name]["arr_idx"] = ni.arr_idx
            export_ni_dict[ni_name]["sv_arr_idx"] = idx_to_sv_idx(ni.arr_idx, ni.endpoint.array) # Convert to SV array string
            export_ni_dict[ni_name]["id"] = {}
            export_ni_dict[ni_name]["id"]["x"] = actual_ni_id.x
            export_ni_dict[ni_name]["id"]["y"] = actual_ni_id.y
            export_ni_dict[ni_name]["id"]["name"] = ni.name + "_id"
            export_ni_dict[ni_name]["id"]["type"] = "id_t"
            export_ni_dict[ni_name]["id"]["render"] = actual_ni_id.render()
        return export_ni_dict
    
    def get_export_ni_name(self):
        ep_nodes = self.graph.get_ep_nodes() # All endpoint node
        ep_export_ni = [ep for ep in ep_nodes if ep.export_ni]
        ep_export_ni_name = []
        for ep in ep_export_ni:
            for port in ep.mgr_ports:
                if port.dest not in ep_export_ni_name:
                    ep_export_ni_name.append(port.dest)
            for port in ep.sbr_ports:
                if port.source not in ep_export_ni_name:
                    ep_export_ni_name.append(port.source)
        return ep_export_ni_name

    # Get port parameter for export to Chipletgen
    def render_prots(self):
        """Render the protocols in the generated code."""
        string = ""
        for prot_list in self.graph.get_prot_edges():
            for prot in prot_list:
                string += prot.declare()
        return string

    def render_links(self):
        """Render the links in the generated code."""
        string = ""
        links = self.graph.get_link_edges()
        if self.compute_tile_gen:
            # Remove router link to Eject endpoint link for compute tile array structure
            ep_eject_ni, _ = self.graph.get_ep_eject_nodes(with_name=True, ni_name_type=True)
            links = [li for li in links if (li.source not in ep_eject_ni) and (li.dest not in ep_eject_ni)]
            # Exclude export NI endpoint
            ep_export_ni = self.get_export_ni_name()
            links = [li for li in links if (li.source not in ep_export_ni) and (li.dest not in ep_export_ni)]
        for link in links:
            string += link.declare()
        return string

    def render_routers(self):
        """Render the routers in the generated code."""
        string = ""
        for rt in self.graph.get_rt_nodes():
            if self.compute_tile_gen:
                string += rt.render_tile(self.routing.id_offset, self.routers[0].array, self.num_snitch_core)
            else:
                string += rt.render()
        return string

    def render_nis(self):
        """Render the network interfaces in the generated code."""
        string = ""
        ni_nodes = self.graph.get_ni_nodes()
        ni_nodes = [ni for ni in ni_nodes if ni.is_sub_addr==False]
        if self.compute_tile_gen:
            # Remove NI for node that connect with Eject for compute tile array structure
            ep_eject_ni, _ = self.graph.get_ep_eject_nodes(with_name=True, ni_name_type=True)
            ni_nodes = [ni for ni in ni_nodes if ni.name not in ep_eject_ni]
            # Exclude export NI endpoint
            ep_export_ni = self.get_export_ni_name()
            ni_nodes = [ni for ni in ni_nodes if ni.name not in ep_export_ni]
        for ni in ni_nodes:
            string += ni.render(noc=self)
        return string

    def render_network(self):
        """Render the network in the generated code."""
        if self.compute_tile_gen:
            return self.tpl_top.render(noc=self)
        else:
            return self.tpl.render(noc=self)
        
    def render_tile(self):
        """Render the compute tile in the generated code."""
        return self.tpl_tile.render(noc=self)
    
    def render_noc_pd(self):
        """Render the FlooNoC PD wrapper in the generated code."""
        return self.tpl_noc_pd.render(noc=self)

    def render_link_cfg(self):
        """Render the link configuration file"""
        # Filter for user width = 0
        noc = deepcopy(self)
        for prot in noc.protocols:
            if prot.user_width==0:
                prot.user_width = 1
        
        prot_names = [prot.name for prot in noc.protocols]
        if "wide" in prot_names and "narrow" in prot_names:
            axi_type, link_type = "narrow_wide", NarrowWideLink
        else:
            axi_type, link_type = "axi", NarrowLink
        # # Add Join data type for HBM Narrow Wide Join
        # prot_join = [prot for prot in noc.protocols if prot.name=="wide" and prot.direction=="subordinate"]
        # prot_join = deepcopy(prot_join[0]) # Copy type from wide out interface
        # prot_join.name = "join" 
        # # Find maximum value of id_width between narrow out and wide out interface
        # # Which is input to floo_narrow_wide_join
        # prot_narrow_out = [prot for prot in noc.protocols if prot.name=="narrow" and prot.direction=="subordinate"]
        # prot_narrow_out = prot_narrow_out[0]
        # if prot_join.id_width > prot_narrow_out.id_width:
        #     max_id_in = prot_narrow_out.id_width
        # else:
        #     max_id_in = prot_join.id_width
        # # ID width of the resulting AXI bus
        # # To prevent the instantiation of any ID remappers,
        # # `AxiIdOutWidth` should be chosen, such that:
        # # max(`AxiNarrowIdWidth` and `AxiWideIdWidth`) == AxidOutWidth - 1
        # prot_join.id_width = max_id_in + 1
        # noc.protocols.append(prot_join) # Add new join output protocol to be generate into Package
        # Add metabuff type that is data type of routing package
        # Narrow Meta Buffer Interface
        prot_narrow_metabuff = [prot for prot in noc.protocols if prot.name=="narrow" and prot.direction=="subordinate"]
        prot_narrow_metabuff = deepcopy(prot_narrow_metabuff[0])
        prot_narrow_metabuff.name = "narrow_metabuff"
        prot_narrow_metabuff.svdirection = ""
        prot_narrow_in = [prot for prot in noc.protocols if prot.name=="narrow" and prot.direction=="manager"]
        prot_narrow_in = prot_narrow_in[0]
        if prot_narrow_metabuff.id_width < prot_narrow_in.id_width:
            prot_narrow_metabuff.id_width = prot_narrow_in.id_width
        if prot_narrow_metabuff.user_width < prot_narrow_in.user_width:
            prot_narrow_metabuff.user_width = prot_narrow_in.user_width
        noc.protocols.append(prot_narrow_metabuff)
        # Wide Meta Buffer Interface
        prot_wide_metabuff = [prot for prot in noc.protocols if prot.name=="wide" and prot.direction=="subordinate"]
        prot_wide_metabuff = deepcopy(prot_wide_metabuff[0])
        prot_wide_metabuff.name = "wide_metabuff"
        prot_wide_metabuff.svdirection = ""
        prot_wide_in = [prot for prot in noc.protocols if prot.name=="wide" and prot.direction=="manager"]
        prot_wide_in = prot_wide_in[0]
        if prot_wide_metabuff.id_width < prot_wide_in.id_width:
            prot_wide_metabuff.id_width = prot_wide_in.id_width
        if prot_wide_metabuff.user_width < prot_wide_in.user_width:
            prot_wide_metabuff.user_width = prot_wide_in.user_width
        noc.protocols.append(prot_wide_metabuff)
        return axi_type, self.tpl_pkg.render(
            name=axi_type, noc=noc, link=link_type
        )
    
    def render_util_job(self):
        """Render the util python file to generated DMA jobs of the generated network."""
        if (len(self.routers)>1):
            raise ValueError(
                "Generating soc_config.py for util jobs generation support the network that have only 1 router"
            )
        return self.tpl_util_job.render(noc=self)
    
    def render_tb_endpoint(self):
        """Render endpoints testbench in the generated code."""
        endpoints, declared_endpoints = "", []
        ep_nodes = self.graph.get_ep_nodes() # All endpoint node
        ep_nodes = [ep for ep in ep_nodes if ep.is_sub_addr==False]
        # Remove node that connect to Eject from the top level interface port for compute tile array structure
        if self.compute_tile_gen:
            ep_eject_nodes = self.graph.get_ep_eject_nodes()
            ep_nodes = [ep for ep in ep_nodes if ep not in ep_eject_nodes]

        for ep in ep_nodes:
            # Skip for port that already declared
            # There is a problem if only some node in the node array connected to eject, 
            # cause the program will not filter that out and declared full range of array interface
            if ep.name in declared_endpoints:
                continue
            if ep.is_memory_tb():
                endpoints += ep.render_tb_mem() + "\n"
            # DMA test node require each endpoint to have both active in mgr and sbr
            elif ep.sbr_port_protocol == ep.mgr_port_protocol:
                if ep.array is not None:
                    raise ValueError(
                        "The current version is not support for generating testbench for an array of non-memory endpoint"
                    )
                endpoint_id = self.graph.get_node_id(ep.name)
                endpoint_id = endpoint_id - self.routing.id_offset
                endpoints += ep.render_tb_dma(endpoint_id) + "\n"
            declared_endpoints.append(ep.name)
        return endpoints
    
    def render_testharness_endpoint(self):
        """Render endpoints testharness in the generated code."""
        endpoints, declared_endpoints = "", []
        ep_nodes = self.graph.get_ep_nodes() # All endpoint node
        ep_nodes = [ep for ep in ep_nodes if ep.is_sub_addr==False]
        # Remove node that connect to Eject from the top level interface port for compute tile array structure
        if self.compute_tile_gen:
            ep_eject_nodes = self.graph.get_ep_eject_nodes()
            ep_nodes = [ep for ep in ep_nodes if ep not in ep_eject_nodes]
        # Due to limitation of current version, only memory simulation model is supported
        #ep_nodes = [ep for ep in ep_nodes if ep.soc_type == "memory"]
        ep_nodes = [ep for ep in ep_nodes if ep.is_memory_tb()]

        for ep in ep_nodes:
            # Skip for port that already declared
            # There is a problem if only some node in the node array connected to eject, 
            # cause the program will not filter that out and declared full range of array interface
            if ep.name in declared_endpoints:
                continue
            endpoints += ep.render_testharness() + "\n"
            declared_endpoints.append(ep.name)
        return endpoints
    
    def render_tb_dut_ports(self):
        """Render the ports in the generated code."""
        ports, declared_ports = [], []
        ep_nodes = self.graph.get_ep_nodes() # All endpoint node
        ep_nodes = [ep for ep in ep_nodes if ep.is_sub_addr==False]
        # Remove node that connect to Eject from the top level interface port for compute tile array structure
        if self.compute_tile_gen:
            ep_eject_nodes = self.graph.get_ep_eject_nodes()
            ep_nodes = [ep for ep in ep_nodes if ep not in ep_eject_nodes]
        
        for ep in ep_nodes:
            # Skip for port that already declared
            # There is a problem if only some node in the node array connected to eject, 
            # cause the program will not filter that out and declared full range of array interface
            if ep.name in declared_ports:
                continue
            ports += ep.render_tb_ports()
            declared_ports.append(ep.name)
        port_string = ",\n  ".join(ports) + "\n"
        return port_string
    
    def render_tb(self):
        """Render the testbench of the generated network."""
        routers = self.graph.get_rt_nodes() # 1 Compute tile have one router
        
        ep_nodes = self.graph.get_ep_nodes() # All endpoint node
        ep_nodes = [ep for ep in ep_nodes if ep.is_sub_addr==False]
        # Remove node that connect to Eject from the top level interface port for compute tile array structure
        ep_eject_nodes = self.graph.get_ep_eject_nodes()
        ep_nodes = [ep for ep in ep_nodes if ep not in ep_eject_nodes]
        # DMA node need to have both master and slave
        endpoint_dma = [ep for ep in ep_nodes if ep.sbr_port_protocol == ep.mgr_port_protocol]
        endpoint_dma_num = 0;
        for ep in endpoint_dma:
            endpoint_dma_num += len(ep.mgr_port_protocol)
        return self.tpl_tb.render(noc=self, cp_tiles=routers, \
            endpoint_dma=endpoint_dma, endpoint_dma_num=endpoint_dma_num)
    
    def render_testharness(self):
        """Render the testbench of the generated network."""
        return self.tpl_testharness.render(noc=self)
    
    def render_tb_pkg(self):
        """Render the package testbench of the generated network."""
        return self.tpl_tb_pkg.render(noc=self)

    def visualize(self, savefig=True, filename: pathlib.Path = "network.png"):
        """Visualize the network graph."""
        ni_nodes = [name for name, _ in self.graph.get_ni_nodes(with_name=True)]
        ni_nodes = [ni for ni in ni_nodes if ni.is_sub_addr==False]
        router_nodes = [name for name, _ in self.graph.get_rt_nodes(with_name=True)]
        filtered_graph = self.graph.subgraph(ni_nodes + router_nodes) # Method from networkx
        nx.draw(filtered_graph, with_labels=True)
        if savefig:
            plt.savefig(filename)
        else:
            plt.show()
