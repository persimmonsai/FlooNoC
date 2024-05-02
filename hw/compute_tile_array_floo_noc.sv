// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

// AUTOMATICALLY GENERATED! DO NOT EDIT!

module compute_tile_array_floo_noc
  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;
(
  input logic clk_i,
  input logic rst_ni,
  input logic test_enable_i,

  input logic [180:1] mtip_i, 
  input logic [180:1] msip_i, 
`ifndef TARGET_DMA_TEST
  input  occamy_pkg::sram_cfgs_t  sram_cfgs_i,
`endif
  output axi_narrow_out_req_t             [4:0] hbm_north_narrow_req_o,
  input axi_narrow_out_rsp_t             [4:0] hbm_north_narrow_rsp_i,
  output axi_wide_out_req_t             [4:0] hbm_north_wide_req_o,
  input axi_wide_out_rsp_t             [4:0] hbm_north_wide_rsp_i,
  output axi_narrow_out_req_t             [4:0] hbm_south_narrow_req_o,
  input axi_narrow_out_rsp_t             [4:0] hbm_south_narrow_rsp_i,
  output axi_wide_out_req_t             [4:0] hbm_south_wide_req_o,
  input axi_wide_out_rsp_t             [4:0] hbm_south_wide_rsp_i,
  output axi_narrow_out_req_t             [3:0] hbm_east_narrow_req_o,
  input axi_narrow_out_rsp_t             [3:0] hbm_east_narrow_rsp_i,
  output axi_wide_out_req_t             [3:0] hbm_east_wide_req_o,
  input axi_wide_out_rsp_t             [3:0] hbm_east_wide_rsp_i,
  output axi_narrow_out_req_t             [3:0] hbm_west_narrow_req_o,
  input axi_narrow_out_rsp_t             [3:0] hbm_west_narrow_rsp_i,
  output axi_wide_out_req_t             [3:0] hbm_west_wide_req_o,
  input axi_wide_out_rsp_t             [3:0] hbm_west_wide_rsp_i

);

floo_req_t router_0_0_to_router_0_1_req;
floo_rsp_t router_0_1_to_router_0_0_rsp;
floo_wide_t router_0_0_to_router_0_1_wide;

floo_req_t router_0_0_to_router_1_0_req;
floo_rsp_t router_1_0_to_router_0_0_rsp;
floo_wide_t router_0_0_to_router_1_0_wide;

floo_req_t router_0_0_to_hbm_south_ni_0_0_req;
floo_rsp_t hbm_south_ni_0_0_to_router_0_0_rsp;
floo_wide_t router_0_0_to_hbm_south_ni_0_0_wide;

floo_req_t router_0_0_to_hbm_west_ni_0_0_req;
floo_rsp_t hbm_west_ni_0_0_to_router_0_0_rsp;
floo_wide_t router_0_0_to_hbm_west_ni_0_0_wide;

floo_req_t router_0_1_to_router_0_0_req;
floo_rsp_t router_0_0_to_router_0_1_rsp;
floo_wide_t router_0_1_to_router_0_0_wide;

floo_req_t router_0_1_to_router_0_2_req;
floo_rsp_t router_0_2_to_router_0_1_rsp;
floo_wide_t router_0_1_to_router_0_2_wide;

floo_req_t router_0_1_to_router_1_1_req;
floo_rsp_t router_1_1_to_router_0_1_rsp;
floo_wide_t router_0_1_to_router_1_1_wide;

floo_req_t router_0_1_to_hbm_west_ni_0_1_req;
floo_rsp_t hbm_west_ni_0_1_to_router_0_1_rsp;
floo_wide_t router_0_1_to_hbm_west_ni_0_1_wide;

floo_req_t router_0_2_to_router_0_1_req;
floo_rsp_t router_0_1_to_router_0_2_rsp;
floo_wide_t router_0_2_to_router_0_1_wide;

floo_req_t router_0_2_to_router_0_3_req;
floo_rsp_t router_0_3_to_router_0_2_rsp;
floo_wide_t router_0_2_to_router_0_3_wide;

floo_req_t router_0_2_to_router_1_2_req;
floo_rsp_t router_1_2_to_router_0_2_rsp;
floo_wide_t router_0_2_to_router_1_2_wide;

floo_req_t router_0_2_to_hbm_west_ni_0_2_req;
floo_rsp_t hbm_west_ni_0_2_to_router_0_2_rsp;
floo_wide_t router_0_2_to_hbm_west_ni_0_2_wide;

floo_req_t router_0_3_to_router_0_2_req;
floo_rsp_t router_0_2_to_router_0_3_rsp;
floo_wide_t router_0_3_to_router_0_2_wide;

floo_req_t router_0_3_to_router_1_3_req;
floo_rsp_t router_1_3_to_router_0_3_rsp;
floo_wide_t router_0_3_to_router_1_3_wide;

floo_req_t router_0_3_to_hbm_north_ni_0_0_req;
floo_rsp_t hbm_north_ni_0_0_to_router_0_3_rsp;
floo_wide_t router_0_3_to_hbm_north_ni_0_0_wide;

floo_req_t router_0_3_to_hbm_west_ni_0_3_req;
floo_rsp_t hbm_west_ni_0_3_to_router_0_3_rsp;
floo_wide_t router_0_3_to_hbm_west_ni_0_3_wide;

floo_req_t router_1_0_to_router_0_0_req;
floo_rsp_t router_0_0_to_router_1_0_rsp;
floo_wide_t router_1_0_to_router_0_0_wide;

floo_req_t router_1_0_to_router_1_1_req;
floo_rsp_t router_1_1_to_router_1_0_rsp;
floo_wide_t router_1_0_to_router_1_1_wide;

floo_req_t router_1_0_to_router_2_0_req;
floo_rsp_t router_2_0_to_router_1_0_rsp;
floo_wide_t router_1_0_to_router_2_0_wide;

floo_req_t router_1_0_to_hbm_south_ni_1_0_req;
floo_rsp_t hbm_south_ni_1_0_to_router_1_0_rsp;
floo_wide_t router_1_0_to_hbm_south_ni_1_0_wide;

floo_req_t router_1_1_to_router_0_1_req;
floo_rsp_t router_0_1_to_router_1_1_rsp;
floo_wide_t router_1_1_to_router_0_1_wide;

floo_req_t router_1_1_to_router_1_0_req;
floo_rsp_t router_1_0_to_router_1_1_rsp;
floo_wide_t router_1_1_to_router_1_0_wide;

floo_req_t router_1_1_to_router_1_2_req;
floo_rsp_t router_1_2_to_router_1_1_rsp;
floo_wide_t router_1_1_to_router_1_2_wide;

floo_req_t router_1_1_to_router_2_1_req;
floo_rsp_t router_2_1_to_router_1_1_rsp;
floo_wide_t router_1_1_to_router_2_1_wide;

floo_req_t router_1_2_to_router_0_2_req;
floo_rsp_t router_0_2_to_router_1_2_rsp;
floo_wide_t router_1_2_to_router_0_2_wide;

floo_req_t router_1_2_to_router_1_1_req;
floo_rsp_t router_1_1_to_router_1_2_rsp;
floo_wide_t router_1_2_to_router_1_1_wide;

floo_req_t router_1_2_to_router_1_3_req;
floo_rsp_t router_1_3_to_router_1_2_rsp;
floo_wide_t router_1_2_to_router_1_3_wide;

floo_req_t router_1_2_to_router_2_2_req;
floo_rsp_t router_2_2_to_router_1_2_rsp;
floo_wide_t router_1_2_to_router_2_2_wide;

floo_req_t router_1_3_to_router_0_3_req;
floo_rsp_t router_0_3_to_router_1_3_rsp;
floo_wide_t router_1_3_to_router_0_3_wide;

floo_req_t router_1_3_to_router_1_2_req;
floo_rsp_t router_1_2_to_router_1_3_rsp;
floo_wide_t router_1_3_to_router_1_2_wide;

floo_req_t router_1_3_to_router_2_3_req;
floo_rsp_t router_2_3_to_router_1_3_rsp;
floo_wide_t router_1_3_to_router_2_3_wide;

floo_req_t router_1_3_to_hbm_north_ni_1_0_req;
floo_rsp_t hbm_north_ni_1_0_to_router_1_3_rsp;
floo_wide_t router_1_3_to_hbm_north_ni_1_0_wide;

floo_req_t router_2_0_to_router_1_0_req;
floo_rsp_t router_1_0_to_router_2_0_rsp;
floo_wide_t router_2_0_to_router_1_0_wide;

floo_req_t router_2_0_to_router_2_1_req;
floo_rsp_t router_2_1_to_router_2_0_rsp;
floo_wide_t router_2_0_to_router_2_1_wide;

floo_req_t router_2_0_to_router_3_0_req;
floo_rsp_t router_3_0_to_router_2_0_rsp;
floo_wide_t router_2_0_to_router_3_0_wide;

floo_req_t router_2_0_to_hbm_south_ni_2_0_req;
floo_rsp_t hbm_south_ni_2_0_to_router_2_0_rsp;
floo_wide_t router_2_0_to_hbm_south_ni_2_0_wide;

floo_req_t router_2_1_to_router_1_1_req;
floo_rsp_t router_1_1_to_router_2_1_rsp;
floo_wide_t router_2_1_to_router_1_1_wide;

floo_req_t router_2_1_to_router_2_0_req;
floo_rsp_t router_2_0_to_router_2_1_rsp;
floo_wide_t router_2_1_to_router_2_0_wide;

floo_req_t router_2_1_to_router_2_2_req;
floo_rsp_t router_2_2_to_router_2_1_rsp;
floo_wide_t router_2_1_to_router_2_2_wide;

floo_req_t router_2_1_to_router_3_1_req;
floo_rsp_t router_3_1_to_router_2_1_rsp;
floo_wide_t router_2_1_to_router_3_1_wide;

floo_req_t router_2_2_to_router_1_2_req;
floo_rsp_t router_1_2_to_router_2_2_rsp;
floo_wide_t router_2_2_to_router_1_2_wide;

floo_req_t router_2_2_to_router_2_1_req;
floo_rsp_t router_2_1_to_router_2_2_rsp;
floo_wide_t router_2_2_to_router_2_1_wide;

floo_req_t router_2_2_to_router_2_3_req;
floo_rsp_t router_2_3_to_router_2_2_rsp;
floo_wide_t router_2_2_to_router_2_3_wide;

floo_req_t router_2_2_to_router_3_2_req;
floo_rsp_t router_3_2_to_router_2_2_rsp;
floo_wide_t router_2_2_to_router_3_2_wide;

floo_req_t router_2_3_to_router_1_3_req;
floo_rsp_t router_1_3_to_router_2_3_rsp;
floo_wide_t router_2_3_to_router_1_3_wide;

floo_req_t router_2_3_to_router_2_2_req;
floo_rsp_t router_2_2_to_router_2_3_rsp;
floo_wide_t router_2_3_to_router_2_2_wide;

floo_req_t router_2_3_to_router_3_3_req;
floo_rsp_t router_3_3_to_router_2_3_rsp;
floo_wide_t router_2_3_to_router_3_3_wide;

floo_req_t router_2_3_to_hbm_north_ni_2_0_req;
floo_rsp_t hbm_north_ni_2_0_to_router_2_3_rsp;
floo_wide_t router_2_3_to_hbm_north_ni_2_0_wide;

floo_req_t router_3_0_to_router_2_0_req;
floo_rsp_t router_2_0_to_router_3_0_rsp;
floo_wide_t router_3_0_to_router_2_0_wide;

floo_req_t router_3_0_to_router_3_1_req;
floo_rsp_t router_3_1_to_router_3_0_rsp;
floo_wide_t router_3_0_to_router_3_1_wide;

floo_req_t router_3_0_to_router_4_0_req;
floo_rsp_t router_4_0_to_router_3_0_rsp;
floo_wide_t router_3_0_to_router_4_0_wide;

floo_req_t router_3_0_to_hbm_south_ni_3_0_req;
floo_rsp_t hbm_south_ni_3_0_to_router_3_0_rsp;
floo_wide_t router_3_0_to_hbm_south_ni_3_0_wide;

floo_req_t router_3_1_to_router_2_1_req;
floo_rsp_t router_2_1_to_router_3_1_rsp;
floo_wide_t router_3_1_to_router_2_1_wide;

floo_req_t router_3_1_to_router_3_0_req;
floo_rsp_t router_3_0_to_router_3_1_rsp;
floo_wide_t router_3_1_to_router_3_0_wide;

floo_req_t router_3_1_to_router_3_2_req;
floo_rsp_t router_3_2_to_router_3_1_rsp;
floo_wide_t router_3_1_to_router_3_2_wide;

