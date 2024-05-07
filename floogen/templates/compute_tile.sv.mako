// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

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
    input  floo_req_t  [West:North]     floo_req_i,
    output floo_rsp_t  [West:North]     floo_rsp_o,
    output floo_req_t  [West:North]     floo_req_o,
    input  floo_rsp_t  [West:North]     floo_rsp_i,
    input  floo_wide_t [West:North]     floo_wide_i,
    output floo_wide_t [West:North]     floo_wide_o
`ifndef TARGET_DMA_TEST
    // SRAM configuration
    ,input  occamy_pkg::sram_cfgs_t  sram_cfgs_i
`endif
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

  // --- NI to Router ---
  // To connect with Eject port of Router
  floo_req_t  router_to_cluster_ni_req;
  floo_rsp_t  cluster_ni_to_router_rsp;
  floo_wide_t router_to_cluster_ni_wide;
  floo_req_t  cluster_ni_to_router_req;
  floo_rsp_t  router_to_cluster_ni_rsp;
  floo_wide_t cluster_ni_to_router_wide;

  // --- Router ---
  // Each router interface have 5 direction include Eject
  floo_req_t  [NumDirections-1:0] router_req_in;
  floo_rsp_t  [NumDirections-1:0] router_rsp_out;
  floo_req_t  [NumDirections-1:0] router_req_out;
  floo_rsp_t  [NumDirections-1:0] router_rsp_in;
  floo_wide_t [NumDirections-1:0] router_wide_in;
  floo_wide_t [NumDirections-1:0] router_wide_out;

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
    .sram_cfg_i (sram_cfgs_i.quadrant)
  );
`endif

  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b1),
      .EnNarrowMgrPort(1'b1),
      .EnWideSbrPort  (1'b1),
      .EnWideMgrPort  (1'b1)
  ) i_cluster_ni (
      .clk_i               (clk_i),
      .rst_ni              (rst_ni),
      .test_enable_i       (test_enable_i),
      .sram_cfg_i          ('0),
      //.sram_cfg_i        (sram_cfgs_i.floorob),
      .axi_narrow_in_req_i (cluster_to_ni_narrow_req),
      .axi_narrow_in_rsp_o (ni_to_cluster_narrow_resp),
      .axi_narrow_out_req_o(ni_to_cluster_narrow_req),
      .axi_narrow_out_rsp_i(cluster_to_ni_narrow_resp),
      .axi_wide_in_req_i   (cluster_to_ni_wide_req),
      .axi_wide_in_rsp_o   (ni_to_cluster_wide_resp),
      .axi_wide_out_req_o  (ni_to_cluster_wide_req),
      .axi_wide_out_rsp_i  (cluster_to_ni_wide_resp),
      .id_i                (id_i),
      .route_table_i       ('0),
      .floo_req_o          (cluster_ni_to_router_req),
      .floo_rsp_i          (router_to_cluster_ni_rsp),
      .floo_wide_o         (cluster_ni_to_router_wide),
      .floo_req_i          (router_to_cluster_ni_req),
      .floo_rsp_o          (cluster_ni_to_router_rsp),
      .floo_wide_i         (router_to_cluster_ni_wide)
  );

  // Assign cluster NI to Eject port of router
  assign router_req_in[Eject] = cluster_ni_to_router_req;
  assign router_to_cluster_ni_rsp = router_rsp_out[Eject];
  assign router_to_cluster_ni_req = router_req_out[Eject];
  assign router_rsp_in[Eject] = cluster_ni_to_router_rsp;
  assign router_wide_in[Eject] = cluster_ni_to_router_wide;
  assign router_to_cluster_ni_wide = router_wide_out[Eject];

   // Mapped router interface for North, East, South, and West direction to port
  assign router_req_in[West:North] = floo_req_i;
  assign floo_rsp_o = router_rsp_out[West:North];
  assign floo_req_o = router_req_out[West:North];
  assign router_rsp_in[West:North] = floo_rsp_i;
  assign router_wide_in[West:North] = floo_wide_i;
  assign floo_wide_o = router_wide_out[West:North];

  floo_narrow_wide_router #(
      .NumRoutes(NumDirections),
      .ChannelFifoDepth(2),
      .OutputFifoDepth(2),
      .RouteAlgo(XYRouting),
      .XYRouteOpt(XYRouteOpt),
      .id_t(id_t),
      .border_id_t(floo_narrow_wide_pkg::border_id_t),
      .BorderId(floo_narrow_wide_pkg::BorderId)
  ) i_router (
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_enable_i(test_enable_i),
      .id_i(id_i), // map to output port
      .id_route_map_i('0),
      .floo_req_i(router_req_in),
      .floo_rsp_o(router_rsp_out),
      .floo_req_o(router_req_out),
      .floo_rsp_i(router_rsp_in),
      .floo_wide_i(router_wide_in),
      .floo_wide_o(router_wide_out)
  );

endmodule
