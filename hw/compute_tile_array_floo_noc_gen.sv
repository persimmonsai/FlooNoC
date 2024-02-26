// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

// AUTOMATICALLY GENERATED! DO NOT EDIT!

module compute_tile_array_floo_noc_gen
  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;
(
    input  logic                           clk_i,
    input  logic                           rst_ni,
    input  logic                           test_enable_i,
    input  axi_narrow_in_req_t  [1:0][1:0] cluster_narrow_req_i,
    output axi_narrow_in_rsp_t  [1:0][1:0] cluster_narrow_rsp_o,
    input  axi_wide_in_req_t    [1:0][1:0] cluster_wide_req_i,
    output axi_wide_in_rsp_t    [1:0][1:0] cluster_wide_rsp_o,
    output axi_narrow_out_req_t [1:0][1:0] cluster_narrow_req_o,
    input  axi_narrow_out_rsp_t [1:0][1:0] cluster_narrow_rsp_i,
    output axi_wide_out_req_t   [1:0][1:0] cluster_wide_req_o,
    input  axi_wide_out_rsp_t   [1:0][1:0] cluster_wide_rsp_i,
    output axi_narrow_out_req_t [1:0]      hbm_north_narrow_req_o,
    input  axi_narrow_out_rsp_t [1:0]      hbm_north_narrow_rsp_i,
    output axi_wide_out_req_t   [1:0]      hbm_north_wide_req_o,
    input  axi_wide_out_rsp_t   [1:0]      hbm_north_wide_rsp_i,
    output axi_narrow_out_req_t [1:0]      hbm_south_narrow_req_o,
    input  axi_narrow_out_rsp_t [1:0]      hbm_south_narrow_rsp_i,
    output axi_wide_out_req_t   [1:0]      hbm_south_wide_req_o,
    input  axi_wide_out_rsp_t   [1:0]      hbm_south_wide_rsp_i,
    input  axi_narrow_in_req_t             pcie_narrow_req_i,
    output axi_narrow_in_rsp_t             pcie_narrow_rsp_o,
    input  axi_wide_in_req_t               pcie_wide_req_i,
    output axi_wide_in_rsp_t               pcie_wide_rsp_o,
    output axi_narrow_out_req_t            pcie_narrow_req_o,
    input  axi_narrow_out_rsp_t            pcie_narrow_rsp_i,
    output axi_wide_out_req_t              pcie_wide_req_o,
    input  axi_wide_out_rsp_t              pcie_wide_rsp_i,
    input  axi_narrow_in_req_t             cva6_narrow_req_i,
    output axi_narrow_in_rsp_t             cva6_narrow_rsp_o,
    input  axi_narrow_in_req_t  [1:0]      peripherals_narrow_req_i,
    output axi_narrow_in_rsp_t  [1:0]      peripherals_narrow_rsp_o,
    output axi_narrow_out_req_t [1:0]      peripherals_narrow_req_o,
    input  axi_narrow_out_rsp_t [1:0]      peripherals_narrow_rsp_i

);

  floo_req_t  router_0_0_to_router_0_1_req;
  floo_rsp_t  router_0_1_to_router_0_0_rsp;
  floo_wide_t router_0_0_to_router_0_1_wide;

  floo_req_t  router_0_0_to_router_1_0_req;
  floo_rsp_t  router_1_0_to_router_0_0_rsp;
  floo_wide_t router_0_0_to_router_1_0_wide;

  floo_req_t  router_0_0_to_cluster_ni_0_0_req;
  floo_rsp_t  cluster_ni_0_0_to_router_0_0_rsp;
  floo_wide_t router_0_0_to_cluster_ni_0_0_wide;

  floo_req_t  router_0_0_to_hbm_south_ni_0_0_req;
  floo_rsp_t  hbm_south_ni_0_0_to_router_0_0_rsp;
  floo_wide_t router_0_0_to_hbm_south_ni_0_0_wide;

  floo_req_t  router_0_0_to_cva6_ni_req;
  floo_rsp_t  cva6_ni_to_router_0_0_rsp;
  floo_wide_t router_0_0_to_cva6_ni_wide;

  floo_req_t  router_0_1_to_router_0_0_req;
  floo_rsp_t  router_0_0_to_router_0_1_rsp;
  floo_wide_t router_0_1_to_router_0_0_wide;

  floo_req_t  router_0_1_to_router_1_1_req;
  floo_rsp_t  router_1_1_to_router_0_1_rsp;
  floo_wide_t router_0_1_to_router_1_1_wide;

  floo_req_t  router_0_1_to_cluster_ni_0_1_req;
  floo_rsp_t  cluster_ni_0_1_to_router_0_1_rsp;
  floo_wide_t router_0_1_to_cluster_ni_0_1_wide;

  floo_req_t  router_0_1_to_hbm_north_ni_0_0_req;
  floo_rsp_t  hbm_north_ni_0_0_to_router_0_1_rsp;
  floo_wide_t router_0_1_to_hbm_north_ni_0_0_wide;

  floo_req_t  router_0_1_to_pcie_ni_req;
  floo_rsp_t  pcie_ni_to_router_0_1_rsp;
  floo_wide_t router_0_1_to_pcie_ni_wide;

  floo_req_t  router_1_0_to_router_0_0_req;
  floo_rsp_t  router_0_0_to_router_1_0_rsp;
  floo_wide_t router_1_0_to_router_0_0_wide;

  floo_req_t  router_1_0_to_router_1_1_req;
  floo_rsp_t  router_1_1_to_router_1_0_rsp;
  floo_wide_t router_1_0_to_router_1_1_wide;

  floo_req_t  router_1_0_to_cluster_ni_1_0_req;
  floo_rsp_t  cluster_ni_1_0_to_router_1_0_rsp;
  floo_wide_t router_1_0_to_cluster_ni_1_0_wide;

  floo_req_t  router_1_0_to_hbm_south_ni_1_0_req;
  floo_rsp_t  hbm_south_ni_1_0_to_router_1_0_rsp;
  floo_wide_t router_1_0_to_hbm_south_ni_1_0_wide;

  floo_req_t  router_1_0_to_peripherals_ni_0_0_req;
  floo_rsp_t  peripherals_ni_0_0_to_router_1_0_rsp;
  floo_wide_t router_1_0_to_peripherals_ni_0_0_wide;

  floo_req_t  router_1_1_to_router_0_1_req;
  floo_rsp_t  router_0_1_to_router_1_1_rsp;
  floo_wide_t router_1_1_to_router_0_1_wide;

  floo_req_t  router_1_1_to_router_1_0_req;
  floo_rsp_t  router_1_0_to_router_1_1_rsp;
  floo_wide_t router_1_1_to_router_1_0_wide;

  floo_req_t  router_1_1_to_cluster_ni_1_1_req;
  floo_rsp_t  cluster_ni_1_1_to_router_1_1_rsp;
  floo_wide_t router_1_1_to_cluster_ni_1_1_wide;

  floo_req_t  router_1_1_to_hbm_north_ni_1_0_req;
  floo_rsp_t  hbm_north_ni_1_0_to_router_1_1_rsp;
  floo_wide_t router_1_1_to_hbm_north_ni_1_0_wide;

  floo_req_t  router_1_1_to_peripherals_ni_0_1_req;
  floo_rsp_t  peripherals_ni_0_1_to_router_1_1_rsp;
  floo_wide_t router_1_1_to_peripherals_ni_0_1_wide;

  floo_req_t  cluster_ni_0_0_to_router_0_0_req;
  floo_rsp_t  router_0_0_to_cluster_ni_0_0_rsp;
  floo_wide_t cluster_ni_0_0_to_router_0_0_wide;

  floo_req_t  cluster_ni_0_1_to_router_0_1_req;
  floo_rsp_t  router_0_1_to_cluster_ni_0_1_rsp;
  floo_wide_t cluster_ni_0_1_to_router_0_1_wide;

  floo_req_t  cluster_ni_1_0_to_router_1_0_req;
  floo_rsp_t  router_1_0_to_cluster_ni_1_0_rsp;
  floo_wide_t cluster_ni_1_0_to_router_1_0_wide;

  floo_req_t  cluster_ni_1_1_to_router_1_1_req;
  floo_rsp_t  router_1_1_to_cluster_ni_1_1_rsp;
  floo_wide_t cluster_ni_1_1_to_router_1_1_wide;

  floo_req_t  hbm_north_ni_0_0_to_router_0_1_req;
  floo_rsp_t  router_0_1_to_hbm_north_ni_0_0_rsp;
  floo_wide_t hbm_north_ni_0_0_to_router_0_1_wide;

  floo_req_t  hbm_north_ni_1_0_to_router_1_1_req;
  floo_rsp_t  router_1_1_to_hbm_north_ni_1_0_rsp;
  floo_wide_t hbm_north_ni_1_0_to_router_1_1_wide;

  floo_req_t  hbm_south_ni_0_0_to_router_0_0_req;
  floo_rsp_t  router_0_0_to_hbm_south_ni_0_0_rsp;
  floo_wide_t hbm_south_ni_0_0_to_router_0_0_wide;

  floo_req_t  hbm_south_ni_1_0_to_router_1_0_req;
  floo_rsp_t  router_1_0_to_hbm_south_ni_1_0_rsp;
  floo_wide_t hbm_south_ni_1_0_to_router_1_0_wide;

  floo_req_t  pcie_ni_to_router_0_1_req;
  floo_rsp_t  router_0_1_to_pcie_ni_rsp;
  floo_wide_t pcie_ni_to_router_0_1_wide;

  floo_req_t  cva6_ni_to_router_0_0_req;
  floo_rsp_t  router_0_0_to_cva6_ni_rsp;
  floo_wide_t cva6_ni_to_router_0_0_wide;

  floo_req_t  peripherals_ni_0_0_to_router_1_0_req;
  floo_rsp_t  router_1_0_to_peripherals_ni_0_0_rsp;
  floo_wide_t peripherals_ni_0_0_to_router_1_0_wide;

  floo_req_t  peripherals_ni_0_1_to_router_1_1_req;
  floo_rsp_t  router_1_1_to_peripherals_ni_0_1_rsp;
  floo_wide_t peripherals_ni_0_1_to_router_1_1_wide;



  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b1),
      .EnNarrowMgrPort(1'b1),
      .EnWideSbrPort  (1'b1),
      .EnWideMgrPort  (1'b1)
  ) cluster_ni_0_0 (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .sram_cfg_i          ('0),
      .axi_narrow_in_req_i (cluster_narrow_req_i[0][0]),
      .axi_narrow_in_rsp_o (cluster_narrow_rsp_o[0][0]),
      .axi_narrow_out_req_o(cluster_narrow_req_o[0][0]),
      .axi_narrow_out_rsp_i(cluster_narrow_rsp_i[0][0]),
      .axi_wide_in_req_i   (cluster_wide_req_i[0][0]),
      .axi_wide_in_rsp_o   (cluster_wide_rsp_o[0][0]),
      .axi_wide_out_req_o  (cluster_wide_req_o[0][0]),
      .axi_wide_out_rsp_i  (cluster_wide_rsp_i[0][0]),
      .id_i                ('{x: 1, y: 1}),
      .floo_req_o          (cluster_ni_0_0_to_router_0_0_req),
      .floo_rsp_i          (router_0_0_to_cluster_ni_0_0_rsp),
      .floo_wide_o         (cluster_ni_0_0_to_router_0_0_wide),
      .floo_req_i          (router_0_0_to_cluster_ni_0_0_req),
      .floo_rsp_o          (cluster_ni_0_0_to_router_0_0_rsp),
      .floo_wide_i         (router_0_0_to_cluster_ni_0_0_wide)
  );

  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b1),
      .EnNarrowMgrPort(1'b1),
      .EnWideSbrPort  (1'b1),
      .EnWideMgrPort  (1'b1)
  ) cluster_ni_0_1 (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .sram_cfg_i          ('0),
      .axi_narrow_in_req_i (cluster_narrow_req_i[0][1]),
      .axi_narrow_in_rsp_o (cluster_narrow_rsp_o[0][1]),
      .axi_narrow_out_req_o(cluster_narrow_req_o[0][1]),
      .axi_narrow_out_rsp_i(cluster_narrow_rsp_i[0][1]),
      .axi_wide_in_req_i   (cluster_wide_req_i[0][1]),
      .axi_wide_in_rsp_o   (cluster_wide_rsp_o[0][1]),
      .axi_wide_out_req_o  (cluster_wide_req_o[0][1]),
      .axi_wide_out_rsp_i  (cluster_wide_rsp_i[0][1]),
      .id_i                ('{x: 1, y: 2}),
      .floo_req_o          (cluster_ni_0_1_to_router_0_1_req),
      .floo_rsp_i          (router_0_1_to_cluster_ni_0_1_rsp),
      .floo_wide_o         (cluster_ni_0_1_to_router_0_1_wide),
      .floo_req_i          (router_0_1_to_cluster_ni_0_1_req),
      .floo_rsp_o          (cluster_ni_0_1_to_router_0_1_rsp),
      .floo_wide_i         (router_0_1_to_cluster_ni_0_1_wide)
  );

  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b1),
      .EnNarrowMgrPort(1'b1),
      .EnWideSbrPort  (1'b1),
      .EnWideMgrPort  (1'b1)
  ) cluster_ni_1_0 (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .sram_cfg_i          ('0),
      .axi_narrow_in_req_i (cluster_narrow_req_i[1][0]),
      .axi_narrow_in_rsp_o (cluster_narrow_rsp_o[1][0]),
      .axi_narrow_out_req_o(cluster_narrow_req_o[1][0]),
      .axi_narrow_out_rsp_i(cluster_narrow_rsp_i[1][0]),
      .axi_wide_in_req_i   (cluster_wide_req_i[1][0]),
      .axi_wide_in_rsp_o   (cluster_wide_rsp_o[1][0]),
      .axi_wide_out_req_o  (cluster_wide_req_o[1][0]),
      .axi_wide_out_rsp_i  (cluster_wide_rsp_i[1][0]),
      .id_i                ('{x: 2, y: 1}),
      .floo_req_o          (cluster_ni_1_0_to_router_1_0_req),
      .floo_rsp_i          (router_1_0_to_cluster_ni_1_0_rsp),
      .floo_wide_o         (cluster_ni_1_0_to_router_1_0_wide),
      .floo_req_i          (router_1_0_to_cluster_ni_1_0_req),
      .floo_rsp_o          (cluster_ni_1_0_to_router_1_0_rsp),
      .floo_wide_i         (router_1_0_to_cluster_ni_1_0_wide)
  );

  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b1),
      .EnNarrowMgrPort(1'b1),
      .EnWideSbrPort  (1'b1),
      .EnWideMgrPort  (1'b1)
  ) cluster_ni_1_1 (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .sram_cfg_i          ('0),
      .axi_narrow_in_req_i (cluster_narrow_req_i[1][1]),
      .axi_narrow_in_rsp_o (cluster_narrow_rsp_o[1][1]),
      .axi_narrow_out_req_o(cluster_narrow_req_o[1][1]),
      .axi_narrow_out_rsp_i(cluster_narrow_rsp_i[1][1]),
      .axi_wide_in_req_i   (cluster_wide_req_i[1][1]),
      .axi_wide_in_rsp_o   (cluster_wide_rsp_o[1][1]),
      .axi_wide_out_req_o  (cluster_wide_req_o[1][1]),
      .axi_wide_out_rsp_i  (cluster_wide_rsp_i[1][1]),
      .id_i                ('{x: 2, y: 2}),
      .floo_req_o          (cluster_ni_1_1_to_router_1_1_req),
      .floo_rsp_i          (router_1_1_to_cluster_ni_1_1_rsp),
      .floo_wide_o         (cluster_ni_1_1_to_router_1_1_wide),
      .floo_req_i          (router_1_1_to_cluster_ni_1_1_req),
      .floo_rsp_o          (cluster_ni_1_1_to_router_1_1_rsp),
      .floo_wide_i         (router_1_1_to_cluster_ni_1_1_wide)
  );

  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b1),
      .EnNarrowMgrPort(1'b0),
      .EnWideSbrPort  (1'b1),
      .EnWideMgrPort  (1'b0)
  ) hbm_north_ni_0_0 (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .sram_cfg_i          ('0),
      .axi_narrow_in_req_i ('0),
      .axi_narrow_in_rsp_o (),
      .axi_narrow_out_req_o(hbm_north_narrow_req_o[0]),
      .axi_narrow_out_rsp_i(hbm_north_narrow_rsp_i[0]),
      .axi_wide_in_req_i   ('0),
      .axi_wide_in_rsp_o   (),
      .axi_wide_out_req_o  (hbm_north_wide_req_o[0]),
      .axi_wide_out_rsp_i  (hbm_north_wide_rsp_i[0]),
      .id_i                ('{x: 1, y: 3}),
      .floo_req_o          (hbm_north_ni_0_0_to_router_0_1_req),
      .floo_rsp_i          (router_0_1_to_hbm_north_ni_0_0_rsp),
      .floo_wide_o         (hbm_north_ni_0_0_to_router_0_1_wide),
      .floo_req_i          (router_0_1_to_hbm_north_ni_0_0_req),
      .floo_rsp_o          (hbm_north_ni_0_0_to_router_0_1_rsp),
      .floo_wide_i         (router_0_1_to_hbm_north_ni_0_0_wide)
  );

  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b1),
      .EnNarrowMgrPort(1'b0),
      .EnWideSbrPort  (1'b1),
      .EnWideMgrPort  (1'b0)
  ) hbm_north_ni_1_0 (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .sram_cfg_i          ('0),
      .axi_narrow_in_req_i ('0),
      .axi_narrow_in_rsp_o (),
      .axi_narrow_out_req_o(hbm_north_narrow_req_o[1]),
      .axi_narrow_out_rsp_i(hbm_north_narrow_rsp_i[1]),
      .axi_wide_in_req_i   ('0),
      .axi_wide_in_rsp_o   (),
      .axi_wide_out_req_o  (hbm_north_wide_req_o[1]),
      .axi_wide_out_rsp_i  (hbm_north_wide_rsp_i[1]),
      .id_i                ('{x: 2, y: 3}),
      .floo_req_o          (hbm_north_ni_1_0_to_router_1_1_req),
      .floo_rsp_i          (router_1_1_to_hbm_north_ni_1_0_rsp),
      .floo_wide_o         (hbm_north_ni_1_0_to_router_1_1_wide),
      .floo_req_i          (router_1_1_to_hbm_north_ni_1_0_req),
      .floo_rsp_o          (hbm_north_ni_1_0_to_router_1_1_rsp),
      .floo_wide_i         (router_1_1_to_hbm_north_ni_1_0_wide)
  );

  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b1),
      .EnNarrowMgrPort(1'b0),
      .EnWideSbrPort  (1'b1),
      .EnWideMgrPort  (1'b0)
  ) hbm_south_ni_0_0 (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .sram_cfg_i          ('0),
      .axi_narrow_in_req_i ('0),
      .axi_narrow_in_rsp_o (),
      .axi_narrow_out_req_o(hbm_south_narrow_req_o[0]),
      .axi_narrow_out_rsp_i(hbm_south_narrow_rsp_i[0]),
      .axi_wide_in_req_i   ('0),
      .axi_wide_in_rsp_o   (),
      .axi_wide_out_req_o  (hbm_south_wide_req_o[0]),
      .axi_wide_out_rsp_i  (hbm_south_wide_rsp_i[0]),
      .id_i                ('{x: 1, y: 0}),
      .floo_req_o          (hbm_south_ni_0_0_to_router_0_0_req),
      .floo_rsp_i          (router_0_0_to_hbm_south_ni_0_0_rsp),
      .floo_wide_o         (hbm_south_ni_0_0_to_router_0_0_wide),
      .floo_req_i          (router_0_0_to_hbm_south_ni_0_0_req),
      .floo_rsp_o          (hbm_south_ni_0_0_to_router_0_0_rsp),
      .floo_wide_i         (router_0_0_to_hbm_south_ni_0_0_wide)
  );

  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b1),
      .EnNarrowMgrPort(1'b0),
      .EnWideSbrPort  (1'b1),
      .EnWideMgrPort  (1'b0)
  ) hbm_south_ni_1_0 (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .sram_cfg_i          ('0),
      .axi_narrow_in_req_i ('0),
      .axi_narrow_in_rsp_o (),
      .axi_narrow_out_req_o(hbm_south_narrow_req_o[1]),
      .axi_narrow_out_rsp_i(hbm_south_narrow_rsp_i[1]),
      .axi_wide_in_req_i   ('0),
      .axi_wide_in_rsp_o   (),
      .axi_wide_out_req_o  (hbm_south_wide_req_o[1]),
      .axi_wide_out_rsp_i  (hbm_south_wide_rsp_i[1]),
      .id_i                ('{x: 2, y: 0}),
      .floo_req_o          (hbm_south_ni_1_0_to_router_1_0_req),
      .floo_rsp_i          (router_1_0_to_hbm_south_ni_1_0_rsp),
      .floo_wide_o         (hbm_south_ni_1_0_to_router_1_0_wide),
      .floo_req_i          (router_1_0_to_hbm_south_ni_1_0_req),
      .floo_rsp_o          (hbm_south_ni_1_0_to_router_1_0_rsp),
      .floo_wide_i         (router_1_0_to_hbm_south_ni_1_0_wide)
  );

  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b1),
      .EnNarrowMgrPort(1'b1),
      .EnWideSbrPort  (1'b1),
      .EnWideMgrPort  (1'b1)
  ) pcie_ni (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .sram_cfg_i          ('0),
      .axi_narrow_in_req_i (pcie_narrow_req_i),
      .axi_narrow_in_rsp_o (pcie_narrow_rsp_o),
      .axi_narrow_out_req_o(pcie_narrow_req_o),
      .axi_narrow_out_rsp_i(pcie_narrow_rsp_i),
      .axi_wide_in_req_i   (pcie_wide_req_i),
      .axi_wide_in_rsp_o   (pcie_wide_rsp_o),
      .axi_wide_out_req_o  (pcie_wide_req_o),
      .axi_wide_out_rsp_i  (pcie_wide_rsp_i),
      .id_i                ('{x: 0, y: 2}),
      .floo_req_o          (pcie_ni_to_router_0_1_req),
      .floo_rsp_i          (router_0_1_to_pcie_ni_rsp),
      .floo_wide_o         (pcie_ni_to_router_0_1_wide),
      .floo_req_i          (router_0_1_to_pcie_ni_req),
      .floo_rsp_o          (pcie_ni_to_router_0_1_rsp),
      .floo_wide_i         (router_0_1_to_pcie_ni_wide)
  );

  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b0),
      .EnNarrowMgrPort(1'b1),
      .EnWideSbrPort  (1'b0),
      .EnWideMgrPort  (1'b0)
  ) cva6_ni (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .sram_cfg_i          ('0),
      .axi_narrow_in_req_i (cva6_narrow_req_i),
      .axi_narrow_in_rsp_o (cva6_narrow_rsp_o),
      .axi_narrow_out_req_o(),
      .axi_narrow_out_rsp_i('0),
      .axi_wide_in_req_i   ('0),
      .axi_wide_in_rsp_o   (),
      .axi_wide_out_req_o  (),
      .axi_wide_out_rsp_i  ('0),
      .id_i                ('{x: 0, y: 1}),
      .floo_req_o          (cva6_ni_to_router_0_0_req),
      .floo_rsp_i          (router_0_0_to_cva6_ni_rsp),
      .floo_wide_o         (cva6_ni_to_router_0_0_wide),
      .floo_req_i          (router_0_0_to_cva6_ni_req),
      .floo_rsp_o          (cva6_ni_to_router_0_0_rsp),
      .floo_wide_i         (router_0_0_to_cva6_ni_wide)
  );

  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b1),
      .EnNarrowMgrPort(1'b1),
      .EnWideSbrPort  (1'b0),
      .EnWideMgrPort  (1'b0)
  ) peripherals_ni_0_0 (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .sram_cfg_i          ('0),
      .axi_narrow_in_req_i (peripherals_narrow_req_i[0]),
      .axi_narrow_in_rsp_o (peripherals_narrow_rsp_o[0]),
      .axi_narrow_out_req_o(peripherals_narrow_req_o[0]),
      .axi_narrow_out_rsp_i(peripherals_narrow_rsp_i[0]),
      .axi_wide_in_req_i   ('0),
      .axi_wide_in_rsp_o   (),
      .axi_wide_out_req_o  (),
      .axi_wide_out_rsp_i  ('0),
      .id_i                ('{x: 3, y: 1}),
      .floo_req_o          (peripherals_ni_0_0_to_router_1_0_req),
      .floo_rsp_i          (router_1_0_to_peripherals_ni_0_0_rsp),
      .floo_wide_o         (peripherals_ni_0_0_to_router_1_0_wide),
      .floo_req_i          (router_1_0_to_peripherals_ni_0_0_req),
      .floo_rsp_o          (peripherals_ni_0_0_to_router_1_0_rsp),
      .floo_wide_i         (router_1_0_to_peripherals_ni_0_0_wide)
  );

  floo_narrow_wide_chimney #(
      .EnNarrowSbrPort(1'b1),
      .EnNarrowMgrPort(1'b1),
      .EnWideSbrPort  (1'b0),
      .EnWideMgrPort  (1'b0)
  ) peripherals_ni_0_1 (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .sram_cfg_i          ('0),
      .axi_narrow_in_req_i (peripherals_narrow_req_i[1]),
      .axi_narrow_in_rsp_o (peripherals_narrow_rsp_o[1]),
      .axi_narrow_out_req_o(peripherals_narrow_req_o[1]),
      .axi_narrow_out_rsp_i(peripherals_narrow_rsp_i[1]),
      .axi_wide_in_req_i   ('0),
      .axi_wide_in_rsp_o   (),
      .axi_wide_out_req_o  (),
      .axi_wide_out_rsp_i  ('0),
      .id_i                ('{x: 3, y: 2}),
      .floo_req_o          (peripherals_ni_0_1_to_router_1_1_req),
      .floo_rsp_i          (router_1_1_to_peripherals_ni_0_1_rsp),
      .floo_wide_o         (peripherals_ni_0_1_to_router_1_1_wide),
      .floo_req_i          (router_1_1_to_peripherals_ni_0_1_req),
      .floo_rsp_o          (peripherals_ni_0_1_to_router_1_1_rsp),
      .floo_wide_i         (router_1_1_to_peripherals_ni_0_1_wide)
  );


  floo_req_t  [NumDirections-1:0] router_0_0_req_in;
  floo_rsp_t  [NumDirections-1:0] router_0_0_rsp_out;
  floo_req_t  [NumDirections-1:0] router_0_0_req_out;
  floo_rsp_t  [NumDirections-1:0] router_0_0_rsp_in;
  floo_wide_t [NumDirections-1:0] router_0_0_wide_in;
  floo_wide_t [NumDirections-1:0] router_0_0_wide_out;

  assign router_0_0_req_in[Eject] = cluster_ni_0_0_to_router_0_0_req;
  assign router_0_0_req_in[East] = router_1_0_to_router_0_0_req;
  assign router_0_0_req_in[North] = router_0_1_to_router_0_0_req;
  assign router_0_0_req_in[South] = hbm_south_ni_0_0_to_router_0_0_req;
  assign router_0_0_req_in[West] = cva6_ni_to_router_0_0_req;

  assign router_0_0_to_cluster_ni_0_0_rsp = router_0_0_rsp_out[Eject];
  assign router_0_0_to_router_1_0_rsp = router_0_0_rsp_out[East];
  assign router_0_0_to_router_0_1_rsp = router_0_0_rsp_out[North];
  assign router_0_0_to_hbm_south_ni_0_0_rsp = router_0_0_rsp_out[South];
  assign router_0_0_to_cva6_ni_rsp = router_0_0_rsp_out[West];

  assign router_0_0_to_cluster_ni_0_0_req = router_0_0_req_out[Eject];
  assign router_0_0_to_router_1_0_req = router_0_0_req_out[East];
  assign router_0_0_to_router_0_1_req = router_0_0_req_out[North];
  assign router_0_0_to_hbm_south_ni_0_0_req = router_0_0_req_out[South];
  assign router_0_0_to_cva6_ni_req = router_0_0_req_out[West];

  assign router_0_0_rsp_in[Eject] = cluster_ni_0_0_to_router_0_0_rsp;
  assign router_0_0_rsp_in[East] = router_1_0_to_router_0_0_rsp;
  assign router_0_0_rsp_in[North] = router_0_1_to_router_0_0_rsp;
  assign router_0_0_rsp_in[South] = hbm_south_ni_0_0_to_router_0_0_rsp;
  assign router_0_0_rsp_in[West] = cva6_ni_to_router_0_0_rsp;

  assign router_0_0_wide_in[Eject] = cluster_ni_0_0_to_router_0_0_wide;
  assign router_0_0_wide_in[East] = router_1_0_to_router_0_0_wide;
  assign router_0_0_wide_in[North] = router_0_1_to_router_0_0_wide;
  assign router_0_0_wide_in[South] = hbm_south_ni_0_0_to_router_0_0_wide;
  assign router_0_0_wide_in[West] = cva6_ni_to_router_0_0_wide;

  assign router_0_0_to_cluster_ni_0_0_wide = router_0_0_wide_out[Eject];
  assign router_0_0_to_router_1_0_wide = router_0_0_wide_out[East];
  assign router_0_0_to_router_0_1_wide = router_0_0_wide_out[North];
  assign router_0_0_to_hbm_south_ni_0_0_wide = router_0_0_wide_out[South];
  assign router_0_0_to_cva6_ni_wide = router_0_0_wide_out[West];

  floo_narrow_wide_router #(
      .NumRoutes(NumDirections),
      .ChannelFifoDepth(2),
      .OutputFifoDepth(2),
      .RouteAlgo(XYRouting),
      .id_t(id_t)
  ) router_0_0 (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .id_i('{x: 1, y: 1}),
      .id_route_map_i('0),
      .floo_req_i(router_0_0_req_in),
      .floo_rsp_o(router_0_0_rsp_out),
      .floo_req_o(router_0_0_req_out),
      .floo_rsp_i(router_0_0_rsp_in),
      .floo_wide_i(router_0_0_wide_in),
      .floo_wide_o(router_0_0_wide_out)
  );


  floo_req_t  [NumDirections-1:0] router_0_1_req_in;
  floo_rsp_t  [NumDirections-1:0] router_0_1_rsp_out;
  floo_req_t  [NumDirections-1:0] router_0_1_req_out;
  floo_rsp_t  [NumDirections-1:0] router_0_1_rsp_in;
  floo_wide_t [NumDirections-1:0] router_0_1_wide_in;
  floo_wide_t [NumDirections-1:0] router_0_1_wide_out;

  assign router_0_1_req_in[Eject] = cluster_ni_0_1_to_router_0_1_req;
  assign router_0_1_req_in[East] = router_1_1_to_router_0_1_req;
  assign router_0_1_req_in[North] = hbm_north_ni_0_0_to_router_0_1_req;
  assign router_0_1_req_in[South] = router_0_0_to_router_0_1_req;
  assign router_0_1_req_in[West] = pcie_ni_to_router_0_1_req;

  assign router_0_1_to_cluster_ni_0_1_rsp = router_0_1_rsp_out[Eject];
  assign router_0_1_to_router_1_1_rsp = router_0_1_rsp_out[East];
  assign router_0_1_to_hbm_north_ni_0_0_rsp = router_0_1_rsp_out[North];
  assign router_0_1_to_router_0_0_rsp = router_0_1_rsp_out[South];
  assign router_0_1_to_pcie_ni_rsp = router_0_1_rsp_out[West];

  assign router_0_1_to_cluster_ni_0_1_req = router_0_1_req_out[Eject];
  assign router_0_1_to_router_1_1_req = router_0_1_req_out[East];
  assign router_0_1_to_hbm_north_ni_0_0_req = router_0_1_req_out[North];
  assign router_0_1_to_router_0_0_req = router_0_1_req_out[South];
  assign router_0_1_to_pcie_ni_req = router_0_1_req_out[West];

  assign router_0_1_rsp_in[Eject] = cluster_ni_0_1_to_router_0_1_rsp;
  assign router_0_1_rsp_in[East] = router_1_1_to_router_0_1_rsp;
  assign router_0_1_rsp_in[North] = hbm_north_ni_0_0_to_router_0_1_rsp;
  assign router_0_1_rsp_in[South] = router_0_0_to_router_0_1_rsp;
  assign router_0_1_rsp_in[West] = pcie_ni_to_router_0_1_rsp;

  assign router_0_1_wide_in[Eject] = cluster_ni_0_1_to_router_0_1_wide;
  assign router_0_1_wide_in[East] = router_1_1_to_router_0_1_wide;
  assign router_0_1_wide_in[North] = hbm_north_ni_0_0_to_router_0_1_wide;
  assign router_0_1_wide_in[South] = router_0_0_to_router_0_1_wide;
  assign router_0_1_wide_in[West] = pcie_ni_to_router_0_1_wide;

  assign router_0_1_to_cluster_ni_0_1_wide = router_0_1_wide_out[Eject];
  assign router_0_1_to_router_1_1_wide = router_0_1_wide_out[East];
  assign router_0_1_to_hbm_north_ni_0_0_wide = router_0_1_wide_out[North];
  assign router_0_1_to_router_0_0_wide = router_0_1_wide_out[South];
  assign router_0_1_to_pcie_ni_wide = router_0_1_wide_out[West];

  floo_narrow_wide_router #(
      .NumRoutes(NumDirections),
      .ChannelFifoDepth(2),
      .OutputFifoDepth(2),
      .RouteAlgo(XYRouting),
      .id_t(id_t)
  ) router_0_1 (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .id_i('{x: 1, y: 2}),
      .id_route_map_i('0),
      .floo_req_i(router_0_1_req_in),
      .floo_rsp_o(router_0_1_rsp_out),
      .floo_req_o(router_0_1_req_out),
      .floo_rsp_i(router_0_1_rsp_in),
      .floo_wide_i(router_0_1_wide_in),
      .floo_wide_o(router_0_1_wide_out)
  );


  floo_req_t  [NumDirections-1:0] router_1_0_req_in;
  floo_rsp_t  [NumDirections-1:0] router_1_0_rsp_out;
  floo_req_t  [NumDirections-1:0] router_1_0_req_out;
  floo_rsp_t  [NumDirections-1:0] router_1_0_rsp_in;
  floo_wide_t [NumDirections-1:0] router_1_0_wide_in;
  floo_wide_t [NumDirections-1:0] router_1_0_wide_out;

  assign router_1_0_req_in[Eject] = cluster_ni_1_0_to_router_1_0_req;
  assign router_1_0_req_in[East] = peripherals_ni_0_0_to_router_1_0_req;
  assign router_1_0_req_in[North] = router_1_1_to_router_1_0_req;
  assign router_1_0_req_in[South] = hbm_south_ni_1_0_to_router_1_0_req;
  assign router_1_0_req_in[West] = router_0_0_to_router_1_0_req;

  assign router_1_0_to_cluster_ni_1_0_rsp = router_1_0_rsp_out[Eject];
  assign router_1_0_to_peripherals_ni_0_0_rsp = router_1_0_rsp_out[East];
  assign router_1_0_to_router_1_1_rsp = router_1_0_rsp_out[North];
  assign router_1_0_to_hbm_south_ni_1_0_rsp = router_1_0_rsp_out[South];
  assign router_1_0_to_router_0_0_rsp = router_1_0_rsp_out[West];

  assign router_1_0_to_cluster_ni_1_0_req = router_1_0_req_out[Eject];
  assign router_1_0_to_peripherals_ni_0_0_req = router_1_0_req_out[East];
  assign router_1_0_to_router_1_1_req = router_1_0_req_out[North];
  assign router_1_0_to_hbm_south_ni_1_0_req = router_1_0_req_out[South];
  assign router_1_0_to_router_0_0_req = router_1_0_req_out[West];

  assign router_1_0_rsp_in[Eject] = cluster_ni_1_0_to_router_1_0_rsp;
  assign router_1_0_rsp_in[East] = peripherals_ni_0_0_to_router_1_0_rsp;
  assign router_1_0_rsp_in[North] = router_1_1_to_router_1_0_rsp;
  assign router_1_0_rsp_in[South] = hbm_south_ni_1_0_to_router_1_0_rsp;
  assign router_1_0_rsp_in[West] = router_0_0_to_router_1_0_rsp;

  assign router_1_0_wide_in[Eject] = cluster_ni_1_0_to_router_1_0_wide;
  assign router_1_0_wide_in[East] = peripherals_ni_0_0_to_router_1_0_wide;
  assign router_1_0_wide_in[North] = router_1_1_to_router_1_0_wide;
  assign router_1_0_wide_in[South] = hbm_south_ni_1_0_to_router_1_0_wide;
  assign router_1_0_wide_in[West] = router_0_0_to_router_1_0_wide;

  assign router_1_0_to_cluster_ni_1_0_wide = router_1_0_wide_out[Eject];
  assign router_1_0_to_peripherals_ni_0_0_wide = router_1_0_wide_out[East];
  assign router_1_0_to_router_1_1_wide = router_1_0_wide_out[North];
  assign router_1_0_to_hbm_south_ni_1_0_wide = router_1_0_wide_out[South];
  assign router_1_0_to_router_0_0_wide = router_1_0_wide_out[West];

  floo_narrow_wide_router #(
      .NumRoutes(NumDirections),
      .ChannelFifoDepth(2),
      .OutputFifoDepth(2),
      .RouteAlgo(XYRouting),
      .id_t(id_t)
  ) router_1_0 (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .id_i('{x: 2, y: 1}),
      .id_route_map_i('0),
      .floo_req_i(router_1_0_req_in),
      .floo_rsp_o(router_1_0_rsp_out),
      .floo_req_o(router_1_0_req_out),
      .floo_rsp_i(router_1_0_rsp_in),
      .floo_wide_i(router_1_0_wide_in),
      .floo_wide_o(router_1_0_wide_out)
  );


  floo_req_t  [NumDirections-1:0] router_1_1_req_in;
  floo_rsp_t  [NumDirections-1:0] router_1_1_rsp_out;
  floo_req_t  [NumDirections-1:0] router_1_1_req_out;
  floo_rsp_t  [NumDirections-1:0] router_1_1_rsp_in;
  floo_wide_t [NumDirections-1:0] router_1_1_wide_in;
  floo_wide_t [NumDirections-1:0] router_1_1_wide_out;

  assign router_1_1_req_in[Eject] = cluster_ni_1_1_to_router_1_1_req;
  assign router_1_1_req_in[East] = peripherals_ni_0_1_to_router_1_1_req;
  assign router_1_1_req_in[North] = hbm_north_ni_1_0_to_router_1_1_req;
  assign router_1_1_req_in[South] = router_1_0_to_router_1_1_req;
  assign router_1_1_req_in[West] = router_0_1_to_router_1_1_req;

  assign router_1_1_to_cluster_ni_1_1_rsp = router_1_1_rsp_out[Eject];
  assign router_1_1_to_peripherals_ni_0_1_rsp = router_1_1_rsp_out[East];
  assign router_1_1_to_hbm_north_ni_1_0_rsp = router_1_1_rsp_out[North];
  assign router_1_1_to_router_1_0_rsp = router_1_1_rsp_out[South];
  assign router_1_1_to_router_0_1_rsp = router_1_1_rsp_out[West];

  assign router_1_1_to_cluster_ni_1_1_req = router_1_1_req_out[Eject];
  assign router_1_1_to_peripherals_ni_0_1_req = router_1_1_req_out[East];
  assign router_1_1_to_hbm_north_ni_1_0_req = router_1_1_req_out[North];
  assign router_1_1_to_router_1_0_req = router_1_1_req_out[South];
  assign router_1_1_to_router_0_1_req = router_1_1_req_out[West];

  assign router_1_1_rsp_in[Eject] = cluster_ni_1_1_to_router_1_1_rsp;
  assign router_1_1_rsp_in[East] = peripherals_ni_0_1_to_router_1_1_rsp;
  assign router_1_1_rsp_in[North] = hbm_north_ni_1_0_to_router_1_1_rsp;
  assign router_1_1_rsp_in[South] = router_1_0_to_router_1_1_rsp;
  assign router_1_1_rsp_in[West] = router_0_1_to_router_1_1_rsp;

  assign router_1_1_wide_in[Eject] = cluster_ni_1_1_to_router_1_1_wide;
  assign router_1_1_wide_in[East] = peripherals_ni_0_1_to_router_1_1_wide;
  assign router_1_1_wide_in[North] = hbm_north_ni_1_0_to_router_1_1_wide;
  assign router_1_1_wide_in[South] = router_1_0_to_router_1_1_wide;
  assign router_1_1_wide_in[West] = router_0_1_to_router_1_1_wide;

  assign router_1_1_to_cluster_ni_1_1_wide = router_1_1_wide_out[Eject];
  assign router_1_1_to_peripherals_ni_0_1_wide = router_1_1_wide_out[East];
  assign router_1_1_to_hbm_north_ni_1_0_wide = router_1_1_wide_out[North];
  assign router_1_1_to_router_1_0_wide = router_1_1_wide_out[South];
  assign router_1_1_to_router_0_1_wide = router_1_1_wide_out[West];

  floo_narrow_wide_router #(
      .NumRoutes(NumDirections),
      .ChannelFifoDepth(2),
      .OutputFifoDepth(2),
      .RouteAlgo(XYRouting),
      .id_t(id_t)
  ) router_1_1 (
      .clk_i,
      .rst_ni,
      .test_enable_i,
      .id_i('{x: 2, y: 2}),
      .id_route_map_i('0),
      .floo_req_i(router_1_1_req_in),
      .floo_rsp_o(router_1_1_rsp_out),
      .floo_req_o(router_1_1_req_out),
      .floo_rsp_i(router_1_1_rsp_in),
      .floo_wide_i(router_1_1_wide_in),
      .floo_wide_o(router_1_1_wide_out)
  );



endmodule
