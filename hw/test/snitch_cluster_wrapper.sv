
// Blank wrapper for synthesis test
module snitch_cluster_wrapper
  import snitch_cluster_test_pkg::*; // Simulation setting parameter modified through macro for each difference testbench
  import floo_narrow_wide_pkg::*;  // Address map to access DMA
(
    input logic clk_i,
    input logic rst_ni,

    input  logic                                                       sa_rst_ni,
    input  logic                [snitch_cluster_test_pkg::NrCores-1:0] debug_req_i,
    input  logic                [snitch_cluster_test_pkg::NrCores-1:0] meip_i,
    input  logic                [snitch_cluster_test_pkg::NrCores-1:0] mtip_i,
    input  logic                [snitch_cluster_test_pkg::NrCores-1:0] msip_i,
    input  axi_narrow_in_req_t                                         narrow_in_req_i,
    output axi_narrow_in_rsp_t                                         narrow_in_resp_o,
    output axi_narrow_out_req_t                                        narrow_out_req_o,
    input  axi_narrow_out_rsp_t                                        narrow_out_resp_i,
    output axi_wide_out_req_t                                          wide_out_req_o,
    input  axi_wide_out_rsp_t                                          wide_out_resp_i,
    input  axi_wide_in_req_t                                           wide_in_req_i,
    output axi_wide_in_rsp_t                                           wide_in_resp_o
);

  assign narrow_in_resp_o  = '0;
  assign narrow_out_req_o = '0;

  assign wide_out_req_o = '0;
  assign wide_in_resp_o = '0;

endmodule
