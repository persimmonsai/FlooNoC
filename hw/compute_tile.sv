// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

// `include "snitch_cluster_pkg.svh"

// `include "axi_flat.svh"
// `include "axi/typedef.svh"

`include "axi/typedef.svh"

module compute_tile
  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;
  // TODO : Set AXI interface of 'snitch_cluster_pkg' to be equal with 'floo_narrow_wide_pkg'
  // Use AXI interface defined on 'floo_narrow_wide_pkg' that 
  // must be equal with AXI interface parameter defined on 'snitch_cluster_pkg'
  // import snitch_cluster_pkg::*;
(
    input  logic                        clk_i,
    input  logic                        rst_ni,
    input  logic                        test_enable_i,

    input  id_t                         id_i, // XY ID for router and cluster NI
    // North, East, South, and West floonoc router interface
    input  floo_req_t  [North:West]     floo_xy_req_i,
    output floo_rsp_t  [North:West]     floo_xy_rsp_o,
    output floo_req_t  [North:West]     floo_xy_req_o,
    input  floo_rsp_t  [North:West]     floo_xy_rsp_i,
    input  floo_wide_t [North:West]     floo_xy_wide_i,
    output floo_wide_t [North:West]     floo_xy_wide_o
);
  // --- Cluster to NI ---
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

//   input logic                           sa_rst_ni,
//   /// Per-core debug request signal. Asserting this signals puts the
//   /// corresponding core into debug mode. This signal is assumed to be _async_.
//   input  logic [NrCores-1:0]            debug_req_i,
//   /// Machine external interrupt pending. Usually those interrupts come from a
//   /// platform-level interrupt controller. This signal is assumed to be _async_.
//   input  logic [NrCores-1:0]            meip_i,
//   /// Machine timer interrupt pending. Usually those interrupts come from a
//   /// core-local interrupt controller such as a timer/RTC. This signal is
//   /// assumed to be _async_.
//   input  logic [NrCores-1:0]            mtip_i,
//   /// Core software interrupt pending. Usually those interrupts come from
//   /// another core to facilitate inter-processor-interrupts. This signal is
//   /// assumed to be _async_.
//   input  logic [NrCores-1:0]            msip_i,

// Switch to instantiate module between simulation (with questa) and synthesis
`ifdef QUESTA
  snitch_cluster_wrapper_test i_snitch_cluster_test
`else
  snitch_cluster_wrapper i_snitch_cluster
`endif
  (
      .clk_i,
      .rst_ni,
      // sa_rst_ni, debug_req_i, meip_i, mtip_i, and msip_i 
      // may need to extract from AXI narrow, which is a control signal and handshake from others cluster
      .sa_rst_ni('1),
      .debug_req_i ('0),
      .meip_i ('0),
      .mtip_i ('0),
      .msip_i ('0),
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

  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b1),
      .EnNarrowMgrPort(1'b1),
      .EnWideSbrPort  (1'b1),
      .EnWideMgrPort  (1'b1)
  ) i_cluster_ni (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .sram_cfg_i          ('0),
      .axi_narrow_in_req_i (cluster_to_ni_narrow_req),
      .axi_narrow_in_rsp_o (ni_to_cluster_narrow_resp),
      .axi_narrow_out_req_o(ni_to_cluster_narrow_req),
      .axi_narrow_out_rsp_i(cluster_to_ni_narrow_resp),
      .axi_wide_in_req_i   (cluster_to_ni_wide_req),
      .axi_wide_in_rsp_o   (ni_to_cluster_wide_resp),
      .axi_wide_out_req_o  (ni_to_cluster_wide_req),
      .axi_wide_out_rsp_i  (cluster_to_ni_wide_resp),
      .id_i                (id_i),
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
  assign router_req_in[North:West] = floo_xy_req_i;
  assign floo_xy_rsp_o = router_rsp_out[North:West];
  assign floo_xy_req_o = router_req_out[North:West];
  assign router_rsp_in[North:West] = floo_xy_rsp_i;
  assign router_wide_in[North:West] = floo_xy_wide_i;
  assign floo_xy_wide_o = router_wide_out[North:West];

  floo_narrow_wide_router #(
      .NumRoutes(NumDirections),
      .ChannelFifoDepth(2),
      .OutputFifoDepth(2),
      .RouteAlgo(XYRouting),
      .id_t(id_t)
  ) i_router (
      .clk_i,
      .rst_ni,
      .test_enable_i,
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
