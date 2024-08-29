#!/usr/bin/env python3
# Copyright 2023 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Author: Tim Fischer <fischeti@iis.ee.ethz.ch>
from typing import Optional, List, Union, Tuple, ClassVar
from pydantic import BaseModel, field_validator, model_validator
from importlib.resources import files, as_file
from mako.lookup import Template

from floogen.model.routing import AddrRange, Id, Coord
from floogen.model.protocol import Protocols
import floogen.templates


class EndpointDesc(BaseModel):
    """
    Endpoint class to describe an endpoint with adress ranges and configuration parameters.
    """

    name: str
    description: Optional[str] = ""
    is_sub_addr : Optional[bool] = False
    export_ni : Optional[bool] = False
    is_compute_tile : Optional[bool] = False
    is_hbm_tile : Optional[bool] = False
    array: Optional[Union[Tuple[int], Tuple[int, int]]] = None
    addr_range: Optional[AddrRange] = None
    id_offset: Optional[Id] = None
    mgr_port_protocol: Optional[List[str]] = None
    sbr_port_protocol: Optional[List[str]] = None

    @field_validator("array", mode="before")
    @classmethod
    def int_to_tuple(cls, v):
        """Convert int to tuple."""
        if isinstance(v, int):
            return (v,)
        return v

    @field_validator("id_offset", mode="before")
    @classmethod
    def dict_to_coord_obj(cls, v):
        """Convert dict to Coord object."""
        match v:
            case None:
                return None
            case {"x": x, "y": y}:
                return Coord(x=x, y=y)

    @model_validator(mode="after")
    def check_addr_range(self):
        """Check if the address range is valid."""
        # Manager-only endpoints do not need an address range
        match (self.sbr_port_protocol, self.addr_range):
            case (None, _):
                return self
            case (_, None):
                raise ValueError("Endpoint is a Subordinate and requires an address range")
        return self
    
    # @model_validator(mode="after")
    # def check_soc_type(self):
    #     """Check if soc_type is lie on support type."""
    #     if self.soc_type is not None:
    #         soc_type_list = ["cluster", "memory", "processor", "peripheral", "serial_link"]
    #         if not (self.soc_type in soc_type_list):
    #             raise ValueError("soc_type must set to one of " + str(soc_type_list))
    #     return self

    def is_sbr(self) -> bool:
        """Return true if the endpoint is a subordinate."""
        return self.sbr_port_protocol is not None

    def is_mgr(self) -> bool:
        """Return true if the endpoint is a manager."""
        return self.mgr_port_protocol is not None

    def is_only_sbr(self) -> bool:
        """Return true if the endpoint is only a subordinate."""
        return self.is_sbr() and not self.is_mgr()

    def is_only_mgr(self) -> bool:
        """Return true if the endpoint is only a manager."""
        return self.is_mgr() and not self.is_sbr()

    def get_ni_name(self, name: str) -> str:
        """Return the name of the NI."""
        return name.replace(self.name, f"{self.name}_ni")

    def render_ports(self):
        """Render the ports of the endpoint."""
        
    def render_tb(self) -> str:
        """Render endpoints of the testbench."""
        
    def render_testharness(self) -> str:
        """Render endpoints of the testharness."""