floo_req_t router_3_1_to_router_4_1_req;
floo_rsp_t router_4_1_to_router_3_1_rsp;
floo_wide_t router_3_1_to_router_4_1_wide;

floo_req_t router_3_2_to_router_2_2_req;
floo_rsp_t router_2_2_to_router_3_2_rsp;
floo_wide_t router_3_2_to_router_2_2_wide;

floo_req_t router_3_2_to_router_3_1_req;
floo_rsp_t router_3_1_to_router_3_2_rsp;
floo_wide_t router_3_2_to_router_3_1_wide;

floo_req_t router_3_2_to_router_3_3_req;
floo_rsp_t router_3_3_to_router_3_2_rsp;
floo_wide_t router_3_2_to_router_3_3_wide;

floo_req_t router_3_2_to_router_4_2_req;
floo_rsp_t router_4_2_to_router_3_2_rsp;
floo_wide_t router_3_2_to_router_4_2_wide;

floo_req_t router_3_3_to_router_2_3_req;
floo_rsp_t router_2_3_to_router_3_3_rsp;
floo_wide_t router_3_3_to_router_2_3_wide;

floo_req_t router_3_3_to_router_3_2_req;
floo_rsp_t router_3_2_to_router_3_3_rsp;
floo_wide_t router_3_3_to_router_3_2_wide;

floo_req_t router_3_3_to_router_4_3_req;
floo_rsp_t router_4_3_to_router_3_3_rsp;
floo_wide_t router_3_3_to_router_4_3_wide;

floo_req_t router_3_3_to_hbm_north_ni_3_0_req;
floo_rsp_t hbm_north_ni_3_0_to_router_3_3_rsp;
floo_wide_t router_3_3_to_hbm_north_ni_3_0_wide;

floo_req_t router_4_0_to_router_3_0_req;
floo_rsp_t router_3_0_to_router_4_0_rsp;
floo_wide_t router_4_0_to_router_3_0_wide;

floo_req_t router_4_0_to_router_4_1_req;
floo_rsp_t router_4_1_to_router_4_0_rsp;
floo_wide_t router_4_0_to_router_4_1_wide;

floo_req_t router_4_0_to_hbm_south_ni_4_0_req;
floo_rsp_t hbm_south_ni_4_0_to_router_4_0_rsp;
floo_wide_t router_4_0_to_hbm_south_ni_4_0_wide;

floo_req_t router_4_0_to_hbm_east_ni_0_0_req;
floo_rsp_t hbm_east_ni_0_0_to_router_4_0_rsp;
floo_wide_t router_4_0_to_hbm_east_ni_0_0_wide;

floo_req_t router_4_1_to_router_3_1_req;
floo_rsp_t router_3_1_to_router_4_1_rsp;
floo_wide_t router_4_1_to_router_3_1_wide;

floo_req_t router_4_1_to_router_4_0_req;
floo_rsp_t router_4_0_to_router_4_1_rsp;
floo_wide_t router_4_1_to_router_4_0_wide;

floo_req_t router_4_1_to_router_4_2_req;
floo_rsp_t router_4_2_to_router_4_1_rsp;
floo_wide_t router_4_1_to_router_4_2_wide;

floo_req_t router_4_1_to_hbm_east_ni_0_1_req;
floo_rsp_t hbm_east_ni_0_1_to_router_4_1_rsp;
floo_wide_t router_4_1_to_hbm_east_ni_0_1_wide;

floo_req_t router_4_2_to_router_3_2_req;
floo_rsp_t router_3_2_to_router_4_2_rsp;
floo_wide_t router_4_2_to_router_3_2_wide;

floo_req_t router_4_2_to_router_4_1_req;
floo_rsp_t router_4_1_to_router_4_2_rsp;
floo_wide_t router_4_2_to_router_4_1_wide;

floo_req_t router_4_2_to_router_4_3_req;
floo_rsp_t router_4_3_to_router_4_2_rsp;
floo_wide_t router_4_2_to_router_4_3_wide;

floo_req_t router_4_2_to_hbm_east_ni_0_2_req;
floo_rsp_t hbm_east_ni_0_2_to_router_4_2_rsp;
floo_wide_t router_4_2_to_hbm_east_ni_0_2_wide;

floo_req_t router_4_3_to_router_3_3_req;
floo_rsp_t router_3_3_to_router_4_3_rsp;
floo_wide_t router_4_3_to_router_3_3_wide;

floo_req_t router_4_3_to_router_4_2_req;
floo_rsp_t router_4_2_to_router_4_3_rsp;
floo_wide_t router_4_3_to_router_4_2_wide;

floo_req_t router_4_3_to_hbm_north_ni_4_0_req;
floo_rsp_t hbm_north_ni_4_0_to_router_4_3_rsp;
floo_wide_t router_4_3_to_hbm_north_ni_4_0_wide;

floo_req_t router_4_3_to_hbm_east_ni_0_3_req;
floo_rsp_t hbm_east_ni_0_3_to_router_4_3_rsp;
floo_wide_t router_4_3_to_hbm_east_ni_0_3_wide;

floo_req_t hbm_north_ni_0_0_to_router_0_3_req;
floo_rsp_t router_0_3_to_hbm_north_ni_0_0_rsp;
floo_wide_t hbm_north_ni_0_0_to_router_0_3_wide;

floo_req_t hbm_north_ni_1_0_to_router_1_3_req;
floo_rsp_t router_1_3_to_hbm_north_ni_1_0_rsp;
floo_wide_t hbm_north_ni_1_0_to_router_1_3_wide;

floo_req_t hbm_north_ni_2_0_to_router_2_3_req;
floo_rsp_t router_2_3_to_hbm_north_ni_2_0_rsp;
floo_wide_t hbm_north_ni_2_0_to_router_2_3_wide;

floo_req_t hbm_north_ni_3_0_to_router_3_3_req;
floo_rsp_t router_3_3_to_hbm_north_ni_3_0_rsp;
floo_wide_t hbm_north_ni_3_0_to_router_3_3_wide;

floo_req_t hbm_north_ni_4_0_to_router_4_3_req;
floo_rsp_t router_4_3_to_hbm_north_ni_4_0_rsp;
floo_wide_t hbm_north_ni_4_0_to_router_4_3_wide;

floo_req_t hbm_south_ni_0_0_to_router_0_0_req;
floo_rsp_t router_0_0_to_hbm_south_ni_0_0_rsp;
floo_wide_t hbm_south_ni_0_0_to_router_0_0_wide;

floo_req_t hbm_south_ni_1_0_to_router_1_0_req;
floo_rsp_t router_1_0_to_hbm_south_ni_1_0_rsp;
floo_wide_t hbm_south_ni_1_0_to_router_1_0_wide;

floo_req_t hbm_south_ni_2_0_to_router_2_0_req;
floo_rsp_t router_2_0_to_hbm_south_ni_2_0_rsp;
floo_wide_t hbm_south_ni_2_0_to_router_2_0_wide;

floo_req_t hbm_south_ni_3_0_to_router_3_0_req;
floo_rsp_t router_3_0_to_hbm_south_ni_3_0_rsp;
floo_wide_t hbm_south_ni_3_0_to_router_3_0_wide;

floo_req_t hbm_south_ni_4_0_to_router_4_0_req;
floo_rsp_t router_4_0_to_hbm_south_ni_4_0_rsp;
floo_wide_t hbm_south_ni_4_0_to_router_4_0_wide;

floo_req_t hbm_east_ni_0_0_to_router_4_0_req;
floo_rsp_t router_4_0_to_hbm_east_ni_0_0_rsp;
floo_wide_t hbm_east_ni_0_0_to_router_4_0_wide;

floo_req_t hbm_east_ni_0_1_to_router_4_1_req;
floo_rsp_t router_4_1_to_hbm_east_ni_0_1_rsp;
floo_wide_t hbm_east_ni_0_1_to_router_4_1_wide;

floo_req_t hbm_east_ni_0_2_to_router_4_2_req;
floo_rsp_t router_4_2_to_hbm_east_ni_0_2_rsp;
floo_wide_t hbm_east_ni_0_2_to_router_4_2_wide;

floo_req_t hbm_east_ni_0_3_to_router_4_3_req;
floo_rsp_t router_4_3_to_hbm_east_ni_0_3_rsp;
floo_wide_t hbm_east_ni_0_3_to_router_4_3_wide;

floo_req_t hbm_west_ni_0_0_to_router_0_0_req;
floo_rsp_t router_0_0_to_hbm_west_ni_0_0_rsp;
floo_wide_t hbm_west_ni_0_0_to_router_0_0_wide;

floo_req_t hbm_west_ni_0_1_to_router_0_1_req;
floo_rsp_t router_0_1_to_hbm_west_ni_0_1_rsp;
floo_wide_t hbm_west_ni_0_1_to_router_0_1_wide;

floo_req_t hbm_west_ni_0_2_to_router_0_2_req;
floo_rsp_t router_0_2_to_hbm_west_ni_0_2_rsp;
floo_wide_t hbm_west_ni_0_2_to_router_0_2_wide;

floo_req_t hbm_west_ni_0_3_to_router_0_3_req;
floo_rsp_t router_0_3_to_hbm_west_ni_0_3_rsp;
floo_wide_t hbm_west_ni_0_3_to_router_0_3_wide;



localparam id_t hbm_north_ni_0_0_id = '{x: 1, y: 5};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_north_ni_0_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_north_narrow_req_o[0] ),
  .axi_narrow_out_rsp_i ( hbm_north_narrow_rsp_i[0] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_north_wide_req_o[0] ),
  .axi_wide_out_rsp_i ( hbm_north_wide_rsp_i[0] ),
  .id_i             ( hbm_north_ni_0_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_north_ni_0_0_to_router_0_3_req   ),
  .floo_rsp_i       ( router_0_3_to_hbm_north_ni_0_0_rsp   ),
  .floo_wide_o      ( hbm_north_ni_0_0_to_router_0_3_wide  ),
  .floo_req_i       ( router_0_3_to_hbm_north_ni_0_0_req   ),
  .floo_rsp_o       ( hbm_north_ni_0_0_to_router_0_3_rsp   ),
  .floo_wide_i      ( router_0_3_to_hbm_north_ni_0_0_wide  )
);

localparam id_t hbm_north_ni_1_0_id = '{x: 2, y: 5};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_north_ni_1_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_north_narrow_req_o[1] ),
  .axi_narrow_out_rsp_i ( hbm_north_narrow_rsp_i[1] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_north_wide_req_o[1] ),
  .axi_wide_out_rsp_i ( hbm_north_wide_rsp_i[1] ),
  .id_i             ( hbm_north_ni_1_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_north_ni_1_0_to_router_1_3_req   ),
  .floo_rsp_i       ( router_1_3_to_hbm_north_ni_1_0_rsp   ),
  .floo_wide_o      ( hbm_north_ni_1_0_to_router_1_3_wide  ),
  .floo_req_i       ( router_1_3_to_hbm_north_ni_1_0_req   ),
  .floo_rsp_o       ( hbm_north_ni_1_0_to_router_1_3_rsp   ),
  .floo_wide_i      ( router_1_3_to_hbm_north_ni_1_0_wide  )
);

localparam id_t hbm_north_ni_2_0_id = '{x: 3, y: 5};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_north_ni_2_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_north_narrow_req_o[2] ),
  .axi_narrow_out_rsp_i ( hbm_north_narrow_rsp_i[2] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_north_wide_req_o[2] ),
  .axi_wide_out_rsp_i ( hbm_north_wide_rsp_i[2] ),
  .id_i             ( hbm_north_ni_2_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_north_ni_2_0_to_router_2_3_req   ),
  .floo_rsp_i       ( router_2_3_to_hbm_north_ni_2_0_rsp   ),
  .floo_wide_o      ( hbm_north_ni_2_0_to_router_2_3_wide  ),
  .floo_req_i       ( router_2_3_to_hbm_north_ni_2_0_req   ),
  .floo_rsp_o       ( hbm_north_ni_2_0_to_router_2_3_rsp   ),
  .floo_wide_i      ( router_2_3_to_hbm_north_ni_2_0_wide  )
);

localparam id_t hbm_north_ni_3_0_id = '{x: 4, y: 5};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_north_ni_3_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_north_narrow_req_o[3] ),
  .axi_narrow_out_rsp_i ( hbm_north_narrow_rsp_i[3] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_north_wide_req_o[3] ),
  .axi_wide_out_rsp_i ( hbm_north_wide_rsp_i[3] ),
  .id_i             ( hbm_north_ni_3_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_north_ni_3_0_to_router_3_3_req   ),
  .floo_rsp_i       ( router_3_3_to_hbm_north_ni_3_0_rsp   ),
  .floo_wide_o      ( hbm_north_ni_3_0_to_router_3_3_wide  ),
  .floo_req_i       ( router_3_3_to_hbm_north_ni_3_0_req   ),
  .floo_rsp_o       ( hbm_north_ni_3_0_to_router_3_3_rsp   ),
  .floo_wide_i      ( router_3_3_to_hbm_north_ni_3_0_wide  )
);

