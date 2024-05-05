#!/usr/bin/env python3
# Copyright 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Tim Fischer <fischeti@iis.ee.ethz.ch>

import random
import argparse
import os

MEM_SIZE = 2**16 # Memory size in simulation, 65536 byte
NUM_X = 4
NUM_Y = 4

data_widths = {"wide": 512, "narrow": 64}

def clog2(x: int):
    """Compute the ceiling of the log2 of x."""
    return (x - 1).bit_length()

# For UseIdTable=False and RoutingAlgo=XY
def get_xy_base_addr(x: int, y: int):
    """Get the address of a tile in the mesh."""
    assert x <= NUM_X+1 and y <= NUM_Y+1
    return (x + 2 ** clog2(NUM_X + 2) * y) * MEM_SIZE

# def find_soc_type(AddrMap, target_soc_type):
#     addrmap_soc = list()
#     for node_addr in AddrMap:
#         if (node_addr["soc_type"]==target_soc_type):
#             addrmap_soc.append(node_addr)
#     return addrmap_soc

def find_sbr_module(AddrMap):
    addrmap_soc = list()
    for node_addr in AddrMap:
        if (node_addr["sbr_port"]["narrow"]==True or node_addr["sbr_port"]["wide"]==True):
            addrmap_soc.append(node_addr)
    return addrmap_soc

def find_mgr_module(AddrMap):
    addrmap_soc = list()
    for node_addr in AddrMap:
        if (node_addr["mgr_port"]["narrow"]==True or node_addr["mgr_port"]["wide"]==True):
            addrmap_soc.append(node_addr)
    return addrmap_soc

def find_memory(AddrMap):
    addrmap_soc = list()
    for node_addr in AddrMap:
         if (node_addr["mgr_port"]["narrow"]==False and node_addr["mgr_port"]["wide"]==False):
            addrmap_soc.append(node_addr)
    return addrmap_soc

def filter_sbr_type(node_list, node_type):
    if node_type=="narrow_wide":
        return node_list
    node_out = list()
    for node in node_list:
        if node["sbr_port"][node_type]:
            node_out.append(node)
    return node_out

def filter_exclude_idx(node_list, idx):
    # Generate cluster list that self cluster
    node_out = node_list.copy()
    rm_node = None
    for node in node_list:
        if (node["idx"]["x"]==idx["x"] and node["idx"]["y"]==idx["y"]):
            rm_node = node
            break
    if rm_node is not None:
        node_out.remove(rm_node)
    return node_out

def find_shortest_path(node_list, idx):
    shortest_node = dict()
    shortest_path = 100000 # init to more than every possible path
    for node in node_list:
        path_x = abs(node["idx"]["x"] - idx["x"])
        path_y = abs(node["idx"]["y"] - idx["y"])
        path_len = path_x + path_y
        if (shortest_path>path_len or \
            # Give priority to target node that is upper of the local node for avoding congestion
            (shortest_path==path_len and path_y>path_x)):
            shortest_path = path_len
            shortest_node = node
    return shortest_node

def find_target_node(node_list, idx):
    # Give priority to search on Y dimension
    for node in node_list:
        if (node["idx"]["x"]==idx["x"] and node["idx"]["y"]==idx["y"]):
            return(node)
    # Can't find matching node
    return -1

# Create single DMA jobs in string format to be written to file
def gen_job_str(
    length: int,
    src_addr: int,
    dst_addr: int,
    max_src_burst_size: int = 256,
    max_dst_burst_size: int = 256,
    r_aw_decouple: bool = False,
    r_w_decouple: bool = False,
    num_errors: int = 0,
):
    # pylint: disable=too-many-arguments
    """Generate a single job."""
    job_str = ""
    job_str += f"{int(length)}\n"
    job_str += f"{hex(src_addr)}\n"
    job_str += f"{hex(dst_addr)}\n"
    job_str += f"{max_src_burst_size}\n"
    job_str += f"{max_dst_burst_size}\n"
    job_str += f"{int(r_aw_decouple)}\n"
    job_str += f"{int(r_w_decouple)}\n"
    job_str += f"{num_errors}\n"
    return job_str


def emit_jobs(jobs, out_dir, name, idx):
    """Emit jobs to file."""
    # Generate directory if it does not exist
    if not os.path.exists(out_dir):
        os.makedirs(out_dir)
    with open(f"{out_dir}/{name}_{idx}.txt", "w", encoding="utf-8") as job_file:
        job_file.write(jobs)
        job_file.close()


