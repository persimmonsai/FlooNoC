#!/usr/bin/env python3
# Copyright 2023 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Author: Tim Fischer <fischeti@iis.ee.ethz.ch>

from typing import List, Tuple

# package for graph management and visualization
import networkx as nx

from copy import deepcopy

class Graph(nx.DiGraph): # pylint: disable=too-many-public-methods
    """Network graph class."""

    def __init__(self):
        """Initialize the graph."""
        super().__init__()
        self._node_idx = 0

    def add_node(self, node_for_adding: str, **attr):
        """Add a node to the graph."""
        if self.has_node(node_for_adding):
            raise ValueError(f"Node {node_for_adding} already exists in the graph.")
        assert "type" in attr, "Node type not provided"
        if "obj" not in attr:
            attr["obj"] = None
        super().add_node(node_for_adding, **attr)

    def add_edge(self, u_of_edge: str, v_of_edge: str, **attr):
        """Add an edge to the graph."""
        if self.has_edge(u_of_edge, v_of_edge):
            raise ValueError(
                f"Edge ({u_of_edge}, {v_of_edge}) already exists in the graph."
            )
        assert "type" in attr, "Edge type not provided"
        if "obj" not in attr:
            attr["obj"] = None
        super().add_edge(u_of_edge, v_of_edge, **attr)

    def add_edge_bidir(self, u_of_edge: str, v_of_edge: str, **attr):
        """Add a bidirectional edge to the graph."""
        self.add_edge(u_of_edge, v_of_edge, **attr)
        self.add_edge(v_of_edge, u_of_edge, **attr) # pylint: disable=arguments-out-of-order

    def get_node_obj(self, node):
        """Return the node object."""
        return self.nodes[node]["obj"]

    def set_node_obj(self, node, obj):
        """Set the node object."""
        self.nodes[node]["obj"] = obj

    def get_node_arr_idx(self, node):
        """Return the node array index."""
        return self.nodes[node]["arr_idx"]

    def get_node_lvl(self, node):
        """Return the node level."""
        return self.nodes[node]["lvl"]

    def get_edge_obj(self, edge):
        """Return the edge object."""
        return self.edges[edge]["obj"]

    def set_edge_obj(self, edge, obj):
        """Set the edge object."""
        self.edges[edge]["obj"] = obj

    def is_rt_node(self, node):
        """Return whether the node is a router node."""
        return self.nodes[node]["type"] == "router"

    def is_ep_node(self, node):
        """Return whether the node is an endpoint node."""
        return self.nodes[node]["type"] == "endpoint"

    def is_ni_node(self, node):
        """Return whether the node is an ni node."""
        return self.nodes[node]["type"] == "network_interface"

    def is_prot_edge(self, edge):
        """Return whether the edge is a protocol edge."""
        return self.edges[edge]["type"] == "protocol"

    def is_link_edge(self, edge):
        """Return whether the edge is a link edge."""
        return self.edges[edge]["type"] == "link"

    def get_nodes(self, filters=None, with_name=False):
        """Filter the nodes from the graph."""
        nodes = self.nodes
        if filters is not None:
            for flt in filters: # Can be list of method to filter only node that satisfy condition
                nodes = list(filter(flt, nodes)) # Loop through all node and checking for the condition in flt. flt is a function
        if with_name:
            return [(node, self.get_node_obj(node)) for node in nodes]
        return [self.get_node_obj(node) for node in nodes]

    def get_edges(self, filters=None, with_name=False):
        """Filter the edges from the graph."""
        edges = self.edges
        if filters is not None:
            for flt in filters:
                edges = list(filter(flt, edges))
        if with_name:
            return [(edge, self.get_edge_obj(edge)) for edge in edges]
        return [self.get_edge_obj(edge) for edge in edges]

    def get_edges_from(self, node, filters=None, with_name=False):
        """Return the outgoing edges from the node."""
        if filters is None:
            filters = []
        filters.append(lambda e: e[0] == node)
        return self.get_edges(filters=filters, with_name=with_name)

    def get_edges_to(self, node, filters=None, with_name=False):
        """Return the incoming edges to the node."""
        if filters is None:
            filters = []
        filters.append(lambda e: e[1] == node)
        return self.get_edges(filters=filters, with_name=with_name)

    def get_edges_of(self, node, filters=None, with_name=False):
        """Return the edges of the node."""
        if filters is None:
            filters = []
        filters.append(lambda e: node in e)
        return self.get_edges(filters=filters, with_name=with_name)

    def get_ni_nodes(self, with_name=False):
        """Return the ni nodes."""
        return self.get_nodes(filters=[self.is_ni_node], with_name=with_name)

    def get_rt_nodes(self, with_name=False):
        """Return the router nodes."""
        return self.get_nodes(filters=[self.is_rt_node], with_name=with_name)

    def get_ep_nodes(self, with_name=False):
        """Return the endpoint nodes."""
        return self.get_nodes(filters=[self.is_ep_node], with_name=with_name)
    
    # ni_name_type=True : return NI name when with_name=True
    # ni_name_type=False : return EndPoint name when with_name=True
    def get_ep_eject_nodes(self, with_name=False, ni_name_type=False):
        rt_nodes = self.get_rt_nodes()
        ep_eject_nodes = list()
        ep_eject_ni = list()
        """Return whether the node is an endpoint node and it's not connected on Eject port of routing"""
        for rt in rt_nodes:
            rt_obj = self.get_node_obj(rt.name)
            ep_tmp = None
            if rt_obj.incoming.EJECT.source is not None:
                ep_eject_obj = self.get_node_obj(rt_obj.incoming.EJECT.source)
                if ep_eject_obj.mgr_narrow_port is not None:
                    ep_tmp = ep_eject_obj.mgr_narrow_port.source
                elif ep_eject_obj.mgr_wide_port is not None:
                    ep_tmp = ep_eject_obj.mgr_wide_port.source
                elif ep_eject_obj.sbr_narrow_port is not None:
                    ep_tmp = ep_eject_obj.sbr_narrow_port.dest
                elif ep_eject_obj.sbr_wide_port is not None:
                    ep_tmp = ep_eject_obj.sbr_wide_port.dest
                if ep_tmp is None:
                    raise ValueError(f"Eject port of {rt.name} have endpoint, but no connection!")
                ep_eject_nodes.append(ep_tmp)
                ep_eject_ni.append(rt_obj.incoming.EJECT.source)
            elif rt_obj.outgoing.EJECT.dest is not None:
                ep_eject_obj = self.get_node_obj(rt_obj.incoming.EJECT.dest)
                if ep_eject_obj.mgr_narrow_port is not None:
                    ep_tmp = ep_eject_obj.mgr_narrow_port.dest
                elif ep_eject_obj.mgr_wide_port is not None:
                    ep_tmp = ep_eject_obj.mgr_wide_port.dest
                elif ep_eject_obj.sbr_narrow_port is not None:
                    ep_tmp = ep_eject_obj.sbr_narrow_port.source
                elif ep_eject_obj.sbr_wide_port is not None:
                    ep_tmp = ep_eject_obj.sbr_wide_port.source
                if ep_tmp is None:
                    raise ValueError(f"Eject port of {rt.name} have endpoint, but no connection!")
                ep_eject_nodes.append(ep_tmp)
                ep_eject_ni.append(rt_obj.incoming.EJECT.dest)
        if with_name:
            node_obj = list()
            for node in ep_eject_nodes:
                node_obj.append(self.get_node_obj(node))
            #return [(node, self.get_node_obj(node)) for node in ep_eject_nodes]
            if ni_name_type:
                node_name = ep_eject_ni
            else:
                node_name = ep_eject_nodes
            return node_name, node_obj
        return [self.get_node_obj(node) for node in ep_eject_nodes]

    def get_prot_edges(self, with_name=False):
        """Return the protocol edges."""
        return self.get_edges(filters=[self.is_prot_edge], with_name=with_name)

    def get_link_edges(self, with_name=False):
        """Return the link edges."""
        return self.get_edges(filters=[self.is_link_edge], with_name=with_name)

    def get_nodes_from_range(self, node: str, rng: List[Tuple[int]]):
        """Return the nodes from the range."""
        nodes = []
        match rng:
            # 2D range
            case [(start1, end1), (start2, end2)]:
                for x in range(start1, end1 + 1):
                    for y in range(start2, end2 + 1):
                        node_name = f"{node}_{x}_{y}"
                        if self.has_node(node_name):
                            nodes.append(node_name)
                        else:
                            raise ValueError(f"Node {node_name} does not exist")
            # 1D range
            case [(start, end)]:
                for i in range(start, end + 1):
                    node_name = f"{node}_{i}"
                    if self.has_node(node_name):
                        nodes.append(node_name)
                    else:
                        raise ValueError(f"Node {node_name} does not exist")
            case _:
                raise NotImplementedError(f"Unsupported range {rng}")
        return nodes

    def get_nodes_from_idx(self, node: str, idx: List[int]):
        """Return the nodes from the index."""
        node_name = f"{node}_{'_'.join([str(i) for i in idx])}"
        if self.has_node(node_name):
            return [node_name]
        raise ValueError(f"Node {node_name} does not exist")

    def get_nodes_from_lvl(self, node: str, lvl: int):
        """Return the nodes from the level."""
        nodes = self.get_nodes(
            filters=[lambda n: n.startswith(node), lambda n: self.nodes[n]["lvl"] == lvl],
            with_name=True,
        )
        return [name for name, _ in nodes]

    def add_nodes_as_tree(
        self,
        parent: str,
        tree: List[int],
        node_type: str,
        edge_type: str,
        lvl: int=0,
        node_obj=None,
        edge_obj=None,
        connect=True,
    ):  # pylint: disable=too-many-arguments
        """Add nodes as a tree."""
        if lvl == len(tree):
            return
        for i in range(tree[lvl]):
            node = f"{parent}_{i}"
            self.add_node(node, type=node_type, lvl=lvl, obj=node_obj)
            if connect and lvl > 0:
                self.add_edge(parent, node, type=edge_type, obj=edge_obj)
                self.add_edge(node, parent, type=edge_type, obj=edge_obj)
            self.add_nodes_as_tree(
                node, tree, node_type, edge_type, lvl + 1, node_obj, edge_obj, connect
            )

    def add_nodes_as_array(
        self,
        name: str,
        array: Tuple[int],
        node_type: str,
        edge_type: str = "",
        node_obj=None,
        edge_obj=None,
        connect=True,
    ): # pylint: disable=too-many-arguments
        """Add nodes as an array."""
        if node_type=="endpoint" and node_obj.is_compute_tile:
            tile_id = node_obj.start_tile_id
        match array:
            case [n]:
                for i in range(n):
                    node = f"{name}_{i}"
                    if node_type=="endpoint" and node_obj.is_compute_tile:
                        node_obj = deepcopy(node_obj)
                        node_obj.tile_id = tile_id
                        tile_id += 1
                    self.add_node(node, type=node_type, arr_idx=(i,), obj=node_obj)
                    if i > 0 and connect:
                        self.add_edge(node, f"{name}_{i-1}", type=edge_type, obj=edge_obj)
                        self.add_edge(f"{name}_{i-1}", node, type=edge_type, obj=edge_obj)
            case [n, m]:
                for i in range(n):
                    for j in range(m):
                        node = f"{name}_{i}_{j}"
                        if node_type=="endpoint" and node_obj.is_compute_tile:
                            node_obj = deepcopy(node_obj)
                            node_obj.tile_id = tile_id
                            tile_id += 1
                        self.add_node(node, type=node_type, arr_idx=(i, j), obj=node_obj)
                        if i > 0 and connect:
                            self.add_edge(
                                node, f"{name}_{i-1}_{j}", type=edge_type, obj=edge_obj
                            )
                            self.add_edge(
                                f"{name}_{i-1}_{j}", node, type=edge_type, obj=edge_obj
                            )
                        if j > 0 and connect:
                            self.add_edge(
                                node, f"{name}_{i}_{j-1}", type=edge_type, obj=edge_obj
                            )
                            self.add_edge(
                                f"{name}_{i}_{j-1}", node, type=edge_type, obj=edge_obj
                            )
            case _:
                raise NotImplementedError(f"Unsupported array {array}")

    def create_unique_ep_id(self, node) -> int:
        """Return the endpoint id."""
        ep_nodes = [name for name, _ in self.get_ep_nodes(with_name=True)]
        return sorted(ep_nodes).index(node)


    def get_node_id(self, node):
        """Return the node id."""
        return self.nodes[node]["id"]
