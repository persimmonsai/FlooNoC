
`include "test_cluster/snitch_cluster_pkg.svh"

// Blank wrapper for synthesis testing
module snitch_cluster_wrapper (
    input logic clk_i,
    input logic rst_ni,
    //input logic sa_rst_ni,
    input logic [snitch_cluster_pkg::NrCores-1:0] debug_req_i,
    input logic [snitch_cluster_pkg::NrCores-1:0] meip_i,
    input logic [snitch_cluster_pkg::NrCores-1:0] mtip_i,
    input logic [snitch_cluster_pkg::NrCores-1:0] msip_i,
    input snitch_cluster_pkg::narrow_in_req_t narrow_in_req_i,
    output snitch_cluster_pkg::narrow_in_resp_t narrow_in_resp_o,
    output snitch_cluster_pkg::narrow_out_req_t narrow_out_req_o,
    input snitch_cluster_pkg::narrow_out_resp_t narrow_out_resp_i,
    output snitch_cluster_pkg::wide_out_req_t wide_out_req_o,
    input snitch_cluster_pkg::wide_out_resp_t wide_out_resp_i,
    input snitch_cluster_pkg::wide_in_req_t wide_in_req_i,
    output snitch_cluster_pkg::wide_in_resp_t wide_in_resp_o
);

  assign narrow_in_resp_o = '0;
  assign narrow_out_req_o = '0;

  assign wide_out_req_o   = '0;
  assign wide_in_resp_o   = '0;

endmodule
