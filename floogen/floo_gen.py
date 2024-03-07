#!/usr/bin/env python3
# Copyright 2023 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Author: Tim Fischer <fischeti@iis.ee.ethz.ch>

import os
import argparse
from pathlib import Path

from floogen.config_parser import parse_config
from floogen.model.network import Network
from floogen.utils import verible_format


def parse_args():
    """Parse the command line arguments."""
    parser = argparse.ArgumentParser(description="FlooGen: A Network-on-Chip Generator")
    parser.add_argument(
        "-c", "--config", type=Path, required=True, help="Path to the configuration file."
    )
    parser.add_argument(
        "-o",
        "--outdir",
        type=Path,
        required=False,
        help="Path to the output directory of the generated output.",
    )
    parser.add_argument(
        "--pkg-outdir",
        dest="pkg_outdir",
        type=Path,
        required=False,
        help="Path to the output directory of the generated output.",
    )
    parser.add_argument(
        "--tb-outdir",
        dest="tb_outdir",
        type=Path,
        required=False,
        help="Path to the output testbech directory of the generated testbench.",
    )
    parser.add_argument(
        "--util-outdir",
        dest="util_outdir",
        type=Path,
        required=False,
        help="Path to the output utils directory of the generated jobs parameter.",
    )
    parser.add_argument(
        "--only-pkg", dest="only_pkg", action="store_true", help="Only generate the package file."
    )
    parser.add_argument(
        "--no-format",
        dest="no_format",
        action="store_true",
        help="Do not format the output.",
    )
    parser.add_argument("--visualize", action="store_true", help="Visualize the network graph.")
    args = parser.parse_args()
    return args


def main(): # pylint: disable=too-many-branches
    """Generates the network."""
    args = parse_args()
    # Load network configuration .yml file and validate input
    network = parse_config(Network, args.config)

    if args.outdir:
        outdir = Path(os.getcwd(), args.outdir)
    else:
        # default output directory
        outdir = Path(os.getcwd(), "generated")

    if args.pkg_outdir:
        pkg_outdir = Path(os.getcwd(), args.pkg_outdir)
    else:
        # default output directory
        pkg_outdir = Path(os.getcwd(), "hw")
        if not pkg_outdir.exists():
            raise FileNotFoundError(
                f"Was not able to find the directory to store the package file: {pkg_outdir}"
            )

    # Generate wrapper and testbecnch if in the mode 'compute_tile_array'
    if not args.only_pkg:
        network.create_network()
        network.compile_network()
        network.gen_routing_info()

        # Visualize the network graph
        if args.visualize:
            if outdir:
                visual_file_name = outdir / (network.name + ".pdf")
                network.visualize(filename=visual_file_name)
                print("Generating graph : " + str(visual_file_name))
            else:
                network.visualize(savefig=False)

        # Generate the network description
        rendered_top = network.render_network()
        if not args.no_format:
            rendered_top = verible_format(rendered_top)
        # Write the network description to file or print it to stdout
        if outdir:
            outdir.mkdir(parents=True, exist_ok=True)
            top_file_name = outdir / (network.name + "_floo_noc.sv")
            with open(top_file_name, "w+", encoding="utf-8") as top_file:
                top_file.write(rendered_top)
            print("Generating topfile : " + str(top_file_name))
        else:
            print(rendered_top)
        
        # # Generating support file for compute tile array structure
        # if network.compute_tile_gen:
        #     if args.tb_outdir:
        #         tb_outdir = Path(os.getcwd(), args.tb_outdir)
        #     else:
        #         # default output directory
        #         tb_outdir = Path(os.getcwd(), "hw", "tb")
        #         if not tb_outdir.exists():
        #             raise FileNotFoundError(
        #                 f"Was not able to find the directory to store the testbech file: {tb_outdir}"
        #             )
        #     if args.util_outdir:
        #         util_outdir = Path(os.getcwd(), args.util_outdir)
        #     else:
        #         # default output directory
        #         util_outdir = Path(os.getcwd(), "util")
        #         if not util_outdir.exists():
        #             raise FileNotFoundError(
        #                 f"Was not able to find the directory to store the util file: {util_outdir}"
        #             )
        #     # TODO : Generate util python file
        #     rendered_top = network.render_util_job()
        #     # TODO : Generate testbench file
        #     rendered_top = network.render_tb()

    # Generate package
    axi_type, rendered_pkg = network.render_link_cfg()
    if not args.no_format:
        rendered_pkg = verible_format(rendered_pkg)
        # Write the link configuration to file or print it to stdout
        if pkg_outdir:
            cfg_file_name = pkg_outdir / (f"floo_{axi_type}_pkg.sv")
            with open(cfg_file_name, "w+", encoding="utf-8") as cfg_file:
                cfg_file.write(rendered_pkg)
            print("Generating package : " + str(cfg_file_name))
        else:
            print(rendered_pkg)


if __name__ == "__main__":
    main()
