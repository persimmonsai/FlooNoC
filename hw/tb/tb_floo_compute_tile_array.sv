// Copyright 2023 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Author: Tim Fischer <fischeti@iis.ee.ethz.ch>

`include "common_cells/assertions.svh"
`include "floo_noc/typedef.svh"

// Use to detect simulation of floonoc is running
//`ifndef FLOO_NOC_SIMULATION_
//`define FLOO_NOC_SIMULATION_
//`endif

module tb_floo_compute_tile_array;

  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;

  // Import simulation parameter
  import compute_tile_test_pkg::*;

  logic clk, rst_n;

  clk_rst_gen #(
      .ClkPeriod   (CyclTime),
      .RstClkCycles(5)
  ) i_clk_gen (
      .clk_o (clk),
      .rst_no(rst_n)
  );

  //////////////////////////////////
  //   HBM Model on North border  //
  //////////////////////////////////

  axi_narrow_out_req_t [NumX-1:0] hbm_north_narrow_req;
  axi_narrow_out_rsp_t [NumX-1:0] hbm_north_narrow_rsp;
  axi_wide_out_req_t   [NumX-1:0] hbm_north_wide_req;
  axi_wide_out_rsp_t   [NumX-1:0] hbm_north_wide_rsp;

  floo_hbm_model #(
      .TA         (ApplTime),
      .TT         (TestTime),
      .Latency    (HBMLatency),
      .NumChannels(1),
      .AddrWidth  (AxiWideOutAddrWidth),
      .DataWidth  (AxiWideOutDataWidth),
      .UserWidth  (AxiWideOutUserWidth),
      .IdWidth    (AxiWideOutIdWidth),
      .axi_req_t  (axi_wide_out_req_t),
      .axi_rsp_t  (axi_wide_out_rsp_t),
      .aw_chan_t  (axi_wide_out_aw_chan_t),
      .w_chan_t   (axi_wide_out_w_chan_t),
      .b_chan_t   (axi_wide_out_b_chan_t),
      .ar_chan_t  (axi_wide_out_ar_chan_t),
      .r_chan_t   (axi_wide_out_r_chan_t)
      // Place HBM as vertical line on north border of the array
  ) i_floo_wide_hbm_north_model[NumX-1:0] (
      .clk_i    (clk),
      .rst_ni   (rst_n),
      .hbm_req_i(hbm_north_wide_req),
      .hbm_rsp_o(hbm_north_wide_rsp)
  );
  floo_hbm_model #(
      .TA         (ApplTime),
      .TT         (TestTime),
      .Latency    (HBMLatency),
      .NumChannels(1),
      .AddrWidth  (AxiNarrowOutAddrWidth),
      .DataWidth  (AxiNarrowOutDataWidth),
      .UserWidth  (AxiNarrowOutUserWidth),
      .IdWidth    (AxiNarrowOutIdWidth),
      .axi_req_t  (axi_narrow_out_req_t),
      .axi_rsp_t  (axi_narrow_out_rsp_t),
      .aw_chan_t  (axi_narrow_out_aw_chan_t),
      .w_chan_t   (axi_narrow_out_w_chan_t),
      .b_chan_t   (axi_narrow_out_b_chan_t),
      .ar_chan_t  (axi_narrow_out_ar_chan_t),
      .r_chan_t   (axi_narrow_out_r_chan_t)
      // Place HBM as vertical line on north border of the array
  ) i_floo_narrow_hbm_north_model[NumX-1:0] (
      .clk_i    (clk),
      .rst_ni   (rst_n),
      .hbm_req_i(hbm_north_narrow_req),
      .hbm_rsp_o(hbm_north_narrow_rsp)
  );
  // // Generate hbm north XY ID vector in vertical line
  // id_t [NumX-1:0]   xy_id_hbm_north;
  // for (genvar i = 0; i < NumX; i++) begin : gen_id_hbm_north
  //   xy_id_hbm_north[i] = '{x: i+1, y: NumY+1};
  // end

  //////////////////////////////////
  //   HBM Model on South border  //
  //////////////////////////////////

  axi_narrow_out_req_t [NumX-1:0] hbm_south_narrow_req;
  axi_narrow_out_rsp_t [NumX-1:0] hbm_south_narrow_rsp;
  axi_wide_out_req_t   [NumX-1:0] hbm_south_wide_req;
  axi_wide_out_rsp_t   [NumX-1:0] hbm_south_wide_rsp;

  floo_hbm_model #(
      .TA         (ApplTime),
      .TT         (TestTime),
      .Latency    (HBMLatency),
      .NumChannels(1),
      .AddrWidth  (AxiWideOutAddrWidth),
      .DataWidth  (AxiWideOutDataWidth),
      .UserWidth  (AxiWideOutUserWidth),
      .IdWidth    (AxiWideOutIdWidth),
      .axi_req_t  (axi_wide_out_req_t),
      .axi_rsp_t  (axi_wide_out_rsp_t),
      .aw_chan_t  (axi_wide_out_aw_chan_t),
      .w_chan_t   (axi_wide_out_w_chan_t),
      .b_chan_t   (axi_wide_out_b_chan_t),
      .ar_chan_t  (axi_wide_out_ar_chan_t),
      .r_chan_t   (axi_wide_out_r_chan_t)
      // Place HBM as vertical line on south border of the array
  ) i_floo_wide_hbm_south_model[NumX-1:0] (
      .clk_i    (clk),
      .rst_ni   (rst_n),
      .hbm_req_i(hbm_south_wide_req),
      .hbm_rsp_o(hbm_south_wide_rsp)
  );
  floo_hbm_model #(
      .TA         (ApplTime),
      .TT         (TestTime),
      .Latency    (HBMLatency),
      .NumChannels(1),
      .AddrWidth  (AxiNarrowOutAddrWidth),
      .DataWidth  (AxiNarrowOutDataWidth),
      .UserWidth  (AxiNarrowOutUserWidth),
      .IdWidth    (AxiNarrowOutIdWidth),
      .axi_req_t  (axi_narrow_out_req_t),
      .axi_rsp_t  (axi_narrow_out_rsp_t),
      .aw_chan_t  (axi_narrow_out_aw_chan_t),
      .w_chan_t   (axi_narrow_out_w_chan_t),
      .b_chan_t   (axi_narrow_out_b_chan_t),
      .ar_chan_t  (axi_narrow_out_ar_chan_t),
      .r_chan_t   (axi_narrow_out_r_chan_t)
      // Place HBM as vertical line on south border of the array
  ) i_floo_narrow_hbm_south_model[NumX-1:0] (
      .clk_i    (clk),
      .rst_ni   (rst_n),
      .hbm_req_i(hbm_south_narrow_req),
      .hbm_rsp_o(hbm_south_narrow_rsp)
  );
  // // Generate hbm north XY ID vector in vertical line
  // id_t [NumX-1:0]   xy_id_hbm_south;
  // for (genvar i = 0; i < NumX; i++) begin : gen_id_hbm_south
  //   xy_id_hbm_south[i] = '{x: i+1, y: 0};
  // end

  //////////////////////////////////
  //   Compute Tile Array (DUT)   //
  //////////////////////////////////

  // Simulation end at DMA node 
  compute_tile_array_floo_noc i_compute_tile_array_floo_noc (
      .clk_i(clk),
      .rst_ni(rst_n),
      .test_enable_i(1'b0),

      .hbm_north_narrow_req_o(hbm_north_narrow_req),
      .hbm_north_narrow_rsp_i(hbm_north_narrow_rsp),
      .hbm_north_wide_req_o(hbm_north_wide_req),
      .hbm_north_wide_rsp_i(hbm_north_wide_rsp),
      .hbm_south_narrow_req_o(hbm_south_narrow_req),
      .hbm_south_narrow_rsp_i(hbm_south_narrow_rsp),
      .hbm_south_wide_req_o(hbm_south_wide_req),
      .hbm_south_wide_rsp_i(hbm_south_wide_rsp),
      // Temporary Tie-off input port
      .pcie_narrow_req_i('0),
      .pcie_narrow_rsp_o(),
      .pcie_wide_req_i('0),
      .pcie_wide_rsp_o(),
      .pcie_narrow_req_o(),
      .pcie_narrow_rsp_i('0),
      .pcie_wide_req_o(),
      .pcie_wide_rsp_i('0),
      .cva6_narrow_req_i('0),
      .cva6_narrow_rsp_o(),
      .peripherals_narrow_req_i('0),
      .peripherals_narrow_rsp_o(),
      .peripherals_narrow_req_o(),
      .peripherals_narrow_rsp_i('0)
  );

  logic [3:0] endsim_cluster;
  // Get end_of_sim signal inside DUT
  assign endsim_cluster[0] = &tb_floo_compute_tile_array.i_compute_tile_array_floo_noc.compute_tile_0_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[1] = &tb_floo_compute_tile_array.i_compute_tile_array_floo_noc.compute_tile_0_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[2] = &tb_floo_compute_tile_array.i_compute_tile_array_floo_noc.compute_tile_1_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[3] = &tb_floo_compute_tile_array.i_compute_tile_array_floo_noc.compute_tile_1_1.i_snitch_cluster_test_node.end_of_sim;

  initial begin
    wait (&endsim_cluster);
    // Wait for some time
    #100ns;
    // Stop the simulation
    $display("-- End Simulation --");
    $stop;
  end

endmodule