localparam id_t hbm_north_ni_4_0_id = '{x: 5, y: 5};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_north_ni_4_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_north_narrow_req_o[4] ),
  .axi_narrow_out_rsp_i ( hbm_north_narrow_rsp_i[4] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_north_wide_req_o[4] ),
  .axi_wide_out_rsp_i ( hbm_north_wide_rsp_i[4] ),
  .id_i             ( hbm_north_ni_4_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_north_ni_4_0_to_router_4_3_req   ),
  .floo_rsp_i       ( router_4_3_to_hbm_north_ni_4_0_rsp   ),
  .floo_wide_o      ( hbm_north_ni_4_0_to_router_4_3_wide  ),
  .floo_req_i       ( router_4_3_to_hbm_north_ni_4_0_req   ),
  .floo_rsp_o       ( hbm_north_ni_4_0_to_router_4_3_rsp   ),
  .floo_wide_i      ( router_4_3_to_hbm_north_ni_4_0_wide  )
);

localparam id_t hbm_south_ni_0_0_id = '{x: 1, y: 0};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_south_ni_0_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_south_narrow_req_o[0] ),
  .axi_narrow_out_rsp_i ( hbm_south_narrow_rsp_i[0] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_south_wide_req_o[0] ),
  .axi_wide_out_rsp_i ( hbm_south_wide_rsp_i[0] ),
  .id_i             ( hbm_south_ni_0_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_south_ni_0_0_to_router_0_0_req   ),
  .floo_rsp_i       ( router_0_0_to_hbm_south_ni_0_0_rsp   ),
  .floo_wide_o      ( hbm_south_ni_0_0_to_router_0_0_wide  ),
  .floo_req_i       ( router_0_0_to_hbm_south_ni_0_0_req   ),
  .floo_rsp_o       ( hbm_south_ni_0_0_to_router_0_0_rsp   ),
  .floo_wide_i      ( router_0_0_to_hbm_south_ni_0_0_wide  )
);

localparam id_t hbm_south_ni_1_0_id = '{x: 2, y: 0};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_south_ni_1_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_south_narrow_req_o[1] ),
  .axi_narrow_out_rsp_i ( hbm_south_narrow_rsp_i[1] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_south_wide_req_o[1] ),
  .axi_wide_out_rsp_i ( hbm_south_wide_rsp_i[1] ),
  .id_i             ( hbm_south_ni_1_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_south_ni_1_0_to_router_1_0_req   ),
  .floo_rsp_i       ( router_1_0_to_hbm_south_ni_1_0_rsp   ),
  .floo_wide_o      ( hbm_south_ni_1_0_to_router_1_0_wide  ),
  .floo_req_i       ( router_1_0_to_hbm_south_ni_1_0_req   ),
  .floo_rsp_o       ( hbm_south_ni_1_0_to_router_1_0_rsp   ),
  .floo_wide_i      ( router_1_0_to_hbm_south_ni_1_0_wide  )
);

localparam id_t hbm_south_ni_2_0_id = '{x: 3, y: 0};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_south_ni_2_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_south_narrow_req_o[2] ),
  .axi_narrow_out_rsp_i ( hbm_south_narrow_rsp_i[2] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_south_wide_req_o[2] ),
  .axi_wide_out_rsp_i ( hbm_south_wide_rsp_i[2] ),
  .id_i             ( hbm_south_ni_2_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_south_ni_2_0_to_router_2_0_req   ),
  .floo_rsp_i       ( router_2_0_to_hbm_south_ni_2_0_rsp   ),
  .floo_wide_o      ( hbm_south_ni_2_0_to_router_2_0_wide  ),
  .floo_req_i       ( router_2_0_to_hbm_south_ni_2_0_req   ),
  .floo_rsp_o       ( hbm_south_ni_2_0_to_router_2_0_rsp   ),
  .floo_wide_i      ( router_2_0_to_hbm_south_ni_2_0_wide  )
);

localparam id_t hbm_south_ni_3_0_id = '{x: 4, y: 0};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_south_ni_3_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_south_narrow_req_o[3] ),
  .axi_narrow_out_rsp_i ( hbm_south_narrow_rsp_i[3] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_south_wide_req_o[3] ),
  .axi_wide_out_rsp_i ( hbm_south_wide_rsp_i[3] ),
  .id_i             ( hbm_south_ni_3_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_south_ni_3_0_to_router_3_0_req   ),
  .floo_rsp_i       ( router_3_0_to_hbm_south_ni_3_0_rsp   ),
  .floo_wide_o      ( hbm_south_ni_3_0_to_router_3_0_wide  ),
  .floo_req_i       ( router_3_0_to_hbm_south_ni_3_0_req   ),
  .floo_rsp_o       ( hbm_south_ni_3_0_to_router_3_0_rsp   ),
  .floo_wide_i      ( router_3_0_to_hbm_south_ni_3_0_wide  )
);

localparam id_t hbm_south_ni_4_0_id = '{x: 5, y: 0};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_south_ni_4_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_south_narrow_req_o[4] ),
  .axi_narrow_out_rsp_i ( hbm_south_narrow_rsp_i[4] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_south_wide_req_o[4] ),
  .axi_wide_out_rsp_i ( hbm_south_wide_rsp_i[4] ),
  .id_i             ( hbm_south_ni_4_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_south_ni_4_0_to_router_4_0_req   ),
  .floo_rsp_i       ( router_4_0_to_hbm_south_ni_4_0_rsp   ),
  .floo_wide_o      ( hbm_south_ni_4_0_to_router_4_0_wide  ),
  .floo_req_i       ( router_4_0_to_hbm_south_ni_4_0_req   ),
  .floo_rsp_o       ( hbm_south_ni_4_0_to_router_4_0_rsp   ),
  .floo_wide_i      ( router_4_0_to_hbm_south_ni_4_0_wide  )
);

localparam id_t hbm_east_ni_0_0_id = '{x: 6, y: 1};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_east_ni_0_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_east_narrow_req_o[0] ),
  .axi_narrow_out_rsp_i ( hbm_east_narrow_rsp_i[0] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_east_wide_req_o[0] ),
  .axi_wide_out_rsp_i ( hbm_east_wide_rsp_i[0] ),
  .id_i             ( hbm_east_ni_0_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_east_ni_0_0_to_router_4_0_req   ),
  .floo_rsp_i       ( router_4_0_to_hbm_east_ni_0_0_rsp   ),
  .floo_wide_o      ( hbm_east_ni_0_0_to_router_4_0_wide  ),
  .floo_req_i       ( router_4_0_to_hbm_east_ni_0_0_req   ),
  .floo_rsp_o       ( hbm_east_ni_0_0_to_router_4_0_rsp   ),
  .floo_wide_i      ( router_4_0_to_hbm_east_ni_0_0_wide  )
);

localparam id_t hbm_east_ni_0_1_id = '{x: 6, y: 2};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_east_ni_0_1 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_east_narrow_req_o[1] ),
  .axi_narrow_out_rsp_i ( hbm_east_narrow_rsp_i[1] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_east_wide_req_o[1] ),
  .axi_wide_out_rsp_i ( hbm_east_wide_rsp_i[1] ),
  .id_i             ( hbm_east_ni_0_1_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_east_ni_0_1_to_router_4_1_req   ),
  .floo_rsp_i       ( router_4_1_to_hbm_east_ni_0_1_rsp   ),
  .floo_wide_o      ( hbm_east_ni_0_1_to_router_4_1_wide  ),
  .floo_req_i       ( router_4_1_to_hbm_east_ni_0_1_req   ),
  .floo_rsp_o       ( hbm_east_ni_0_1_to_router_4_1_rsp   ),
  .floo_wide_i      ( router_4_1_to_hbm_east_ni_0_1_wide  )
);

localparam id_t hbm_east_ni_0_2_id = '{x: 6, y: 3};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_east_ni_0_2 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_east_narrow_req_o[2] ),
  .axi_narrow_out_rsp_i ( hbm_east_narrow_rsp_i[2] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_east_wide_req_o[2] ),
  .axi_wide_out_rsp_i ( hbm_east_wide_rsp_i[2] ),
  .id_i             ( hbm_east_ni_0_2_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_east_ni_0_2_to_router_4_2_req   ),
  .floo_rsp_i       ( router_4_2_to_hbm_east_ni_0_2_rsp   ),
  .floo_wide_o      ( hbm_east_ni_0_2_to_router_4_2_wide  ),
  .floo_req_i       ( router_4_2_to_hbm_east_ni_0_2_req   ),
  .floo_rsp_o       ( hbm_east_ni_0_2_to_router_4_2_rsp   ),
  .floo_wide_i      ( router_4_2_to_hbm_east_ni_0_2_wide  )
);

localparam id_t hbm_east_ni_0_3_id = '{x: 6, y: 4};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_east_ni_0_3 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_east_narrow_req_o[3] ),
  .axi_narrow_out_rsp_i ( hbm_east_narrow_rsp_i[3] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_east_wide_req_o[3] ),
  .axi_wide_out_rsp_i ( hbm_east_wide_rsp_i[3] ),
  .id_i             ( hbm_east_ni_0_3_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_east_ni_0_3_to_router_4_3_req   ),
  .floo_rsp_i       ( router_4_3_to_hbm_east_ni_0_3_rsp   ),
  .floo_wide_o      ( hbm_east_ni_0_3_to_router_4_3_wide  ),
  .floo_req_i       ( router_4_3_to_hbm_east_ni_0_3_req   ),
  .floo_rsp_o       ( hbm_east_ni_0_3_to_router_4_3_rsp   ),
  .floo_wide_i      ( router_4_3_to_hbm_east_ni_0_3_wide  )
);

localparam id_t hbm_west_ni_0_0_id = '{x: 0, y: 1};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_west_ni_0_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_west_narrow_req_o[0] ),
  .axi_narrow_out_rsp_i ( hbm_west_narrow_rsp_i[0] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_west_wide_req_o[0] ),
  .axi_wide_out_rsp_i ( hbm_west_wide_rsp_i[0] ),
  .id_i             ( hbm_west_ni_0_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_west_ni_0_0_to_router_0_0_req   ),
  .floo_rsp_i       ( router_0_0_to_hbm_west_ni_0_0_rsp   ),
  .floo_wide_o      ( hbm_west_ni_0_0_to_router_0_0_wide  ),
  .floo_req_i       ( router_0_0_to_hbm_west_ni_0_0_req   ),
  .floo_rsp_o       ( hbm_west_ni_0_0_to_router_0_0_rsp   ),
  .floo_wide_i      ( router_0_0_to_hbm_west_ni_0_0_wide  )
);

localparam id_t hbm_west_ni_0_1_id = '{x: 0, y: 2};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_west_ni_0_1 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_west_narrow_req_o[1] ),
  .axi_narrow_out_rsp_i ( hbm_west_narrow_rsp_i[1] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_west_wide_req_o[1] ),
  .axi_wide_out_rsp_i ( hbm_west_wide_rsp_i[1] ),
  .id_i             ( hbm_west_ni_0_1_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_west_ni_0_1_to_router_0_1_req   ),
  .floo_rsp_i       ( router_0_1_to_hbm_west_ni_0_1_rsp   ),
  .floo_wide_o      ( hbm_west_ni_0_1_to_router_0_1_wide  ),
  .floo_req_i       ( router_0_1_to_hbm_west_ni_0_1_req   ),
  .floo_rsp_o       ( hbm_west_ni_0_1_to_router_0_1_rsp   ),
  .floo_wide_i      ( router_0_1_to_hbm_west_ni_0_1_wide  )
);

localparam id_t hbm_west_ni_0_2_id = '{x: 0, y: 3};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_west_ni_0_2 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_west_narrow_req_o[2] ),
  .axi_narrow_out_rsp_i ( hbm_west_narrow_rsp_i[2] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_west_wide_req_o[2] ),
  .axi_wide_out_rsp_i ( hbm_west_wide_rsp_i[2] ),
  .id_i             ( hbm_west_ni_0_2_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_west_ni_0_2_to_router_0_2_req   ),
  .floo_rsp_i       ( router_0_2_to_hbm_west_ni_0_2_rsp   ),
  .floo_wide_o      ( hbm_west_ni_0_2_to_router_0_2_wide  ),
  .floo_req_i       ( router_0_2_to_hbm_west_ni_0_2_req   ),
  .floo_rsp_o       ( hbm_west_ni_0_2_to_router_0_2_rsp   ),
  .floo_wide_i      ( router_0_2_to_hbm_west_ni_0_2_wide  )
);