def gen_chimney2chimney_traffic(
    narrow_burst_length: int = 16,
    num_narrow_bursts: int = 16,
    rw: str = "write",
    bidir: bool = False,
    out_dir: str = "jobs"
):
    """Generate Chimney to Chimney traffic."""
    num_masters = 2
    for i in range(num_masters):
        jobs = ""
        if bidir or i == 0:
            for _ in range(num_narrow_bursts):
                length = narrow_burst_length * data_widths["narrow"] / 8
                assert length <= MEM_SIZE
                src_addr = 0 if rw == "write" else MEM_SIZE
                dst_addr = MEM_SIZE if rw == "write" else 0
                job_str = gen_job_str(length, src_addr, dst_addr)
                jobs += job_str
        emit_jobs(jobs, out_dir, "chimney2chimney", i)


def gen_nw_chimney2chimney_traffic(
    narrow_burst_length: int,
    wide_burst_length: int,
    num_narrow_bursts: int,
    num_wide_bursts: int,
    rw: str,
    bidir: bool,
    out_dir: str,
    **_kwargs
):
    # pylint: disable=too-many-arguments
    """Generate Narrow Wide Chimney to Chimney traffic."""
    num_masters = 2
    for i in range(num_masters):
        wide_jobs = ""
        narrow_jobs = ""
        wide_length = wide_burst_length * data_widths["wide"] / 8 # total data to be transfer over wide DMA interface in byte unit
        narrow_length = narrow_burst_length * data_widths["narrow"] / 8 # total data to be transfer over narrow DMA interface in byte unit
        assert wide_length <= MEM_SIZE and narrow_length <= MEM_SIZE
        src_addr = 0 if rw == "write" else MEM_SIZE
        dst_addr = MEM_SIZE if rw == "write" else 0
        # the jobs creating will be skipped if its not bidir transfer (only one master initiate DMA transfer)
        if bidir or i == 0:
            for _ in range(num_wide_bursts):
                wide_jobs += gen_job_str(wide_length, src_addr, dst_addr)
            for _ in range(num_narrow_bursts):
                narrow_jobs += gen_job_str(narrow_length, src_addr, dst_addr)
        # index of wide DMA jobs is running from 0 for difference master DMA
        emit_jobs(wide_jobs, out_dir, "nw_chimney2chimney", i)
        # index of narrow DMA jobs is running from 100 for difference master DMA
        # The system must ensure that number of master DMA is not exceed 100
        emit_jobs(narrow_jobs, out_dir, "nw_chimney2chimney", i + 100)


def gen_mesh_traffic(
    narrow_burst_length: int,
    wide_burst_length: int,
    num_narrow_bursts: int,
    num_wide_bursts: int,
    rw: str,
    traffic_type: str,
    out_dir: str,
    **_kwargs
):
    # pylint: disable=too-many-arguments, too-many-locals
    """Generate Mesh traffic."""
    for x in range(1, NUM_X + 1):
        for y in range(1, NUM_Y + 1):
            wide_jobs = ""
            narrow_jobs = ""
            wide_length = wide_burst_length * data_widths["wide"] / 8
            narrow_length = narrow_burst_length * data_widths["narrow"] / 8
            assert wide_length <= MEM_SIZE and narrow_length <= MEM_SIZE
            if traffic_type == "hbm":
                # Tile x=0 are the HBM channels
                # Each core read from the channel of its y coordinate
                hbm_addr = get_xy_base_addr(0, y)
                local_addr = get_xy_base_addr(x, y)
                src_addr = hbm_addr if rw == "read" else local_addr
                dst_addr = local_addr if rw == "read" else hbm_addr
            elif traffic_type == "random":
                local_addr = get_xy_base_addr(x, y)
                ext_addr = get_xy_base_addr(random.randint(1, NUM_X), random.randint(1, NUM_Y))
                src_addr = ext_addr if rw == "read" else local_addr
                dst_addr = local_addr if rw == "read" else ext_addr
            elif traffic_type == "onehop":
                if not (x == 1 and y == 1):
                    wide_length = 0
                    narrow_length = 0
                    src_addr = 0
                    dst_addr = 0
                else:
                    local_addr = get_xy_base_addr(x, y)
                    ext_addr = get_xy_base_addr(x, y + 1)
                    src_addr = ext_addr if rw == "read" else local_addr
                    dst_addr = local_addr if rw == "read" else ext_addr
            else:
                raise ValueError(f"Unknown traffic type: {traffic_type}")
            for _ in range(num_wide_bursts):
                wide_jobs += gen_job_str(wide_length, src_addr, dst_addr)
            for _ in range(num_narrow_bursts):
                narrow_jobs += gen_job_str(narrow_length, src_addr, dst_addr)
            emit_jobs(wide_jobs, out_dir, "mesh", x + (y - 1) * NUM_X)
            emit_jobs(narrow_jobs, out_dir, "mesh", x + (y - 1) * NUM_X + 100)

