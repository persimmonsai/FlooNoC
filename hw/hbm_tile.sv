// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

`include "axi/typedef.svh"
`include "axi/assign.svh"

module hbm_tile
  import hbm_pd_pkg::*;
  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;
(
    input logic clk_i,
    input logic rst_ni,
    input logic test_enable_i,
    input id_t  id_i,           // XY ID for router and hbm NI

    // hbm interface
    input logic clk_hbmphy_i,
    input logic pll_lock_hbmphy_i,
    input logic clk_hbmcfg_i,
    input logic rst_hbmcfg_ni,
    input xbar_rule_t [XbarRuleNum-1:0] XbarAddrMap,
    inout Xdram_CK,
    inout Xdram_CKB,
    inout Xdram_APAR,
    inout Xdram_ARFU,
    inout Xdram_AERR,
    inout [9:0] Xdram_RA,
    inout [7:0] Xdram_CA,
    inout Xdram_RRC,
    inout [63:0] Xdram_DQ,
    inout [3:0] Xdram_ECC,
    inout [3:0] Xdram_SEV,
    inout [7:0] Xdram_DBI,
    inout [1:0] Xdram_DPAR,
    inout [1:0] Xdram_DERR,
    inout [1:0] Xdram_RDQSP,
    inout [1:0] Xdram_RDQSN,
    inout [1:0] Xdram_WDQSP,
    inout [1:0] Xdram_WDQSN,
    inout [3:0] Xdram_RD,

    // North, East, South, and West floonoc router interface
    input  floo_req_t  [West:North] floo_req_i,
    output floo_rsp_t  [West:North] floo_rsp_o,
    output floo_req_t  [West:North] floo_req_o,
    input  floo_rsp_t  [West:North] floo_rsp_i,
    input  floo_wide_t [West:North] floo_wide_i,
    output floo_wide_t [West:North] floo_wide_o
);
  // --- Cluster to NI ---
  // in/out direction type that is declared in this scope is respect to NI
  // So axi_narrow_in_req_t of NI will connected to axi_narrow_out_req_t of snitch_hbm
  // In case, id width is not equal between axi_narrow_in_req_t of NI and axi_narrow_out_req_t of snitch_hbm,
  // axi_iw_converter need to place to convert ID width
  axi_narrow_out_req_t ni_to_hbm_narrow_req;
  axi_narrow_out_rsp_t hbm_to_ni_narrow_resp;
  axi_wide_out_req_t   ni_to_hbm_wide_req;
  axi_wide_out_rsp_t   hbm_to_ni_wide_resp;

  // Switch to instantiate module between simulation (with questa) and synthesis
`ifdef TARGET_DMA_TEST
  import compute_tile_array_test_pkg::*;
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
  ) i_floo_wide_hbm_model (
      .clk_i    (clk_i),
      .rst_ni   (rst_ni),
      .hbm_req_i(ni_to_hbm_wide_req),
      .hbm_rsp_o(hbm_to_ni_wide_resp)
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
  ) i_floo_narrow_hbm_model (
      .clk_i    (clk_i),
      .rst_ni   (rst_ni),
      .hbm_req_i(ni_to_hbm_narrow_req),
      .hbm_rsp_o(hbm_to_ni_narrow_resp)
  );
`else
  hbm_narrow_wide_wrapper_1ch #(
      .axi_narrow_req_type(axi_narrow_req_type),
      .axi_narrow_rsp_type(axi_narrow_rsp_type),
      .axi_wide_req_type(axi_wide_req_type),
      .axi_wide_rsp_type(axi_wide_rsp_type),
      .NarrowAxiLiteCfg(1'b1),  // Enable HBM configuration through narrow interface port
      .XbarCfg(HbmCfgXbar),
      .xbar_rule_t(xbar_rule_t),
      .XbarRuleNum(XbarRuleNum),
      .axi_join_req_type(axi_join_req_type),
      .axi_join_rsp_type(axi_join_rsp_type),
      .FilterNarrowAtops(1'b0),
      .FilterWideAtops(1'b0),
      .AtopUserAsId(1'b1),
      .AxiAddrWidth(AxiAddrWidth),
      .AxiNarrowDataWidth(AxiNarrowDataWidth),
      .AxiNarrowIdInWidth(AxiNarrowIdWidth),
      .AxiNarrowUserInWidth(AxiNarrowUserWidth),
      .AxiWideDataWidth(AxiWideDataWidth),
      .AxiWideIdInWidth(AxiWideIdWidth),
      .AxiWideUserInWidth(AxiWideUserWidth),
      .AxiJoinDataWidth(AxiJoinDataWidth),
      .AxiJoinIdWidth(AxiJoinIdWidth),
      .AxiJoinUserWidth(AxiJoinUserWidth)
  ) i_hbm_narrow_wide_wrapper (
      // Synchronous clock to FlooNoC (<1000 MHz)
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_mode_i(test_mode_i),
      // High speed clock required by HBM PHY (>4600 GHz)
      .clk_hbmphy_i(clk_hbmphy_i),
      .pll_lock_hbmphy_i(pll_lock_hbmphy_i),
      // AXI Lite configuration clock
      .clk_hbmcfg_i(clk_hbmcfg_i),
      .rst_hbmcfg_ni(rst_hbmcfg_ni),
      // AXI interface to FlooNoC
      .axi_narrow_req_i(ni_to_hbm_narrow_req),
      .axi_narrow_rsp_o(hbm_to_ni_narrow_resp),
      .axi_wide_req_i(ni_to_hbm_wide_req),
      .axi_wide_rsp_o(hbm_to_ni_wide_resp),
      // Xbar Address Map
      .XbarAddrMap(XbarAddrMap),
      // DRAM interface
      .Xdram_CK(Xdram_CK),
      .Xdram_CKB(Xdram_CKB),
      .Xdram_APAR(Xdram_APAR),
      .Xdram_ARFU(Xdram_ARFU),
      .Xdram_AERR(Xdram_AERR),
      .Xdram_RA(Xdram_RA),
      .Xdram_CA(Xdram_CA),
      .Xdram_RRC(Xdram_RRC),
      .Xdram_DQ(Xdram_DQ),
      .Xdram_ECC(Xdram_ECC),
      .Xdram_SEV(Xdram_SEV),
      .Xdram_DBI(Xdram_DBI),
      .Xdram_DPAR(Xdram_DPAR),
      .Xdram_DERR(Xdram_DERR),
      .Xdram_RDQSP(Xdram_RDQSP),
      .Xdram_RDQSN(Xdram_RDQSN),
      .Xdram_WDQSP(Xdram_WDQSP),
      .Xdram_WDQSN(Xdram_WDQSN),
      .Xdram_RD(Xdram_RD)
  );
`endif

  floo_noc_hbm_pd_top i_floo_noc_pd (
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_enable_i(test_enable_i),

      .id_i(id_i),

      // FlooNoC router
      .floo_req_i (floo_req_i),
      .floo_rsp_i (floo_rsp_i),
      .floo_req_o (floo_req_o),
      .floo_rsp_o (floo_rsp_o),
      .floo_wide_i(floo_wide_i),
      .floo_wide_o(floo_wide_o),

      // Cluster interface
      .ni_to_hbm_narrow_req(ni_to_hbm_narrow_req),
      .hbm_to_ni_narrow_resp(hbm_to_ni_narrow_resp),
      .ni_to_hbm_wide_req(ni_to_hbm_wide_req),
      .hbm_to_ni_wide_resp(hbm_to_ni_wide_resp)
  );

endmodule
