// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

`include "common_cells/assertions.svh"
`include "floo_noc/typedef.svh"

module floo_testharness
  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;
//import snitch_cluster_pkg::*;
(
    input logic clk_i,
    input logic rst_ni
);

  import "DPI-C" function void clint_tick(output byte msip[]);

  //////////////////////////////////
  //   Endpoint Simulation Model  //
  //////////////////////////////////

  axi_narrow_out_req_t [1:0] hbm_north_narrow_req;
  axi_narrow_out_rsp_t [1:0] hbm_north_narrow_rsp;
  axi_wide_out_req_t   [1:0] hbm_north_wide_req;
  axi_wide_out_rsp_t   [1:0] hbm_north_wide_rsp;

  // Wide port into simulation memory.
  tb_memory_axi #(
      .AxiAddrWidth(AxiWideOutAddrWidth),
      .AxiDataWidth(AxiWideOutDataWidth),
      .AxiIdWidth(AxiWideOutIdWidth),
      .AxiUserWidth(AxiWideOutUserWidth),
      .req_t(axi_wide_out_req_t),
      .rsp_t(axi_wide_out_rsp_t)
  ) i_wide_hbm_north_memory[1:0] (
      .clk_i (clk_i),
      .rst_ni(rst_ni),
      .req_i (hbm_north_wide_req),
      .rsp_o (hbm_north_wide_rsp)
  );
  // Narrow port into simulation memory.
  tb_memory_axi #(
      .AxiAddrWidth(AxiNarrowOutAddrWidth),
      .AxiDataWidth(AxiNarrowOutDataWidth),
      .AxiIdWidth(AxiNarrowOutIdWidth),
      .AxiUserWidth(AxiNarrowOutUserWidth),
      .req_t(axi_narrow_out_req_t),
      .rsp_t(axi_narrow_out_rsp_t)
  ) i_narrow_hbm_north_memory[1:0] (
      .clk_i (clk_i),
      .rst_ni(rst_ni),
      .req_i (hbm_north_narrow_req),
      .rsp_o (hbm_north_narrow_rsp)
  );

  axi_narrow_out_req_t [1:0] hbm_south_narrow_req;
  axi_narrow_out_rsp_t [1:0] hbm_south_narrow_rsp;
  axi_wide_out_req_t   [1:0] hbm_south_wide_req;
  axi_wide_out_rsp_t   [1:0] hbm_south_wide_rsp;

  tb_memory_axi #(
      .AxiAddrWidth(AxiWideOutAddrWidth),
      .AxiDataWidth(AxiWideOutDataWidth),
      .AxiIdWidth(AxiWideOutIdWidth),
      .AxiUserWidth(AxiWideOutUserWidth),
      .req_t(axi_wide_out_req_t),
      .rsp_t(axi_wide_out_rsp_t)
  ) i_wide_hbm_south_memory[1:0] (
      .clk_i (clk_i),
      .rst_ni(rst_ni),
      .req_i (hbm_south_wide_req),
      .rsp_o (hbm_south_wide_rsp)
  );
  // Narrow port into simulation memory.
  tb_memory_axi #(
      .AxiAddrWidth(AxiNarrowOutAddrWidth),
      .AxiDataWidth(AxiNarrowOutDataWidth),
      .AxiIdWidth(AxiNarrowOutIdWidth),
      .AxiUserWidth(AxiNarrowOutUserWidth),
      .req_t(axi_narrow_out_req_t),
      .rsp_t(axi_narrow_out_rsp_t)
  ) i_narrow_hbm_south_memory[1:0] (
      .clk_i (clk_i),
      .rst_ni(rst_ni),
      .req_i (hbm_south_narrow_req),
      .rsp_o (hbm_south_narrow_rsp)
  );

  axi_narrow_out_req_t [1:0] peripherals_narrow_req;
  axi_narrow_out_rsp_t [1:0] peripherals_narrow_rsp;
  axi_wide_out_req_t   [1:0] peripherals_wide_req;
  axi_wide_out_rsp_t   [1:0] peripherals_wide_rsp;

  tb_memory_axi #(
      .AxiAddrWidth(AxiWideOutAddrWidth),
      .AxiDataWidth(AxiWideOutDataWidth),
      .AxiIdWidth(AxiWideOutIdWidth),
      .AxiUserWidth(AxiWideOutUserWidth),
      .req_t(axi_wide_out_req_t),
      .rsp_t(axi_wide_out_rsp_t)
  ) i_wide_peripherals_memory[1:0] (
      .clk_i (clk_i),
      .rst_ni(rst_ni),
      .req_i (peripherals_wide_req),
      .rsp_o (peripherals_wide_rsp)
  );
  // Narrow port into simulation memory.
  tb_memory_axi #(
      .AxiAddrWidth(AxiNarrowOutAddrWidth),
      .AxiDataWidth(AxiNarrowOutDataWidth),
      .AxiIdWidth(AxiNarrowOutIdWidth),
      .AxiUserWidth(AxiNarrowOutUserWidth),
      .req_t(axi_narrow_out_req_t),
      .rsp_t(axi_narrow_out_rsp_t)
  ) i_narrow_peripherals_memory[1:0] (
      .clk_i (clk_i),
      .rst_ni(rst_ni),
      .req_i (peripherals_narrow_req),
      .rsp_o (peripherals_narrow_rsp)
  );

  //////////////////////////////////
  //   Compute Tile Array (DUT)   //
  //////////////////////////////////

  logic [snitch_cluster_pkg::NrCores-1:0] msip_i;

  // CLINT
  // verilog_lint: waive-start always-ff-non-blocking
  localparam int NumCores = snitch_cluster_pkg::NrCores;
  always_ff @(posedge clk_i) begin
    automatic byte msip_ret[NumCores];
    if (rst_ni) begin
      clint_tick(msip_ret);
      for (int i = 0; i < NumCores; i++) begin
        msip_i[i] = msip_ret[i];
      end
    end
  end
  // verilog_lint: waive-stop always-ff-non-blocking

  compute_tile_array_floo_noc i_compute_tile_array_floo_noc (
      .clk_i(clk),
      .rst_ni(rst_n),
      .test_enable_i(1'b0),

      .msip_i(msip_i),

      .hbm_north_narrow_req_o(hbm_north_narrow_req),
      .hbm_north_narrow_rsp_i(hbm_north_narrow_rsp),
      .hbm_north_wide_req_o(hbm_north_wide_req),
      .hbm_north_wide_rsp_i(hbm_north_wide_rsp),
      .hbm_south_narrow_req_o(hbm_south_narrow_req),
      .hbm_south_narrow_rsp_i(hbm_south_narrow_rsp),
      .hbm_south_wide_req_o(hbm_south_wide_req),
      .hbm_south_wide_rsp_i(hbm_south_wide_rsp),
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
      .peripherals_wide_req_i('0),
      .peripherals_wide_rsp_o(),
      .peripherals_narrow_req_o(peripherals_narrow_req),
      .peripherals_narrow_rsp_i(peripherals_narrow_rsp),
      .peripherals_wide_req_o(peripherals_wide_req),
      .peripherals_wide_rsp_i(peripherals_wide_rsp)
  );

  //   logic [3:0] endsim_cluster;
  //   // Get end_of_sim signal inside DUT
  //   assign endsim_cluster[0] = &tb_floo_bin.i_floo_testharness.i_compute_tile_array_floo_noc.compute_tile_0_0.i_snitch_cluster_test_node.end_of_sim;
  //   assign endsim_cluster[1] = &tb_floo_bin.i_floo_testharness.i_compute_tile_array_floo_noc.compute_tile_0_1.i_snitch_cluster_test_node.end_of_sim;
  //   assign endsim_cluster[2] = &tb_floo_bin.i_floo_testharness.i_compute_tile_array_floo_noc.compute_tile_1_0.i_snitch_cluster_test_node.end_of_sim;
  //   assign endsim_cluster[3] = &tb_floo_bin.i_floo_testharness.i_compute_tile_array_floo_noc.compute_tile_1_1.i_snitch_cluster_test_node.end_of_sim;

  //   initial begin
  //     wait (&endsim_cluster);
  //     // Wait for some time
  //     #100ns;
  //     // Stop the simulation
  //     $display("-- End Simulation --");
  //     $finish;
  //   end

endmodule