# TODO : Modify this to generate compitible of compute tile array jobs
# This required to use ID table and XY routing algorithm
def gen_compute_tile_array_traffic(
    narrow_burst_length: int,
    wide_burst_length: int,
    num_narrow_bursts: int,
    num_wide_bursts: int,
    rw: str,
    traffic_type: str,
    out_dir: str,
    **_kwargs
):
    # Import address map configuration from file that generated by floogen
    import soc_config
    
    # pylint: disable=too-many-arguments, too-many-locals
    """Generate compute tile array traffic."""
    # cluster_list = find_soc_type(soc_config.AddrMap, "cluster")
    # hbm_list = find_soc_type(soc_config.AddrMap, "memory")
    
    mgr_module_list = find_mgr_module(soc_config.AddrMap)
    sbr_module_list = find_sbr_module(soc_config.AddrMap)
    memory_list = find_memory(soc_config.AddrMap)
    # sbr_narrow_list = find_sbr_module(soc_config.AddrMap, "narrow")
    # sbr_wide_list = find_sbr_module(soc_config.AddrMap, "wide")
    # sbr_narrow_wide_list = find_sbr_module(soc_config.AddrMap, ["narrow_wide"])
    # ID table based DMA jobs generation
    for mgr_module in mgr_module_list:
        wide_jobs = ""
        narrow_jobs = ""
        mgr_port_type = "narrow_wide"
        wide_length = wide_burst_length * soc_config.data_widths["wide"] / 8 # total data to be transfer over wide DMA interface in byte unit
        narrow_length = narrow_burst_length * soc_config.data_widths["narrow"] / 8  # total data to be transfer over narrow DMA interface in byte unit
        if mgr_module["mgr_port"]["narrow"]==False:
            mgr_port_type = "wide"
        elif mgr_module["mgr_port"]["wide"]==False:
            mgr_port_type = "narrow"
        # assert wide_length <= MEM_SIZE and narrow_length <= MEM_SIZE
        # 1) master node DMA from shortest path memory
        if traffic_type == "memory":
            sel_sbr_module_list = filter_sbr_type(memory_list, mgr_port_type) # No filter for mgr_port_type="narrow_wide"
            sel_sbr_module_list = filter_exclude_idx(sel_sbr_module_list, mgr_module["idx"])
            ext = find_shortest_path(sel_sbr_module_list, mgr_module["idx"])
            src_addr = ext["start_addr"] if rw == "read" else mgr_module["start_addr"]
            dst_addr = mgr_module["start_addr"] if rw == "read" else ext["start_addr"]
        # 2) master node DMA from random memory
        elif traffic_type == "memory_rand":
            sel_sbr_module_list = filter_sbr_type(memory_list, mgr_port_type) # No filter for mgr_port_type="narrow_wide"
            sel_sbr_module_list = filter_exclude_idx(sel_sbr_module_list, mgr_module["idx"])
            # Find possible number of hbm target node
            sbr_node_num = len(sel_sbr_module_list)
            # Random picking target node
            rand_idx = random.randint(0, sbr_node_num-1)
            ext = sel_sbr_module_list[rand_idx]
            src_addr = ext["start_addr"] if rw == "read" else mgr_module["start_addr"]
            dst_addr = mgr_module["start_addr"] if rw == "read" else ext["start_addr"]
        # 3) master node DMA from random slave node
        elif traffic_type == "random":
            sel_sbr_module_list = filter_sbr_type(sbr_module_list, mgr_port_type) # No filter for mgr_port_type="narrow_wide"
            sel_sbr_module_list = filter_exclude_idx(sel_sbr_module_list, mgr_module["idx"])
            # Find possible number of target node for both cluster and hbm
            sbr_node_num = len(sel_sbr_module_list)
            # Random picking target node
            rand_idx = random.randint(0, sbr_node_num-1)
            ext = sel_sbr_module_list[rand_idx]
            src_addr = ext["start_addr"] if rw == "read" else mgr_module["start_addr"]
            dst_addr = mgr_module["start_addr"] if rw == "read" else ext["start_addr"]
        # 4) master node DMA from other master node
        elif traffic_type == "mgr_rand":
            sel_sbr_module_list = find_sbr_module(mgr_module_list)
            sel_sbr_module_list = filter_sbr_type(sel_sbr_module_list, mgr_port_type) # No filter for mgr_port_type="narrow_wide"
            sel_sbr_module_list = filter_exclude_idx(sel_sbr_module_list, mgr_module["idx"])
            # Find possible number of cluster target node
            sbr_node_num = len(sel_sbr_module_list)
            # Random picking target node
            rand_idx = random.randint(0, sbr_node_num-1)
            ext = sel_sbr_module_list[rand_idx]
            src_addr = ext["start_addr"] if rw == "read" else mgr_module["start_addr"]
            dst_addr = mgr_module["start_addr"] if rw == "read" else ext["start_addr"]
        # 5) cluster DMA from the next right node
        elif traffic_type == "onehop":
            sel_sbr_module_list = filter_sbr_type(sbr_module_list, mgr_port_type) # No filter for mgr_port_type="narrow_wide"
            sel_sbr_module_list = filter_exclude_idx(sel_sbr_module_list, mgr_module["idx"])
            # Access to next upper hop
            ext_idx = {"x": mgr_module["idx"]["x"]+1, "y": mgr_module["idx"]["y"]};
            # Find matching target idx
            ext = find_target_node(sel_sbr_module_list, ext_idx);
            if (ext==-1):
                wide_length = 0
                narrow_length = 0
                src_addr = 0
                dst_addr = 0
            else:
                src_addr = ext["start_addr"] if rw == "read" else mgr_module["start_addr"]
                dst_addr = mgr_module["start_addr"] if rw == "read" else ext["start_addr"]
        else:
            raise ValueError(f"Unknown traffic type: {traffic_type}")
        
        if ext!=-1:
            ext_mem_size = ext["end_addr"] - ext["start_addr"]
            assert wide_length <= ext_mem_size and narrow_length <= ext_mem_size
            sbr_port_type = "narrow_wide"
            if ext["sbr_port"]["narrow"]==False:
                sbr_port_type = "wide"
            elif ext["sbr_port"]["wide"]==False:
                sbr_port_type = "narrow"
            if sbr_port_type == "narrow_wide" and mgr_port_type != "narrow_wide":
                sbr_port_type = mgr_port_type
            # Print DMA summary
            print("  [jobs] " + mgr_module["name"] + str(mgr_module["idx"]) + 
                " " + sbr_port_type + " DMA " + rw + " to " + ext["name"] + str(ext["idx"]))
            # Write DMA jobs to file separately between narrow and wide interface
            if "wide" not in sbr_port_type:
                wide_length = 0
            if "narrow" not in sbr_port_type:
                narrow_length = 0
        for _ in range(num_wide_bursts):
            wide_jobs += gen_job_str(wide_length, src_addr, dst_addr)
        emit_jobs(wide_jobs, out_dir, "compute_tile_array", mgr_module["idx"]["x"] + mgr_module["idx"]["y"] * soc_config.NUM_X)
        for _ in range(num_narrow_bursts):
            narrow_jobs += gen_job_str(narrow_length, src_addr, dst_addr)
        emit_jobs(narrow_jobs, out_dir, "compute_tile_array", mgr_module["idx"]["x"] + mgr_module["idx"]["y"] * soc_config.NUM_X + 1000)

def main():
    """Main function."""
    # parse arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("--out_dir", type=str, default="test/jobs")
    parser.add_argument("--num_narrow_bursts", type=int, default=10)
    parser.add_argument("--num_wide_bursts", type=int, default=100)
    parser.add_argument("--narrow_burst_length", type=int, default=1)
    parser.add_argument("--wide_burst_length", type=int, default=16)
    parser.add_argument("--bidir", action="store_true")
    parser.add_argument("--tb", type=str, default="dma_mesh")
    parser.add_argument("--traffic_type", type=str, default="random")
    parser.add_argument("--rw", type=str, default="read")
    args = parser.parse_args()

    kwargs = vars(args)

    if args.tb == "chimney2chimney":
        gen_chimney2chimney_traffic(**kwargs)
    elif args.tb == "nw_chimney2chimney":
        gen_nw_chimney2chimney_traffic(**kwargs)
    elif args.tb == "dma_mesh":
        gen_mesh_traffic(**kwargs)
    elif args.tb == "compute_tile_array":
        gen_compute_tile_array_traffic(**kwargs)
    else:
        raise ValueError(f"Unknown testbench: {args.tb}")


if __name__ == "__main__":
    main()