localparam id_t hbm_west_ni_0_3_id = '{x: 0, y: 4};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_west_ni_0_3 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_west_narrow_req_o[3] ),
  .axi_narrow_out_rsp_i ( hbm_west_narrow_rsp_i[3] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_west_wide_req_o[3] ),
  .axi_wide_out_rsp_i ( hbm_west_wide_rsp_i[3] ),
  .id_i             ( hbm_west_ni_0_3_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_west_ni_0_3_to_router_0_3_req   ),
  .floo_rsp_i       ( router_0_3_to_hbm_west_ni_0_3_rsp   ),
  .floo_wide_o      ( hbm_west_ni_0_3_to_router_0_3_wide  ),
  .floo_req_i       ( router_0_3_to_hbm_west_ni_0_3_req   ),
  .floo_rsp_o       ( hbm_west_ni_0_3_to_router_0_3_rsp   ),
  .floo_wide_i      ( router_0_3_to_hbm_west_ni_0_3_wide  )
);


floo_req_t [West:North] router_0_0_req_in;
floo_rsp_t [West:North] router_0_0_rsp_out;
floo_req_t [West:North] router_0_0_req_out;
floo_rsp_t [West:North] router_0_0_rsp_in;
floo_wide_t [West:North] router_0_0_wide_in;
floo_wide_t [West:North] router_0_0_wide_out;

  assign router_0_0_req_in[East] = router_1_0_to_router_0_0_req;
  assign router_0_0_req_in[North] = router_0_1_to_router_0_0_req;
  assign router_0_0_req_in[South] = hbm_south_ni_0_0_to_router_0_0_req;
  assign router_0_0_req_in[West] = hbm_west_ni_0_0_to_router_0_0_req;

  assign router_0_0_to_router_1_0_rsp = router_0_0_rsp_out[East];
  assign router_0_0_to_router_0_1_rsp = router_0_0_rsp_out[North];
  assign router_0_0_to_hbm_south_ni_0_0_rsp = router_0_0_rsp_out[South];
  assign router_0_0_to_hbm_west_ni_0_0_rsp = router_0_0_rsp_out[West];

  assign router_0_0_to_router_1_0_req = router_0_0_req_out[East];
  assign router_0_0_to_router_0_1_req = router_0_0_req_out[North];
  assign router_0_0_to_hbm_south_ni_0_0_req = router_0_0_req_out[South];
  assign router_0_0_to_hbm_west_ni_0_0_req = router_0_0_req_out[West];

  assign router_0_0_rsp_in[East] = router_1_0_to_router_0_0_rsp;
  assign router_0_0_rsp_in[North] = router_0_1_to_router_0_0_rsp;
  assign router_0_0_rsp_in[South] = hbm_south_ni_0_0_to_router_0_0_rsp;
  assign router_0_0_rsp_in[West] = hbm_west_ni_0_0_to_router_0_0_rsp;

  assign router_0_0_wide_in[East] = router_1_0_to_router_0_0_wide;
  assign router_0_0_wide_in[North] = router_0_1_to_router_0_0_wide;
  assign router_0_0_wide_in[South] = hbm_south_ni_0_0_to_router_0_0_wide;
  assign router_0_0_wide_in[West] = hbm_west_ni_0_0_to_router_0_0_wide;

  assign router_0_0_to_router_1_0_wide = router_0_0_wide_out[East];
  assign router_0_0_to_router_0_1_wide = router_0_0_wide_out[North];
  assign router_0_0_to_hbm_south_ni_0_0_wide = router_0_0_wide_out[South];
  assign router_0_0_to_hbm_west_ni_0_0_wide = router_0_0_wide_out[West];

