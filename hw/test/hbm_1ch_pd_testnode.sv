
`include "axi/typedef.svh"
`include "axi/assign.svh"

module hbm_1ch_pd_testnode
  import hbm_pd_pkg::*;
  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;
(
    // Synchronous clock to FlooNoC (<1000 MHz)
    input logic clk_i,
    input logic rst_ni,
    input logic test_mode_i,
    // AXI interface to FlooNoC
    input id_t ni_id_i,
    output floo_req_t floo_req_o,
    output floo_rsp_t floo_rsp_o,
    output floo_wide_t floo_wide_o,
    input  floo_req_t floo_req_i,
    input  floo_rsp_t floo_rsp_i,
    input  floo_wide_t floo_wide_i
);

  axi_narrow_req_type axi_hbm_narrow_req;
  axi_narrow_rsp_type axi_hbm_narrow_rsp;
  axi_wide_req_type   axi_wide_req_i;
  axi_wide_rsp_type   axi_wide_rsp_o;

  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b1),
      .EnNarrowMgrPort(1'b0),
      .EnWideSbrPort  (1'b1),
      .EnWideMgrPort  (1'b0)
  ) i_hbm_floo_ni (
      .clk_i               (clk_i),
      .rst_ni              (rst_ni),
      .test_enable_i       (test_mode_i),
      .sram_cfg_i          ('0),
      .axi_narrow_in_req_i ('0),
      .axi_narrow_in_rsp_o (),
      .axi_narrow_out_req_o(axi_hbm_narrow_req),
      .axi_narrow_out_rsp_i(axi_hbm_narrow_rsp),
      .axi_wide_in_req_i   ('0),
      .axi_wide_in_rsp_o   (),
      .axi_wide_out_req_o  (axi_wide_req_i),
      .axi_wide_out_rsp_i  (axi_wide_rsp_o),
      .id_i                (ni_id_i),
      .route_table_i       ('0),
      .floo_req_o          (floo_req_o),
      .floo_rsp_i          (floo_rsp_i),
      .floo_wide_o         (floo_wide_o),
      .floo_req_i          (floo_req_i),
      .floo_rsp_o          (floo_rsp_o),
      .floo_wide_i         (floo_wide_i)
  );

  axi_join_req_type axi_hbm_join_req;
  axi_join_rsp_type axi_hbm_join_rsp;

  floo_narrow_wide_join #(
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
      .AxiDataOutWidth(AxiJoinDataWidth),
      .AxiIdOutWidth(AxiJoinIdWidth),
      .AxiUserWidth(AxiJoinUserWidth),
      .AtopInputNoCut(2),
      .UpdownInputNoCut(1),
      .AxiNarrowMaxTxns(4),
      .AxiWideMaxTxns(8),
      /// AXI type of narrow and wide AXI bus
      .axi_narrow_req_t(axi_narrow_req_type),
      .axi_narrow_rsp_t(axi_narrow_rsp_type),
      .axi_wide_req_t(axi_wide_req_type),
      .axi_wide_rsp_t(axi_wide_rsp_type),
      /// AXI type of the resulting wide AXI bus
      .axi_req_t(axi_join_req_type),
      .axi_rsp_t(axi_join_rsp_type)
  ) i_hbm_narrow_wide_join (
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_enable_i(test_mode_i),
      .axi_narrow_req_i(axi_hbm_narrow_req),
      .axi_narrow_rsp_o(axi_hbm_narrow_rsp),
      .axi_wide_req_i(axi_wide_req_i),
      .axi_wide_rsp_o(axi_wide_rsp_o),
      .axi_req_o(axi_hbm_join_req),
      .axi_rsp_i(axi_hbm_join_rsp)
  );

  floo_hbm_model #(
      .TA         (ApplTime),
      .TT         (TestTime),
      .Latency    (HBMLatency),
      .NumChannels(1),
      .AddrWidth  (AxiAddrWidth),
      .DataWidth  (AxiJoinDataWidth),
      .UserWidth  (AxiJoinUserWidth),
      .IdWidth    (AxiJoinIdWidth),
      .axi_req_t  (axi_join_req_type),
      .axi_rsp_t  (axi_join_rsp_type),
      .aw_chan_t  (axi_join_aw_chan_t),
      .w_chan_t   (axi_join_w_chan_t),
      .b_chan_t   (axi_join_b_chan_t),
      .ar_chan_t  (axi_join_ar_chan_t),
      .r_chan_t   (axi_join_r_chan_t)
  ) i_floo_hbm_model (
      .clk_i    (clk_i),
      .rst_ni   (rst_ni),
      .hbm_req_i(axi_hbm_join_req),
      .hbm_rsp_o(axi_hbm_join_rsp)
  );

endmodule
