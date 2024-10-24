// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

`include "common_cells/assertions.svh"
`include "floo_noc/typedef.svh"

module tb_floo_compute_tile_array_pd;

  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;

  // Import simulation parameter
  import compute_tile_array_test_pkg::*;

  logic clk_i, rst_ni;

  clk_rst_gen #(
      .ClkPeriod   (CyclTime),
      .RstClkCycles(5)
  ) i_clk_gen (
      .clk_o (clk_i),
      .rst_no(rst_ni)
  );

  initial begin
    if ($test$plusargs("fsdbon")) begin
      $fsdbDumpfile("floonoc.fsdb");
      $fsdbDumpvars(0, "+all");
    end
  end

  //////////////////////////////////
  //   Endpoint Simulation Model  //
  //////////////////////////////////

  //--------------------------------------------------
  // HBM Controller + PHY

  floo_req_t [3:0] hbm_north_floo_req_i;
  floo_rsp_t [3:0] hbm_north_floo_rsp_i;
  floo_wide_t [3:0] hbm_north_floo_wide_i;
  floo_req_t [3:0] hbm_north_floo_req_o;
  floo_rsp_t [3:0] hbm_north_floo_rsp_o;
  floo_wide_t [3:0] hbm_north_floo_wide_o;
  floo_req_t [3:0] hbm_south_floo_req_i;
  floo_rsp_t [3:0] hbm_south_floo_rsp_i;
  floo_wide_t [3:0] hbm_south_floo_wide_i;
  floo_req_t [3:0] hbm_south_floo_req_o;
  floo_rsp_t [3:0] hbm_south_floo_rsp_o;
  floo_wide_t [3:0] hbm_south_floo_wide_o;
  floo_req_t [3:0] hbm_west_floo_req_i;
  floo_rsp_t [3:0] hbm_west_floo_rsp_i;
  floo_wide_t [3:0] hbm_west_floo_wide_i;
  floo_req_t [3:0] hbm_west_floo_req_o;
  floo_rsp_t [3:0] hbm_west_floo_rsp_o;
  floo_wide_t [3:0] hbm_west_floo_wide_o;
  floo_req_t [3:0] hbm_east_floo_req_i;
  floo_rsp_t [3:0] hbm_east_floo_rsp_i;
  floo_wide_t [3:0] hbm_east_floo_wide_i;
  floo_req_t [3:0] hbm_east_floo_req_o;
  floo_rsp_t [3:0] hbm_east_floo_rsp_o;
  floo_wide_t [3:0] hbm_east_floo_wide_o;

  localparam id_t hbm_north_dram_0_ni_id = '{x: 3, y: 5};
  hbm_1ch_pd_testnode i_hbm_north_0_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_north_dram_0_ni_id),
      .floo_req_o(hbm_north_floo_req_i[0]),
      .floo_rsp_o(hbm_north_floo_rsp_i[0]),
      .floo_wide_o(hbm_north_floo_wide_i[0]),
      .floo_req_i(hbm_north_floo_req_o[0]),
      .floo_rsp_i(hbm_north_floo_rsp_o[0]),
      .floo_wide_i(hbm_north_floo_wide_o[0])
  );

  localparam id_t hbm_north_dram_1_ni_id = '{x: 5, y: 5};
  hbm_1ch_pd_testnode i_hbm_north_1_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_north_dram_1_ni_id),
      .floo_req_o(hbm_north_floo_req_i[1]),
      .floo_rsp_o(hbm_north_floo_rsp_i[1]),
      .floo_wide_o(hbm_north_floo_wide_i[1]),
      .floo_req_i(hbm_north_floo_req_o[1]),
      .floo_rsp_i(hbm_north_floo_rsp_o[1]),
      .floo_wide_i(hbm_north_floo_wide_o[1])
  );

  localparam id_t hbm_north_2_ni_id = '{x: 2, y: 5};
  hbm_1ch_pd_testnode i_hbm_north_2_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_north_2_ni_id),
      .floo_req_o(hbm_north_floo_req_i[2]),
      .floo_rsp_o(hbm_north_floo_rsp_i[2]),
      .floo_wide_o(hbm_north_floo_wide_i[2]),
      .floo_req_i(hbm_north_floo_req_o[2]),
      .floo_rsp_i(hbm_north_floo_rsp_o[2]),
      .floo_wide_i(hbm_north_floo_wide_o[2])
  );

  localparam id_t hbm_north_3_ni_id = '{x: 6, y: 5};
  hbm_1ch_pd_testnode i_hbm_north_3_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_north_3_ni_id),
      .floo_req_o(hbm_north_floo_req_i[3]),
      .floo_rsp_o(hbm_north_floo_rsp_i[3]),
      .floo_wide_o(hbm_north_floo_wide_i[3]),
      .floo_req_i(hbm_north_floo_req_o[3]),
      .floo_rsp_i(hbm_north_floo_rsp_o[3]),
      .floo_wide_i(hbm_north_floo_wide_o[3])
  );

  localparam id_t hbm_south_0_ni_0_0_id = '{x: 2, y: 0};
  hbm_1ch_pd_testnode i_hbm_south_0_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_south_0_ni_0_0_id),
      .floo_req_o(hbm_south_floo_req_i[0]),
      .floo_rsp_o(hbm_south_floo_rsp_i[0]),
      .floo_wide_o(hbm_south_floo_wide_i[0]),
      .floo_req_i(hbm_south_floo_req_o[0]),
      .floo_rsp_i(hbm_south_floo_rsp_o[0]),
      .floo_wide_i(hbm_south_floo_wide_o[0])
  );

  localparam id_t hbm_south_0_ni_1_0_id = '{x: 3, y: 0};
  hbm_1ch_pd_testnode i_hbm_south_1_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_south_0_ni_1_0_id),
      .floo_req_o(hbm_south_floo_req_i[1]),
      .floo_rsp_o(hbm_south_floo_rsp_i[1]),
      .floo_wide_o(hbm_south_floo_wide_i[1]),
      .floo_req_i(hbm_south_floo_req_o[1]),
      .floo_rsp_i(hbm_south_floo_rsp_o[1]),
      .floo_wide_i(hbm_south_floo_wide_o[1])
  );

  localparam id_t hbm_south_2_ni_0_0_id = '{x: 5, y: 0};
  hbm_1ch_pd_testnode i_hbm_south_2_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_south_2_ni_0_0_id),
      .floo_req_o(hbm_south_floo_req_i[2]),
      .floo_rsp_o(hbm_south_floo_rsp_i[2]),
      .floo_wide_o(hbm_south_floo_wide_i[2]),
      .floo_req_i(hbm_south_floo_req_o[2]),
      .floo_rsp_i(hbm_south_floo_rsp_o[2]),
      .floo_wide_i(hbm_south_floo_wide_o[2])
  );

  localparam id_t hbm_south_2_ni_1_0_id = '{x: 6, y: 0};
  hbm_1ch_pd_testnode i_hbm_south_3_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_south_2_ni_1_0_id),
      .floo_req_o(hbm_south_floo_req_i[3]),
      .floo_rsp_o(hbm_south_floo_rsp_i[3]),
      .floo_wide_o(hbm_south_floo_wide_i[3]),
      .floo_req_i(hbm_south_floo_req_o[3]),
      .floo_rsp_i(hbm_south_floo_rsp_o[3]),
      .floo_wide_i(hbm_south_floo_wide_o[3])
  );

  localparam id_t hbm_west_ni_0_0_id = '{x: 0, y: 1};
  hbm_1ch_pd_testnode i_hbm_west_0_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_west_ni_0_0_id),
      .floo_req_o(hbm_west_floo_req_i[0]),
      .floo_rsp_o(hbm_west_floo_rsp_i[0]),
      .floo_wide_o(hbm_west_floo_wide_i[0]),
      .floo_req_i(hbm_west_floo_req_o[0]),
      .floo_rsp_i(hbm_west_floo_rsp_o[0]),
      .floo_wide_i(hbm_west_floo_wide_o[0])
  );

  localparam id_t hbm_west_ni_0_1_id = '{x: 0, y: 2};
  hbm_1ch_pd_testnode i_hbm_west_1_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_west_ni_0_1_id),
      .floo_req_o(hbm_west_floo_req_i[1]),
      .floo_rsp_o(hbm_west_floo_rsp_i[1]),
      .floo_wide_o(hbm_west_floo_wide_i[1]),
      .floo_req_i(hbm_west_floo_req_o[1]),
      .floo_rsp_i(hbm_west_floo_rsp_o[1]),
      .floo_wide_i(hbm_west_floo_wide_o[1])
  );

  localparam id_t hbm_west_ni_0_2_id = '{x: 0, y: 3};
  hbm_1ch_pd_testnode i_hbm_west_2_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_west_ni_0_2_id),
      .floo_req_o(hbm_west_floo_req_i[2]),
      .floo_rsp_o(hbm_west_floo_rsp_i[2]),
      .floo_wide_o(hbm_west_floo_wide_i[2]),
      .floo_req_i(hbm_west_floo_req_o[2]),
      .floo_rsp_i(hbm_west_floo_rsp_o[2]),
      .floo_wide_i(hbm_west_floo_wide_o[2])
  );

  localparam id_t hbm_west_ni_0_3_id = '{x: 0, y: 4};
  hbm_1ch_pd_testnode i_hbm_west_3_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_west_ni_0_3_id),
      .floo_req_o(hbm_west_floo_req_i[3]),
      .floo_rsp_o(hbm_west_floo_rsp_i[3]),
      .floo_wide_o(hbm_west_floo_wide_i[3]),
      .floo_req_i(hbm_west_floo_req_o[3]),
      .floo_rsp_i(hbm_west_floo_rsp_o[3]),
      .floo_wide_i(hbm_west_floo_wide_o[3])
  );

  localparam id_t hbm_east_ni_0_0_id = '{x: 8, y: 1};
  hbm_1ch_pd_testnode i_hbm_east_0_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_east_ni_0_0_id),
      .floo_req_o(hbm_east_floo_req_i[0]),
      .floo_rsp_o(hbm_east_floo_rsp_i[0]),
      .floo_wide_o(hbm_east_floo_wide_i[0]),
      .floo_req_i(hbm_east_floo_req_o[0]),
      .floo_rsp_i(hbm_east_floo_rsp_o[0]),
      .floo_wide_i(hbm_east_floo_wide_o[0])
  );

  localparam id_t hbm_east_ni_0_1_id = '{x: 8, y: 2};
  hbm_1ch_pd_testnode i_hbm_east_1_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_east_ni_0_1_id),
      .floo_req_o(hbm_east_floo_req_i[1]),
      .floo_rsp_o(hbm_east_floo_rsp_i[1]),
      .floo_wide_o(hbm_east_floo_wide_i[1]),
      .floo_req_i(hbm_east_floo_req_o[1]),
      .floo_rsp_i(hbm_east_floo_rsp_o[1]),
      .floo_wide_i(hbm_east_floo_wide_o[1])
  );

  localparam id_t hbm_east_ni_0_2_id = '{x: 8, y: 3};
  hbm_1ch_pd_testnode i_hbm_east_2_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_east_ni_0_2_id),
      .floo_req_o(hbm_east_floo_req_i[2]),
      .floo_rsp_o(hbm_east_floo_rsp_i[2]),
      .floo_wide_o(hbm_east_floo_wide_i[2]),
      .floo_req_i(hbm_east_floo_req_o[2]),
      .floo_rsp_i(hbm_east_floo_rsp_o[2]),
      .floo_wide_i(hbm_east_floo_wide_o[2])
  );

  localparam id_t hbm_east_ni_0_3_id = '{x: 8, y: 4};
  hbm_1ch_pd_testnode i_hbm_east_3_pd_top (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),
      // FlooNoC interface
      .ni_id_i(hbm_east_ni_0_3_id),
      .floo_req_o(hbm_east_floo_req_i[3]),
      .floo_rsp_o(hbm_east_floo_rsp_i[3]),
      .floo_wide_o(hbm_east_floo_wide_i[3]),
      .floo_req_i(hbm_east_floo_req_o[3]),
      .floo_rsp_i(hbm_east_floo_rsp_o[3]),
      .floo_wide_i(hbm_east_floo_wide_o[3])
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
      .id_x         (4),
      .id_y         (5),
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
      .clk_i         (clk_i),
      .rst_ni        (rst_ni),
      .axi_in_req_i  (idma_wide_out_req),
      .axi_in_resp_o (idma_wide_out_rsp),
      .axi_out_req_o (idma_wide_in_req),
      .axi_out_resp_i(idma_wide_in_rsp)
  );
  dma_test_node #(
      .id_x         (4),
      .id_y         (5),
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
      .clk_i         (clk_i),
      .rst_ni        (rst_ni),
      .axi_in_req_i  (idma_narrow_out_req),
      .axi_in_resp_o (idma_narrow_out_rsp),
      .axi_out_req_o (idma_narrow_in_req),
      .axi_out_resp_i(idma_narrow_in_rsp)
  );

  axi_narrow_out_req_t spm_narrow_req;
  axi_narrow_out_rsp_t spm_narrow_rsp;
  axi_wide_out_req_t   spm_wide_req;
  axi_wide_out_rsp_t   spm_wide_rsp;

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
  ) i_floo_wide_spm_model (
      .clk_i    (clk_i),
      .rst_ni   (rst_ni),
      .hbm_req_i(spm_wide_req),
      .hbm_rsp_o(spm_wide_rsp)
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
  ) i_floo_narrow_spm_model (
      .clk_i    (clk_i),
      .rst_ni   (rst_ni),
      .hbm_req_i(spm_narrow_req),
      .hbm_rsp_o(spm_narrow_rsp)
  );

  axi_narrow_out_req_t cva6_narrow_out_req;
  axi_narrow_out_rsp_t cva6_narrow_out_rsp;
  axi_narrow_in_req_t  cva6_narrow_in_req;
  axi_narrow_in_rsp_t  cva6_narrow_in_rsp;

  dma_test_node #(
      .id_x         (4),
      .id_y         (3),
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
      .clk_i         (clk_i),
      .rst_ni        (rst_ni),
      .axi_in_req_i  (cva6_narrow_out_req),
      .axi_in_resp_o (cva6_narrow_out_rsp),
      .axi_out_req_o (cva6_narrow_in_req),
      .axi_out_resp_i(cva6_narrow_in_rsp)
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
      .clk_i    (clk_i),
      .rst_ni   (rst_ni),
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
      .clk_i    (clk_i),
      .rst_ni   (rst_ni),
      .hbm_req_i(peripherals_narrow_req),
      .hbm_rsp_o(peripherals_narrow_rsp)
  );

  axi_narrow_out_req_t jtag_narrow_out_req;
  axi_narrow_out_rsp_t jtag_narrow_out_rsp;
  axi_narrow_in_req_t  jtag_narrow_in_req;
  axi_narrow_in_rsp_t  jtag_narrow_in_rsp;

  dma_test_node #(
      .id_x         (4),
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
  ) i_floo_narrow_jtag_model (
      .clk_i         (clk_i),
      .rst_ni        (rst_ni),
      .axi_in_req_i  (jtag_narrow_out_req),
      .axi_in_resp_o (jtag_narrow_out_rsp),
      .axi_out_req_o (jtag_narrow_in_req),
      .axi_out_resp_i(jtag_narrow_in_rsp)
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
      .clk_i    (clk_i),
      .rst_ni   (rst_ni),
      .hbm_req_i(zero_mem_wide_req),
      .hbm_rsp_o(zero_mem_wide_rsp)
  );


  //////////////////////////////////
  //   Compute Tile Array (DUT)   //
  //////////////////////////////////

  // HBM north interface between Chip Top level and SoC
  floo_req_t [3:0] hbm_north_floo_req_soc_i;
  floo_rsp_t [3:0] hbm_north_floo_rsp_soc_i;
  floo_wide_t [3:0] hbm_north_floo_wide_soc_i;
  floo_req_t [3:0] hbm_north_floo_req_soc_o;
  floo_rsp_t [3:0] hbm_north_floo_rsp_soc_o;
  floo_wide_t [3:0] hbm_north_floo_wide_soc_o;
  floo_req_t [3:0] hbm_north_floo_req_top_i;
  floo_rsp_t [3:0] hbm_north_floo_rsp_top_i;
  floo_wide_t [3:0] hbm_north_floo_wide_top_i;
  floo_req_t [3:0] hbm_north_floo_req_top_o;
  floo_rsp_t [3:0] hbm_north_floo_rsp_top_o;
  floo_wide_t [3:0] hbm_north_floo_wide_top_o;
  // HBM south interface between Chip Top level and SoC
  floo_req_t [3:0] hbm_south_floo_req_soc_i;
  floo_rsp_t [3:0] hbm_south_floo_rsp_soc_i;
  floo_wide_t [3:0] hbm_south_floo_wide_soc_i;
  floo_req_t [3:0] hbm_south_floo_req_soc_o;
  floo_rsp_t [3:0] hbm_south_floo_rsp_soc_o;
  floo_wide_t [3:0] hbm_south_floo_wide_soc_o;
  floo_req_t [3:0] hbm_south_floo_req_top_i;
  floo_rsp_t [3:0] hbm_south_floo_rsp_top_i;
  floo_wide_t [3:0] hbm_south_floo_wide_top_i;
  floo_req_t [3:0] hbm_south_floo_req_top_o;
  floo_rsp_t [3:0] hbm_south_floo_rsp_top_o;
  floo_wide_t [3:0] hbm_south_floo_wide_top_o;
  // HBM west interface between Chip Top level and SoC
  floo_req_t [3:0] hbm_west_floo_req_soc_i;
  floo_rsp_t [3:0] hbm_west_floo_rsp_soc_i;
  floo_wide_t [3:0] hbm_west_floo_wide_soc_i;
  floo_req_t [3:0] hbm_west_floo_req_soc_o;
  floo_rsp_t [3:0] hbm_west_floo_rsp_soc_o;
  floo_wide_t [3:0] hbm_west_floo_wide_soc_o;
  floo_req_t [3:0] hbm_west_floo_req_top_i;
  floo_rsp_t [3:0] hbm_west_floo_rsp_top_i;
  floo_wide_t [3:0] hbm_west_floo_wide_top_i;
  floo_req_t [3:0] hbm_west_floo_req_top_o;
  floo_rsp_t [3:0] hbm_west_floo_rsp_top_o;
  floo_wide_t [3:0] hbm_west_floo_wide_top_o;
  // HBM east interface between Chip Top level and SoC
  floo_req_t [3:0] hbm_east_floo_req_soc_i;
  floo_rsp_t [3:0] hbm_east_floo_rsp_soc_i;
  floo_wide_t [3:0] hbm_east_floo_wide_soc_i;
  floo_req_t [3:0] hbm_east_floo_req_soc_o;
  floo_rsp_t [3:0] hbm_east_floo_rsp_soc_o;
  floo_wide_t [3:0] hbm_east_floo_wide_soc_o;
  floo_req_t [3:0] hbm_east_floo_req_top_i;
  floo_rsp_t [3:0] hbm_east_floo_rsp_top_i;
  floo_wide_t [3:0] hbm_east_floo_wide_top_i;
  floo_req_t [3:0] hbm_east_floo_req_top_o;
  floo_rsp_t [3:0] hbm_east_floo_rsp_top_o;
  floo_wide_t [3:0] hbm_east_floo_wide_top_o;

  chiplet_soc i_chiplet_soc (
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(1'b0),

      .mtip_i('0),
      .msip_i('0),

      .hbm_north_floo_req_i(hbm_north_floo_req_soc_i),
      .hbm_north_floo_rsp_i(hbm_north_floo_rsp_soc_i),
      .hbm_north_floo_wide_i(hbm_north_floo_wide_soc_i),
      .hbm_north_floo_req_o(hbm_north_floo_req_soc_o),
      .hbm_north_floo_rsp_o(hbm_north_floo_rsp_soc_o),
      .hbm_north_floo_wide_o(hbm_north_floo_wide_soc_o),
      .hbm_south_floo_req_i(hbm_south_floo_req_soc_i),
      .hbm_south_floo_rsp_i(hbm_south_floo_rsp_soc_i),
      .hbm_south_floo_wide_i(hbm_south_floo_wide_soc_i),
      .hbm_south_floo_req_o(hbm_south_floo_req_soc_o),
      .hbm_south_floo_rsp_o(hbm_south_floo_rsp_soc_o),
      .hbm_south_floo_wide_o(hbm_south_floo_wide_soc_o),
      .hbm_west_floo_req_i(hbm_west_floo_req_soc_i),
      .hbm_west_floo_rsp_i(hbm_west_floo_rsp_soc_i),
      .hbm_west_floo_wide_i(hbm_west_floo_wide_soc_i),
      .hbm_west_floo_req_o(hbm_west_floo_req_soc_o),
      .hbm_west_floo_rsp_o(hbm_west_floo_rsp_soc_o),
      .hbm_west_floo_wide_o(hbm_west_floo_wide_soc_o),
      .hbm_east_floo_req_i(hbm_east_floo_req_soc_i),
      .hbm_east_floo_rsp_i(hbm_east_floo_rsp_soc_i),
      .hbm_east_floo_wide_i(hbm_east_floo_wide_soc_i),
      .hbm_east_floo_req_o(hbm_east_floo_req_soc_o),
      .hbm_east_floo_rsp_o(hbm_east_floo_rsp_soc_o),
      .hbm_east_floo_wide_o(hbm_east_floo_wide_soc_o),

      .idma_narrow_req_i(idma_narrow_in_req),
      .idma_narrow_rsp_o(idma_narrow_in_rsp),
      .idma_wide_req_i(idma_wide_in_req),
      .idma_wide_rsp_o(idma_wide_in_rsp),
      .idma_narrow_req_o(idma_narrow_out_req),
      .idma_narrow_rsp_i(idma_narrow_out_rsp),
      .idma_wide_req_o(idma_wide_out_req),
      .idma_wide_rsp_i(idma_wide_out_rsp),
      .spm_narrow_req_o(spm_narrow_req),
      .spm_narrow_rsp_i(spm_narrow_rsp),
      .spm_wide_req_o(spm_wide_req),
      .spm_wide_rsp_i(spm_wide_rsp),
      .cva6_narrow_req_i(cva6_narrow_in_req),
      .cva6_narrow_rsp_o(cva6_narrow_in_rsp),
      .cva6_narrow_req_o(cva6_narrow_out_req),
      .cva6_narrow_rsp_i(cva6_narrow_out_rsp),
      .peripherals_narrow_req_o(peripherals_narrow_req),
      .peripherals_narrow_rsp_i(peripherals_narrow_rsp),
      .peripherals_wide_req_o(peripherals_wide_req),
      .peripherals_wide_rsp_i(peripherals_wide_rsp),
      .jtag_narrow_req_i(jtag_narrow_in_req),
      .jtag_narrow_rsp_o(jtag_narrow_in_rsp),
      .jtag_narrow_req_o(jtag_narrow_out_req),
      .jtag_narrow_rsp_i(jtag_narrow_out_rsp),
      .zero_mem_wide_req_o(zero_mem_wide_req),
      .zero_mem_wide_rsp_i(zero_mem_wide_rsp)
  );

  /////////////////////////////
  // Floo HBM Cuts Interface //
  /////////////////////////////


  // Generate hbm interface cuts
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_req_chan_t)
  ) i_floo_req_hbm_north_0_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_north_floo_req_soc_o[0].valid, hbm_north_floo_req_top_i[0].valid}),
      .ready_i({hbm_north_floo_req_top_i[0].ready, hbm_north_floo_req_soc_o[0].ready}),
      .data_i ({hbm_north_floo_req_soc_o[0].req, hbm_north_floo_req_top_i[0].req}),
      .valid_o({hbm_north_floo_req_top_o[0].valid, hbm_north_floo_req_soc_i[0].valid}),
      .ready_o({hbm_north_floo_req_soc_i[0].ready, hbm_north_floo_req_top_o[0].ready}),
      .data_o ({hbm_north_floo_req_top_o[0].req, hbm_north_floo_req_soc_i[0].req})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_rsp_chan_t)
  ) i_floo_rsp_hbm_north_0_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_north_floo_rsp_soc_o[0].valid, hbm_north_floo_rsp_top_i[0].valid}),
      .ready_i({hbm_north_floo_rsp_top_i[0].ready, hbm_north_floo_rsp_soc_o[0].ready}),
      .data_i ({hbm_north_floo_rsp_soc_o[0].rsp, hbm_north_floo_rsp_top_i[0].rsp}),
      .valid_o({hbm_north_floo_rsp_top_o[0].valid, hbm_north_floo_rsp_soc_i[0].valid}),
      .ready_o({hbm_north_floo_rsp_soc_i[0].ready, hbm_north_floo_rsp_top_o[0].ready}),
      .data_o ({hbm_north_floo_rsp_top_o[0].rsp, hbm_north_floo_rsp_soc_i[0].rsp})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_wide_chan_t)
  ) i_floo_wide_hbm_north_0_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_north_floo_wide_soc_o[0].valid, hbm_north_floo_wide_top_i[0].valid}),
      .ready_i({hbm_north_floo_wide_top_i[0].ready, hbm_north_floo_wide_soc_o[0].ready}),
      .data_i ({hbm_north_floo_wide_soc_o[0].wide, hbm_north_floo_wide_top_i[0].wide}),
      .valid_o({hbm_north_floo_wide_top_o[0].valid, hbm_north_floo_wide_soc_i[0].valid}),
      .ready_o({hbm_north_floo_wide_soc_i[0].ready, hbm_north_floo_wide_top_o[0].ready}),
      .data_o ({hbm_north_floo_wide_top_o[0].wide, hbm_north_floo_wide_soc_i[0].wide})
  );

  // Generate hbm interface cuts
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_req_chan_t)
  ) i_floo_req_hbm_north_1_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_north_floo_req_soc_o[1].valid, hbm_north_floo_req_top_i[1].valid}),
      .ready_i({hbm_north_floo_req_top_i[1].ready, hbm_north_floo_req_soc_o[1].ready}),
      .data_i ({hbm_north_floo_req_soc_o[1].req, hbm_north_floo_req_top_i[1].req}),
      .valid_o({hbm_north_floo_req_top_o[1].valid, hbm_north_floo_req_soc_i[1].valid}),
      .ready_o({hbm_north_floo_req_soc_i[1].ready, hbm_north_floo_req_top_o[1].ready}),
      .data_o ({hbm_north_floo_req_top_o[1].req, hbm_north_floo_req_soc_i[1].req})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_rsp_chan_t)
  ) i_floo_rsp_hbm_north_1_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_north_floo_rsp_soc_o[1].valid, hbm_north_floo_rsp_top_i[1].valid}),
      .ready_i({hbm_north_floo_rsp_top_i[1].ready, hbm_north_floo_rsp_soc_o[1].ready}),
      .data_i ({hbm_north_floo_rsp_soc_o[1].rsp, hbm_north_floo_rsp_top_i[1].rsp}),
      .valid_o({hbm_north_floo_rsp_top_o[1].valid, hbm_north_floo_rsp_soc_i[1].valid}),
      .ready_o({hbm_north_floo_rsp_soc_i[1].ready, hbm_north_floo_rsp_top_o[1].ready}),
      .data_o ({hbm_north_floo_rsp_top_o[1].rsp, hbm_north_floo_rsp_soc_i[1].rsp})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_wide_chan_t)
  ) i_floo_wide_hbm_north_1_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_north_floo_wide_soc_o[1].valid, hbm_north_floo_wide_top_i[1].valid}),
      .ready_i({hbm_north_floo_wide_top_i[1].ready, hbm_north_floo_wide_soc_o[1].ready}),
      .data_i ({hbm_north_floo_wide_soc_o[1].wide, hbm_north_floo_wide_top_i[1].wide}),
      .valid_o({hbm_north_floo_wide_top_o[1].valid, hbm_north_floo_wide_soc_i[1].valid}),
      .ready_o({hbm_north_floo_wide_soc_i[1].ready, hbm_north_floo_wide_top_o[1].ready}),
      .data_o ({hbm_north_floo_wide_top_o[1].wide, hbm_north_floo_wide_soc_i[1].wide})
  );

  // Generate hbm interface cuts
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_req_chan_t)
  ) i_floo_req_hbm_north_2_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_north_floo_req_soc_o[2].valid, hbm_north_floo_req_top_i[2].valid}),
      .ready_i({hbm_north_floo_req_top_i[2].ready, hbm_north_floo_req_soc_o[2].ready}),
      .data_i ({hbm_north_floo_req_soc_o[2].req, hbm_north_floo_req_top_i[2].req}),
      .valid_o({hbm_north_floo_req_top_o[2].valid, hbm_north_floo_req_soc_i[2].valid}),
      .ready_o({hbm_north_floo_req_soc_i[2].ready, hbm_north_floo_req_top_o[2].ready}),
      .data_o ({hbm_north_floo_req_top_o[2].req, hbm_north_floo_req_soc_i[2].req})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_rsp_chan_t)
  ) i_floo_rsp_hbm_north_2_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_north_floo_rsp_soc_o[2].valid, hbm_north_floo_rsp_top_i[2].valid}),
      .ready_i({hbm_north_floo_rsp_top_i[2].ready, hbm_north_floo_rsp_soc_o[2].ready}),
      .data_i ({hbm_north_floo_rsp_soc_o[2].rsp, hbm_north_floo_rsp_top_i[2].rsp}),
      .valid_o({hbm_north_floo_rsp_top_o[2].valid, hbm_north_floo_rsp_soc_i[2].valid}),
      .ready_o({hbm_north_floo_rsp_soc_i[2].ready, hbm_north_floo_rsp_top_o[2].ready}),
      .data_o ({hbm_north_floo_rsp_top_o[2].rsp, hbm_north_floo_rsp_soc_i[2].rsp})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_wide_chan_t)
  ) i_floo_wide_hbm_north_2_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_north_floo_wide_soc_o[2].valid, hbm_north_floo_wide_top_i[2].valid}),
      .ready_i({hbm_north_floo_wide_top_i[2].ready, hbm_north_floo_wide_soc_o[2].ready}),
      .data_i ({hbm_north_floo_wide_soc_o[2].wide, hbm_north_floo_wide_top_i[2].wide}),
      .valid_o({hbm_north_floo_wide_top_o[2].valid, hbm_north_floo_wide_soc_i[2].valid}),
      .ready_o({hbm_north_floo_wide_soc_i[2].ready, hbm_north_floo_wide_top_o[2].ready}),
      .data_o ({hbm_north_floo_wide_top_o[2].wide, hbm_north_floo_wide_soc_i[2].wide})
  );

  // Generate hbm interface cuts
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_req_chan_t)
  ) i_floo_req_hbm_north_3_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_north_floo_req_soc_o[3].valid, hbm_north_floo_req_top_i[3].valid}),
      .ready_i({hbm_north_floo_req_top_i[3].ready, hbm_north_floo_req_soc_o[3].ready}),
      .data_i ({hbm_north_floo_req_soc_o[3].req, hbm_north_floo_req_top_i[3].req}),
      .valid_o({hbm_north_floo_req_top_o[3].valid, hbm_north_floo_req_soc_i[3].valid}),
      .ready_o({hbm_north_floo_req_soc_i[3].ready, hbm_north_floo_req_top_o[3].ready}),
      .data_o ({hbm_north_floo_req_top_o[3].req, hbm_north_floo_req_soc_i[3].req})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_rsp_chan_t)
  ) i_floo_rsp_hbm_north_3_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_north_floo_rsp_soc_o[3].valid, hbm_north_floo_rsp_top_i[3].valid}),
      .ready_i({hbm_north_floo_rsp_top_i[3].ready, hbm_north_floo_rsp_soc_o[3].ready}),
      .data_i ({hbm_north_floo_rsp_soc_o[3].rsp, hbm_north_floo_rsp_top_i[3].rsp}),
      .valid_o({hbm_north_floo_rsp_top_o[3].valid, hbm_north_floo_rsp_soc_i[3].valid}),
      .ready_o({hbm_north_floo_rsp_soc_i[3].ready, hbm_north_floo_rsp_top_o[3].ready}),
      .data_o ({hbm_north_floo_rsp_top_o[3].rsp, hbm_north_floo_rsp_soc_i[3].rsp})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_wide_chan_t)
  ) i_floo_wide_hbm_north_3_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_north_floo_wide_soc_o[3].valid, hbm_north_floo_wide_top_i[3].valid}),
      .ready_i({hbm_north_floo_wide_top_i[3].ready, hbm_north_floo_wide_soc_o[3].ready}),
      .data_i ({hbm_north_floo_wide_soc_o[3].wide, hbm_north_floo_wide_top_i[3].wide}),
      .valid_o({hbm_north_floo_wide_top_o[3].valid, hbm_north_floo_wide_soc_i[3].valid}),
      .ready_o({hbm_north_floo_wide_soc_i[3].ready, hbm_north_floo_wide_top_o[3].ready}),
      .data_o ({hbm_north_floo_wide_top_o[3].wide, hbm_north_floo_wide_soc_i[3].wide})
  );

  // Generate hbm interface cuts
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_req_chan_t)
  ) i_floo_req_hbm_south_0_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_south_floo_req_soc_o[0].valid, hbm_south_floo_req_top_i[0].valid}),
      .ready_i({hbm_south_floo_req_top_i[0].ready, hbm_south_floo_req_soc_o[0].ready}),
      .data_i ({hbm_south_floo_req_soc_o[0].req, hbm_south_floo_req_top_i[0].req}),
      .valid_o({hbm_south_floo_req_top_o[0].valid, hbm_south_floo_req_soc_i[0].valid}),
      .ready_o({hbm_south_floo_req_soc_i[0].ready, hbm_south_floo_req_top_o[0].ready}),
      .data_o ({hbm_south_floo_req_top_o[0].req, hbm_south_floo_req_soc_i[0].req})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_rsp_chan_t)
  ) i_floo_rsp_hbm_south_0_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_south_floo_rsp_soc_o[0].valid, hbm_south_floo_rsp_top_i[0].valid}),
      .ready_i({hbm_south_floo_rsp_top_i[0].ready, hbm_south_floo_rsp_soc_o[0].ready}),
      .data_i ({hbm_south_floo_rsp_soc_o[0].rsp, hbm_south_floo_rsp_top_i[0].rsp}),
      .valid_o({hbm_south_floo_rsp_top_o[0].valid, hbm_south_floo_rsp_soc_i[0].valid}),
      .ready_o({hbm_south_floo_rsp_soc_i[0].ready, hbm_south_floo_rsp_top_o[0].ready}),
      .data_o ({hbm_south_floo_rsp_top_o[0].rsp, hbm_south_floo_rsp_soc_i[0].rsp})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_wide_chan_t)
  ) i_floo_wide_hbm_south_0_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_south_floo_wide_soc_o[0].valid, hbm_south_floo_wide_top_i[0].valid}),
      .ready_i({hbm_south_floo_wide_top_i[0].ready, hbm_south_floo_wide_soc_o[0].ready}),
      .data_i ({hbm_south_floo_wide_soc_o[0].wide, hbm_south_floo_wide_top_i[0].wide}),
      .valid_o({hbm_south_floo_wide_top_o[0].valid, hbm_south_floo_wide_soc_i[0].valid}),
      .ready_o({hbm_south_floo_wide_soc_i[0].ready, hbm_south_floo_wide_top_o[0].ready}),
      .data_o ({hbm_south_floo_wide_top_o[0].wide, hbm_south_floo_wide_soc_i[0].wide})
  );

  // Generate hbm interface cuts
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_req_chan_t)
  ) i_floo_req_hbm_south_1_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_south_floo_req_soc_o[1].valid, hbm_south_floo_req_top_i[1].valid}),
      .ready_i({hbm_south_floo_req_top_i[1].ready, hbm_south_floo_req_soc_o[1].ready}),
      .data_i ({hbm_south_floo_req_soc_o[1].req, hbm_south_floo_req_top_i[1].req}),
      .valid_o({hbm_south_floo_req_top_o[1].valid, hbm_south_floo_req_soc_i[1].valid}),
      .ready_o({hbm_south_floo_req_soc_i[1].ready, hbm_south_floo_req_top_o[1].ready}),
      .data_o ({hbm_south_floo_req_top_o[1].req, hbm_south_floo_req_soc_i[1].req})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_rsp_chan_t)
  ) i_floo_rsp_hbm_south_1_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_south_floo_rsp_soc_o[1].valid, hbm_south_floo_rsp_top_i[1].valid}),
      .ready_i({hbm_south_floo_rsp_top_i[1].ready, hbm_south_floo_rsp_soc_o[1].ready}),
      .data_i ({hbm_south_floo_rsp_soc_o[1].rsp, hbm_south_floo_rsp_top_i[1].rsp}),
      .valid_o({hbm_south_floo_rsp_top_o[1].valid, hbm_south_floo_rsp_soc_i[1].valid}),
      .ready_o({hbm_south_floo_rsp_soc_i[1].ready, hbm_south_floo_rsp_top_o[1].ready}),
      .data_o ({hbm_south_floo_rsp_top_o[1].rsp, hbm_south_floo_rsp_soc_i[1].rsp})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_wide_chan_t)
  ) i_floo_wide_hbm_south_1_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_south_floo_wide_soc_o[1].valid, hbm_south_floo_wide_top_i[1].valid}),
      .ready_i({hbm_south_floo_wide_top_i[1].ready, hbm_south_floo_wide_soc_o[1].ready}),
      .data_i ({hbm_south_floo_wide_soc_o[1].wide, hbm_south_floo_wide_top_i[1].wide}),
      .valid_o({hbm_south_floo_wide_top_o[1].valid, hbm_south_floo_wide_soc_i[1].valid}),
      .ready_o({hbm_south_floo_wide_soc_i[1].ready, hbm_south_floo_wide_top_o[1].ready}),
      .data_o ({hbm_south_floo_wide_top_o[1].wide, hbm_south_floo_wide_soc_i[1].wide})
  );

  // Generate hbm interface cuts
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_req_chan_t)
  ) i_floo_req_hbm_south_2_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_south_floo_req_soc_o[2].valid, hbm_south_floo_req_top_i[2].valid}),
      .ready_i({hbm_south_floo_req_top_i[2].ready, hbm_south_floo_req_soc_o[2].ready}),
      .data_i ({hbm_south_floo_req_soc_o[2].req, hbm_south_floo_req_top_i[2].req}),
      .valid_o({hbm_south_floo_req_top_o[2].valid, hbm_south_floo_req_soc_i[2].valid}),
      .ready_o({hbm_south_floo_req_soc_i[2].ready, hbm_south_floo_req_top_o[2].ready}),
      .data_o ({hbm_south_floo_req_top_o[2].req, hbm_south_floo_req_soc_i[2].req})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_rsp_chan_t)
  ) i_floo_rsp_hbm_south_2_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_south_floo_rsp_soc_o[2].valid, hbm_south_floo_rsp_top_i[2].valid}),
      .ready_i({hbm_south_floo_rsp_top_i[2].ready, hbm_south_floo_rsp_soc_o[2].ready}),
      .data_i ({hbm_south_floo_rsp_soc_o[2].rsp, hbm_south_floo_rsp_top_i[2].rsp}),
      .valid_o({hbm_south_floo_rsp_top_o[2].valid, hbm_south_floo_rsp_soc_i[2].valid}),
      .ready_o({hbm_south_floo_rsp_soc_i[2].ready, hbm_south_floo_rsp_top_o[2].ready}),
      .data_o ({hbm_south_floo_rsp_top_o[2].rsp, hbm_south_floo_rsp_soc_i[2].rsp})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_wide_chan_t)
  ) i_floo_wide_hbm_south_2_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_south_floo_wide_soc_o[2].valid, hbm_south_floo_wide_top_i[2].valid}),
      .ready_i({hbm_south_floo_wide_top_i[2].ready, hbm_south_floo_wide_soc_o[2].ready}),
      .data_i ({hbm_south_floo_wide_soc_o[2].wide, hbm_south_floo_wide_top_i[2].wide}),
      .valid_o({hbm_south_floo_wide_top_o[2].valid, hbm_south_floo_wide_soc_i[2].valid}),
      .ready_o({hbm_south_floo_wide_soc_i[2].ready, hbm_south_floo_wide_top_o[2].ready}),
      .data_o ({hbm_south_floo_wide_top_o[2].wide, hbm_south_floo_wide_soc_i[2].wide})
  );

  // Generate hbm interface cuts
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_req_chan_t)
  ) i_floo_req_hbm_south_3_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_south_floo_req_soc_o[3].valid, hbm_south_floo_req_top_i[3].valid}),
      .ready_i({hbm_south_floo_req_top_i[3].ready, hbm_south_floo_req_soc_o[3].ready}),
      .data_i ({hbm_south_floo_req_soc_o[3].req, hbm_south_floo_req_top_i[3].req}),
      .valid_o({hbm_south_floo_req_top_o[3].valid, hbm_south_floo_req_soc_i[3].valid}),
      .ready_o({hbm_south_floo_req_soc_i[3].ready, hbm_south_floo_req_top_o[3].ready}),
      .data_o ({hbm_south_floo_req_top_o[3].req, hbm_south_floo_req_soc_i[3].req})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_rsp_chan_t)
  ) i_floo_rsp_hbm_south_3_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_south_floo_rsp_soc_o[3].valid, hbm_south_floo_rsp_top_i[3].valid}),
      .ready_i({hbm_south_floo_rsp_top_i[3].ready, hbm_south_floo_rsp_soc_o[3].ready}),
      .data_i ({hbm_south_floo_rsp_soc_o[3].rsp, hbm_south_floo_rsp_top_i[3].rsp}),
      .valid_o({hbm_south_floo_rsp_top_o[3].valid, hbm_south_floo_rsp_soc_i[3].valid}),
      .ready_o({hbm_south_floo_rsp_soc_i[3].ready, hbm_south_floo_rsp_top_o[3].ready}),
      .data_o ({hbm_south_floo_rsp_top_o[3].rsp, hbm_south_floo_rsp_soc_i[3].rsp})
  );
  floo_cut #(
      .NumCuts(2),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_wide_chan_t)
  ) i_floo_wide_hbm_south_3_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_south_floo_wide_soc_o[3].valid, hbm_south_floo_wide_top_i[3].valid}),
      .ready_i({hbm_south_floo_wide_top_i[3].ready, hbm_south_floo_wide_soc_o[3].ready}),
      .data_i ({hbm_south_floo_wide_soc_o[3].wide, hbm_south_floo_wide_top_i[3].wide}),
      .valid_o({hbm_south_floo_wide_top_o[3].valid, hbm_south_floo_wide_soc_i[3].valid}),
      .ready_o({hbm_south_floo_wide_soc_i[3].ready, hbm_south_floo_wide_top_o[3].ready}),
      .data_o ({hbm_south_floo_wide_top_o[3].wide, hbm_south_floo_wide_soc_i[3].wide})
  );

  // Generate hbm interface cuts bypass
  assign hbm_west_floo_req_top_o[0]  = hbm_west_floo_req_soc_o[0];
  assign hbm_west_floo_req_soc_i[0]  = hbm_west_floo_req_top_i[0];
  assign hbm_west_floo_rsp_top_o[0]  = hbm_west_floo_rsp_soc_o[0];
  assign hbm_west_floo_rsp_soc_i[0]  = hbm_west_floo_rsp_top_i[0];
  assign hbm_west_floo_wide_top_o[0] = hbm_west_floo_wide_soc_o[0];
  assign hbm_west_floo_wide_soc_i[0] = hbm_west_floo_wide_top_i[0];

  // Generate hbm interface cuts
  floo_cut #(
      .NumCuts(1),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_req_chan_t)
  ) i_floo_req_hbm_west_1_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_west_floo_req_soc_o[1].valid, hbm_west_floo_req_top_i[1].valid}),
      .ready_i({hbm_west_floo_req_top_i[1].ready, hbm_west_floo_req_soc_o[1].ready}),
      .data_i ({hbm_west_floo_req_soc_o[1].req, hbm_west_floo_req_top_i[1].req}),
      .valid_o({hbm_west_floo_req_top_o[1].valid, hbm_west_floo_req_soc_i[1].valid}),
      .ready_o({hbm_west_floo_req_soc_i[1].ready, hbm_west_floo_req_top_o[1].ready}),
      .data_o ({hbm_west_floo_req_top_o[1].req, hbm_west_floo_req_soc_i[1].req})
  );
  floo_cut #(
      .NumCuts(1),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_rsp_chan_t)
  ) i_floo_rsp_hbm_west_1_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_west_floo_rsp_soc_o[1].valid, hbm_west_floo_rsp_top_i[1].valid}),
      .ready_i({hbm_west_floo_rsp_top_i[1].ready, hbm_west_floo_rsp_soc_o[1].ready}),
      .data_i ({hbm_west_floo_rsp_soc_o[1].rsp, hbm_west_floo_rsp_top_i[1].rsp}),
      .valid_o({hbm_west_floo_rsp_top_o[1].valid, hbm_west_floo_rsp_soc_i[1].valid}),
      .ready_o({hbm_west_floo_rsp_soc_i[1].ready, hbm_west_floo_rsp_top_o[1].ready}),
      .data_o ({hbm_west_floo_rsp_top_o[1].rsp, hbm_west_floo_rsp_soc_i[1].rsp})
  );
  floo_cut #(
      .NumCuts(1),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_wide_chan_t)
  ) i_floo_wide_hbm_west_1_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_west_floo_wide_soc_o[1].valid, hbm_west_floo_wide_top_i[1].valid}),
      .ready_i({hbm_west_floo_wide_top_i[1].ready, hbm_west_floo_wide_soc_o[1].ready}),
      .data_i ({hbm_west_floo_wide_soc_o[1].wide, hbm_west_floo_wide_top_i[1].wide}),
      .valid_o({hbm_west_floo_wide_top_o[1].valid, hbm_west_floo_wide_soc_i[1].valid}),
      .ready_o({hbm_west_floo_wide_soc_i[1].ready, hbm_west_floo_wide_top_o[1].ready}),
      .data_o ({hbm_west_floo_wide_top_o[1].wide, hbm_west_floo_wide_soc_i[1].wide})
  );

  // Generate hbm interface cuts bypass
  assign hbm_west_floo_req_top_o[2]  = hbm_west_floo_req_soc_o[2];
  assign hbm_west_floo_req_soc_i[2]  = hbm_west_floo_req_top_i[2];
  assign hbm_west_floo_rsp_top_o[2]  = hbm_west_floo_rsp_soc_o[2];
  assign hbm_west_floo_rsp_soc_i[2]  = hbm_west_floo_rsp_top_i[2];
  assign hbm_west_floo_wide_top_o[2] = hbm_west_floo_wide_soc_o[2];
  assign hbm_west_floo_wide_soc_i[2] = hbm_west_floo_wide_top_i[2];

  // Generate hbm interface cuts
  floo_cut #(
      .NumCuts(1),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_req_chan_t)
  ) i_floo_req_hbm_west_3_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_west_floo_req_soc_o[3].valid, hbm_west_floo_req_top_i[3].valid}),
      .ready_i({hbm_west_floo_req_top_i[3].ready, hbm_west_floo_req_soc_o[3].ready}),
      .data_i ({hbm_west_floo_req_soc_o[3].req, hbm_west_floo_req_top_i[3].req}),
      .valid_o({hbm_west_floo_req_top_o[3].valid, hbm_west_floo_req_soc_i[3].valid}),
      .ready_o({hbm_west_floo_req_soc_i[3].ready, hbm_west_floo_req_top_o[3].ready}),
      .data_o ({hbm_west_floo_req_top_o[3].req, hbm_west_floo_req_soc_i[3].req})
  );
  floo_cut #(
      .NumCuts(1),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_rsp_chan_t)
  ) i_floo_rsp_hbm_west_3_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_west_floo_rsp_soc_o[3].valid, hbm_west_floo_rsp_top_i[3].valid}),
      .ready_i({hbm_west_floo_rsp_top_i[3].ready, hbm_west_floo_rsp_soc_o[3].ready}),
      .data_i ({hbm_west_floo_rsp_soc_o[3].rsp, hbm_west_floo_rsp_top_i[3].rsp}),
      .valid_o({hbm_west_floo_rsp_top_o[3].valid, hbm_west_floo_rsp_soc_i[3].valid}),
      .ready_o({hbm_west_floo_rsp_soc_i[3].ready, hbm_west_floo_rsp_top_o[3].ready}),
      .data_o ({hbm_west_floo_rsp_top_o[3].rsp, hbm_west_floo_rsp_soc_i[3].rsp})
  );
  floo_cut #(
      .NumCuts(1),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_wide_chan_t)
  ) i_floo_wide_hbm_west_3_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_west_floo_wide_soc_o[3].valid, hbm_west_floo_wide_top_i[3].valid}),
      .ready_i({hbm_west_floo_wide_top_i[3].ready, hbm_west_floo_wide_soc_o[3].ready}),
      .data_i ({hbm_west_floo_wide_soc_o[3].wide, hbm_west_floo_wide_top_i[3].wide}),
      .valid_o({hbm_west_floo_wide_top_o[3].valid, hbm_west_floo_wide_soc_i[3].valid}),
      .ready_o({hbm_west_floo_wide_soc_i[3].ready, hbm_west_floo_wide_top_o[3].ready}),
      .data_o ({hbm_west_floo_wide_top_o[3].wide, hbm_west_floo_wide_soc_i[3].wide})
  );

  // Generate hbm interface cuts bypass
  assign hbm_east_floo_req_top_o[0]  = hbm_east_floo_req_soc_o[0];
  assign hbm_east_floo_req_soc_i[0]  = hbm_east_floo_req_top_i[0];
  assign hbm_east_floo_rsp_top_o[0]  = hbm_east_floo_rsp_soc_o[0];
  assign hbm_east_floo_rsp_soc_i[0]  = hbm_east_floo_rsp_top_i[0];
  assign hbm_east_floo_wide_top_o[0] = hbm_east_floo_wide_soc_o[0];
  assign hbm_east_floo_wide_soc_i[0] = hbm_east_floo_wide_top_i[0];

  // Generate hbm interface cuts
  floo_cut #(
      .NumCuts(1),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_req_chan_t)
  ) i_floo_req_hbm_east_1_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_east_floo_req_soc_o[1].valid, hbm_east_floo_req_top_i[1].valid}),
      .ready_i({hbm_east_floo_req_top_i[1].ready, hbm_east_floo_req_soc_o[1].ready}),
      .data_i ({hbm_east_floo_req_soc_o[1].req, hbm_east_floo_req_top_i[1].req}),
      .valid_o({hbm_east_floo_req_top_o[1].valid, hbm_east_floo_req_soc_i[1].valid}),
      .ready_o({hbm_east_floo_req_soc_i[1].ready, hbm_east_floo_req_top_o[1].ready}),
      .data_o ({hbm_east_floo_req_top_o[1].req, hbm_east_floo_req_soc_i[1].req})
  );
  floo_cut #(
      .NumCuts(1),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_rsp_chan_t)
  ) i_floo_rsp_hbm_east_1_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_east_floo_rsp_soc_o[1].valid, hbm_east_floo_rsp_top_i[1].valid}),
      .ready_i({hbm_east_floo_rsp_top_i[1].ready, hbm_east_floo_rsp_soc_o[1].ready}),
      .data_i ({hbm_east_floo_rsp_soc_o[1].rsp, hbm_east_floo_rsp_top_i[1].rsp}),
      .valid_o({hbm_east_floo_rsp_top_o[1].valid, hbm_east_floo_rsp_soc_i[1].valid}),
      .ready_o({hbm_east_floo_rsp_soc_i[1].ready, hbm_east_floo_rsp_top_o[1].ready}),
      .data_o ({hbm_east_floo_rsp_top_o[1].rsp, hbm_east_floo_rsp_soc_i[1].rsp})
  );
  floo_cut #(
      .NumCuts(1),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_wide_chan_t)
  ) i_floo_wide_hbm_east_1_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_east_floo_wide_soc_o[1].valid, hbm_east_floo_wide_top_i[1].valid}),
      .ready_i({hbm_east_floo_wide_top_i[1].ready, hbm_east_floo_wide_soc_o[1].ready}),
      .data_i ({hbm_east_floo_wide_soc_o[1].wide, hbm_east_floo_wide_top_i[1].wide}),
      .valid_o({hbm_east_floo_wide_top_o[1].valid, hbm_east_floo_wide_soc_i[1].valid}),
      .ready_o({hbm_east_floo_wide_soc_i[1].ready, hbm_east_floo_wide_top_o[1].ready}),
      .data_o ({hbm_east_floo_wide_top_o[1].wide, hbm_east_floo_wide_soc_i[1].wide})
  );

  // Generate hbm interface cuts bypass
  assign hbm_east_floo_req_top_o[2]  = hbm_east_floo_req_soc_o[2];
  assign hbm_east_floo_req_soc_i[2]  = hbm_east_floo_req_top_i[2];
  assign hbm_east_floo_rsp_top_o[2]  = hbm_east_floo_rsp_soc_o[2];
  assign hbm_east_floo_rsp_soc_i[2]  = hbm_east_floo_rsp_top_i[2];
  assign hbm_east_floo_wide_top_o[2] = hbm_east_floo_wide_soc_o[2];
  assign hbm_east_floo_wide_soc_i[2] = hbm_east_floo_wide_top_i[2];

  // Generate hbm interface cuts
  floo_cut #(
      .NumCuts(1),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_req_chan_t)
  ) i_floo_req_hbm_east_3_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_east_floo_req_soc_o[3].valid, hbm_east_floo_req_top_i[3].valid}),
      .ready_i({hbm_east_floo_req_top_i[3].ready, hbm_east_floo_req_soc_o[3].ready}),
      .data_i ({hbm_east_floo_req_soc_o[3].req, hbm_east_floo_req_top_i[3].req}),
      .valid_o({hbm_east_floo_req_top_o[3].valid, hbm_east_floo_req_soc_i[3].valid}),
      .ready_o({hbm_east_floo_req_soc_i[3].ready, hbm_east_floo_req_top_o[3].ready}),
      .data_o ({hbm_east_floo_req_top_o[3].req, hbm_east_floo_req_soc_i[3].req})
  );
  floo_cut #(
      .NumCuts(1),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_rsp_chan_t)
  ) i_floo_rsp_hbm_east_3_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_east_floo_rsp_soc_o[3].valid, hbm_east_floo_rsp_top_i[3].valid}),
      .ready_i({hbm_east_floo_rsp_top_i[3].ready, hbm_east_floo_rsp_soc_o[3].ready}),
      .data_i ({hbm_east_floo_rsp_soc_o[3].rsp, hbm_east_floo_rsp_top_i[3].rsp}),
      .valid_o({hbm_east_floo_rsp_top_o[3].valid, hbm_east_floo_rsp_soc_i[3].valid}),
      .ready_o({hbm_east_floo_rsp_soc_i[3].ready, hbm_east_floo_rsp_top_o[3].ready}),
      .data_o ({hbm_east_floo_rsp_top_o[3].rsp, hbm_east_floo_rsp_soc_i[3].rsp})
  );
  floo_cut #(
      .NumCuts(1),
      .NumChannels(2),  // 2 for bi-directional channels
      .flit_t(floo_wide_chan_t)
  ) i_floo_wide_hbm_east_3_cut (
      .clk_i  (clk_i),
      .rst_ni (rst_ni),
      // {SoC -> Top, Top -> SoC}
      .valid_i({hbm_east_floo_wide_soc_o[3].valid, hbm_east_floo_wide_top_i[3].valid}),
      .ready_i({hbm_east_floo_wide_top_i[3].ready, hbm_east_floo_wide_soc_o[3].ready}),
      .data_i ({hbm_east_floo_wide_soc_o[3].wide, hbm_east_floo_wide_top_i[3].wide}),
      .valid_o({hbm_east_floo_wide_top_o[3].valid, hbm_east_floo_wide_soc_i[3].valid}),
      .ready_o({hbm_east_floo_wide_soc_i[3].ready, hbm_east_floo_wide_top_o[3].ready}),
      .data_o ({hbm_east_floo_wide_top_o[3].wide, hbm_east_floo_wide_soc_i[3].wide})
  );

  // Assign to port
  assign hbm_north_floo_req_o = hbm_north_floo_req_top_o;
  assign hbm_north_floo_req_top_i = hbm_north_floo_req_i;
  assign hbm_north_floo_rsp_o = hbm_north_floo_rsp_top_o;
  assign hbm_north_floo_rsp_top_i = hbm_north_floo_rsp_i;
  assign hbm_north_floo_wide_o = hbm_north_floo_wide_top_o;
  assign hbm_north_floo_wide_top_i = hbm_north_floo_wide_i;
  assign hbm_south_floo_req_o = hbm_south_floo_req_top_o;
  assign hbm_south_floo_req_top_i = hbm_south_floo_req_i;
  assign hbm_south_floo_rsp_o = hbm_south_floo_rsp_top_o;
  assign hbm_south_floo_rsp_top_i = hbm_south_floo_rsp_i;
  assign hbm_south_floo_wide_o = hbm_south_floo_wide_top_o;
  assign hbm_south_floo_wide_top_i = hbm_south_floo_wide_i;
  assign hbm_west_floo_req_o = hbm_west_floo_req_top_o;
  assign hbm_west_floo_req_top_i = hbm_west_floo_req_i;
  assign hbm_west_floo_rsp_o = hbm_west_floo_rsp_top_o;
  assign hbm_west_floo_rsp_top_i = hbm_west_floo_rsp_i;
  assign hbm_west_floo_wide_o = hbm_west_floo_wide_top_o;
  assign hbm_west_floo_wide_top_i = hbm_west_floo_wide_i;
  assign hbm_east_floo_req_o = hbm_east_floo_req_top_o;
  assign hbm_east_floo_req_top_i = hbm_east_floo_req_i;
  assign hbm_east_floo_rsp_o = hbm_east_floo_rsp_top_o;
  assign hbm_east_floo_rsp_top_i = hbm_east_floo_rsp_i;
  assign hbm_east_floo_wide_o = hbm_east_floo_wide_top_o;
  assign hbm_east_floo_wide_top_i = hbm_east_floo_wide_i;

  logic [27:0] endsim_cluster;
  // Get end_of_sim signal inside DUT
  assign endsim_cluster[0] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_0_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[1] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_0_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[2] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_0_2.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[3] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_0_3.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[4] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_1_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[5] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_1_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[6] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_1_2.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[7] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_1_3.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[8] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_2_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[9] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_2_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[10] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_2_2.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[11] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_2_3.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[12] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_4_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[13] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_4_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[14] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_4_2.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[15] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_4_3.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[16] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_5_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[17] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_5_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[18] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_5_2.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[19] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_5_3.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[20] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_6_0.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[21] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_6_1.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[22] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_6_2.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[23] = &tb_floo_compute_tile_array_pd.i_chiplet_soc.i_chiplet_floo_noc.compute_tile_6_3.i_snitch_cluster_test_node.end_of_sim;
  assign endsim_cluster[24] = &tb_floo_compute_tile_array_pd.i_floo_narrow_idma_model.end_of_sim;
  assign endsim_cluster[25] = &tb_floo_compute_tile_array_pd.i_floo_wide_idma_model.end_of_sim;
  assign endsim_cluster[26] = &tb_floo_compute_tile_array_pd.i_floo_narrow_cva6_model.end_of_sim;
  assign endsim_cluster[27] = &tb_floo_compute_tile_array_pd.i_floo_narrow_jtag_model.end_of_sim;

  initial begin
    wait (&endsim_cluster);
    // Wait for some time
    #100ns;
    // Stop the simulation
    $display("-- End Simulation --");
    $finish;
  end

endmodule