localparam id_t compute_tile_0_0_id = '{x: 1, y: 1};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(1),
  .id_y(1)
) 
`endif
 compute_tile_0_0 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd0),
  .meip_i (9'b0),
  .mtip_i (mtip_i[9:1]),
  .msip_i (msip_i[9:1]),
  .id_i (compute_tile_0_0_id),
  .floo_req_i (router_0_0_req_in),
  .floo_rsp_o (router_0_0_rsp_out),
  .floo_req_o (router_0_0_req_out),
  .floo_rsp_i (router_0_0_rsp_in),
  .floo_wide_i (router_0_0_wide_in),
  .floo_wide_o (router_0_0_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_0_1_req_in;
floo_rsp_t [West:North] router_0_1_rsp_out;
floo_req_t [West:North] router_0_1_req_out;
floo_rsp_t [West:North] router_0_1_rsp_in;
floo_wide_t [West:North] router_0_1_wide_in;
floo_wide_t [West:North] router_0_1_wide_out;

  assign router_0_1_req_in[East] = router_1_1_to_router_0_1_req;
  assign router_0_1_req_in[North] = router_0_2_to_router_0_1_req;
  assign router_0_1_req_in[South] = router_0_0_to_router_0_1_req;
  assign router_0_1_req_in[West] = hbm_west_ni_0_1_to_router_0_1_req;

  assign router_0_1_to_router_1_1_rsp = router_0_1_rsp_out[East];
  assign router_0_1_to_router_0_2_rsp = router_0_1_rsp_out[North];
  assign router_0_1_to_router_0_0_rsp = router_0_1_rsp_out[South];
  assign router_0_1_to_hbm_west_ni_0_1_rsp = router_0_1_rsp_out[West];

  assign router_0_1_to_router_1_1_req = router_0_1_req_out[East];
  assign router_0_1_to_router_0_2_req = router_0_1_req_out[North];
  assign router_0_1_to_router_0_0_req = router_0_1_req_out[South];
  assign router_0_1_to_hbm_west_ni_0_1_req = router_0_1_req_out[West];

  assign router_0_1_rsp_in[East] = router_1_1_to_router_0_1_rsp;
  assign router_0_1_rsp_in[North] = router_0_2_to_router_0_1_rsp;
  assign router_0_1_rsp_in[South] = router_0_0_to_router_0_1_rsp;
  assign router_0_1_rsp_in[West] = hbm_west_ni_0_1_to_router_0_1_rsp;

  assign router_0_1_wide_in[East] = router_1_1_to_router_0_1_wide;
  assign router_0_1_wide_in[North] = router_0_2_to_router_0_1_wide;
  assign router_0_1_wide_in[South] = router_0_0_to_router_0_1_wide;
  assign router_0_1_wide_in[West] = hbm_west_ni_0_1_to_router_0_1_wide;

  assign router_0_1_to_router_1_1_wide = router_0_1_wide_out[East];
  assign router_0_1_to_router_0_2_wide = router_0_1_wide_out[North];
  assign router_0_1_to_router_0_0_wide = router_0_1_wide_out[South];
  assign router_0_1_to_hbm_west_ni_0_1_wide = router_0_1_wide_out[West];

localparam id_t compute_tile_0_1_id = '{x: 1, y: 2};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(1),
  .id_y(2)
) 
`endif
 compute_tile_0_1 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd1),
  .meip_i (9'b0),
  .mtip_i (mtip_i[18:10]),
  .msip_i (msip_i[18:10]),
  .id_i (compute_tile_0_1_id),
  .floo_req_i (router_0_1_req_in),
  .floo_rsp_o (router_0_1_rsp_out),
  .floo_req_o (router_0_1_req_out),
  .floo_rsp_i (router_0_1_rsp_in),
  .floo_wide_i (router_0_1_wide_in),
  .floo_wide_o (router_0_1_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_0_2_req_in;
floo_rsp_t [West:North] router_0_2_rsp_out;
floo_req_t [West:North] router_0_2_req_out;
floo_rsp_t [West:North] router_0_2_rsp_in;
floo_wide_t [West:North] router_0_2_wide_in;
floo_wide_t [West:North] router_0_2_wide_out;

  assign router_0_2_req_in[East] = router_1_2_to_router_0_2_req;
  assign router_0_2_req_in[North] = router_0_3_to_router_0_2_req;
  assign router_0_2_req_in[South] = router_0_1_to_router_0_2_req;
  assign router_0_2_req_in[West] = hbm_west_ni_0_2_to_router_0_2_req;

  assign router_0_2_to_router_1_2_rsp = router_0_2_rsp_out[East];
  assign router_0_2_to_router_0_3_rsp = router_0_2_rsp_out[North];
  assign router_0_2_to_router_0_1_rsp = router_0_2_rsp_out[South];
  assign router_0_2_to_hbm_west_ni_0_2_rsp = router_0_2_rsp_out[West];

  assign router_0_2_to_router_1_2_req = router_0_2_req_out[East];
  assign router_0_2_to_router_0_3_req = router_0_2_req_out[North];
  assign router_0_2_to_router_0_1_req = router_0_2_req_out[South];
  assign router_0_2_to_hbm_west_ni_0_2_req = router_0_2_req_out[West];

  assign router_0_2_rsp_in[East] = router_1_2_to_router_0_2_rsp;
  assign router_0_2_rsp_in[North] = router_0_3_to_router_0_2_rsp;
  assign router_0_2_rsp_in[South] = router_0_1_to_router_0_2_rsp;
  assign router_0_2_rsp_in[West] = hbm_west_ni_0_2_to_router_0_2_rsp;

  assign router_0_2_wide_in[East] = router_1_2_to_router_0_2_wide;
  assign router_0_2_wide_in[North] = router_0_3_to_router_0_2_wide;
  assign router_0_2_wide_in[South] = router_0_1_to_router_0_2_wide;
  assign router_0_2_wide_in[West] = hbm_west_ni_0_2_to_router_0_2_wide;

  assign router_0_2_to_router_1_2_wide = router_0_2_wide_out[East];
  assign router_0_2_to_router_0_3_wide = router_0_2_wide_out[North];
  assign router_0_2_to_router_0_1_wide = router_0_2_wide_out[South];
  assign router_0_2_to_hbm_west_ni_0_2_wide = router_0_2_wide_out[West];

localparam id_t compute_tile_0_2_id = '{x: 1, y: 3};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(1),
  .id_y(3)
) 
`endif
 compute_tile_0_2 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd2),
  .meip_i (9'b0),
  .mtip_i (mtip_i[27:19]),
  .msip_i (msip_i[27:19]),
  .id_i (compute_tile_0_2_id),
  .floo_req_i (router_0_2_req_in),
  .floo_rsp_o (router_0_2_rsp_out),
  .floo_req_o (router_0_2_req_out),
  .floo_rsp_i (router_0_2_rsp_in),
  .floo_wide_i (router_0_2_wide_in),
  .floo_wide_o (router_0_2_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_0_3_req_in;
floo_rsp_t [West:North] router_0_3_rsp_out;
floo_req_t [West:North] router_0_3_req_out;
floo_rsp_t [West:North] router_0_3_rsp_in;
floo_wide_t [West:North] router_0_3_wide_in;
floo_wide_t [West:North] router_0_3_wide_out;

  assign router_0_3_req_in[East] = router_1_3_to_router_0_3_req;
  assign router_0_3_req_in[North] = hbm_north_ni_0_0_to_router_0_3_req;
  assign router_0_3_req_in[South] = router_0_2_to_router_0_3_req;
  assign router_0_3_req_in[West] = hbm_west_ni_0_3_to_router_0_3_req;

  assign router_0_3_to_router_1_3_rsp = router_0_3_rsp_out[East];
  assign router_0_3_to_hbm_north_ni_0_0_rsp = router_0_3_rsp_out[North];
  assign router_0_3_to_router_0_2_rsp = router_0_3_rsp_out[South];
  assign router_0_3_to_hbm_west_ni_0_3_rsp = router_0_3_rsp_out[West];

  assign router_0_3_to_router_1_3_req = router_0_3_req_out[East];
  assign router_0_3_to_hbm_north_ni_0_0_req = router_0_3_req_out[North];
  assign router_0_3_to_router_0_2_req = router_0_3_req_out[South];
  assign router_0_3_to_hbm_west_ni_0_3_req = router_0_3_req_out[West];

  assign router_0_3_rsp_in[East] = router_1_3_to_router_0_3_rsp;
  assign router_0_3_rsp_in[North] = hbm_north_ni_0_0_to_router_0_3_rsp;
  assign router_0_3_rsp_in[South] = router_0_2_to_router_0_3_rsp;
  assign router_0_3_rsp_in[West] = hbm_west_ni_0_3_to_router_0_3_rsp;

  assign router_0_3_wide_in[East] = router_1_3_to_router_0_3_wide;
  assign router_0_3_wide_in[North] = hbm_north_ni_0_0_to_router_0_3_wide;
  assign router_0_3_wide_in[South] = router_0_2_to_router_0_3_wide;
  assign router_0_3_wide_in[West] = hbm_west_ni_0_3_to_router_0_3_wide;

  assign router_0_3_to_router_1_3_wide = router_0_3_wide_out[East];
  assign router_0_3_to_hbm_north_ni_0_0_wide = router_0_3_wide_out[North];
  assign router_0_3_to_router_0_2_wide = router_0_3_wide_out[South];
  assign router_0_3_to_hbm_west_ni_0_3_wide = router_0_3_wide_out[West];

localparam id_t compute_tile_0_3_id = '{x: 1, y: 4};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(1),
  .id_y(4)
) 
`endif
 compute_tile_0_3 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd3),
  .meip_i (9'b0),
  .mtip_i (mtip_i[36:28]),
  .msip_i (msip_i[36:28]),
  .id_i (compute_tile_0_3_id),
  .floo_req_i (router_0_3_req_in),
  .floo_rsp_o (router_0_3_rsp_out),
  .floo_req_o (router_0_3_req_out),
  .floo_rsp_i (router_0_3_rsp_in),
  .floo_wide_i (router_0_3_wide_in),
  .floo_wide_o (router_0_3_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_1_0_req_in;
floo_rsp_t [West:North] router_1_0_rsp_out;
floo_req_t [West:North] router_1_0_req_out;
floo_rsp_t [West:North] router_1_0_rsp_in;
floo_wide_t [West:North] router_1_0_wide_in;
floo_wide_t [West:North] router_1_0_wide_out;

  assign router_1_0_req_in[East] = router_2_0_to_router_1_0_req;
  assign router_1_0_req_in[North] = router_1_1_to_router_1_0_req;
  assign router_1_0_req_in[South] = hbm_south_ni_1_0_to_router_1_0_req;
  assign router_1_0_req_in[West] = router_0_0_to_router_1_0_req;

  assign router_1_0_to_router_2_0_rsp = router_1_0_rsp_out[East];
  assign router_1_0_to_router_1_1_rsp = router_1_0_rsp_out[North];
  assign router_1_0_to_hbm_south_ni_1_0_rsp = router_1_0_rsp_out[South];
  assign router_1_0_to_router_0_0_rsp = router_1_0_rsp_out[West];

  assign router_1_0_to_router_2_0_req = router_1_0_req_out[East];
  assign router_1_0_to_router_1_1_req = router_1_0_req_out[North];
  assign router_1_0_to_hbm_south_ni_1_0_req = router_1_0_req_out[South];
  assign router_1_0_to_router_0_0_req = router_1_0_req_out[West];

  assign router_1_0_rsp_in[East] = router_2_0_to_router_1_0_rsp;
  assign router_1_0_rsp_in[North] = router_1_1_to_router_1_0_rsp;
  assign router_1_0_rsp_in[South] = hbm_south_ni_1_0_to_router_1_0_rsp;
  assign router_1_0_rsp_in[West] = router_0_0_to_router_1_0_rsp;

  assign router_1_0_wide_in[East] = router_2_0_to_router_1_0_wide;
  assign router_1_0_wide_in[North] = router_1_1_to_router_1_0_wide;
  assign router_1_0_wide_in[South] = hbm_south_ni_1_0_to_router_1_0_wide;
  assign router_1_0_wide_in[West] = router_0_0_to_router_1_0_wide;

  assign router_1_0_to_router_2_0_wide = router_1_0_wide_out[East];
  assign router_1_0_to_router_1_1_wide = router_1_0_wide_out[North];
  assign router_1_0_to_hbm_south_ni_1_0_wide = router_1_0_wide_out[South];
  assign router_1_0_to_router_0_0_wide = router_1_0_wide_out[West];

localparam id_t compute_tile_1_0_id = '{x: 2, y: 1};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(2),
  .id_y(1)
) 
`endif
 compute_tile_1_0 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd4),
  .meip_i (9'b0),
  .mtip_i (mtip_i[45:37]),
  .msip_i (msip_i[45:37]),
  .id_i (compute_tile_1_0_id),
  .floo_req_i (router_1_0_req_in),
  .floo_rsp_o (router_1_0_rsp_out),
  .floo_req_o (router_1_0_req_out),
  .floo_rsp_i (router_1_0_rsp_in),
  .floo_wide_i (router_1_0_wide_in),
  .floo_wide_o (router_1_0_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_1_1_req_in;
floo_rsp_t [West:North] router_1_1_rsp_out;
floo_req_t [West:North] router_1_1_req_out;
floo_rsp_t [West:North] router_1_1_rsp_in;
floo_wide_t [West:North] router_1_1_wide_in;
floo_wide_t [West:North] router_1_1_wide_out;

  assign router_1_1_req_in[East] = router_2_1_to_router_1_1_req;
  assign router_1_1_req_in[North] = router_1_2_to_router_1_1_req;
  assign router_1_1_req_in[South] = router_1_0_to_router_1_1_req;
  assign router_1_1_req_in[West] = router_0_1_to_router_1_1_req;

  assign router_1_1_to_router_2_1_rsp = router_1_1_rsp_out[East];
  assign router_1_1_to_router_1_2_rsp = router_1_1_rsp_out[North];
  assign router_1_1_to_router_1_0_rsp = router_1_1_rsp_out[South];
  assign router_1_1_to_router_0_1_rsp = router_1_1_rsp_out[West];

  assign router_1_1_to_router_2_1_req = router_1_1_req_out[East];
  assign router_1_1_to_router_1_2_req = router_1_1_req_out[North];
  assign router_1_1_to_router_1_0_req = router_1_1_req_out[South];
  assign router_1_1_to_router_0_1_req = router_1_1_req_out[West];

  assign router_1_1_rsp_in[East] = router_2_1_to_router_1_1_rsp;
  assign router_1_1_rsp_in[North] = router_1_2_to_router_1_1_rsp;
  assign router_1_1_rsp_in[South] = router_1_0_to_router_1_1_rsp;
  assign router_1_1_rsp_in[West] = router_0_1_to_router_1_1_rsp;

  assign router_1_1_wide_in[East] = router_2_1_to_router_1_1_wide;
  assign router_1_1_wide_in[North] = router_1_2_to_router_1_1_wide;
  assign router_1_1_wide_in[South] = router_1_0_to_router_1_1_wide;
  assign router_1_1_wide_in[West] = router_0_1_to_router_1_1_wide;

  assign router_1_1_to_router_2_1_wide = router_1_1_wide_out[East];
  assign router_1_1_to_router_1_2_wide = router_1_1_wide_out[North];
  assign router_1_1_to_router_1_0_wide = router_1_1_wide_out[South];
  assign router_1_1_to_router_0_1_wide = router_1_1_wide_out[West];

localparam id_t compute_tile_1_1_id = '{x: 2, y: 2};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(2),
  .id_y(2)
) 
`endif
 compute_tile_1_1 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd5),
  .meip_i (9'b0),
  .mtip_i (mtip_i[54:46]),
  .msip_i (msip_i[54:46]),
  .id_i (compute_tile_1_1_id),
  .floo_req_i (router_1_1_req_in),
  .floo_rsp_o (router_1_1_rsp_out),
  .floo_req_o (router_1_1_req_out),
  .floo_rsp_i (router_1_1_rsp_in),
  .floo_wide_i (router_1_1_wide_in),
  .floo_wide_o (router_1_1_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_1_2_req_in;
floo_rsp_t [West:North] router_1_2_rsp_out;
floo_req_t [West:North] router_1_2_req_out;
floo_rsp_t [West:North] router_1_2_rsp_in;
floo_wide_t [West:North] router_1_2_wide_in;
floo_wide_t [West:North] router_1_2_wide_out;

  assign router_1_2_req_in[East] = router_2_2_to_router_1_2_req;
  assign router_1_2_req_in[North] = router_1_3_to_router_1_2_req;
  assign router_1_2_req_in[South] = router_1_1_to_router_1_2_req;
  assign router_1_2_req_in[West] = router_0_2_to_router_1_2_req;

  assign router_1_2_to_router_2_2_rsp = router_1_2_rsp_out[East];
  assign router_1_2_to_router_1_3_rsp = router_1_2_rsp_out[North];
  assign router_1_2_to_router_1_1_rsp = router_1_2_rsp_out[South];
  assign router_1_2_to_router_0_2_rsp = router_1_2_rsp_out[West];

  assign router_1_2_to_router_2_2_req = router_1_2_req_out[East];
  assign router_1_2_to_router_1_3_req = router_1_2_req_out[North];
  assign router_1_2_to_router_1_1_req = router_1_2_req_out[South];
  assign router_1_2_to_router_0_2_req = router_1_2_req_out[West];

  assign router_1_2_rsp_in[East] = router_2_2_to_router_1_2_rsp;
  assign router_1_2_rsp_in[North] = router_1_3_to_router_1_2_rsp;
  assign router_1_2_rsp_in[South] = router_1_1_to_router_1_2_rsp;
  assign router_1_2_rsp_in[West] = router_0_2_to_router_1_2_rsp;

  assign router_1_2_wide_in[East] = router_2_2_to_router_1_2_wide;
  assign router_1_2_wide_in[North] = router_1_3_to_router_1_2_wide;
  assign router_1_2_wide_in[South] = router_1_1_to_router_1_2_wide;
  assign router_1_2_wide_in[West] = router_0_2_to_router_1_2_wide;

  assign router_1_2_to_router_2_2_wide = router_1_2_wide_out[East];
  assign router_1_2_to_router_1_3_wide = router_1_2_wide_out[North];
  assign router_1_2_to_router_1_1_wide = router_1_2_wide_out[South];
  assign router_1_2_to_router_0_2_wide = router_1_2_wide_out[West];

localparam id_t compute_tile_1_2_id = '{x: 2, y: 3};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(2),
  .id_y(3)
) 
`endif
 compute_tile_1_2 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd6),
  .meip_i (9'b0),
  .mtip_i (mtip_i[63:55]),
  .msip_i (msip_i[63:55]),
  .id_i (compute_tile_1_2_id),
  .floo_req_i (router_1_2_req_in),
  .floo_rsp_o (router_1_2_rsp_out),
  .floo_req_o (router_1_2_req_out),
  .floo_rsp_i (router_1_2_rsp_in),
  .floo_wide_i (router_1_2_wide_in),
  .floo_wide_o (router_1_2_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_1_3_req_in;
floo_rsp_t [West:North] router_1_3_rsp_out;
floo_req_t [West:North] router_1_3_req_out;
floo_rsp_t [West:North] router_1_3_rsp_in;
floo_wide_t [West:North] router_1_3_wide_in;
floo_wide_t [West:North] router_1_3_wide_out;

  assign router_1_3_req_in[East] = router_2_3_to_router_1_3_req;
  assign router_1_3_req_in[North] = hbm_north_ni_1_0_to_router_1_3_req;
  assign router_1_3_req_in[South] = router_1_2_to_router_1_3_req;
  assign router_1_3_req_in[West] = router_0_3_to_router_1_3_req;

  assign router_1_3_to_router_2_3_rsp = router_1_3_rsp_out[East];
  assign router_1_3_to_hbm_north_ni_1_0_rsp = router_1_3_rsp_out[North];
  assign router_1_3_to_router_1_2_rsp = router_1_3_rsp_out[South];
  assign router_1_3_to_router_0_3_rsp = router_1_3_rsp_out[West];

  assign router_1_3_to_router_2_3_req = router_1_3_req_out[East];
  assign router_1_3_to_hbm_north_ni_1_0_req = router_1_3_req_out[North];
  assign router_1_3_to_router_1_2_req = router_1_3_req_out[South];
  assign router_1_3_to_router_0_3_req = router_1_3_req_out[West];

  assign router_1_3_rsp_in[East] = router_2_3_to_router_1_3_rsp;
  assign router_1_3_rsp_in[North] = hbm_north_ni_1_0_to_router_1_3_rsp;
  assign router_1_3_rsp_in[South] = router_1_2_to_router_1_3_rsp;
  assign router_1_3_rsp_in[West] = router_0_3_to_router_1_3_rsp;

  assign router_1_3_wide_in[East] = router_2_3_to_router_1_3_wide;
  assign router_1_3_wide_in[North] = hbm_north_ni_1_0_to_router_1_3_wide;
  assign router_1_3_wide_in[South] = router_1_2_to_router_1_3_wide;
  assign router_1_3_wide_in[West] = router_0_3_to_router_1_3_wide;

  assign router_1_3_to_router_2_3_wide = router_1_3_wide_out[East];
  assign router_1_3_to_hbm_north_ni_1_0_wide = router_1_3_wide_out[North];
  assign router_1_3_to_router_1_2_wide = router_1_3_wide_out[South];
  assign router_1_3_to_router_0_3_wide = router_1_3_wide_out[West];

localparam id_t compute_tile_1_3_id = '{x: 2, y: 4};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(2),
  .id_y(4)
) 
`endif
 compute_tile_1_3 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd7),
  .meip_i (9'b0),
  .mtip_i (mtip_i[72:64]),
  .msip_i (msip_i[72:64]),
  .id_i (compute_tile_1_3_id),
  .floo_req_i (router_1_3_req_in),
  .floo_rsp_o (router_1_3_rsp_out),
  .floo_req_o (router_1_3_req_out),
  .floo_rsp_i (router_1_3_rsp_in),
  .floo_wide_i (router_1_3_wide_in),
  .floo_wide_o (router_1_3_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_2_0_req_in;
floo_rsp_t [West:North] router_2_0_rsp_out;
floo_req_t [West:North] router_2_0_req_out;
floo_rsp_t [West:North] router_2_0_rsp_in;
floo_wide_t [West:North] router_2_0_wide_in;
floo_wide_t [West:North] router_2_0_wide_out;

  assign router_2_0_req_in[East] = router_3_0_to_router_2_0_req;
  assign router_2_0_req_in[North] = router_2_1_to_router_2_0_req;
  assign router_2_0_req_in[South] = hbm_south_ni_2_0_to_router_2_0_req;
  assign router_2_0_req_in[West] = router_1_0_to_router_2_0_req;

  assign router_2_0_to_router_3_0_rsp = router_2_0_rsp_out[East];
  assign router_2_0_to_router_2_1_rsp = router_2_0_rsp_out[North];
  assign router_2_0_to_hbm_south_ni_2_0_rsp = router_2_0_rsp_out[South];
  assign router_2_0_to_router_1_0_rsp = router_2_0_rsp_out[West];

  assign router_2_0_to_router_3_0_req = router_2_0_req_out[East];
  assign router_2_0_to_router_2_1_req = router_2_0_req_out[North];
  assign router_2_0_to_hbm_south_ni_2_0_req = router_2_0_req_out[South];
  assign router_2_0_to_router_1_0_req = router_2_0_req_out[West];

  assign router_2_0_rsp_in[East] = router_3_0_to_router_2_0_rsp;
  assign router_2_0_rsp_in[North] = router_2_1_to_router_2_0_rsp;
  assign router_2_0_rsp_in[South] = hbm_south_ni_2_0_to_router_2_0_rsp;
  assign router_2_0_rsp_in[West] = router_1_0_to_router_2_0_rsp;

  assign router_2_0_wide_in[East] = router_3_0_to_router_2_0_wide;
  assign router_2_0_wide_in[North] = router_2_1_to_router_2_0_wide;
  assign router_2_0_wide_in[South] = hbm_south_ni_2_0_to_router_2_0_wide;
  assign router_2_0_wide_in[West] = router_1_0_to_router_2_0_wide;

  assign router_2_0_to_router_3_0_wide = router_2_0_wide_out[East];
  assign router_2_0_to_router_2_1_wide = router_2_0_wide_out[North];
  assign router_2_0_to_hbm_south_ni_2_0_wide = router_2_0_wide_out[South];
  assign router_2_0_to_router_1_0_wide = router_2_0_wide_out[West];

localparam id_t compute_tile_2_0_id = '{x: 3, y: 1};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(3),
  .id_y(1)
) 
`endif
 compute_tile_2_0 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd8),
  .meip_i (9'b0),
  .mtip_i (mtip_i[81:73]),
  .msip_i (msip_i[81:73]),
  .id_i (compute_tile_2_0_id),
  .floo_req_i (router_2_0_req_in),
  .floo_rsp_o (router_2_0_rsp_out),
  .floo_req_o (router_2_0_req_out),
  .floo_rsp_i (router_2_0_rsp_in),
  .floo_wide_i (router_2_0_wide_in),
  .floo_wide_o (router_2_0_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_2_1_req_in;
floo_rsp_t [West:North] router_2_1_rsp_out;
floo_req_t [West:North] router_2_1_req_out;
floo_rsp_t [West:North] router_2_1_rsp_in;
floo_wide_t [West:North] router_2_1_wide_in;
floo_wide_t [West:North] router_2_1_wide_out;

  assign router_2_1_req_in[East] = router_3_1_to_router_2_1_req;
  assign router_2_1_req_in[North] = router_2_2_to_router_2_1_req;
  assign router_2_1_req_in[South] = router_2_0_to_router_2_1_req;
  assign router_2_1_req_in[West] = router_1_1_to_router_2_1_req;

  assign router_2_1_to_router_3_1_rsp = router_2_1_rsp_out[East];
  assign router_2_1_to_router_2_2_rsp = router_2_1_rsp_out[North];
  assign router_2_1_to_router_2_0_rsp = router_2_1_rsp_out[South];
  assign router_2_1_to_router_1_1_rsp = router_2_1_rsp_out[West];

  assign router_2_1_to_router_3_1_req = router_2_1_req_out[East];
  assign router_2_1_to_router_2_2_req = router_2_1_req_out[North];
  assign router_2_1_to_router_2_0_req = router_2_1_req_out[South];
  assign router_2_1_to_router_1_1_req = router_2_1_req_out[West];

  assign router_2_1_rsp_in[East] = router_3_1_to_router_2_1_rsp;
  assign router_2_1_rsp_in[North] = router_2_2_to_router_2_1_rsp;
  assign router_2_1_rsp_in[South] = router_2_0_to_router_2_1_rsp;
  assign router_2_1_rsp_in[West] = router_1_1_to_router_2_1_rsp;

  assign router_2_1_wide_in[East] = router_3_1_to_router_2_1_wide;
  assign router_2_1_wide_in[North] = router_2_2_to_router_2_1_wide;
  assign router_2_1_wide_in[South] = router_2_0_to_router_2_1_wide;
  assign router_2_1_wide_in[West] = router_1_1_to_router_2_1_wide;

  assign router_2_1_to_router_3_1_wide = router_2_1_wide_out[East];
  assign router_2_1_to_router_2_2_wide = router_2_1_wide_out[North];
  assign router_2_1_to_router_2_0_wide = router_2_1_wide_out[South];
  assign router_2_1_to_router_1_1_wide = router_2_1_wide_out[West];

localparam id_t compute_tile_2_1_id = '{x: 3, y: 2};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(3),
  .id_y(2)
) 
`endif
 compute_tile_2_1 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd9),
  .meip_i (9'b0),
  .mtip_i (mtip_i[90:82]),
  .msip_i (msip_i[90:82]),
  .id_i (compute_tile_2_1_id),
  .floo_req_i (router_2_1_req_in),
  .floo_rsp_o (router_2_1_rsp_out),
  .floo_req_o (router_2_1_req_out),
  .floo_rsp_i (router_2_1_rsp_in),
  .floo_wide_i (router_2_1_wide_in),
  .floo_wide_o (router_2_1_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_2_2_req_in;
floo_rsp_t [West:North] router_2_2_rsp_out;
floo_req_t [West:North] router_2_2_req_out;
floo_rsp_t [West:North] router_2_2_rsp_in;
floo_wide_t [West:North] router_2_2_wide_in;
floo_wide_t [West:North] router_2_2_wide_out;

  assign router_2_2_req_in[East] = router_3_2_to_router_2_2_req;
  assign router_2_2_req_in[North] = router_2_3_to_router_2_2_req;
  assign router_2_2_req_in[South] = router_2_1_to_router_2_2_req;
  assign router_2_2_req_in[West] = router_1_2_to_router_2_2_req;

  assign router_2_2_to_router_3_2_rsp = router_2_2_rsp_out[East];
  assign router_2_2_to_router_2_3_rsp = router_2_2_rsp_out[North];
  assign router_2_2_to_router_2_1_rsp = router_2_2_rsp_out[South];
  assign router_2_2_to_router_1_2_rsp = router_2_2_rsp_out[West];

  assign router_2_2_to_router_3_2_req = router_2_2_req_out[East];
  assign router_2_2_to_router_2_3_req = router_2_2_req_out[North];
  assign router_2_2_to_router_2_1_req = router_2_2_req_out[South];
  assign router_2_2_to_router_1_2_req = router_2_2_req_out[West];

  assign router_2_2_rsp_in[East] = router_3_2_to_router_2_2_rsp;
  assign router_2_2_rsp_in[North] = router_2_3_to_router_2_2_rsp;
  assign router_2_2_rsp_in[South] = router_2_1_to_router_2_2_rsp;
  assign router_2_2_rsp_in[West] = router_1_2_to_router_2_2_rsp;

  assign router_2_2_wide_in[East] = router_3_2_to_router_2_2_wide;
  assign router_2_2_wide_in[North] = router_2_3_to_router_2_2_wide;
  assign router_2_2_wide_in[South] = router_2_1_to_router_2_2_wide;
  assign router_2_2_wide_in[West] = router_1_2_to_router_2_2_wide;

  assign router_2_2_to_router_3_2_wide = router_2_2_wide_out[East];
  assign router_2_2_to_router_2_3_wide = router_2_2_wide_out[North];
  assign router_2_2_to_router_2_1_wide = router_2_2_wide_out[South];
  assign router_2_2_to_router_1_2_wide = router_2_2_wide_out[West];

localparam id_t compute_tile_2_2_id = '{x: 3, y: 3};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(3),
  .id_y(3)
) 
`endif
 compute_tile_2_2 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd10),
  .meip_i (9'b0),
  .mtip_i (mtip_i[99:91]),
  .msip_i (msip_i[99:91]),
  .id_i (compute_tile_2_2_id),
  .floo_req_i (router_2_2_req_in),
  .floo_rsp_o (router_2_2_rsp_out),
  .floo_req_o (router_2_2_req_out),
  .floo_rsp_i (router_2_2_rsp_in),
  .floo_wide_i (router_2_2_wide_in),
  .floo_wide_o (router_2_2_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_2_3_req_in;
floo_rsp_t [West:North] router_2_3_rsp_out;
floo_req_t [West:North] router_2_3_req_out;
floo_rsp_t [West:North] router_2_3_rsp_in;
floo_wide_t [West:North] router_2_3_wide_in;
floo_wide_t [West:North] router_2_3_wide_out;

  assign router_2_3_req_in[East] = router_3_3_to_router_2_3_req;
  assign router_2_3_req_in[North] = hbm_north_ni_2_0_to_router_2_3_req;
  assign router_2_3_req_in[South] = router_2_2_to_router_2_3_req;
  assign router_2_3_req_in[West] = router_1_3_to_router_2_3_req;

  assign router_2_3_to_router_3_3_rsp = router_2_3_rsp_out[East];
  assign router_2_3_to_hbm_north_ni_2_0_rsp = router_2_3_rsp_out[North];
  assign router_2_3_to_router_2_2_rsp = router_2_3_rsp_out[South];
  assign router_2_3_to_router_1_3_rsp = router_2_3_rsp_out[West];

  assign router_2_3_to_router_3_3_req = router_2_3_req_out[East];
  assign router_2_3_to_hbm_north_ni_2_0_req = router_2_3_req_out[North];
  assign router_2_3_to_router_2_2_req = router_2_3_req_out[South];
  assign router_2_3_to_router_1_3_req = router_2_3_req_out[West];

  assign router_2_3_rsp_in[East] = router_3_3_to_router_2_3_rsp;
  assign router_2_3_rsp_in[North] = hbm_north_ni_2_0_to_router_2_3_rsp;
  assign router_2_3_rsp_in[South] = router_2_2_to_router_2_3_rsp;
  assign router_2_3_rsp_in[West] = router_1_3_to_router_2_3_rsp;

  assign router_2_3_wide_in[East] = router_3_3_to_router_2_3_wide;
  assign router_2_3_wide_in[North] = hbm_north_ni_2_0_to_router_2_3_wide;
  assign router_2_3_wide_in[South] = router_2_2_to_router_2_3_wide;
  assign router_2_3_wide_in[West] = router_1_3_to_router_2_3_wide;

  assign router_2_3_to_router_3_3_wide = router_2_3_wide_out[East];
  assign router_2_3_to_hbm_north_ni_2_0_wide = router_2_3_wide_out[North];
  assign router_2_3_to_router_2_2_wide = router_2_3_wide_out[South];
  assign router_2_3_to_router_1_3_wide = router_2_3_wide_out[West];

localparam id_t compute_tile_2_3_id = '{x: 3, y: 4};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(3),
  .id_y(4)
) 
`endif
 compute_tile_2_3 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd11),
  .meip_i (9'b0),
  .mtip_i (mtip_i[108:100]),
  .msip_i (msip_i[108:100]),
  .id_i (compute_tile_2_3_id),
  .floo_req_i (router_2_3_req_in),
  .floo_rsp_o (router_2_3_rsp_out),
  .floo_req_o (router_2_3_req_out),
  .floo_rsp_i (router_2_3_rsp_in),
  .floo_wide_i (router_2_3_wide_in),
  .floo_wide_o (router_2_3_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_3_0_req_in;
floo_rsp_t [West:North] router_3_0_rsp_out;
floo_req_t [West:North] router_3_0_req_out;
floo_rsp_t [West:North] router_3_0_rsp_in;
floo_wide_t [West:North] router_3_0_wide_in;
floo_wide_t [West:North] router_3_0_wide_out;

  assign router_3_0_req_in[East] = router_4_0_to_router_3_0_req;
  assign router_3_0_req_in[North] = router_3_1_to_router_3_0_req;
  assign router_3_0_req_in[South] = hbm_south_ni_3_0_to_router_3_0_req;
  assign router_3_0_req_in[West] = router_2_0_to_router_3_0_req;

  assign router_3_0_to_router_4_0_rsp = router_3_0_rsp_out[East];
  assign router_3_0_to_router_3_1_rsp = router_3_0_rsp_out[North];
  assign router_3_0_to_hbm_south_ni_3_0_rsp = router_3_0_rsp_out[South];
  assign router_3_0_to_router_2_0_rsp = router_3_0_rsp_out[West];

  assign router_3_0_to_router_4_0_req = router_3_0_req_out[East];
  assign router_3_0_to_router_3_1_req = router_3_0_req_out[North];
  assign router_3_0_to_hbm_south_ni_3_0_req = router_3_0_req_out[South];
  assign router_3_0_to_router_2_0_req = router_3_0_req_out[West];

  assign router_3_0_rsp_in[East] = router_4_0_to_router_3_0_rsp;
  assign router_3_0_rsp_in[North] = router_3_1_to_router_3_0_rsp;
  assign router_3_0_rsp_in[South] = hbm_south_ni_3_0_to_router_3_0_rsp;
  assign router_3_0_rsp_in[West] = router_2_0_to_router_3_0_rsp;

  assign router_3_0_wide_in[East] = router_4_0_to_router_3_0_wide;
  assign router_3_0_wide_in[North] = router_3_1_to_router_3_0_wide;
  assign router_3_0_wide_in[South] = hbm_south_ni_3_0_to_router_3_0_wide;
  assign router_3_0_wide_in[West] = router_2_0_to_router_3_0_wide;

  assign router_3_0_to_router_4_0_wide = router_3_0_wide_out[East];
  assign router_3_0_to_router_3_1_wide = router_3_0_wide_out[North];
  assign router_3_0_to_hbm_south_ni_3_0_wide = router_3_0_wide_out[South];
  assign router_3_0_to_router_2_0_wide = router_3_0_wide_out[West];

localparam id_t compute_tile_3_0_id = '{x: 4, y: 1};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(4),
  .id_y(1)
) 
`endif
 compute_tile_3_0 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd12),
  .meip_i (9'b0),
  .mtip_i (mtip_i[117:109]),
  .msip_i (msip_i[117:109]),
  .id_i (compute_tile_3_0_id),
  .floo_req_i (router_3_0_req_in),
  .floo_rsp_o (router_3_0_rsp_out),
  .floo_req_o (router_3_0_req_out),
  .floo_rsp_i (router_3_0_rsp_in),
  .floo_wide_i (router_3_0_wide_in),
  .floo_wide_o (router_3_0_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_3_1_req_in;
floo_rsp_t [West:North] router_3_1_rsp_out;
floo_req_t [West:North] router_3_1_req_out;
floo_rsp_t [West:North] router_3_1_rsp_in;
floo_wide_t [West:North] router_3_1_wide_in;
floo_wide_t [West:North] router_3_1_wide_out;

  assign router_3_1_req_in[East] = router_4_1_to_router_3_1_req;
  assign router_3_1_req_in[North] = router_3_2_to_router_3_1_req;
  assign router_3_1_req_in[South] = router_3_0_to_router_3_1_req;
  assign router_3_1_req_in[West] = router_2_1_to_router_3_1_req;

  assign router_3_1_to_router_4_1_rsp = router_3_1_rsp_out[East];
  assign router_3_1_to_router_3_2_rsp = router_3_1_rsp_out[North];
  assign router_3_1_to_router_3_0_rsp = router_3_1_rsp_out[South];
  assign router_3_1_to_router_2_1_rsp = router_3_1_rsp_out[West];

  assign router_3_1_to_router_4_1_req = router_3_1_req_out[East];
  assign router_3_1_to_router_3_2_req = router_3_1_req_out[North];
  assign router_3_1_to_router_3_0_req = router_3_1_req_out[South];
  assign router_3_1_to_router_2_1_req = router_3_1_req_out[West];

  assign router_3_1_rsp_in[East] = router_4_1_to_router_3_1_rsp;
  assign router_3_1_rsp_in[North] = router_3_2_to_router_3_1_rsp;
  assign router_3_1_rsp_in[South] = router_3_0_to_router_3_1_rsp;
  assign router_3_1_rsp_in[West] = router_2_1_to_router_3_1_rsp;

  assign router_3_1_wide_in[East] = router_4_1_to_router_3_1_wide;
  assign router_3_1_wide_in[North] = router_3_2_to_router_3_1_wide;
  assign router_3_1_wide_in[South] = router_3_0_to_router_3_1_wide;
  assign router_3_1_wide_in[West] = router_2_1_to_router_3_1_wide;

  assign router_3_1_to_router_4_1_wide = router_3_1_wide_out[East];
  assign router_3_1_to_router_3_2_wide = router_3_1_wide_out[North];
  assign router_3_1_to_router_3_0_wide = router_3_1_wide_out[South];
  assign router_3_1_to_router_2_1_wide = router_3_1_wide_out[West];

localparam id_t compute_tile_3_1_id = '{x: 4, y: 2};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(4),
  .id_y(2)
) 
`endif
 compute_tile_3_1 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd13),
  .meip_i (9'b0),
  .mtip_i (mtip_i[126:118]),
  .msip_i (msip_i[126:118]),
  .id_i (compute_tile_3_1_id),
  .floo_req_i (router_3_1_req_in),
  .floo_rsp_o (router_3_1_rsp_out),
  .floo_req_o (router_3_1_req_out),
  .floo_rsp_i (router_3_1_rsp_in),
  .floo_wide_i (router_3_1_wide_in),
  .floo_wide_o (router_3_1_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_3_2_req_in;
floo_rsp_t [West:North] router_3_2_rsp_out;
floo_req_t [West:North] router_3_2_req_out;
floo_rsp_t [West:North] router_3_2_rsp_in;
floo_wide_t [West:North] router_3_2_wide_in;
floo_wide_t [West:North] router_3_2_wide_out;

  assign router_3_2_req_in[East] = router_4_2_to_router_3_2_req;
  assign router_3_2_req_in[North] = router_3_3_to_router_3_2_req;
  assign router_3_2_req_in[South] = router_3_1_to_router_3_2_req;
  assign router_3_2_req_in[West] = router_2_2_to_router_3_2_req;

  assign router_3_2_to_router_4_2_rsp = router_3_2_rsp_out[East];
  assign router_3_2_to_router_3_3_rsp = router_3_2_rsp_out[North];
  assign router_3_2_to_router_3_1_rsp = router_3_2_rsp_out[South];
  assign router_3_2_to_router_2_2_rsp = router_3_2_rsp_out[West];

  assign router_3_2_to_router_4_2_req = router_3_2_req_out[East];
  assign router_3_2_to_router_3_3_req = router_3_2_req_out[North];
  assign router_3_2_to_router_3_1_req = router_3_2_req_out[South];
  assign router_3_2_to_router_2_2_req = router_3_2_req_out[West];

  assign router_3_2_rsp_in[East] = router_4_2_to_router_3_2_rsp;
  assign router_3_2_rsp_in[North] = router_3_3_to_router_3_2_rsp;
  assign router_3_2_rsp_in[South] = router_3_1_to_router_3_2_rsp;
  assign router_3_2_rsp_in[West] = router_2_2_to_router_3_2_rsp;

  assign router_3_2_wide_in[East] = router_4_2_to_router_3_2_wide;
  assign router_3_2_wide_in[North] = router_3_3_to_router_3_2_wide;
  assign router_3_2_wide_in[South] = router_3_1_to_router_3_2_wide;
  assign router_3_2_wide_in[West] = router_2_2_to_router_3_2_wide;

  assign router_3_2_to_router_4_2_wide = router_3_2_wide_out[East];
  assign router_3_2_to_router_3_3_wide = router_3_2_wide_out[North];
  assign router_3_2_to_router_3_1_wide = router_3_2_wide_out[South];
  assign router_3_2_to_router_2_2_wide = router_3_2_wide_out[West];

localparam id_t compute_tile_3_2_id = '{x: 4, y: 3};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(4),
  .id_y(3)
) 
`endif
 compute_tile_3_2 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd14),
  .meip_i (9'b0),
  .mtip_i (mtip_i[135:127]),
  .msip_i (msip_i[135:127]),
  .id_i (compute_tile_3_2_id),
  .floo_req_i (router_3_2_req_in),
  .floo_rsp_o (router_3_2_rsp_out),
  .floo_req_o (router_3_2_req_out),
  .floo_rsp_i (router_3_2_rsp_in),
  .floo_wide_i (router_3_2_wide_in),
  .floo_wide_o (router_3_2_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_3_3_req_in;
floo_rsp_t [West:North] router_3_3_rsp_out;
floo_req_t [West:North] router_3_3_req_out;
floo_rsp_t [West:North] router_3_3_rsp_in;
floo_wide_t [West:North] router_3_3_wide_in;
floo_wide_t [West:North] router_3_3_wide_out;

  assign router_3_3_req_in[East] = router_4_3_to_router_3_3_req;
  assign router_3_3_req_in[North] = hbm_north_ni_3_0_to_router_3_3_req;
  assign router_3_3_req_in[South] = router_3_2_to_router_3_3_req;
  assign router_3_3_req_in[West] = router_2_3_to_router_3_3_req;

  assign router_3_3_to_router_4_3_rsp = router_3_3_rsp_out[East];
  assign router_3_3_to_hbm_north_ni_3_0_rsp = router_3_3_rsp_out[North];
  assign router_3_3_to_router_3_2_rsp = router_3_3_rsp_out[South];
  assign router_3_3_to_router_2_3_rsp = router_3_3_rsp_out[West];

  assign router_3_3_to_router_4_3_req = router_3_3_req_out[East];
  assign router_3_3_to_hbm_north_ni_3_0_req = router_3_3_req_out[North];
  assign router_3_3_to_router_3_2_req = router_3_3_req_out[South];
  assign router_3_3_to_router_2_3_req = router_3_3_req_out[West];

  assign router_3_3_rsp_in[East] = router_4_3_to_router_3_3_rsp;
  assign router_3_3_rsp_in[North] = hbm_north_ni_3_0_to_router_3_3_rsp;
  assign router_3_3_rsp_in[South] = router_3_2_to_router_3_3_rsp;
  assign router_3_3_rsp_in[West] = router_2_3_to_router_3_3_rsp;

  assign router_3_3_wide_in[East] = router_4_3_to_router_3_3_wide;
  assign router_3_3_wide_in[North] = hbm_north_ni_3_0_to_router_3_3_wide;
  assign router_3_3_wide_in[South] = router_3_2_to_router_3_3_wide;
  assign router_3_3_wide_in[West] = router_2_3_to_router_3_3_wide;

  assign router_3_3_to_router_4_3_wide = router_3_3_wide_out[East];
  assign router_3_3_to_hbm_north_ni_3_0_wide = router_3_3_wide_out[North];
  assign router_3_3_to_router_3_2_wide = router_3_3_wide_out[South];
  assign router_3_3_to_router_2_3_wide = router_3_3_wide_out[West];

localparam id_t compute_tile_3_3_id = '{x: 4, y: 4};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(4),
  .id_y(4)
) 
`endif
 compute_tile_3_3 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd15),
  .meip_i (9'b0),
  .mtip_i (mtip_i[144:136]),
  .msip_i (msip_i[144:136]),
  .id_i (compute_tile_3_3_id),
  .floo_req_i (router_3_3_req_in),
  .floo_rsp_o (router_3_3_rsp_out),
  .floo_req_o (router_3_3_req_out),
  .floo_rsp_i (router_3_3_rsp_in),
  .floo_wide_i (router_3_3_wide_in),
  .floo_wide_o (router_3_3_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_4_0_req_in;
floo_rsp_t [West:North] router_4_0_rsp_out;
floo_req_t [West:North] router_4_0_req_out;
floo_rsp_t [West:North] router_4_0_rsp_in;
floo_wide_t [West:North] router_4_0_wide_in;
floo_wide_t [West:North] router_4_0_wide_out;

  assign router_4_0_req_in[East] = hbm_east_ni_0_0_to_router_4_0_req;
  assign router_4_0_req_in[North] = router_4_1_to_router_4_0_req;
  assign router_4_0_req_in[South] = hbm_south_ni_4_0_to_router_4_0_req;
  assign router_4_0_req_in[West] = router_3_0_to_router_4_0_req;

  assign router_4_0_to_hbm_east_ni_0_0_rsp = router_4_0_rsp_out[East];
  assign router_4_0_to_router_4_1_rsp = router_4_0_rsp_out[North];
  assign router_4_0_to_hbm_south_ni_4_0_rsp = router_4_0_rsp_out[South];
  assign router_4_0_to_router_3_0_rsp = router_4_0_rsp_out[West];

  assign router_4_0_to_hbm_east_ni_0_0_req = router_4_0_req_out[East];
  assign router_4_0_to_router_4_1_req = router_4_0_req_out[North];
  assign router_4_0_to_hbm_south_ni_4_0_req = router_4_0_req_out[South];
  assign router_4_0_to_router_3_0_req = router_4_0_req_out[West];

  assign router_4_0_rsp_in[East] = hbm_east_ni_0_0_to_router_4_0_rsp;
  assign router_4_0_rsp_in[North] = router_4_1_to_router_4_0_rsp;
  assign router_4_0_rsp_in[South] = hbm_south_ni_4_0_to_router_4_0_rsp;
  assign router_4_0_rsp_in[West] = router_3_0_to_router_4_0_rsp;

  assign router_4_0_wide_in[East] = hbm_east_ni_0_0_to_router_4_0_wide;
  assign router_4_0_wide_in[North] = router_4_1_to_router_4_0_wide;
  assign router_4_0_wide_in[South] = hbm_south_ni_4_0_to_router_4_0_wide;
  assign router_4_0_wide_in[West] = router_3_0_to_router_4_0_wide;

  assign router_4_0_to_hbm_east_ni_0_0_wide = router_4_0_wide_out[East];
  assign router_4_0_to_router_4_1_wide = router_4_0_wide_out[North];
  assign router_4_0_to_hbm_south_ni_4_0_wide = router_4_0_wide_out[South];
  assign router_4_0_to_router_3_0_wide = router_4_0_wide_out[West];

localparam id_t compute_tile_4_0_id = '{x: 5, y: 1};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(5),
  .id_y(1)
) 
`endif
 compute_tile_4_0 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd16),
  .meip_i (9'b0),
  .mtip_i (mtip_i[153:145]),
  .msip_i (msip_i[153:145]),
  .id_i (compute_tile_4_0_id),
  .floo_req_i (router_4_0_req_in),
  .floo_rsp_o (router_4_0_rsp_out),
  .floo_req_o (router_4_0_req_out),
  .floo_rsp_i (router_4_0_rsp_in),
  .floo_wide_i (router_4_0_wide_in),
  .floo_wide_o (router_4_0_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_4_1_req_in;
floo_rsp_t [West:North] router_4_1_rsp_out;
floo_req_t [West:North] router_4_1_req_out;
floo_rsp_t [West:North] router_4_1_rsp_in;
floo_wide_t [West:North] router_4_1_wide_in;
floo_wide_t [West:North] router_4_1_wide_out;

  assign router_4_1_req_in[East] = hbm_east_ni_0_1_to_router_4_1_req;
  assign router_4_1_req_in[North] = router_4_2_to_router_4_1_req;
  assign router_4_1_req_in[South] = router_4_0_to_router_4_1_req;
  assign router_4_1_req_in[West] = router_3_1_to_router_4_1_req;

  assign router_4_1_to_hbm_east_ni_0_1_rsp = router_4_1_rsp_out[East];
  assign router_4_1_to_router_4_2_rsp = router_4_1_rsp_out[North];
  assign router_4_1_to_router_4_0_rsp = router_4_1_rsp_out[South];
  assign router_4_1_to_router_3_1_rsp = router_4_1_rsp_out[West];

  assign router_4_1_to_hbm_east_ni_0_1_req = router_4_1_req_out[East];
  assign router_4_1_to_router_4_2_req = router_4_1_req_out[North];
  assign router_4_1_to_router_4_0_req = router_4_1_req_out[South];
  assign router_4_1_to_router_3_1_req = router_4_1_req_out[West];

  assign router_4_1_rsp_in[East] = hbm_east_ni_0_1_to_router_4_1_rsp;
  assign router_4_1_rsp_in[North] = router_4_2_to_router_4_1_rsp;
  assign router_4_1_rsp_in[South] = router_4_0_to_router_4_1_rsp;
  assign router_4_1_rsp_in[West] = router_3_1_to_router_4_1_rsp;

  assign router_4_1_wide_in[East] = hbm_east_ni_0_1_to_router_4_1_wide;
  assign router_4_1_wide_in[North] = router_4_2_to_router_4_1_wide;
  assign router_4_1_wide_in[South] = router_4_0_to_router_4_1_wide;
  assign router_4_1_wide_in[West] = router_3_1_to_router_4_1_wide;

  assign router_4_1_to_hbm_east_ni_0_1_wide = router_4_1_wide_out[East];
  assign router_4_1_to_router_4_2_wide = router_4_1_wide_out[North];
  assign router_4_1_to_router_4_0_wide = router_4_1_wide_out[South];
  assign router_4_1_to_router_3_1_wide = router_4_1_wide_out[West];

localparam id_t compute_tile_4_1_id = '{x: 5, y: 2};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(5),
  .id_y(2)
) 
`endif
 compute_tile_4_1 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd17),
  .meip_i (9'b0),
  .mtip_i (mtip_i[162:154]),
  .msip_i (msip_i[162:154]),
  .id_i (compute_tile_4_1_id),
  .floo_req_i (router_4_1_req_in),
  .floo_rsp_o (router_4_1_rsp_out),
  .floo_req_o (router_4_1_req_out),
  .floo_rsp_i (router_4_1_rsp_in),
  .floo_wide_i (router_4_1_wide_in),
  .floo_wide_o (router_4_1_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_4_2_req_in;
floo_rsp_t [West:North] router_4_2_rsp_out;
floo_req_t [West:North] router_4_2_req_out;
floo_rsp_t [West:North] router_4_2_rsp_in;
floo_wide_t [West:North] router_4_2_wide_in;
floo_wide_t [West:North] router_4_2_wide_out;

  assign router_4_2_req_in[East] = hbm_east_ni_0_2_to_router_4_2_req;
  assign router_4_2_req_in[North] = router_4_3_to_router_4_2_req;
  assign router_4_2_req_in[South] = router_4_1_to_router_4_2_req;
  assign router_4_2_req_in[West] = router_3_2_to_router_4_2_req;

  assign router_4_2_to_hbm_east_ni_0_2_rsp = router_4_2_rsp_out[East];
  assign router_4_2_to_router_4_3_rsp = router_4_2_rsp_out[North];
  assign router_4_2_to_router_4_1_rsp = router_4_2_rsp_out[South];
  assign router_4_2_to_router_3_2_rsp = router_4_2_rsp_out[West];

  assign router_4_2_to_hbm_east_ni_0_2_req = router_4_2_req_out[East];
  assign router_4_2_to_router_4_3_req = router_4_2_req_out[North];
  assign router_4_2_to_router_4_1_req = router_4_2_req_out[South];
  assign router_4_2_to_router_3_2_req = router_4_2_req_out[West];

  assign router_4_2_rsp_in[East] = hbm_east_ni_0_2_to_router_4_2_rsp;
  assign router_4_2_rsp_in[North] = router_4_3_to_router_4_2_rsp;
  assign router_4_2_rsp_in[South] = router_4_1_to_router_4_2_rsp;
  assign router_4_2_rsp_in[West] = router_3_2_to_router_4_2_rsp;

  assign router_4_2_wide_in[East] = hbm_east_ni_0_2_to_router_4_2_wide;
  assign router_4_2_wide_in[North] = router_4_3_to_router_4_2_wide;
  assign router_4_2_wide_in[South] = router_4_1_to_router_4_2_wide;
  assign router_4_2_wide_in[West] = router_3_2_to_router_4_2_wide;

  assign router_4_2_to_hbm_east_ni_0_2_wide = router_4_2_wide_out[East];
  assign router_4_2_to_router_4_3_wide = router_4_2_wide_out[North];
  assign router_4_2_to_router_4_1_wide = router_4_2_wide_out[South];
  assign router_4_2_to_router_3_2_wide = router_4_2_wide_out[West];

localparam id_t compute_tile_4_2_id = '{x: 5, y: 3};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(5),
  .id_y(3)
) 
`endif
 compute_tile_4_2 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd18),
  .meip_i (9'b0),
  .mtip_i (mtip_i[171:163]),
  .msip_i (msip_i[171:163]),
  .id_i (compute_tile_4_2_id),
  .floo_req_i (router_4_2_req_in),
  .floo_rsp_o (router_4_2_rsp_out),
  .floo_req_o (router_4_2_req_out),
  .floo_rsp_i (router_4_2_rsp_in),
  .floo_wide_i (router_4_2_wide_in),
  .floo_wide_o (router_4_2_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_4_3_req_in;
floo_rsp_t [West:North] router_4_3_rsp_out;
floo_req_t [West:North] router_4_3_req_out;
floo_rsp_t [West:North] router_4_3_rsp_in;
floo_wide_t [West:North] router_4_3_wide_in;
floo_wide_t [West:North] router_4_3_wide_out;

  assign router_4_3_req_in[East] = hbm_east_ni_0_3_to_router_4_3_req;
  assign router_4_3_req_in[North] = hbm_north_ni_4_0_to_router_4_3_req;
  assign router_4_3_req_in[South] = router_4_2_to_router_4_3_req;
  assign router_4_3_req_in[West] = router_3_3_to_router_4_3_req;

  assign router_4_3_to_hbm_east_ni_0_3_rsp = router_4_3_rsp_out[East];
  assign router_4_3_to_hbm_north_ni_4_0_rsp = router_4_3_rsp_out[North];
  assign router_4_3_to_router_4_2_rsp = router_4_3_rsp_out[South];
  assign router_4_3_to_router_3_3_rsp = router_4_3_rsp_out[West];

  assign router_4_3_to_hbm_east_ni_0_3_req = router_4_3_req_out[East];
  assign router_4_3_to_hbm_north_ni_4_0_req = router_4_3_req_out[North];
  assign router_4_3_to_router_4_2_req = router_4_3_req_out[South];
  assign router_4_3_to_router_3_3_req = router_4_3_req_out[West];

  assign router_4_3_rsp_in[East] = hbm_east_ni_0_3_to_router_4_3_rsp;
  assign router_4_3_rsp_in[North] = hbm_north_ni_4_0_to_router_4_3_rsp;
  assign router_4_3_rsp_in[South] = router_4_2_to_router_4_3_rsp;
  assign router_4_3_rsp_in[West] = router_3_3_to_router_4_3_rsp;

  assign router_4_3_wide_in[East] = hbm_east_ni_0_3_to_router_4_3_wide;
  assign router_4_3_wide_in[North] = hbm_north_ni_4_0_to_router_4_3_wide;
  assign router_4_3_wide_in[South] = router_4_2_to_router_4_3_wide;
  assign router_4_3_wide_in[West] = router_3_3_to_router_4_3_wide;

  assign router_4_3_to_hbm_east_ni_0_3_wide = router_4_3_wide_out[East];
  assign router_4_3_to_hbm_north_ni_4_0_wide = router_4_3_wide_out[North];
  assign router_4_3_to_router_4_2_wide = router_4_3_wide_out[South];
  assign router_4_3_to_router_3_3_wide = router_4_3_wide_out[West];

localparam id_t compute_tile_4_3_id = '{x: 5, y: 4};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(5),
  .id_y(4)
) 
`endif
 compute_tile_4_3 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd19),
  .meip_i (9'b0),
  .mtip_i (mtip_i[180:172]),
  .msip_i (msip_i[180:172]),
  .id_i (compute_tile_4_3_id),
  .floo_req_i (router_4_3_req_in),
  .floo_rsp_o (router_4_3_rsp_out),
  .floo_req_o (router_4_3_req_out),
  .floo_rsp_i (router_4_3_rsp_in),
  .floo_wide_i (router_4_3_wide_in),
  .floo_wide_o (router_4_3_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);



endmodule
