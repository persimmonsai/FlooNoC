
module floo_noc_pd_top
  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;
(
    input logic clk_i,
    input logic rst_ni,
    input logic test_enable_i,

    input id_t id_i,

    // FlooNoC router
    input  floo_req_t  [West:North] floo_req_i,
    input  floo_rsp_t  [West:North] floo_rsp_i,
    output floo_req_t  [West:North] floo_req_o,
    output floo_rsp_t  [West:North] floo_rsp_o,
    input  floo_wide_t [West:North] floo_wide_i,
    output floo_wide_t [West:North] floo_wide_o,

    // Cluster interface
    input axi_narrow_in_req_t  cluster_to_ni_narrow_req,
    output axi_narrow_in_rsp_t  ni_to_cluster_narrow_resp,
    output axi_narrow_out_req_t ni_to_cluster_narrow_req,
    input axi_narrow_out_rsp_t cluster_to_ni_narrow_resp,
    input axi_wide_in_req_t    cluster_to_ni_wide_req,
    output axi_wide_in_rsp_t    ni_to_cluster_wide_resp,
    output axi_wide_out_req_t   ni_to_cluster_wide_req,
    input axi_wide_out_rsp_t   cluster_to_ni_wide_resp
);

  // --- NI to Router ---
  // To connect with Eject port of Router
  floo_req_t router_to_cluster_ni_req;
  floo_rsp_t cluster_ni_to_router_rsp;
  floo_wide_t router_to_cluster_ni_wide;
  floo_req_t cluster_ni_to_router_req;
  floo_rsp_t router_to_cluster_ni_rsp;
  floo_wide_t cluster_ni_to_router_wide;

  // --- Router ---
  // Each router interface have 5 direction include Eject
  floo_req_t [NumDirections-1:0] router_req_in;
  floo_rsp_t [NumDirections-1:0] router_rsp_out;
  floo_req_t [NumDirections-1:0] router_req_out;
  floo_rsp_t [NumDirections-1:0] router_rsp_in;
  floo_wide_t [NumDirections-1:0] router_wide_in;
  floo_wide_t [NumDirections-1:0] router_wide_out;

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
      .id_i(id_i),  // map to output port
      .id_route_map_i('0),
      .floo_req_i(router_req_in),
      .floo_rsp_o(router_rsp_out),
      .floo_req_o(router_req_out),
      .floo_rsp_i(router_rsp_in),
      .floo_wide_i(router_wide_in),
      .floo_wide_o(router_wide_out)
  );

endmodule
