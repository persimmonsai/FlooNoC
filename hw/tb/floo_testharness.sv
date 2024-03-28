// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

`include "common_cells/assertions.svh"
`include "floo_noc/typedef.svh"

module floo_testharness
  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;
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

  tb_memory_axi #(
      .AxiAddrWidth(AxiWideOutAddrWidth),
      .AxiDataWidth(AxiWideOutDataWidth),
      .AxiUserWidth(AxiWideOutUserWidth),
      .AxiIdWidth  (AxiWideOutIdWidth),
      .req_t       (axi_wide_out_req_t),
      .rsp_t       (axi_wide_out_rsp_t)
  ) i_wide_hbm_north_memory[1:0] (
      .clk_i (clk_i),
      .rst_ni(rst_ni),
      .req_i (hbm_north_wide_req),
      .rsp_o (hbm_north_wide_rsp)
  );
  tb_memory_axi #(
      .AxiAddrWidth(AxiNarrowOutAddrWidth),
      .AxiDataWidth(AxiNarrowOutDataWidth),
      .AxiUserWidth(AxiNarrowOutUserWidth),
      .AxiIdWidth  (AxiNarrowOutIdWidth),
      .req_t       (axi_narrow_out_req_t),
      .rsp_t       (axi_narrow_out_rsp_t)
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
      .AxiUserWidth(AxiWideOutUserWidth),
      .AxiIdWidth  (AxiWideOutIdWidth),
      .req_t       (axi_wide_out_req_t),
      .rsp_t       (axi_wide_out_rsp_t)
  ) i_wide_hbm_south_memory[1:0] (
      .clk_i (clk_i),
      .rst_ni(rst_ni),
      .req_i (hbm_south_wide_req),
      .rsp_o (hbm_south_wide_rsp)
  );
  tb_memory_axi #(
      .AxiAddrWidth(AxiNarrowOutAddrWidth),
      .AxiDataWidth(AxiNarrowOutDataWidth),
      .AxiUserWidth(AxiNarrowOutUserWidth),
      .AxiIdWidth  (AxiNarrowOutIdWidth),
      .req_t       (axi_narrow_out_req_t),
      .rsp_t       (axi_narrow_out_rsp_t)
  ) i_narrow_hbm_south_memory[1:0] (
      .clk_i (clk_i),
      .rst_ni(rst_ni),
      .req_i (hbm_south_narrow_req),
      .rsp_o (hbm_south_narrow_rsp)
  );

  axi_narrow_out_req_t bootrom_narrow_req;
  axi_narrow_out_rsp_t bootrom_narrow_rsp;
  axi_wide_out_req_t   bootrom_wide_req;
  axi_wide_out_rsp_t   bootrom_wide_rsp;

  tb_memory_axi #(
      .AxiAddrWidth(AxiWideOutAddrWidth),
      .AxiDataWidth(AxiWideOutDataWidth),
      .AxiUserWidth(AxiWideOutUserWidth),
      .AxiIdWidth  (AxiWideOutIdWidth),
      .req_t       (axi_wide_out_req_t),
      .rsp_t       (axi_wide_out_rsp_t)
  ) i_wide_bootrom_memory (
      .clk_i (clk_i),
      .rst_ni(rst_ni),
      .req_i (bootrom_wide_req),
      .rsp_o (bootrom_wide_rsp)
  );
  tb_memory_axi #(
      .AxiAddrWidth(AxiNarrowOutAddrWidth),
      .AxiDataWidth(AxiNarrowOutDataWidth),
      .AxiUserWidth(AxiNarrowOutUserWidth),
      .AxiIdWidth  (AxiNarrowOutIdWidth),
      .req_t       (axi_narrow_out_req_t),
      .rsp_t       (axi_narrow_out_rsp_t)
  ) i_narrow_bootrom_memory (
      .clk_i (clk_i),
      .rst_ni(rst_ni),
      .req_i (bootrom_narrow_req),
      .rsp_o (bootrom_narrow_rsp)
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
      .clk_i(clk_i),
      .rst_ni(rst_ni),
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
      .bootrom_narrow_req_o(bootrom_narrow_req),
      .bootrom_narrow_rsp_i(bootrom_narrow_rsp),
      .bootrom_wide_req_o(bootrom_wide_req),
      .bootrom_wide_rsp_i(bootrom_wide_rsp),
      .peripherals_narrow_req_i('0),
      .peripherals_narrow_rsp_o(),
      .peripherals_narrow_req_o(),
      .peripherals_narrow_rsp_i('0)

  );

endmodule
