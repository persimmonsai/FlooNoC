// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
<% def camelcase(s):
     return ''.join(x.capitalize() or '_' for x in s.split('_'))
%>\
<%
  import math
%>\
<% NUM_X = noc.routers[0].array[0] %>\
<% NUM_Y = noc.routers[0].array[1] %>\
<% tile_id_bit_num = int(math.ceil(math.log2(NUM_X*NUM_Y))) %>\

`include "axi/typedef.svh"

module compute_tile
  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;
`ifdef TARGET_DMA_TEST
#(
    // Additional simulation input port to control simulation behaviour
    parameter int unsigned id_x = 1,
    parameter int unsigned id_y = 1
)
`endif
(
    input  logic                        clk_i,
    input  logic                        rst_ni,
    input  logic                        test_enable_i,
    
    input  logic [${noc.num_snitch_core-1}:0]   meip_i,
    input  logic [${noc.num_snitch_core-1}:0]   mtip_i,
    input  logic [${noc.num_snitch_core-1}:0]   msip_i,
    input  logic [${tile_id_bit_num-1}:0]   tile_id_i,

    input  id_t                         id_i, // XY ID for router and cluster NI
    // North, East, South, and West floonoc router interface
% for dir in ["north","east","south","west"]:
    input  floo_vec_req_t    floo_${dir}_req_i,
    output floo_vec_rsp_t    floo_${dir}_rsp_o,
    output floo_vec_req_t    floo_${dir}_req_o,
    input  floo_vec_rsp_t    floo_${dir}_rsp_i,
    input  floo_vec_wide_t   floo_${dir}_wide_i,
% if dir!="west":
    output floo_vec_wide_t   floo_${dir}_wide_o,
% else:
    output floo_vec_wide_t   floo_${dir}_wide_o
% endif
% endfor
);
  // --- Cluster to NI ---
  // in/out direction type that is declared in this scope is respect to NI
  // So axi_narrow_in_req_t of NI will connected to axi_narrow_out_req_t of snitch_cluster
  // In case, id width is not equal between axi_narrow_in_req_t of NI and axi_narrow_out_req_t of snitch_cluster,
  // axi_iw_converter need to place to convert ID width
  axi_narrow_in_req_t  cluster_to_ni_narrow_req;
  axi_narrow_in_rsp_t  ni_to_cluster_narrow_resp;
  axi_narrow_out_req_t ni_to_cluster_narrow_req;
  axi_narrow_out_rsp_t cluster_to_ni_narrow_resp;
  axi_wide_in_req_t    cluster_to_ni_wide_req;
  axi_wide_in_rsp_t    ni_to_cluster_wide_resp;
  axi_wide_out_req_t   ni_to_cluster_wide_req;
  axi_wide_out_rsp_t   cluster_to_ni_wide_resp;

// Switch to instantiate module between simulation (with questa) and synthesis
`ifdef TARGET_DMA_TEST
  snitch_cluster_test_node  
  #(
    .id_x(id_x),
    .id_y(id_y)
  ) i_snitch_cluster_test_node
  (
    .clk_i (clk_i),
    .rst_ni (rst_ni),
    // Narrow AXI Master
    .narrow_out_req_o (cluster_to_ni_narrow_req),
    .narrow_out_resp_i (ni_to_cluster_narrow_resp),
    // Narrow AXI Slave
    .narrow_in_req_i (ni_to_cluster_narrow_req),
    .narrow_in_resp_o (cluster_to_ni_narrow_resp),
    // Wide AXI Master
    .wide_out_req_o (cluster_to_ni_wide_req),
    .wide_out_resp_i (ni_to_cluster_wide_resp),
    // Wide AXI Slave
    .wide_in_req_i (ni_to_cluster_wide_req),
    .wide_in_resp_o (cluster_to_ni_wide_resp)
  );
`else
  occamy_quadrant_s1 i_occamy_quadrant_s1
  (
    .clk_i (clk_i),
    .rst_ni (rst_ni),
    //.sa_rst_ni('1),
    .test_mode_i (test_enable_i),
    .tile_id_i (tile_id_i),
    .meip_i (meip_i),
    .mtip_i (mtip_i),
    .msip_i (msip_i),
    // Narrow AXI Master
    .quadrant_narrow_out_req_o (cluster_to_ni_narrow_req),
    .quadrant_narrow_out_rsp_i (ni_to_cluster_narrow_resp),
    // Narrow AXI Slave
    .quadrant_narrow_in_req_i (ni_to_cluster_narrow_req),
    .quadrant_narrow_in_rsp_o (cluster_to_ni_narrow_resp),
    // Wide AXI Master
    .quadrant_wide_out_req_o (cluster_to_ni_wide_req),
    .quadrant_wide_out_rsp_i (ni_to_cluster_wide_resp),
    // Wide AXI Slave
    .quadrant_wide_in_req_i (ni_to_cluster_wide_req),
    .quadrant_wide_in_rsp_o (cluster_to_ni_wide_resp),
    // SRAM configuration
    .sram_cfg_i ('0)
  );
`endif

  floo_req_t  [West:North] floo_req_i;
  floo_rsp_t  [West:North] floo_rsp_o;
  floo_req_t  [West:North] floo_req_o;
  floo_rsp_t  [West:North] floo_rsp_i;
  floo_wide_t [West:North] floo_wide_i;
  floo_wide_t [West:North] floo_wide_o;
% for dir in ["north","east","south","west"]:
  assign floo_req_i[${camelcase(dir)}] = floo_${dir}_req_i;
  assign floo_rsp_i[${camelcase(dir)}] = floo_${dir}_rsp_i;
  assign floo_wide_i[${camelcase(dir)}] = floo_${dir}_wide_i;
  assign #0.1ns floo_${dir}_req_o = floo_req_o[${camelcase(dir)}];
  assign #0.1ns floo_${dir}_rsp_o = floo_rsp_o[${camelcase(dir)}];
  assign #0.1ns floo_${dir}_wide_o = floo_wide_o[${camelcase(dir)}];
% endfor

  floo_noc_pd_top i_floo_noc_pd
  (
    .clk_i (clk_i),
    .rst_ni (rst_ni),
    .test_enable_i (test_enable_i),

    .id_i (id_i),

    // FlooNoC router
    .floo_req_i (floo_req_i),
    .floo_rsp_i (floo_rsp_i),
    .floo_req_o (floo_req_o),
    .floo_rsp_o (floo_rsp_o),
    .floo_wide_i (floo_wide_i),
    .floo_wide_o (floo_wide_o),

    // Cluster interface
    .cluster_to_ni_narrow_req (cluster_to_ni_narrow_req),
    .ni_to_cluster_narrow_resp (ni_to_cluster_narrow_resp),
    .ni_to_cluster_narrow_req (ni_to_cluster_narrow_req),
    .cluster_to_ni_narrow_resp (cluster_to_ni_narrow_resp),
    .cluster_to_ni_wide_req (cluster_to_ni_wide_req),
    .ni_to_cluster_wide_resp (ni_to_cluster_wide_resp),
    .ni_to_cluster_wide_req (ni_to_cluster_wide_req),
    .cluster_to_ni_wide_resp (cluster_to_ni_wide_resp)
  );

endmodule
