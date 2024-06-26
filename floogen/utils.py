#!/usr/bin/env python3
# Copyright 2023 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Author: Tim Fischer <fischeti@iis.ee.ethz.ch>

import math
import shutil
import subprocess
import numpy
from typing import Union


def cdiv(x, y) -> int:
    """Returns the ceiling of x/y."""
    return -(-x // y)


def clog2(x) -> int:
    """Returns the ceiling of log2(x)."""
    return math.ceil(math.log2(x))


def camel_to_snake(name: str) -> str:
    """Converts a camel case string to snake case."""
    return "".join(["_" + i.lower() if i.isupper() else i for i in name]).lstrip("_")


def snake_to_camel(name: str) -> str:
    """Converts a snake case string to camel case."""
    return "".join([i.capitalize() for i in name.split("_")])


def short_dir(direction: str) -> str:
    """Returns the short direction string."""
    return "in" if direction == "input" else "out"


def bool_to_sv(value: bool) -> str:
    """Converts a boolean to a SystemVerilog string."""
    return "1'b1" if value else "1'b0"


def int_to_hex(value: int, width: int) -> str:
    """Converts an integer to a hex string."""
    return f"{width}'h{value:0{width//4}x}"


def sv_param_decl(
    name: str,
    value: Union[int, str],
    ptype: str = "localparam",
    dtype: str = "int unsigned",
    array_size: Union[int, str] = None,
) -> str:
    """Declare a SystemVerilog parameter."""
    assert ptype in ["localparam", "parameter"]
    if array_size is None:
        return f"{ptype} {dtype} {name} = {value};\n"
    if isinstance(array_size, int):
        return f"{ptype} {dtype}[{array_size-1}:0] {name} = {value};\n"
    return f"{ptype} {dtype}[{array_size}:0] {name} = {value};\n"

def py_param_decl(
    name: str,
    value: Union[int, str]
) -> str:
    """Declare a Python util parameter."""
    return f"{name} = {value}\n"

def sv_typedef(name: str, dtype: str = "logic", array_size: int = None) -> str:
    """Declare a SystemVerilog typedef."""
    assert array_size is None or isinstance(array_size, int)
    if array_size is None:
        return f"typedef {dtype} {name};\n"
    return f"typedef {dtype}[{array_size-1}:0] {name};\n"


def sv_struct_typedef(name: str, fields: dict, union=False) -> str:
    """Declare a SystemVerilog struct typedef."""
    if union:
        typedef = "typedef union packed {\n"
    else:
        typedef = "typedef struct packed {\n"
    for field, dtype in fields.items():
        typedef += f"    {dtype} {field};\n"
    typedef += f"}} {name};\n\n"
    return typedef

def idx_to_sv_idx(arr_idx, array):
    """Convert the array to a SystemVerilog array."""
    if (arr_idx is not None) and (array is not None):
        string = ""
        for idx, val in zip(arr_idx, array):
            if val != 1:
                string += f"[{idx}]"
        return string
    return ""

def verible_format(string: str) -> str:
    """Format the string using verible-verilog-format."""
    if shutil.which("verible-verilog-format") is None:
        raise RuntimeError(
            "verible-verilog-format not found. Please install it to use the --format option."
        )
    # Format the output using verible-verilog-format, by piping it into the stdin
    # of the formatter and capturing the stdout
    return subprocess.run(
        ["verible-verilog-format", "-"],
        input=string,
        capture_output=True,
        text=True,
        check=True,
    ).stdout

def port_dict_convert(port_nodes):
    port_dicts = {}
    for port in port_nodes:
        array = 0
        port_dicts[port.name] = {} # New endpoint
        if port.addr_range is not None:
            port_dicts[port.name]["addr_range"] = {}
            port_dicts[port.name]["addr_range"]["base"] = port.addr_range.base
            port_dicts[port.name]["addr_range"]["size"] = port.addr_range.size
            # port_dicts[port.name]["addr_range"]["start"] = port.addr_range.start
            # port_dicts[port.name]["addr_range"]["end"] = port.addr_range.end
        for mgr_port in port.mgr_ports:
            port_dicts[port.name]["mgr_"+mgr_port.name] = {}
            port_dicts[port.name]["mgr_"+mgr_port.name]["req_name"] = mgr_port.req_name(port=True)
            port_dicts[port.name]["mgr_"+mgr_port.name]["rsp_name"] = mgr_port.rsp_name(port=True)
            port_dicts[port.name]["mgr_"+mgr_port.name]["req_type"] = mgr_port.req_type()
            port_dicts[port.name]["mgr_"+mgr_port.name]["rsp_type"] = mgr_port.rsp_type()
            port_dicts[port.name]["mgr_"+mgr_port.name]["sv_array"] = mgr_port._array_to_sv_array()
            port_dicts[port.name]["mgr_"+mgr_port.name]["array"] = mgr_port.array
            array = mgr_port.array
            port_dicts[port.name]["mgr_"+mgr_port.name]["addr_width"] = mgr_port.addr_width
            port_dicts[port.name]["mgr_"+mgr_port.name]["data_width"] = mgr_port.data_width
            port_dicts[port.name]["mgr_"+mgr_port.name]["id_width"] = mgr_port.id_width
            port_dicts[port.name]["mgr_"+mgr_port.name]["user_width"] = mgr_port.user_width
            port_dicts[port.name]["mgr_"+mgr_port.name]["svdirection"] = mgr_port.svdirection
            port_dicts[port.name]["mgr_"+mgr_port.name]["type"] = mgr_port.type
        for sbr_port in port.sbr_ports:
            port_dicts[port.name]["sbr_"+sbr_port.name] = {}
            port_dicts[port.name]["sbr_"+sbr_port.name]["req_name"] = sbr_port.req_name(port=True)
            port_dicts[port.name]["sbr_"+sbr_port.name]["rsp_name"] = sbr_port.rsp_name(port=True)
            port_dicts[port.name]["sbr_"+sbr_port.name]["req_type"] = sbr_port.req_type()
            port_dicts[port.name]["sbr_"+sbr_port.name]["rsp_type"] = sbr_port.rsp_type()
            port_dicts[port.name]["sbr_"+sbr_port.name]["sv_array"] = sbr_port._array_to_sv_array()
            port_dicts[port.name]["sbr_"+sbr_port.name]["array"] = sbr_port.array
            array = sbr_port.array
            port_dicts[port.name]["sbr_"+sbr_port.name]["addr_width"] = sbr_port.addr_width
            port_dicts[port.name]["sbr_"+sbr_port.name]["data_width"] = sbr_port.data_width
            port_dicts[port.name]["sbr_"+sbr_port.name]["id_width"] = sbr_port.id_width
            port_dicts[port.name]["sbr_"+sbr_port.name]["user_width"] = sbr_port.user_width
            port_dicts[port.name]["sbr_"+sbr_port.name]["svdirection"] = sbr_port.svdirection
            port_dicts[port.name]["sbr_"+sbr_port.name]["type"] = sbr_port.type
        if array is not None:
            port_dicts[port.name]["array"] = array
            port_dicts[port.name]["num"] = numpy.prod(array).tolist()
        else:
            port_dicts[port.name]["array"] = 1
            port_dicts[port.name]["num"] = 1
    return port_dicts