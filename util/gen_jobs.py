#!/usr/bin/env python3
# Copyright 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Tim Fischer <fischeti@iis.ee.ethz.ch>

import random
import argparse
import os

# -------------------------------------------------------
# TODO :Make python package that described all DMA able node to generated by floogen
# and include that file into this file to generate DMA jobs for each test node

MEM_SIZE = 2**16 # Memory size in simulation, 65536 byte
NUM_X = 4
NUM_Y = 4

data_widths = {"wide": 512, "narrow": 64}

# # -------------------------------------------------------

def clog2(x: int):
    """Compute the ceiling of the log2 of x."""
    return (x - 1).bit_length()

# For UseIdTable=False and RoutingAlgo=XY
def get_xy_base_addr(x: int, y: int):
    """Get the address of a tile in the mesh."""
    assert x <= NUM_X+1 and y <= NUM_Y+1
    return (x + 2 ** clog2(NUM_X + 2) * y) * MEM_SIZE

def find_soc_type(AddrMap, target_soc_type):
    addrmap_soc = list()
    for node_addr in AddrMap:
        if (node_addr["soc_type"]==target_soc_type):
            addrmap_soc.append(node_addr)
    return addrmap_soc

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
    cluster_list = find_soc_type(soc_config.AddrMap, "cluster")
    hbm_list = find_soc_type(soc_config.AddrMap, "memory")
    # ID table based DMA jobs generation
    for cluster in cluster_list:
        wide_jobs = ""
        narrow_jobs = ""
        wide_length = wide_burst_length * soc_config.data_widths["wide"] / 8 # total data to be transfer over wide DMA interface in byte unit
        narrow_length = narrow_burst_length * soc_config.data_widths["narrow"] / 8  # total data to be transfer over narrow DMA interface in byte unit
        # assert wide_length <= MEM_SIZE and narrow_length <= MEM_SIZE
        # 1) cluster DMA from shortest path hbm
        if traffic_type == "hbm":
            ext = find_shortest_path(hbm_list, cluster["idx"])
            src_addr = ext["start_addr"] if rw == "read" else cluster["start_addr"]
            dst_addr = cluster["start_addr"] if rw == "read" else ext["start_addr"]
        # 2) cluster DMA from random hbm
        elif traffic_type == "hbm_rand":
            # Find possible number of hbm target node
            hbm_node_num = len(hbm_list)
            # Ramdom picking target node
            rand_idx = random.randint(0, hbm_node_num-1)
            ext = hbm_list[rand_idx]
            src_addr = ext["start_addr"] if rw == "read" else cluster["start_addr"]
            dst_addr = cluster["start_addr"] if rw == "read" else ext["start_addr"]
        # 3) cluster DMA from random hbm and random cluster
        elif traffic_type == "random":
            # Generate cluster list that self cluster
            cluster_noself_list = cluster_list.copy()
            cluster_noself_list.remove(cluster)
            # Find possible number of target node for both cluster and hbm
            cluster_node_num = len(cluster_noself_list)
            hbm_node_num = len(hbm_list)
            # Ramdom picking target node
            rand_idx = random.randint(0, cluster_node_num+hbm_node_num-1)
            if (rand_idx < cluster_node_num):
                ext = cluster_noself_list[rand_idx]
            else:
                ext = hbm_list[rand_idx-cluster_node_num]
            src_addr = ext["start_addr"] if rw == "read" else cluster["start_addr"]
            dst_addr = cluster["start_addr"] if rw == "read" else ext["start_addr"]
        # 4) cluster DMA from random cluster
        elif traffic_type == "cluster_rand":
            # Generate cluster list that self cluster
            cluster_noself_list = cluster_list.copy()
            cluster_noself_list.remove(cluster)
            # Find possible number of cluster target node
            cluster_node_num = len(cluster_noself_list)
            # Ramdom picking target node
            rand_idx = random.randint(0, cluster_node_num-1)
            ext = cluster_noself_list[rand_idx]
            src_addr = ext["start_addr"] if rw == "read" else cluster["start_addr"]
            dst_addr = cluster["start_addr"] if rw == "read" else ext["start_addr"]
        # 5) cluster DMA from the next upper node
        elif traffic_type == "onehop":
            # Filter only hbm memory and cluster
            all_node_list = cluster_list + hbm_list
            # Access to next upper hop
            ext_idx = {"x": cluster["idx"]["x"], "y": cluster["idx"]["y"]+1};
            # Find matching target idx
            ext = find_target_node(all_node_list, ext_idx);
            if (ext==-1):
                wide_length = 0
                narrow_length = 0
                src_addr = 0
                dst_addr = 0
            else:
                src_addr = ext["start_addr"] if rw == "read" else cluster["start_addr"]
                dst_addr = cluster["start_addr"] if rw == "read" else ext["start_addr"]
        else:
            raise ValueError(f"Unknown traffic type: {traffic_type}")
        
        ext_mem_size = ext["end_addr"] - ext["start_addr"]
        assert wide_length <= ext_mem_size and narrow_length <= ext_mem_size
        # Print DMA sumary
        print("  [jobs] " + cluster["name"] + str(cluster["idx"]) + " DMA " + rw + " to " + ext["name"] + str(ext["idx"]))
        # Write DMA jobs to file
        for _ in range(num_wide_bursts):
            wide_jobs += gen_job_str(wide_length, src_addr, dst_addr)
        for _ in range(num_narrow_bursts):
            narrow_jobs += gen_job_str(narrow_length, src_addr, dst_addr)
        emit_jobs(wide_jobs, out_dir, "compute_tile_array", cluster["idx"]["x"] + (cluster["idx"]["y"] - 1) * soc_config.NUM_X)
        emit_jobs(narrow_jobs, out_dir, "compute_tile_array", cluster["idx"]["x"] + (cluster["idx"]["y"] - 1) * soc_config.NUM_X + 1000)

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
