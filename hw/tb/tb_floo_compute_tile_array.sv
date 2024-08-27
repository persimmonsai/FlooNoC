// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

`include "common_cells/assertions.svh"
`include "floo_noc/typedef.svh"

module tb_floo_compute_tile_array;

  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;

  // Import simulation parameter
  import compute_tile_array_test_pkg::*;

  logic clk, rst_n;

  clk_rst_gen #(
      .ClkPeriod   (CyclTime),
      .RstClkCycles(5)
  ) i_clk_gen (
      .clk_o (clk),
      .rst_no(rst_n)
  );

  //////////////////////////////////
  //   Endpoint Simulation Model  //
  //////////////////////////////////

  axi_narrow_out_req_t [1:0] hbm_south_dram_narrow_req;
  axi_narrow_out_rsp_t [1:0] hbm_south_dram_narrow_rsp;
  axi_wide_out_req_t   [1:0] hbm_south_dram_wide_req;
  axi_wide_out_rsp_t   [1:0] hbm_south_dram_wide_rsp;

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
  ) i_floo_wide_hbm_south_dram_model[1:0] (
      .clk_i    (clk),
      .rst_ni   (rst_n),
      .hbm_req_i(hbm_south_dram_wide_req),
      .hbm_rsp_o(hbm_south_dram_wide_rsp)
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
  ) i_floo_narrow_hbm_south_dram_model[1:0] (
      .clk_i    (clk),
      .rst_ni   (rst_n),
      .hbm_req_i(hbm_south_dram_narrow_req),
      .hbm_rsp_o(hbm_south_dram_narrow_rsp)
  );

  axi_narrow_out_req_t [5:0] hbm_south_narrow_req;
  axi_narrow_out_rsp_t [5:0] hbm_south_narrow_rsp;
  axi_wide_out_req_t   [5:0] hbm_south_wide_req;
  axi_wide_out_rsp_t   [5:0] hbm_south_wide_rsp;

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
  ) i_floo_wide_hbm_south_model[5:0] (
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
  ) i_floo_narrow_hbm_south_model[5:0] (
      .clk_i    (clk),
      .rst_ni   (rst_n),
      .hbm_req_i(hbm_south_narrow_req),
      .hbm_rsp_o(hbm_south_narrow_rsp)
  );

  axi_narrow_out_req_t [7:0] hbm_north_narrow_req;
  axi_narrow_out_rsp_t [7:0] hbm_north_narrow_rsp;
  axi_wide_out_req_t   [7:0] hbm_north_wide_req;
  axi_wide_out_rsp_t   [7:0] hbm_north_wide_rsp;

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
  ) i_floo_wide_hbm_north_model[7:0] (
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
  ) i_floo_narrow_hbm_north_model[7:0] (
      .clk_i    (clk),
      .rst_ni   (rst_n),
      .hbm_req_i(hbm_north_narrow_req),
      .hbm_rsp_o(hbm_north_narrow_rsp)
  );

  axi_narrow_out_req_t pcie_narrow_out_req;
  axi_narrow_out_rsp_t pcie_narrow_out_rsp;
  axi_narrow_in_req_t  pcie_narrow_in_req;
  axi_narrow_in_rsp_t  pcie_narrow_in_rsp;

  dma_test_node #(
      .id_x         (0),
      .id_y         (4),
      .is_narrow    (1'b1),
      .axi_out_req_t(axi_narrow_out_req_t),
      .axi_out_rsp_t(axi_narrow_out_rsp_t),
      .axi_in_req_t (axi_narrow_in_req_t),
      .axi_in_rsp_t (axi_narrow_in_rsp_t),
      .AxiAddrWidth (AxiNarrowOutAddrWidth),
      .AxiDataWidth (AxiNarrowOutDataWidth),
      .AxiUserWidth (AxiNarrowOutUserWidth),
      .AxiOutIdWidth(AxiNarrowOutIdWidth),
      .AxiInIdWidth (AxiNarrowInIdWidth),
      .MaxTxnsPerId (NarrowMaxTxnsPerId)
  ) i_floo_narrow_pcie_model (
      .clk_i         (clk),
      .rst_ni        (rst_n),
      .axi_in_req_i  (pcie_narrow_out_req),
      .axi_in_resp_o (pcie_narrow_out_rsp),
      .axi_out_req_o (pcie_narrow_in_req),
      .axi_out_resp_i(pcie_narrow_in_rsp)
  );

  axi_narrow_out_req_t peripherals_narrow_req;
  axi_narrow_out_rsp_t peripherals_narrow_rsp;
  axi_wide_out_req_t   peripherals_wide_req;
  axi_wide_out_rsp_t   peripherals_wide_rsp;

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
  ) i_floo_wide_peripherals_model (
      .clk_i    (clk),
      .rst_ni   (rst_n),
      .hbm_req_i(peripherals_wide_req),
      .hbm_rsp_o(peripherals_wide_rsp)
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
  ) i_floo_narrow_peripherals_model (
      .clk_i    (clk),
      .rst_ni   (rst_n),
      .hbm_req_i(peripherals_narrow_req),
      .hbm_rsp_o(peripherals_narrow_rsp)
  );

  axi_narrow_out_req_t jtag_narrow_out_req;
  axi_narrow_out_rsp_t jtag_narrow_out_rsp;
  axi_narrow_in_req_t  jtag_narrow_in_req;
  axi_narrow_in_rsp_t  jtag_narrow_in_rsp;

  dma_test_node #(
      .id_x         (0),
      .id_y         (2),
      .is_narrow    (1'b1),
      .axi_out_req_t(axi_narrow_out_req_t),
      .axi_out_rsp_t(axi_narrow_out_rsp_t),
      .axi_in_req_t (axi_narrow_in_req_t),
      .axi_in_rsp_t (axi_narrow_in_rsp_t),
      .AxiAddrWidth (AxiNarrowOutAddrWidth),
      .AxiDataWidth (AxiNarrowOutDataWidth),
      .AxiUserWidth (AxiNarrowOutUserWidth),
      .AxiOutIdWidth(AxiNarrowOutIdWidth),
      .AxiInIdWidth (AxiNarrowInIdWidth),
      .MaxTxnsPerId (NarrowMaxTxnsPerId)
  ) i_floo_narrow_jtag_model (
      .clk_i         (clk),
      .rst_ni        (rst_n),
      .axi_in_req_i  (jtag_narrow_out_req),
      .axi_in_resp_o (jtag_narrow_out_rsp),
      .axi_out_req_o (jtag_narrow_in_req),
      .axi_out_resp_i(jtag_narrow_in_rsp)
  );

  axi_narrow_out_req_t cva6_narrow_out_req;
  axi_narrow_out_rsp_t cva6_narrow_out_rsp;
  axi_narrow_in_req_t  cva6_narrow_in_req;
  axi_narrow_in_rsp_t  cva6_narrow_in_rsp;

  dma_test_node #(
      .id_x         (0),
      .id_y         (1),
      .is_narrow    (1'b1),
      .axi_out_req_t(axi_narrow_out_req_t),
      .axi_out_rsp_t(axi_narrow_out_rsp_t),
      .axi_in_req_t (axi_narrow_in_req_t),
      .axi_in_rsp_t (axi_narrow_in_rsp_t),
      .AxiAddrWidth (AxiNarrowOutAddrWidth),
      .AxiDataWidth (AxiNarrowOutDataWidth),
      .AxiUserWidth (AxiNarrowOutUserWidth),
      .AxiOutIdWidth(AxiNarrowOutIdWidth),
      .AxiInIdWidth (AxiNarrowInIdWidth),
      .MaxTxnsPerId (NarrowMaxTxnsPerId)
  ) i_floo_narrow_cva6_model (
      .clk_i         (clk),
      .rst_ni        (rst_n),
      .axi_in_req_i  (cva6_narrow_out_req),
      .axi_in_resp_o (cva6_narrow_out_rsp),
      .axi_out_req_o (cva6_narrow_in_req),
      .axi_out_resp_i(cva6_narrow_in_rsp)
  );

  axi_wide_out_req_t spm_wide_wide_req;
  axi_wide_out_rsp_t spm_wide_wide_rsp;

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
  ) i_floo_wide_spm_wide_model (
      .clk_i    (clk),
      .rst_ni   (rst_n),
      .hbm_req_i(spm_wide_wide_req),
      .hbm_rsp_o(spm_wide_wide_rsp)
  );

  axi_narrow_out_req_t spm_narrow_narrow_req;
  axi_narrow_out_rsp_t spm_narrow_narrow_rsp;

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
  ) i_floo_narrow_spm_narrow_model (
      .clk_i    (clk),
      .rst_ni   (rst_n),
      .hbm_req_i(spm_narrow_narrow_req),
      .hbm_rsp_o(spm_narrow_narrow_rsp)
  );

  axi_narrow_out_req_t idma_narrow_out_req;
  axi_narrow_out_rsp_t idma_narrow_out_rsp;
  axi_wide_out_req_t idma_wide_out_req;
  axi_wide_out_rsp_t idma_wide_out_rsp;
  axi_narrow_in_req_t idma_narrow_in_req;
  axi_narrow_in_rsp_t idma_narrow_in_rsp;
  axi_wide_in_req_t idma_wide_in_req;
  axi_wide_in_rsp_t idma_wide_in_rsp;

  dma_test_node #(
      .id_x         (9),
      .id_y         (2),
      .is_narrow    (1'b0),
      .axi_out_req_t(axi_wide_out_req_t),
      .axi_out_rsp_t(axi_wide_out_rsp_t),
      .axi_in_req_t (axi_wide_in_req_t),
      .axi_in_rsp_t (axi_wide_in_rsp_t),
      .AxiAddrWidth (AxiWideOutAddrWidth),
      .AxiDataWidth (AxiWideOutDataWidth),
      .AxiUserWidth (AxiWideOutUserWidth),
      .AxiOutIdWidth(AxiWideOutIdWidth),
      .AxiInIdWidth (AxiWideInIdWidth),
      .MaxTxnsPerId (WideMaxTxnsPerId)
  ) i_floo_wide_idma_model (
      .clk_i         (clk),
      .rst_ni        (rst_n),
      .axi_in_req_i  (idma_wide_out_req),
      .axi_in_resp_o (idma_wide_out_rsp),
      .axi_out_req_o (idma_wide_in_req),
      .axi_out_resp_i(idma_wide_in_rsp)
  );
  dma_test_node #(
      .id_x         (9),
      .id_y         (2),
      .is_narrow    (1'b1),
      .axi_out_req_t(axi_narrow_out_req_t),
      .axi_out_rsp_t(axi_narrow_out_rsp_t),
      .axi_in_req_t (axi_narrow_in_req_t),
      .axi_in_rsp_t (axi_narrow_in_rsp_t),
      .AxiAddrWidth (AxiNarrowOutAddrWidth),
      .AxiDataWidth (AxiNarrowOutDataWidth),
      .AxiUserWidth (AxiNarrowOutUserWidth),
      .AxiOutIdWidth(AxiNarrowOutIdWidth),
      .AxiInIdWidth (AxiNarrowInIdWidth),
      .MaxTxnsPerId (NarrowMaxTxnsPerId)
  ) i_floo_narrow_idma_model (
      .clk_i         (clk),
      .rst_ni        (rst_n),
      .axi_in_req_i  (idma_narrow_out_req),
      .axi_in_resp_o (idma_narrow_out_rsp),
      .axi_out_req_o (idma_narrow_in_req),
      .axi_out_resp_i(idma_narrow_in_rsp)
  );

  axi_wide_out_req_t zero_mem_wide_req;
  axi_wide_out_rsp_t zero_mem_wide_rsp;

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
  ) i_floo_wide_zero_mem_model (
      .clk_i    (clk),
      .rst_ni   (rst_n),
      .hbm_req_i(zero_mem_wide_req),
      .hbm_rsp_o(zero_mem_wide_rsp)
  );


  //////////////////////////////////
  //   Compute Tile Array (DUT)   //
  //////////////////////////////////

  logic [64:1] mtip_i;
  logic [64:1] msip_i;
  assign mtip_i = 'b0;
  assign msip_i = 'b0;

  // occamy_pkg::sram_cfgs_t = sram_cfgs_i;
  // assign sram_cfgs_i = 'b0;

  chiplet_floo_noc i_chiplet_floo_noc (
      .clk_i(clk),
      .rst_ni(rst_n),
      .test_enable_i(1'b0),

      .mtip_i(mtip_i),
      .msip_i(msip_i),
      // .sram_cfgs_i(sram_cfgs_i),

      .hbm_south_dram_narrow_req_o(hbm_south_dram_narrow_req),
      .hbm_south_dram_narrow_rsp_i(hbm_south_dram_narrow_rsp),
      .hbm_south_dram_wide_req_o(hbm_south_dram_wide_req),
      .hbm_south_dram_wide_rsp_i(hbm_south_dram_wide_rsp),
      .hbm_south_narrow_req_o(hbm_south_narrow_req),
      .hbm_south_narrow_rsp_i(hbm_south_narrow_rsp),
      .hbm_south_wide_req_o(hbm_south_wide_req),
      .hbm_south_wide_rsp_i(hbm_south_wide_rsp),
      .hbm_north_narrow_req_o(hbm_north_narrow_req),
      .hbm_north_narrow_rsp_i(hbm_north_narrow_rsp),
      .hbm_north_wide_req_o(hbm_north_wide_req),
      .hbm_north_wide_rsp_i(hbm_north_wide_rsp),
      .pcie_narrow_req_i(pcie_narrow_in_req),
      .pcie_narrow_rsp_o(pcie_narrow_in_rsp),
      .pcie_narrow_req_o(pcie_narrow_out_req),
      .pcie_narrow_rsp_i(pcie_narrow_out_rsp),
      .peripherals_narrow_req_o(peripherals_narrow_req),
      .peripherals_narrow_rsp_i(peripherals_narrow_rsp),
      .peripherals_wide_req_o(peripherals_wide_req),
      .peripherals_wide_rsp_i(peripherals_wide_rsp),
      .jtag_narrow_req_i(jtag_narrow_in_req),
      .jtag_narrow_rsp_o(jtag_narrow_in_rsp),
      .jtag_narrow_req_o(jtag_narrow_out_req),
      .jtag_narrow_rsp_i(jtag_narrow_out_rsp),
      .cva6_narrow_req_i(cva6_narrow_in_req),
      .cva6_narrow_rsp_o(cva6_narrow_in_rsp),
      .cva6_narrow_req_o(cva6_narrow_out_req),
      .cva6_narrow_rsp_i(cva6_narrow_out_rsp),
      .spm_wide_wide_req_o(spm_wide_wide_req),
      .spm_wide_wide_rsp_i(spm_wide_wide_rsp),
      .spm_narrow_narrow_req_o(spm_narrow_narrow_req),
      .spm_narrow_narrow_rsp_i(spm_narrow_narrow_rsp),
      .idma_narrow_req_i(idma_narrow_in_req),
      .idma_narrow_rsp_o(idma_narrow_in_rsp),
      .idma_wide_req_i(idma_wide_in_req),
      .idma_wide_rsp_o(idma_wide_in_rsp),
      .idma_narrow_req_o(idma_narrow_out_req),
      .idma_narrow_rsp_i(idma_narrow_out_rsp),
      .idma_wide_req_o(idma_wide_out_req),
      .idma_wide_rsp_i(idma_wide_out_rsp),
      .zero_mem_wide_req_o(zero_mem_wide_req),
      .zero_mem_wide_rsp_i(zero_mem_wide_rsp)

  );

  logic [36:0] endsim_cluster;
  // Get end_of_sim signal inside DUT
  assign endsim_cluster[0] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_0_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[1] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_0_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[2] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_0_2.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[3] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_0_3.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[4] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_1_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[5] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_1_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[6] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_1_2.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[7] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_1_3.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[8] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_2_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[9] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_2_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[10] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_2_2.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[11] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_2_3.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[12] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_3_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[13] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_3_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[14] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_3_2.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[15] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_3_3.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[16] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_4_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[17] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_4_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[18] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_4_2.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[19] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_4_3.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[20] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_5_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[21] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_5_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[22] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_5_2.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[23] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_5_3.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[24] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_6_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[25] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_6_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[26] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_6_2.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[27] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_6_3.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[28] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_7_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[29] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_7_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[30] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_7_2.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[31] = &tb_floo_compute_tile_array.i_chiplet_floo_noc.compute_tile_7_3.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[32] = &tb_floo_compute_tile_array.i_floo_narrow_pcie_model.end_of_sim;
  assign endsim_cluster[33] = &tb_floo_compute_tile_array.i_floo_narrow_jtag_model.end_of_sim;
  assign endsim_cluster[34] = &tb_floo_compute_tile_array.i_floo_narrow_cva6_model.end_of_sim;
  assign endsim_cluster[35] = &tb_floo_compute_tile_array.i_floo_narrow_idma_model.end_of_sim;
  assign endsim_cluster[36] = &tb_floo_compute_tile_array.i_floo_wide_idma_model.end_of_sim;

  initial begin
    wait (&endsim_cluster);
    // Wait for some time
    #100ns;
    // Stop the simulation
    $display("-- End Simulation --");
    $finish;
  end

endmodule