class Endpoint(EndpointDesc):
    """Endpoint class to describe an endpoint with address ranges and configuration parameters."""
    
    with as_file(files(floogen.templates).joinpath("tb_memory_model.sv.mako")) as _tpl_path:
        _tpl_tb_mem: ClassVar = Template(filename=str(_tpl_path))
       
    with as_file(files(floogen.templates).joinpath("tb_virtual_memory.sv.mako")) as _tpl_path:
        _tpl_virtual_mem: ClassVar = Template(filename=str(_tpl_path)) 
    
    with as_file(files(floogen.templates).joinpath("tb_dma_model.sv.mako")) as _tpl_path:
        _tpl_tb_dma: ClassVar = Template(filename=str(_tpl_path)) 

    mgr_ports: List[Protocols] = []
    sbr_ports: List[Protocols] = []

    @classmethod
    def from_desc(cls, desc: EndpointDesc,
                  mgr_ports: List[Protocols],
                  sbr_ports: List[Protocols]):
        """Create an endpoint from a description."""
        return cls(**desc.model_dump(), mgr_ports=mgr_ports, sbr_ports=sbr_ports)
    
    def is_memory_tb(self):
        """Check if the endpoint is memory type."""
        if (self.mgr_port_protocol is None) and (self.sbr_port_protocol is not None):
            return True
        else:
            return False

    def render_ports(self):
        """Render the ports of the endpoint."""
        ports = []
        for port in self.mgr_ports:
            ports += port.render_port()
        for port in self.sbr_ports:
            ports += port.render_port()
        return ports
    
    def render_compute_tile_ports(self, noc, port_1st_render):
        """Render the compute tile port specific of the endpoint."""
        ports = []
        # Ports that instantiate for only one time if there is any compute tile inside noc network
        if port_1st_render:
            ep_eject_nodes = noc.graph.get_ep_eject_nodes()
            ep_cp_tile_nodes = [ep for ep in ep_eject_nodes if ep.is_compute_tile]
            num_core = len(ep_cp_tile_nodes) * noc.num_snitch_core
            irq_bit_num = num_core + 1 # +1 for CVA6 core
            ports.append(f"input logic [{str(irq_bit_num-1)}:1] mtip_i")
            ports.append(f"input logic [{str(irq_bit_num-1)}:1] msip_i")
        return ports
        
    def render_hbm_tile_ports(self, noc, port_1st_render):
        """Render the hbm tile port specific of the endpoint."""
        ports = []
        # Ports that instantiate for only one time if there is any hbm tile inside noc network
        if port_1st_render:
            ports.append(f"input logic clk_hbmcfg_i")
            ports.append(f"input logic rst_hbmcfg_ni")
        endpoint_id = noc.graph.get_node_id(self.name)
        # endpoint_id = endpoint_id - noc.routing.id_offset
        hbm_name_xy = self.name + str(endpoint_id.x) + "_" + str(endpoint_id.y)
        ports.append(f"input logic {hbm_name_xy}_clk_hbmphy_i")
        ports.append(f"input logic {hbm_name_xy}_pll_lock_hbmphy_i")
        ports.append(f"input xbar_rule_t [XbarRuleNum-1:0] {hbm_name_xy}_XbarAddrMap")
        ports.append(f"inout {hbm_name_xy}_Xdram_CK")
        ports.append(f"inout {hbm_name_xy}_Xdram_CKB")
        ports.append(f"inout {hbm_name_xy}_Xdram_APAR")
        ports.append(f"inout {hbm_name_xy}_Xdram_ARFU")
        ports.append(f"inout {hbm_name_xy}_Xdram_AERR")
        ports.append(f"inout [9:0] {hbm_name_xy}_Xdram_RA")
        ports.append(f"inout [7:0] {hbm_name_xy}_Xdram_CA")
        ports.append(f"inout {hbm_name_xy}_Xdram_RRC")
        ports.append(f"inout [63:0] {hbm_name_xy}_Xdram_DQ")
        ports.append(f"inout [3:0] {hbm_name_xy}_Xdram_ECC")
        ports.append(f"inout [3:0] {hbm_name_xy}_Xdram_SEV")
        ports.append(f"inout [7:0] {hbm_name_xy}_Xdram_DBI")
        ports.append(f"inout [1:0] {hbm_name_xy}_Xdram_DPAR")
        ports.append(f"inout [1:0] {hbm_name_xy}_Xdram_DERR")
        ports.append(f"inout [1:0] {hbm_name_xy}_Xdram_RDQSP")
        ports.append(f"inout [1:0] {hbm_name_xy}_Xdram_RDQSN")
        ports.append(f"inout [1:0] {hbm_name_xy}_Xdram_WDQSP")
        ports.append(f"inout [1:0] {hbm_name_xy}_Xdram_WDQSN")
        ports.append(f"inout [3:0] {hbm_name_xy}_Xdram_RD")
        return ports
    
    def render_export_ni_ports(self):
        """Render the FlooNoC router ports of the endpoint."""
        ports = []
        svdirections = ["input","output"]
        port_types = ["req", "rsp", "wide"]
        for dir in svdirections:
            for type in port_types: 
                ports.append(
                    f"{dir} floo_{type}_t \
                      {self._array_to_sv_array()} {self.name}_floo_{type}_{dir[0]}"
                )
        return ports
    
    def _array_to_sv_array(self):
        """Convert the array to a SystemVerilog array."""
        if self.array is not None:
            return "".join([f"[{i-1}:0]" if i != 1 else "" for i in self.array])
        return ""
    
    def render_tb_compute_tile_ports(self, noc, port_1st_render):
        """Render the compute tile port specific of the endpoint."""
        ports = []
        # Ports that instantiate for only one time if there is any compute tile inside noc network
        if port_1st_render:
            ports.append(f".mtip_i ('0)")
            ports.append(f".msip_i ('0)")
        return ports
        
    def render_tb_hbm_tile_ports(self, noc, port_1st_render):
        """Render the hbm tile port specific of the endpoint."""
        ports = []
        # Ports that instantiate for only one time if there is any hbm tile inside noc network
        if port_1st_render:
            ports.append(f".clk_hbmcfg_i (1'b0)")
            ports.append(f".rst_hbmcfg_ni (1'b0)")
        endpoint_id = noc.graph.get_node_id(self.name)
        # endpoint_id = endpoint_id - noc.routing.id_offset
        hbm_name_xy = self.name + str(endpoint_id.x) + "_" + str(endpoint_id.y)
        ports.append(f".{hbm_name_xy}_clk_hbmphy_i (1'b0)")
        ports.append(f".{hbm_name_xy}_pll_lock_hbmphy_i (1'b0)")
        ports.append(f".{hbm_name_xy}_XbarAddrMap ('0)")
        ports.append(f".{hbm_name_xy}_Xdram_CK ()")
        ports.append(f".{hbm_name_xy}_Xdram_CKB ()")
        ports.append(f".{hbm_name_xy}_Xdram_APAR ()")
        ports.append(f".{hbm_name_xy}_Xdram_ARFU ()")
        ports.append(f".{hbm_name_xy}_Xdram_AERR ()")
        ports.append(f".{hbm_name_xy}_Xdram_RA ()")
        ports.append(f".{hbm_name_xy}_Xdram_CA ()")
        ports.append(f".{hbm_name_xy}_Xdram_RRC ()")
        ports.append(f".{hbm_name_xy}_Xdram_DQ ()")
        ports.append(f".{hbm_name_xy}_Xdram_ECC ()")
        ports.append(f".{hbm_name_xy}_Xdram_SEV ()")
        ports.append(f".{hbm_name_xy}_Xdram_DBI ()")
        ports.append(f".{hbm_name_xy}_Xdram_DPAR ()")
        ports.append(f".{hbm_name_xy}_Xdram_DERR ()")
        ports.append(f".{hbm_name_xy}_Xdram_RDQSP ()")
        ports.append(f".{hbm_name_xy}_Xdram_RDQSN ()")
        ports.append(f".{hbm_name_xy}_Xdram_WDQSP ()")
        ports.append(f".{hbm_name_xy}_Xdram_WDQSN ()")
        ports.append(f".{hbm_name_xy}_Xdram_RD ()")
        return ports
        
    def render_tb_ports(self):
        """Render the testbench ports of the endpoint."""
        ports = []
        # Render as connected port (support simulation model endpoint)
        if (self.is_memory_tb()):
            for port in self.sbr_ports:
                ports += port.render_tb_mem_connect_port()
        # Render as connected port (support simulation model endpoint)
        elif self.sbr_port_protocol == self.mgr_port_protocol:
            for port in self.mgr_ports:
                ports += port.render_tb_dma_connect_port()
            for port in self.sbr_ports:
                ports += port.render_tb_dma_connect_port()
        # Render as trimmed port (unsupport simulation model endpoint)
        else:
            for port in self.mgr_ports:
                ports += port.render_tb_trim_port()
            for port in self.sbr_ports:
                ports += port.render_tb_trim_port()
        return ports
    
    def render_tb_mem(self) -> str:
        """Render memory endpoints of the testbench."""
        return self._tpl_tb_mem.render(ep=self)
    
    def render_tb_dma(self, endpoint_id) -> str:
        """Render DMA endpoints of the testbench."""
        return self._tpl_tb_dma.render(ep=self, endpoint_id=endpoint_id)
    
    def render_testharness(self) -> str:
        """Render endpoints of the testharness."""
        return self._tpl_virtual_mem.render(ep=self)
    
