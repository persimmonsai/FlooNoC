// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

// AUTOMATICALLY GENERATED! DO NOT EDIT!

module chiplet_floo_noc
  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;
  import hbm_pd_pkg::*;
(
  input logic clk_i,
  input logic rst_ni,
  input logic test_enable_i,

  input logic [408:1] mtip_i,
  input logic [408:1] msip_i,

  output axi_narrow_out_req_t              hbm_north_dram_0_narrow_req_o,
  input axi_narrow_out_rsp_t              hbm_north_dram_0_narrow_rsp_i,
  output axi_wide_out_req_t              hbm_north_dram_0_wide_req_o,
  input axi_wide_out_rsp_t              hbm_north_dram_0_wide_rsp_i,
  output axi_narrow_out_req_t              hbm_north_dram_1_narrow_req_o,
  input axi_narrow_out_rsp_t              hbm_north_dram_1_narrow_rsp_i,
  output axi_wide_out_req_t              hbm_north_dram_1_wide_req_o,
  input axi_wide_out_rsp_t              hbm_north_dram_1_wide_rsp_i,
  output axi_narrow_out_req_t              hbm_north_2_narrow_req_o,
  input axi_narrow_out_rsp_t              hbm_north_2_narrow_rsp_i,
  output axi_wide_out_req_t              hbm_north_2_wide_req_o,
  input axi_wide_out_rsp_t              hbm_north_2_wide_rsp_i,
  output axi_narrow_out_req_t              hbm_north_3_narrow_req_o,
  input axi_narrow_out_rsp_t              hbm_north_3_narrow_rsp_i,
  output axi_wide_out_req_t              hbm_north_3_wide_req_o,
  input axi_wide_out_rsp_t              hbm_north_3_wide_rsp_i,
  output axi_narrow_out_req_t             [1:0] hbm_south_0_narrow_req_o,
  input axi_narrow_out_rsp_t             [1:0] hbm_south_0_narrow_rsp_i,
  output axi_wide_out_req_t             [1:0] hbm_south_0_wide_req_o,
  input axi_wide_out_rsp_t             [1:0] hbm_south_0_wide_rsp_i,
  output axi_narrow_out_req_t             [1:0] hbm_south_2_narrow_req_o,
  input axi_narrow_out_rsp_t             [1:0] hbm_south_2_narrow_rsp_i,
  output axi_wide_out_req_t             [1:0] hbm_south_2_wide_req_o,
  input axi_wide_out_rsp_t             [1:0] hbm_south_2_wide_rsp_i,
  output axi_narrow_out_req_t             [3:0] hbm_west_narrow_req_o,
  input axi_narrow_out_rsp_t             [3:0] hbm_west_narrow_rsp_i,
  output axi_wide_out_req_t             [3:0] hbm_west_wide_req_o,
  input axi_wide_out_rsp_t             [3:0] hbm_west_wide_rsp_i,
  output axi_narrow_out_req_t             [3:0] hbm_east_narrow_req_o,
  input axi_narrow_out_rsp_t             [3:0] hbm_east_narrow_rsp_i,
  output axi_wide_out_req_t             [3:0] hbm_east_wide_req_o,
  input axi_wide_out_rsp_t             [3:0] hbm_east_wide_rsp_i,
  input axi_narrow_in_req_t              idma_narrow_req_i,
  output axi_narrow_in_rsp_t              idma_narrow_rsp_o,
  input axi_wide_in_req_t              idma_wide_req_i,
  output axi_wide_in_rsp_t              idma_wide_rsp_o,
  output axi_narrow_out_req_t              idma_narrow_req_o,
  input axi_narrow_out_rsp_t              idma_narrow_rsp_i,
  output axi_wide_out_req_t              idma_wide_req_o,
  input axi_wide_out_rsp_t              idma_wide_rsp_i,
  output axi_narrow_out_req_t              spm_narrow_req_o,
  input axi_narrow_out_rsp_t              spm_narrow_rsp_i,
  output axi_wide_out_req_t              spm_wide_req_o,
  input axi_wide_out_rsp_t              spm_wide_rsp_i,
  input axi_narrow_in_req_t              cva6_narrow_req_i,
  output axi_narrow_in_rsp_t              cva6_narrow_rsp_o,
  output axi_narrow_out_req_t              cva6_narrow_req_o,
  input axi_narrow_out_rsp_t              cva6_narrow_rsp_i,
  output axi_narrow_out_req_t              peripherals_narrow_req_o,
  input axi_narrow_out_rsp_t              peripherals_narrow_rsp_i,
  output axi_wide_out_req_t              peripherals_wide_req_o,
  input axi_wide_out_rsp_t              peripherals_wide_rsp_i,
  input axi_narrow_in_req_t              jtag_narrow_req_i,
  output axi_narrow_in_rsp_t              jtag_narrow_rsp_o,
  output axi_narrow_out_req_t              jtag_narrow_req_o,
  input axi_narrow_out_rsp_t              jtag_narrow_rsp_i,
  output axi_wide_out_req_t              zero_mem_wide_req_o,
  input axi_wide_out_rsp_t              zero_mem_wide_rsp_i

);

floo_req_t router_0_0_to_router_0_1_req;
floo_rsp_t router_0_1_to_router_0_0_rsp;
floo_wide_t router_0_0_to_router_0_1_wide;

floo_req_t router_0_0_to_router_1_0_req;
floo_rsp_t router_1_0_to_router_0_0_rsp;
floo_wide_t router_0_0_to_router_1_0_wide;

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

floo_req_t router_1_0_to_hbm_south_0_ni_0_0_req;
floo_rsp_t hbm_south_0_ni_0_0_to_router_1_0_rsp;
floo_wide_t router_1_0_to_hbm_south_0_ni_0_0_wide;

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

floo_req_t router_1_3_to_hbm_north_2_ni_req;
floo_rsp_t hbm_north_2_ni_to_router_1_3_rsp;
floo_wide_t router_1_3_to_hbm_north_2_ni_wide;

floo_req_t router_2_0_to_router_1_0_req;
floo_rsp_t router_1_0_to_router_2_0_rsp;
floo_wide_t router_2_0_to_router_1_0_wide;

floo_req_t router_2_0_to_router_2_1_req;
floo_rsp_t router_2_1_to_router_2_0_rsp;
floo_wide_t router_2_0_to_router_2_1_wide;

floo_req_t router_2_0_to_router_3_0_req;
floo_rsp_t router_3_0_to_router_2_0_rsp;
floo_wide_t router_2_0_to_router_3_0_wide;

floo_req_t router_2_0_to_hbm_south_0_ni_1_0_req;
floo_rsp_t hbm_south_0_ni_1_0_to_router_2_0_rsp;
floo_wide_t router_2_0_to_hbm_south_0_ni_1_0_wide;

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

floo_req_t router_2_3_to_hbm_north_dram_0_ni_req;
floo_rsp_t hbm_north_dram_0_ni_to_router_2_3_rsp;
floo_wide_t router_2_3_to_hbm_north_dram_0_ni_wide;

floo_req_t router_3_0_to_router_2_0_req;
floo_rsp_t router_2_0_to_router_3_0_rsp;
floo_wide_t router_3_0_to_router_2_0_wide;

floo_req_t router_3_0_to_router_3_1_req;
floo_rsp_t router_3_1_to_router_3_0_rsp;
floo_wide_t router_3_0_to_router_3_1_wide;

floo_req_t router_3_0_to_router_4_0_req;
floo_rsp_t router_4_0_to_router_3_0_rsp;
floo_wide_t router_3_0_to_router_4_0_wide;

floo_req_t router_3_0_to_jtag_ni_req;
floo_rsp_t jtag_ni_to_router_3_0_rsp;
floo_wide_t router_3_0_to_jtag_ni_wide;

floo_req_t router_3_0_to_zero_mem_ni_req;
floo_rsp_t zero_mem_ni_to_router_3_0_rsp;
floo_wide_t router_3_0_to_zero_mem_ni_wide;

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

floo_req_t router_3_1_to_peripherals_ni_req;
floo_rsp_t peripherals_ni_to_router_3_1_rsp;
floo_wide_t router_3_1_to_peripherals_ni_wide;

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

floo_req_t router_3_2_to_cva6_ni_req;
floo_rsp_t cva6_ni_to_router_3_2_rsp;
floo_wide_t router_3_2_to_cva6_ni_wide;

floo_req_t router_3_3_to_router_2_3_req;
floo_rsp_t router_2_3_to_router_3_3_rsp;
floo_wide_t router_3_3_to_router_2_3_wide;

floo_req_t router_3_3_to_router_3_2_req;
floo_rsp_t router_3_2_to_router_3_3_rsp;
floo_wide_t router_3_3_to_router_3_2_wide;

floo_req_t router_3_3_to_router_4_3_req;
floo_rsp_t router_4_3_to_router_3_3_rsp;
floo_wide_t router_3_3_to_router_4_3_wide;

floo_req_t router_3_3_to_idma_ni_req;
floo_rsp_t idma_ni_to_router_3_3_rsp;
floo_wide_t router_3_3_to_idma_ni_wide;

floo_req_t router_3_3_to_spm_ni_req;
floo_rsp_t spm_ni_to_router_3_3_rsp;
floo_wide_t router_3_3_to_spm_ni_wide;

floo_req_t router_4_0_to_router_3_0_req;
floo_rsp_t router_3_0_to_router_4_0_rsp;
floo_wide_t router_4_0_to_router_3_0_wide;

floo_req_t router_4_0_to_router_4_1_req;
floo_rsp_t router_4_1_to_router_4_0_rsp;
floo_wide_t router_4_0_to_router_4_1_wide;

floo_req_t router_4_0_to_router_5_0_req;
floo_rsp_t router_5_0_to_router_4_0_rsp;
floo_wide_t router_4_0_to_router_5_0_wide;

floo_req_t router_4_0_to_hbm_south_2_ni_0_0_req;
floo_rsp_t hbm_south_2_ni_0_0_to_router_4_0_rsp;
floo_wide_t router_4_0_to_hbm_south_2_ni_0_0_wide;

floo_req_t router_4_1_to_router_3_1_req;
floo_rsp_t router_3_1_to_router_4_1_rsp;
floo_wide_t router_4_1_to_router_3_1_wide;

floo_req_t router_4_1_to_router_4_0_req;
floo_rsp_t router_4_0_to_router_4_1_rsp;
floo_wide_t router_4_1_to_router_4_0_wide;

floo_req_t router_4_1_to_router_4_2_req;
floo_rsp_t router_4_2_to_router_4_1_rsp;
floo_wide_t router_4_1_to_router_4_2_wide;

floo_req_t router_4_1_to_router_5_1_req;
floo_rsp_t router_5_1_to_router_4_1_rsp;
floo_wide_t router_4_1_to_router_5_1_wide;

floo_req_t router_4_2_to_router_3_2_req;
floo_rsp_t router_3_2_to_router_4_2_rsp;
floo_wide_t router_4_2_to_router_3_2_wide;

floo_req_t router_4_2_to_router_4_1_req;
floo_rsp_t router_4_1_to_router_4_2_rsp;
floo_wide_t router_4_2_to_router_4_1_wide;

floo_req_t router_4_2_to_router_4_3_req;
floo_rsp_t router_4_3_to_router_4_2_rsp;
floo_wide_t router_4_2_to_router_4_3_wide;

floo_req_t router_4_2_to_router_5_2_req;
floo_rsp_t router_5_2_to_router_4_2_rsp;
floo_wide_t router_4_2_to_router_5_2_wide;

floo_req_t router_4_3_to_router_3_3_req;
floo_rsp_t router_3_3_to_router_4_3_rsp;
floo_wide_t router_4_3_to_router_3_3_wide;

floo_req_t router_4_3_to_router_4_2_req;
floo_rsp_t router_4_2_to_router_4_3_rsp;
floo_wide_t router_4_3_to_router_4_2_wide;

floo_req_t router_4_3_to_router_5_3_req;
floo_rsp_t router_5_3_to_router_4_3_rsp;
floo_wide_t router_4_3_to_router_5_3_wide;

floo_req_t router_4_3_to_hbm_north_dram_1_ni_req;
floo_rsp_t hbm_north_dram_1_ni_to_router_4_3_rsp;
floo_wide_t router_4_3_to_hbm_north_dram_1_ni_wide;

floo_req_t router_5_0_to_router_4_0_req;
floo_rsp_t router_4_0_to_router_5_0_rsp;
floo_wide_t router_5_0_to_router_4_0_wide;

floo_req_t router_5_0_to_router_5_1_req;
floo_rsp_t router_5_1_to_router_5_0_rsp;
floo_wide_t router_5_0_to_router_5_1_wide;

floo_req_t router_5_0_to_router_6_0_req;
floo_rsp_t router_6_0_to_router_5_0_rsp;
floo_wide_t router_5_0_to_router_6_0_wide;

floo_req_t router_5_0_to_hbm_south_2_ni_1_0_req;
floo_rsp_t hbm_south_2_ni_1_0_to_router_5_0_rsp;
floo_wide_t router_5_0_to_hbm_south_2_ni_1_0_wide;

floo_req_t router_5_1_to_router_4_1_req;
floo_rsp_t router_4_1_to_router_5_1_rsp;
floo_wide_t router_5_1_to_router_4_1_wide;

floo_req_t router_5_1_to_router_5_0_req;
floo_rsp_t router_5_0_to_router_5_1_rsp;
floo_wide_t router_5_1_to_router_5_0_wide;

floo_req_t router_5_1_to_router_5_2_req;
floo_rsp_t router_5_2_to_router_5_1_rsp;
floo_wide_t router_5_1_to_router_5_2_wide;

floo_req_t router_5_1_to_router_6_1_req;
floo_rsp_t router_6_1_to_router_5_1_rsp;
floo_wide_t router_5_1_to_router_6_1_wide;

floo_req_t router_5_2_to_router_4_2_req;
floo_rsp_t router_4_2_to_router_5_2_rsp;
floo_wide_t router_5_2_to_router_4_2_wide;

floo_req_t router_5_2_to_router_5_1_req;
floo_rsp_t router_5_1_to_router_5_2_rsp;
floo_wide_t router_5_2_to_router_5_1_wide;

floo_req_t router_5_2_to_router_5_3_req;
floo_rsp_t router_5_3_to_router_5_2_rsp;
floo_wide_t router_5_2_to_router_5_3_wide;

floo_req_t router_5_2_to_router_6_2_req;
floo_rsp_t router_6_2_to_router_5_2_rsp;
floo_wide_t router_5_2_to_router_6_2_wide;

floo_req_t router_5_3_to_router_4_3_req;
floo_rsp_t router_4_3_to_router_5_3_rsp;
floo_wide_t router_5_3_to_router_4_3_wide;

floo_req_t router_5_3_to_router_5_2_req;
floo_rsp_t router_5_2_to_router_5_3_rsp;
floo_wide_t router_5_3_to_router_5_2_wide;

floo_req_t router_5_3_to_router_6_3_req;
floo_rsp_t router_6_3_to_router_5_3_rsp;
floo_wide_t router_5_3_to_router_6_3_wide;

floo_req_t router_5_3_to_hbm_north_3_ni_req;
floo_rsp_t hbm_north_3_ni_to_router_5_3_rsp;
floo_wide_t router_5_3_to_hbm_north_3_ni_wide;

floo_req_t router_6_0_to_router_5_0_req;
floo_rsp_t router_5_0_to_router_6_0_rsp;
floo_wide_t router_6_0_to_router_5_0_wide;

floo_req_t router_6_0_to_router_6_1_req;
floo_rsp_t router_6_1_to_router_6_0_rsp;
floo_wide_t router_6_0_to_router_6_1_wide;

floo_req_t router_6_0_to_hbm_east_ni_0_0_req;
floo_rsp_t hbm_east_ni_0_0_to_router_6_0_rsp;
floo_wide_t router_6_0_to_hbm_east_ni_0_0_wide;

floo_req_t router_6_1_to_router_5_1_req;
floo_rsp_t router_5_1_to_router_6_1_rsp;
floo_wide_t router_6_1_to_router_5_1_wide;

floo_req_t router_6_1_to_router_6_0_req;
floo_rsp_t router_6_0_to_router_6_1_rsp;
floo_wide_t router_6_1_to_router_6_0_wide;

floo_req_t router_6_1_to_router_6_2_req;
floo_rsp_t router_6_2_to_router_6_1_rsp;
floo_wide_t router_6_1_to_router_6_2_wide;

floo_req_t router_6_1_to_hbm_east_ni_0_1_req;
floo_rsp_t hbm_east_ni_0_1_to_router_6_1_rsp;
floo_wide_t router_6_1_to_hbm_east_ni_0_1_wide;

floo_req_t router_6_2_to_router_5_2_req;
floo_rsp_t router_5_2_to_router_6_2_rsp;
floo_wide_t router_6_2_to_router_5_2_wide;

floo_req_t router_6_2_to_router_6_1_req;
floo_rsp_t router_6_1_to_router_6_2_rsp;
floo_wide_t router_6_2_to_router_6_1_wide;

floo_req_t router_6_2_to_router_6_3_req;
floo_rsp_t router_6_3_to_router_6_2_rsp;
floo_wide_t router_6_2_to_router_6_3_wide;

floo_req_t router_6_2_to_hbm_east_ni_0_2_req;
floo_rsp_t hbm_east_ni_0_2_to_router_6_2_rsp;
floo_wide_t router_6_2_to_hbm_east_ni_0_2_wide;

floo_req_t router_6_3_to_router_5_3_req;
floo_rsp_t router_5_3_to_router_6_3_rsp;
floo_wide_t router_6_3_to_router_5_3_wide;

floo_req_t router_6_3_to_router_6_2_req;
floo_rsp_t router_6_2_to_router_6_3_rsp;
floo_wide_t router_6_3_to_router_6_2_wide;

floo_req_t router_6_3_to_hbm_east_ni_0_3_req;
floo_rsp_t hbm_east_ni_0_3_to_router_6_3_rsp;
floo_wide_t router_6_3_to_hbm_east_ni_0_3_wide;

floo_req_t hbm_north_dram_0_ni_to_router_2_3_req;
floo_rsp_t router_2_3_to_hbm_north_dram_0_ni_rsp;
floo_wide_t hbm_north_dram_0_ni_to_router_2_3_wide;

floo_req_t hbm_north_dram_1_ni_to_router_4_3_req;
floo_rsp_t router_4_3_to_hbm_north_dram_1_ni_rsp;
floo_wide_t hbm_north_dram_1_ni_to_router_4_3_wide;

floo_req_t hbm_north_2_ni_to_router_1_3_req;
floo_rsp_t router_1_3_to_hbm_north_2_ni_rsp;
floo_wide_t hbm_north_2_ni_to_router_1_3_wide;

floo_req_t hbm_north_3_ni_to_router_5_3_req;
floo_rsp_t router_5_3_to_hbm_north_3_ni_rsp;
floo_wide_t hbm_north_3_ni_to_router_5_3_wide;

floo_req_t hbm_south_0_ni_0_0_to_router_1_0_req;
floo_rsp_t router_1_0_to_hbm_south_0_ni_0_0_rsp;
floo_wide_t hbm_south_0_ni_0_0_to_router_1_0_wide;

floo_req_t hbm_south_0_ni_1_0_to_router_2_0_req;
floo_rsp_t router_2_0_to_hbm_south_0_ni_1_0_rsp;
floo_wide_t hbm_south_0_ni_1_0_to_router_2_0_wide;

floo_req_t hbm_south_2_ni_0_0_to_router_4_0_req;
floo_rsp_t router_4_0_to_hbm_south_2_ni_0_0_rsp;
floo_wide_t hbm_south_2_ni_0_0_to_router_4_0_wide;

floo_req_t hbm_south_2_ni_1_0_to_router_5_0_req;
floo_rsp_t router_5_0_to_hbm_south_2_ni_1_0_rsp;
floo_wide_t hbm_south_2_ni_1_0_to_router_5_0_wide;

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

floo_req_t hbm_east_ni_0_0_to_router_6_0_req;
floo_rsp_t router_6_0_to_hbm_east_ni_0_0_rsp;
floo_wide_t hbm_east_ni_0_0_to_router_6_0_wide;

floo_req_t hbm_east_ni_0_1_to_router_6_1_req;
floo_rsp_t router_6_1_to_hbm_east_ni_0_1_rsp;
floo_wide_t hbm_east_ni_0_1_to_router_6_1_wide;

floo_req_t hbm_east_ni_0_2_to_router_6_2_req;
floo_rsp_t router_6_2_to_hbm_east_ni_0_2_rsp;
floo_wide_t hbm_east_ni_0_2_to_router_6_2_wide;

floo_req_t hbm_east_ni_0_3_to_router_6_3_req;
floo_rsp_t router_6_3_to_hbm_east_ni_0_3_rsp;
floo_wide_t hbm_east_ni_0_3_to_router_6_3_wide;

floo_req_t idma_ni_to_router_3_3_req;
floo_rsp_t router_3_3_to_idma_ni_rsp;
floo_wide_t idma_ni_to_router_3_3_wide;

floo_req_t spm_ni_to_router_3_3_req;
floo_rsp_t router_3_3_to_spm_ni_rsp;
floo_wide_t spm_ni_to_router_3_3_wide;

floo_req_t cva6_ni_to_router_3_2_req;
floo_rsp_t router_3_2_to_cva6_ni_rsp;
floo_wide_t cva6_ni_to_router_3_2_wide;

floo_req_t peripherals_ni_to_router_3_1_req;
floo_rsp_t router_3_1_to_peripherals_ni_rsp;
floo_wide_t peripherals_ni_to_router_3_1_wide;

floo_req_t jtag_ni_to_router_3_0_req;
floo_rsp_t router_3_0_to_jtag_ni_rsp;
floo_wide_t jtag_ni_to_router_3_0_wide;

floo_req_t zero_mem_ni_to_router_3_0_req;
floo_rsp_t router_3_0_to_zero_mem_ni_rsp;
floo_wide_t zero_mem_ni_to_router_3_0_wide;



localparam id_t hbm_north_dram_0_ni_id = '{x: 3, y: 5};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_north_dram_0_ni (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_north_dram_0_narrow_req_o ),
  .axi_narrow_out_rsp_i ( hbm_north_dram_0_narrow_rsp_i ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_north_dram_0_wide_req_o ),
  .axi_wide_out_rsp_i ( hbm_north_dram_0_wide_rsp_i ),
  .id_i             ( hbm_north_dram_0_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_north_dram_0_ni_to_router_2_3_req   ),
  .floo_rsp_i       ( router_2_3_to_hbm_north_dram_0_ni_rsp   ),
  .floo_wide_o      ( hbm_north_dram_0_ni_to_router_2_3_wide  ),
  .floo_req_i       ( router_2_3_to_hbm_north_dram_0_ni_req   ),
  .floo_rsp_o       ( hbm_north_dram_0_ni_to_router_2_3_rsp   ),
  .floo_wide_i      ( router_2_3_to_hbm_north_dram_0_ni_wide  )
);

localparam id_t hbm_north_dram_1_ni_id = '{x: 5, y: 5};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_north_dram_1_ni (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_north_dram_1_narrow_req_o ),
  .axi_narrow_out_rsp_i ( hbm_north_dram_1_narrow_rsp_i ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_north_dram_1_wide_req_o ),
  .axi_wide_out_rsp_i ( hbm_north_dram_1_wide_rsp_i ),
  .id_i             ( hbm_north_dram_1_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_north_dram_1_ni_to_router_4_3_req   ),
  .floo_rsp_i       ( router_4_3_to_hbm_north_dram_1_ni_rsp   ),
  .floo_wide_o      ( hbm_north_dram_1_ni_to_router_4_3_wide  ),
  .floo_req_i       ( router_4_3_to_hbm_north_dram_1_ni_req   ),
  .floo_rsp_o       ( hbm_north_dram_1_ni_to_router_4_3_rsp   ),
  .floo_wide_i      ( router_4_3_to_hbm_north_dram_1_ni_wide  )
);

localparam id_t hbm_north_2_ni_id = '{x: 2, y: 5};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_north_2_ni (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_north_2_narrow_req_o ),
  .axi_narrow_out_rsp_i ( hbm_north_2_narrow_rsp_i ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_north_2_wide_req_o ),
  .axi_wide_out_rsp_i ( hbm_north_2_wide_rsp_i ),
  .id_i             ( hbm_north_2_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_north_2_ni_to_router_1_3_req   ),
  .floo_rsp_i       ( router_1_3_to_hbm_north_2_ni_rsp   ),
  .floo_wide_o      ( hbm_north_2_ni_to_router_1_3_wide  ),
  .floo_req_i       ( router_1_3_to_hbm_north_2_ni_req   ),
  .floo_rsp_o       ( hbm_north_2_ni_to_router_1_3_rsp   ),
  .floo_wide_i      ( router_1_3_to_hbm_north_2_ni_wide  )
);

localparam id_t hbm_north_3_ni_id = '{x: 6, y: 5};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_north_3_ni (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_north_3_narrow_req_o ),
  .axi_narrow_out_rsp_i ( hbm_north_3_narrow_rsp_i ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_north_3_wide_req_o ),
  .axi_wide_out_rsp_i ( hbm_north_3_wide_rsp_i ),
  .id_i             ( hbm_north_3_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_north_3_ni_to_router_5_3_req   ),
  .floo_rsp_i       ( router_5_3_to_hbm_north_3_ni_rsp   ),
  .floo_wide_o      ( hbm_north_3_ni_to_router_5_3_wide  ),
  .floo_req_i       ( router_5_3_to_hbm_north_3_ni_req   ),
  .floo_rsp_o       ( hbm_north_3_ni_to_router_5_3_rsp   ),
  .floo_wide_i      ( router_5_3_to_hbm_north_3_ni_wide  )
);

localparam id_t hbm_south_0_ni_0_0_id = '{x: 2, y: 0};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_south_0_ni_0_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_south_0_narrow_req_o[0] ),
  .axi_narrow_out_rsp_i ( hbm_south_0_narrow_rsp_i[0] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_south_0_wide_req_o[0] ),
  .axi_wide_out_rsp_i ( hbm_south_0_wide_rsp_i[0] ),
  .id_i             ( hbm_south_0_ni_0_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_south_0_ni_0_0_to_router_1_0_req   ),
  .floo_rsp_i       ( router_1_0_to_hbm_south_0_ni_0_0_rsp   ),
  .floo_wide_o      ( hbm_south_0_ni_0_0_to_router_1_0_wide  ),
  .floo_req_i       ( router_1_0_to_hbm_south_0_ni_0_0_req   ),
  .floo_rsp_o       ( hbm_south_0_ni_0_0_to_router_1_0_rsp   ),
  .floo_wide_i      ( router_1_0_to_hbm_south_0_ni_0_0_wide  )
);

localparam id_t hbm_south_0_ni_1_0_id = '{x: 3, y: 0};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_south_0_ni_1_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_south_0_narrow_req_o[1] ),
  .axi_narrow_out_rsp_i ( hbm_south_0_narrow_rsp_i[1] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_south_0_wide_req_o[1] ),
  .axi_wide_out_rsp_i ( hbm_south_0_wide_rsp_i[1] ),
  .id_i             ( hbm_south_0_ni_1_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_south_0_ni_1_0_to_router_2_0_req   ),
  .floo_rsp_i       ( router_2_0_to_hbm_south_0_ni_1_0_rsp   ),
  .floo_wide_o      ( hbm_south_0_ni_1_0_to_router_2_0_wide  ),
  .floo_req_i       ( router_2_0_to_hbm_south_0_ni_1_0_req   ),
  .floo_rsp_o       ( hbm_south_0_ni_1_0_to_router_2_0_rsp   ),
  .floo_wide_i      ( router_2_0_to_hbm_south_0_ni_1_0_wide  )
);

localparam id_t hbm_south_2_ni_0_0_id = '{x: 5, y: 0};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_south_2_ni_0_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_south_2_narrow_req_o[0] ),
  .axi_narrow_out_rsp_i ( hbm_south_2_narrow_rsp_i[0] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_south_2_wide_req_o[0] ),
  .axi_wide_out_rsp_i ( hbm_south_2_wide_rsp_i[0] ),
  .id_i             ( hbm_south_2_ni_0_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_south_2_ni_0_0_to_router_4_0_req   ),
  .floo_rsp_i       ( router_4_0_to_hbm_south_2_ni_0_0_rsp   ),
  .floo_wide_o      ( hbm_south_2_ni_0_0_to_router_4_0_wide  ),
  .floo_req_i       ( router_4_0_to_hbm_south_2_ni_0_0_req   ),
  .floo_rsp_o       ( hbm_south_2_ni_0_0_to_router_4_0_rsp   ),
  .floo_wide_i      ( router_4_0_to_hbm_south_2_ni_0_0_wide  )
);

localparam id_t hbm_south_2_ni_1_0_id = '{x: 6, y: 0};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_south_2_ni_1_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_south_2_narrow_req_o[1] ),
  .axi_narrow_out_rsp_i ( hbm_south_2_narrow_rsp_i[1] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_south_2_wide_req_o[1] ),
  .axi_wide_out_rsp_i ( hbm_south_2_wide_rsp_i[1] ),
  .id_i             ( hbm_south_2_ni_1_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_south_2_ni_1_0_to_router_5_0_req   ),
  .floo_rsp_i       ( router_5_0_to_hbm_south_2_ni_1_0_rsp   ),
  .floo_wide_o      ( hbm_south_2_ni_1_0_to_router_5_0_wide  ),
  .floo_req_i       ( router_5_0_to_hbm_south_2_ni_1_0_req   ),
  .floo_rsp_o       ( hbm_south_2_ni_1_0_to_router_5_0_rsp   ),
  .floo_wide_i      ( router_5_0_to_hbm_south_2_ni_1_0_wide  )
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

localparam id_t hbm_east_ni_0_0_id = '{x: 8, y: 1};


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
  .floo_req_o       ( hbm_east_ni_0_0_to_router_6_0_req   ),
  .floo_rsp_i       ( router_6_0_to_hbm_east_ni_0_0_rsp   ),
  .floo_wide_o      ( hbm_east_ni_0_0_to_router_6_0_wide  ),
  .floo_req_i       ( router_6_0_to_hbm_east_ni_0_0_req   ),
  .floo_rsp_o       ( hbm_east_ni_0_0_to_router_6_0_rsp   ),
  .floo_wide_i      ( router_6_0_to_hbm_east_ni_0_0_wide  )
);

localparam id_t hbm_east_ni_0_1_id = '{x: 8, y: 2};


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
  .floo_req_o       ( hbm_east_ni_0_1_to_router_6_1_req   ),
  .floo_rsp_i       ( router_6_1_to_hbm_east_ni_0_1_rsp   ),
  .floo_wide_o      ( hbm_east_ni_0_1_to_router_6_1_wide  ),
  .floo_req_i       ( router_6_1_to_hbm_east_ni_0_1_req   ),
  .floo_rsp_o       ( hbm_east_ni_0_1_to_router_6_1_rsp   ),
  .floo_wide_i      ( router_6_1_to_hbm_east_ni_0_1_wide  )
);

localparam id_t hbm_east_ni_0_2_id = '{x: 8, y: 3};


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
  .floo_req_o       ( hbm_east_ni_0_2_to_router_6_2_req   ),
  .floo_rsp_i       ( router_6_2_to_hbm_east_ni_0_2_rsp   ),
  .floo_wide_o      ( hbm_east_ni_0_2_to_router_6_2_wide  ),
  .floo_req_i       ( router_6_2_to_hbm_east_ni_0_2_req   ),
  .floo_rsp_o       ( hbm_east_ni_0_2_to_router_6_2_rsp   ),
  .floo_wide_i      ( router_6_2_to_hbm_east_ni_0_2_wide  )
);

localparam id_t hbm_east_ni_0_3_id = '{x: 8, y: 4};


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
  .floo_req_o       ( hbm_east_ni_0_3_to_router_6_3_req   ),
  .floo_rsp_i       ( router_6_3_to_hbm_east_ni_0_3_rsp   ),
  .floo_wide_o      ( hbm_east_ni_0_3_to_router_6_3_wide  ),
  .floo_req_i       ( router_6_3_to_hbm_east_ni_0_3_req   ),
  .floo_rsp_o       ( hbm_east_ni_0_3_to_router_6_3_rsp   ),
  .floo_wide_i      ( router_6_3_to_hbm_east_ni_0_3_wide  )
);

localparam id_t idma_ni_id = '{x: 4, y: 5};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b1),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b1)
) idma_ni (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( idma_narrow_req_i ),
  .axi_narrow_in_rsp_o  ( idma_narrow_rsp_o ),
  .axi_narrow_out_req_o ( idma_narrow_req_o ),
  .axi_narrow_out_rsp_i ( idma_narrow_rsp_i ),
  .axi_wide_in_req_i  ( idma_wide_req_i ),
  .axi_wide_in_rsp_o  ( idma_wide_rsp_o ),
  .axi_wide_out_req_o ( idma_wide_req_o ),
  .axi_wide_out_rsp_i ( idma_wide_rsp_i ),
  .id_i             ( idma_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( idma_ni_to_router_3_3_req   ),
  .floo_rsp_i       ( router_3_3_to_idma_ni_rsp   ),
  .floo_wide_o      ( idma_ni_to_router_3_3_wide  ),
  .floo_req_i       ( router_3_3_to_idma_ni_req   ),
  .floo_rsp_o       ( idma_ni_to_router_3_3_rsp   ),
  .floo_wide_i      ( router_3_3_to_idma_ni_wide  )
);

localparam id_t spm_ni_id = '{x: 4, y: 4};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) spm_ni (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( spm_narrow_req_o ),
  .axi_narrow_out_rsp_i ( spm_narrow_rsp_i ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( spm_wide_req_o ),
  .axi_wide_out_rsp_i ( spm_wide_rsp_i ),
  .id_i             ( spm_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( spm_ni_to_router_3_3_req   ),
  .floo_rsp_i       ( router_3_3_to_spm_ni_rsp   ),
  .floo_wide_o      ( spm_ni_to_router_3_3_wide  ),
  .floo_req_i       ( router_3_3_to_spm_ni_req   ),
  .floo_rsp_o       ( spm_ni_to_router_3_3_rsp   ),
  .floo_wide_i      ( router_3_3_to_spm_ni_wide  )
);

localparam id_t cva6_ni_id = '{x: 4, y: 3};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b1),
  .EnWideSbrPort(1'b0),
  .EnWideMgrPort(1'b0)
) cva6_ni (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( cva6_narrow_req_i ),
  .axi_narrow_in_rsp_o  ( cva6_narrow_rsp_o ),
  .axi_narrow_out_req_o ( cva6_narrow_req_o ),
  .axi_narrow_out_rsp_i ( cva6_narrow_rsp_i ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o (    ),
  .axi_wide_out_rsp_i ( '0 ),
  .id_i             ( cva6_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( cva6_ni_to_router_3_2_req   ),
  .floo_rsp_i       ( router_3_2_to_cva6_ni_rsp   ),
  .floo_wide_o      ( cva6_ni_to_router_3_2_wide  ),
  .floo_req_i       ( router_3_2_to_cva6_ni_req   ),
  .floo_rsp_o       ( cva6_ni_to_router_3_2_rsp   ),
  .floo_wide_i      ( router_3_2_to_cva6_ni_wide  )
);

localparam id_t peripherals_ni_id = '{x: 4, y: 2};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) peripherals_ni (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( peripherals_narrow_req_o ),
  .axi_narrow_out_rsp_i ( peripherals_narrow_rsp_i ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( peripherals_wide_req_o ),
  .axi_wide_out_rsp_i ( peripherals_wide_rsp_i ),
  .id_i             ( peripherals_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( peripherals_ni_to_router_3_1_req   ),
  .floo_rsp_i       ( router_3_1_to_peripherals_ni_rsp   ),
  .floo_wide_o      ( peripherals_ni_to_router_3_1_wide  ),
  .floo_req_i       ( router_3_1_to_peripherals_ni_req   ),
  .floo_rsp_o       ( peripherals_ni_to_router_3_1_rsp   ),
  .floo_wide_i      ( router_3_1_to_peripherals_ni_wide  )
);

localparam id_t jtag_ni_id = '{x: 4, y: 1};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b1),
  .EnWideSbrPort(1'b0),
  .EnWideMgrPort(1'b0)
) jtag_ni (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( jtag_narrow_req_i ),
  .axi_narrow_in_rsp_o  ( jtag_narrow_rsp_o ),
  .axi_narrow_out_req_o ( jtag_narrow_req_o ),
  .axi_narrow_out_rsp_i ( jtag_narrow_rsp_i ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o (    ),
  .axi_wide_out_rsp_i ( '0 ),
  .id_i             ( jtag_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( jtag_ni_to_router_3_0_req   ),
  .floo_rsp_i       ( router_3_0_to_jtag_ni_rsp   ),
  .floo_wide_o      ( jtag_ni_to_router_3_0_wide  ),
  .floo_req_i       ( router_3_0_to_jtag_ni_req   ),
  .floo_rsp_o       ( jtag_ni_to_router_3_0_rsp   ),
  .floo_wide_i      ( router_3_0_to_jtag_ni_wide  )
);

localparam id_t zero_mem_ni_id = '{x: 4, y: 0};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b0),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) zero_mem_ni (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o (    ),
  .axi_narrow_out_rsp_i ( '0 ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( zero_mem_wide_req_o ),
  .axi_wide_out_rsp_i ( zero_mem_wide_rsp_i ),
  .id_i             ( zero_mem_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( zero_mem_ni_to_router_3_0_req   ),
  .floo_rsp_i       ( router_3_0_to_zero_mem_ni_rsp   ),
  .floo_wide_o      ( zero_mem_ni_to_router_3_0_wide  ),
  .floo_req_i       ( router_3_0_to_zero_mem_ni_req   ),
  .floo_rsp_o       ( zero_mem_ni_to_router_3_0_rsp   ),
  .floo_wide_i      ( router_3_0_to_zero_mem_ni_wide  )
);


floo_req_t [West:North] router_0_0_req_in;
floo_rsp_t [West:North] router_0_0_rsp_out;
floo_req_t [West:North] router_0_0_req_out;
floo_rsp_t [West:North] router_0_0_rsp_in;
floo_wide_t [West:North] router_0_0_wide_in;
floo_wide_t [West:North] router_0_0_wide_out;

  assign router_0_0_req_in[East] = router_1_0_to_router_0_0_req;
  assign router_0_0_req_in[North] = router_0_1_to_router_0_0_req;
  assign router_0_0_req_in[South] = '0;
  assign router_0_0_req_in[West] = hbm_west_ni_0_0_to_router_0_0_req;

  assign router_0_0_to_router_1_0_rsp = router_0_0_rsp_out[East];
  assign router_0_0_to_router_0_1_rsp = router_0_0_rsp_out[North];
  assign router_0_0_to_hbm_west_ni_0_0_rsp = router_0_0_rsp_out[West];

  assign router_0_0_to_router_1_0_req = router_0_0_req_out[East];
  assign router_0_0_to_router_0_1_req = router_0_0_req_out[North];
  assign router_0_0_to_hbm_west_ni_0_0_req = router_0_0_req_out[West];

  assign router_0_0_rsp_in[East] = router_1_0_to_router_0_0_rsp;
  assign router_0_0_rsp_in[North] = router_0_1_to_router_0_0_rsp;
  assign router_0_0_rsp_in[South] = '0;
  assign router_0_0_rsp_in[West] = hbm_west_ni_0_0_to_router_0_0_rsp;

  assign router_0_0_wide_in[East] = router_1_0_to_router_0_0_wide;
  assign router_0_0_wide_in[North] = router_0_1_to_router_0_0_wide;
  assign router_0_0_wide_in[South] = '0;
  assign router_0_0_wide_in[West] = hbm_west_ni_0_0_to_router_0_0_wide;

  assign router_0_0_to_router_1_0_wide = router_0_0_wide_out[East];
  assign router_0_0_to_router_0_1_wide = router_0_0_wide_out[North];
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
  .meip_i (17'b0),
  .mtip_i (mtip_i[17:1]),
  .msip_i (msip_i[17:1]),
  .id_i (compute_tile_0_0_id),
  .floo_req_i (router_0_0_req_in),
  .floo_rsp_o (router_0_0_rsp_out),
  .floo_req_o (router_0_0_req_out),
  .floo_rsp_i (router_0_0_rsp_in),
  .floo_wide_i (router_0_0_wide_in),
  .floo_wide_o (router_0_0_wide_out)
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
  .meip_i (17'b0),
  .mtip_i (mtip_i[34:18]),
  .msip_i (msip_i[34:18]),
  .id_i (compute_tile_0_1_id),
  .floo_req_i (router_0_1_req_in),
  .floo_rsp_o (router_0_1_rsp_out),
  .floo_req_o (router_0_1_req_out),
  .floo_rsp_i (router_0_1_rsp_in),
  .floo_wide_i (router_0_1_wide_in),
  .floo_wide_o (router_0_1_wide_out)
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
  .meip_i (17'b0),
  .mtip_i (mtip_i[51:35]),
  .msip_i (msip_i[51:35]),
  .id_i (compute_tile_0_2_id),
  .floo_req_i (router_0_2_req_in),
  .floo_rsp_o (router_0_2_rsp_out),
  .floo_req_o (router_0_2_req_out),
  .floo_rsp_i (router_0_2_rsp_in),
  .floo_wide_i (router_0_2_wide_in),
  .floo_wide_o (router_0_2_wide_out)
);


floo_req_t [West:North] router_0_3_req_in;
floo_rsp_t [West:North] router_0_3_rsp_out;
floo_req_t [West:North] router_0_3_req_out;
floo_rsp_t [West:North] router_0_3_rsp_in;
floo_wide_t [West:North] router_0_3_wide_in;
floo_wide_t [West:North] router_0_3_wide_out;

  assign router_0_3_req_in[East] = router_1_3_to_router_0_3_req;
  assign router_0_3_req_in[North] = '0;
  assign router_0_3_req_in[South] = router_0_2_to_router_0_3_req;
  assign router_0_3_req_in[West] = hbm_west_ni_0_3_to_router_0_3_req;

  assign router_0_3_to_router_1_3_rsp = router_0_3_rsp_out[East];
  assign router_0_3_to_router_0_2_rsp = router_0_3_rsp_out[South];
  assign router_0_3_to_hbm_west_ni_0_3_rsp = router_0_3_rsp_out[West];

  assign router_0_3_to_router_1_3_req = router_0_3_req_out[East];
  assign router_0_3_to_router_0_2_req = router_0_3_req_out[South];
  assign router_0_3_to_hbm_west_ni_0_3_req = router_0_3_req_out[West];

  assign router_0_3_rsp_in[East] = router_1_3_to_router_0_3_rsp;
  assign router_0_3_rsp_in[North] = '0;
  assign router_0_3_rsp_in[South] = router_0_2_to_router_0_3_rsp;
  assign router_0_3_rsp_in[West] = hbm_west_ni_0_3_to_router_0_3_rsp;

  assign router_0_3_wide_in[East] = router_1_3_to_router_0_3_wide;
  assign router_0_3_wide_in[North] = '0;
  assign router_0_3_wide_in[South] = router_0_2_to_router_0_3_wide;
  assign router_0_3_wide_in[West] = hbm_west_ni_0_3_to_router_0_3_wide;

  assign router_0_3_to_router_1_3_wide = router_0_3_wide_out[East];
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
  .meip_i (17'b0),
  .mtip_i (mtip_i[68:52]),
  .msip_i (msip_i[68:52]),
  .id_i (compute_tile_0_3_id),
  .floo_req_i (router_0_3_req_in),
  .floo_rsp_o (router_0_3_rsp_out),
  .floo_req_o (router_0_3_req_out),
  .floo_rsp_i (router_0_3_rsp_in),
  .floo_wide_i (router_0_3_wide_in),
  .floo_wide_o (router_0_3_wide_out)
);


floo_req_t [West:North] router_1_0_req_in;
floo_rsp_t [West:North] router_1_0_rsp_out;
floo_req_t [West:North] router_1_0_req_out;
floo_rsp_t [West:North] router_1_0_rsp_in;
floo_wide_t [West:North] router_1_0_wide_in;
floo_wide_t [West:North] router_1_0_wide_out;

  assign router_1_0_req_in[East] = router_2_0_to_router_1_0_req;
  assign router_1_0_req_in[North] = router_1_1_to_router_1_0_req;
  assign router_1_0_req_in[South] = hbm_south_0_ni_0_0_to_router_1_0_req;
  assign router_1_0_req_in[West] = router_0_0_to_router_1_0_req;

  assign router_1_0_to_router_2_0_rsp = router_1_0_rsp_out[East];
  assign router_1_0_to_router_1_1_rsp = router_1_0_rsp_out[North];
  assign router_1_0_to_hbm_south_0_ni_0_0_rsp = router_1_0_rsp_out[South];
  assign router_1_0_to_router_0_0_rsp = router_1_0_rsp_out[West];

  assign router_1_0_to_router_2_0_req = router_1_0_req_out[East];
  assign router_1_0_to_router_1_1_req = router_1_0_req_out[North];
  assign router_1_0_to_hbm_south_0_ni_0_0_req = router_1_0_req_out[South];
  assign router_1_0_to_router_0_0_req = router_1_0_req_out[West];

  assign router_1_0_rsp_in[East] = router_2_0_to_router_1_0_rsp;
  assign router_1_0_rsp_in[North] = router_1_1_to_router_1_0_rsp;
  assign router_1_0_rsp_in[South] = hbm_south_0_ni_0_0_to_router_1_0_rsp;
  assign router_1_0_rsp_in[West] = router_0_0_to_router_1_0_rsp;

  assign router_1_0_wide_in[East] = router_2_0_to_router_1_0_wide;
  assign router_1_0_wide_in[North] = router_1_1_to_router_1_0_wide;
  assign router_1_0_wide_in[South] = hbm_south_0_ni_0_0_to_router_1_0_wide;
  assign router_1_0_wide_in[West] = router_0_0_to_router_1_0_wide;

  assign router_1_0_to_router_2_0_wide = router_1_0_wide_out[East];
  assign router_1_0_to_router_1_1_wide = router_1_0_wide_out[North];
  assign router_1_0_to_hbm_south_0_ni_0_0_wide = router_1_0_wide_out[South];
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
  .meip_i (17'b0),
  .mtip_i (mtip_i[85:69]),
  .msip_i (msip_i[85:69]),
  .id_i (compute_tile_1_0_id),
  .floo_req_i (router_1_0_req_in),
  .floo_rsp_o (router_1_0_rsp_out),
  .floo_req_o (router_1_0_req_out),
  .floo_rsp_i (router_1_0_rsp_in),
  .floo_wide_i (router_1_0_wide_in),
  .floo_wide_o (router_1_0_wide_out)
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
  .meip_i (17'b0),
  .mtip_i (mtip_i[102:86]),
  .msip_i (msip_i[102:86]),
  .id_i (compute_tile_1_1_id),
  .floo_req_i (router_1_1_req_in),
  .floo_rsp_o (router_1_1_rsp_out),
  .floo_req_o (router_1_1_req_out),
  .floo_rsp_i (router_1_1_rsp_in),
  .floo_wide_i (router_1_1_wide_in),
  .floo_wide_o (router_1_1_wide_out)
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
  .meip_i (17'b0),
  .mtip_i (mtip_i[119:103]),
  .msip_i (msip_i[119:103]),
  .id_i (compute_tile_1_2_id),
  .floo_req_i (router_1_2_req_in),
  .floo_rsp_o (router_1_2_rsp_out),
  .floo_req_o (router_1_2_req_out),
  .floo_rsp_i (router_1_2_rsp_in),
  .floo_wide_i (router_1_2_wide_in),
  .floo_wide_o (router_1_2_wide_out)
);


floo_req_t [West:North] router_1_3_req_in;
floo_rsp_t [West:North] router_1_3_rsp_out;
floo_req_t [West:North] router_1_3_req_out;
floo_rsp_t [West:North] router_1_3_rsp_in;
floo_wide_t [West:North] router_1_3_wide_in;
floo_wide_t [West:North] router_1_3_wide_out;

  assign router_1_3_req_in[East] = router_2_3_to_router_1_3_req;
  assign router_1_3_req_in[North] = hbm_north_2_ni_to_router_1_3_req;
  assign router_1_3_req_in[South] = router_1_2_to_router_1_3_req;
  assign router_1_3_req_in[West] = router_0_3_to_router_1_3_req;

  assign router_1_3_to_router_2_3_rsp = router_1_3_rsp_out[East];
  assign router_1_3_to_hbm_north_2_ni_rsp = router_1_3_rsp_out[North];
  assign router_1_3_to_router_1_2_rsp = router_1_3_rsp_out[South];
  assign router_1_3_to_router_0_3_rsp = router_1_3_rsp_out[West];

  assign router_1_3_to_router_2_3_req = router_1_3_req_out[East];
  assign router_1_3_to_hbm_north_2_ni_req = router_1_3_req_out[North];
  assign router_1_3_to_router_1_2_req = router_1_3_req_out[South];
  assign router_1_3_to_router_0_3_req = router_1_3_req_out[West];

  assign router_1_3_rsp_in[East] = router_2_3_to_router_1_3_rsp;
  assign router_1_3_rsp_in[North] = hbm_north_2_ni_to_router_1_3_rsp;
  assign router_1_3_rsp_in[South] = router_1_2_to_router_1_3_rsp;
  assign router_1_3_rsp_in[West] = router_0_3_to_router_1_3_rsp;

  assign router_1_3_wide_in[East] = router_2_3_to_router_1_3_wide;
  assign router_1_3_wide_in[North] = hbm_north_2_ni_to_router_1_3_wide;
  assign router_1_3_wide_in[South] = router_1_2_to_router_1_3_wide;
  assign router_1_3_wide_in[West] = router_0_3_to_router_1_3_wide;

  assign router_1_3_to_router_2_3_wide = router_1_3_wide_out[East];
  assign router_1_3_to_hbm_north_2_ni_wide = router_1_3_wide_out[North];
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
  .meip_i (17'b0),
  .mtip_i (mtip_i[136:120]),
  .msip_i (msip_i[136:120]),
  .id_i (compute_tile_1_3_id),
  .floo_req_i (router_1_3_req_in),
  .floo_rsp_o (router_1_3_rsp_out),
  .floo_req_o (router_1_3_req_out),
  .floo_rsp_i (router_1_3_rsp_in),
  .floo_wide_i (router_1_3_wide_in),
  .floo_wide_o (router_1_3_wide_out)
);


floo_req_t [West:North] router_2_0_req_in;
floo_rsp_t [West:North] router_2_0_rsp_out;
floo_req_t [West:North] router_2_0_req_out;
floo_rsp_t [West:North] router_2_0_rsp_in;
floo_wide_t [West:North] router_2_0_wide_in;
floo_wide_t [West:North] router_2_0_wide_out;

  assign router_2_0_req_in[East] = router_3_0_to_router_2_0_req;
  assign router_2_0_req_in[North] = router_2_1_to_router_2_0_req;
  assign router_2_0_req_in[South] = hbm_south_0_ni_1_0_to_router_2_0_req;
  assign router_2_0_req_in[West] = router_1_0_to_router_2_0_req;

  assign router_2_0_to_router_3_0_rsp = router_2_0_rsp_out[East];
  assign router_2_0_to_router_2_1_rsp = router_2_0_rsp_out[North];
  assign router_2_0_to_hbm_south_0_ni_1_0_rsp = router_2_0_rsp_out[South];
  assign router_2_0_to_router_1_0_rsp = router_2_0_rsp_out[West];

  assign router_2_0_to_router_3_0_req = router_2_0_req_out[East];
  assign router_2_0_to_router_2_1_req = router_2_0_req_out[North];
  assign router_2_0_to_hbm_south_0_ni_1_0_req = router_2_0_req_out[South];
  assign router_2_0_to_router_1_0_req = router_2_0_req_out[West];

  assign router_2_0_rsp_in[East] = router_3_0_to_router_2_0_rsp;
  assign router_2_0_rsp_in[North] = router_2_1_to_router_2_0_rsp;
  assign router_2_0_rsp_in[South] = hbm_south_0_ni_1_0_to_router_2_0_rsp;
  assign router_2_0_rsp_in[West] = router_1_0_to_router_2_0_rsp;

  assign router_2_0_wide_in[East] = router_3_0_to_router_2_0_wide;
  assign router_2_0_wide_in[North] = router_2_1_to_router_2_0_wide;
  assign router_2_0_wide_in[South] = hbm_south_0_ni_1_0_to_router_2_0_wide;
  assign router_2_0_wide_in[West] = router_1_0_to_router_2_0_wide;

  assign router_2_0_to_router_3_0_wide = router_2_0_wide_out[East];
  assign router_2_0_to_router_2_1_wide = router_2_0_wide_out[North];
  assign router_2_0_to_hbm_south_0_ni_1_0_wide = router_2_0_wide_out[South];
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
  .meip_i (17'b0),
  .mtip_i (mtip_i[153:137]),
  .msip_i (msip_i[153:137]),
  .id_i (compute_tile_2_0_id),
  .floo_req_i (router_2_0_req_in),
  .floo_rsp_o (router_2_0_rsp_out),
  .floo_req_o (router_2_0_req_out),
  .floo_rsp_i (router_2_0_rsp_in),
  .floo_wide_i (router_2_0_wide_in),
  .floo_wide_o (router_2_0_wide_out)
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
  .meip_i (17'b0),
  .mtip_i (mtip_i[170:154]),
  .msip_i (msip_i[170:154]),
  .id_i (compute_tile_2_1_id),
  .floo_req_i (router_2_1_req_in),
  .floo_rsp_o (router_2_1_rsp_out),
  .floo_req_o (router_2_1_req_out),
  .floo_rsp_i (router_2_1_rsp_in),
  .floo_wide_i (router_2_1_wide_in),
  .floo_wide_o (router_2_1_wide_out)
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
  .meip_i (17'b0),
  .mtip_i (mtip_i[187:171]),
  .msip_i (msip_i[187:171]),
  .id_i (compute_tile_2_2_id),
  .floo_req_i (router_2_2_req_in),
  .floo_rsp_o (router_2_2_rsp_out),
  .floo_req_o (router_2_2_req_out),
  .floo_rsp_i (router_2_2_rsp_in),
  .floo_wide_i (router_2_2_wide_in),
  .floo_wide_o (router_2_2_wide_out)
);


floo_req_t [West:North] router_2_3_req_in;
floo_rsp_t [West:North] router_2_3_rsp_out;
floo_req_t [West:North] router_2_3_req_out;
floo_rsp_t [West:North] router_2_3_rsp_in;
floo_wide_t [West:North] router_2_3_wide_in;
floo_wide_t [West:North] router_2_3_wide_out;

  assign router_2_3_req_in[East] = router_3_3_to_router_2_3_req;
  assign router_2_3_req_in[North] = hbm_north_dram_0_ni_to_router_2_3_req;
  assign router_2_3_req_in[South] = router_2_2_to_router_2_3_req;
  assign router_2_3_req_in[West] = router_1_3_to_router_2_3_req;

  assign router_2_3_to_router_3_3_rsp = router_2_3_rsp_out[East];
  assign router_2_3_to_hbm_north_dram_0_ni_rsp = router_2_3_rsp_out[North];
  assign router_2_3_to_router_2_2_rsp = router_2_3_rsp_out[South];
  assign router_2_3_to_router_1_3_rsp = router_2_3_rsp_out[West];

  assign router_2_3_to_router_3_3_req = router_2_3_req_out[East];
  assign router_2_3_to_hbm_north_dram_0_ni_req = router_2_3_req_out[North];
  assign router_2_3_to_router_2_2_req = router_2_3_req_out[South];
  assign router_2_3_to_router_1_3_req = router_2_3_req_out[West];

  assign router_2_3_rsp_in[East] = router_3_3_to_router_2_3_rsp;
  assign router_2_3_rsp_in[North] = hbm_north_dram_0_ni_to_router_2_3_rsp;
  assign router_2_3_rsp_in[South] = router_2_2_to_router_2_3_rsp;
  assign router_2_3_rsp_in[West] = router_1_3_to_router_2_3_rsp;

  assign router_2_3_wide_in[East] = router_3_3_to_router_2_3_wide;
  assign router_2_3_wide_in[North] = hbm_north_dram_0_ni_to_router_2_3_wide;
  assign router_2_3_wide_in[South] = router_2_2_to_router_2_3_wide;
  assign router_2_3_wide_in[West] = router_1_3_to_router_2_3_wide;

  assign router_2_3_to_router_3_3_wide = router_2_3_wide_out[East];
  assign router_2_3_to_hbm_north_dram_0_ni_wide = router_2_3_wide_out[North];
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
  .meip_i (17'b0),
  .mtip_i (mtip_i[204:188]),
  .msip_i (msip_i[204:188]),
  .id_i (compute_tile_2_3_id),
  .floo_req_i (router_2_3_req_in),
  .floo_rsp_o (router_2_3_rsp_out),
  .floo_req_o (router_2_3_req_out),
  .floo_rsp_i (router_2_3_rsp_in),
  .floo_wide_i (router_2_3_wide_in),
  .floo_wide_o (router_2_3_wide_out)
);


floo_req_t [NumDirections-1:0] router_3_0_req_in;
floo_rsp_t [NumDirections-1:0] router_3_0_rsp_out;
floo_req_t [NumDirections-1:0] router_3_0_req_out;
floo_rsp_t [NumDirections-1:0] router_3_0_rsp_in;
floo_wide_t [NumDirections-1:0] router_3_0_wide_in;
floo_wide_t [NumDirections-1:0] router_3_0_wide_out;

  assign router_3_0_req_in[Eject] = jtag_ni_to_router_3_0_req;
  assign router_3_0_req_in[East] = router_4_0_to_router_3_0_req;
  assign router_3_0_req_in[North] = router_3_1_to_router_3_0_req;
  assign router_3_0_req_in[South] = zero_mem_ni_to_router_3_0_req;
  assign router_3_0_req_in[West] = router_2_0_to_router_3_0_req;

  assign router_3_0_to_jtag_ni_rsp = router_3_0_rsp_out[Eject];
  assign router_3_0_to_router_4_0_rsp = router_3_0_rsp_out[East];
  assign router_3_0_to_router_3_1_rsp = router_3_0_rsp_out[North];
  assign router_3_0_to_zero_mem_ni_rsp = router_3_0_rsp_out[South];
  assign router_3_0_to_router_2_0_rsp = router_3_0_rsp_out[West];

  assign router_3_0_to_jtag_ni_req = router_3_0_req_out[Eject];
  assign router_3_0_to_router_4_0_req = router_3_0_req_out[East];
  assign router_3_0_to_router_3_1_req = router_3_0_req_out[North];
  assign router_3_0_to_zero_mem_ni_req = router_3_0_req_out[South];
  assign router_3_0_to_router_2_0_req = router_3_0_req_out[West];

  assign router_3_0_rsp_in[Eject] = jtag_ni_to_router_3_0_rsp;
  assign router_3_0_rsp_in[East] = router_4_0_to_router_3_0_rsp;
  assign router_3_0_rsp_in[North] = router_3_1_to_router_3_0_rsp;
  assign router_3_0_rsp_in[South] = zero_mem_ni_to_router_3_0_rsp;
  assign router_3_0_rsp_in[West] = router_2_0_to_router_3_0_rsp;

  assign router_3_0_wide_in[Eject] = jtag_ni_to_router_3_0_wide;
  assign router_3_0_wide_in[East] = router_4_0_to_router_3_0_wide;
  assign router_3_0_wide_in[North] = router_3_1_to_router_3_0_wide;
  assign router_3_0_wide_in[South] = zero_mem_ni_to_router_3_0_wide;
  assign router_3_0_wide_in[West] = router_2_0_to_router_3_0_wide;

  assign router_3_0_to_jtag_ni_wide = router_3_0_wide_out[Eject];
  assign router_3_0_to_router_4_0_wide = router_3_0_wide_out[East];
  assign router_3_0_to_router_3_1_wide = router_3_0_wide_out[North];
  assign router_3_0_to_zero_mem_ni_wide = router_3_0_wide_out[South];
  assign router_3_0_to_router_2_0_wide = router_3_0_wide_out[West];

localparam id_t router_3_0_id = '{x: 4, y: 1};
floo_narrow_wide_router #(
  .NumRoutes (NumDirections),
  .ChannelFifoDepth (2),
  .OutputFifoDepth (2),
  .RouteAlgo (XYRouting),
  .XYRouteOpt(XYRouteOpt),
  .id_t(id_t),
  .border_id_t(floo_narrow_wide_pkg::border_id_t),
  .BorderId(floo_narrow_wide_pkg::BorderId)
) router_3_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .id_i (router_3_0_id),
  .id_route_map_i ('0),
  .floo_req_i (router_3_0_req_in),
  .floo_rsp_o (router_3_0_rsp_out),
  .floo_req_o (router_3_0_req_out),
  .floo_rsp_i (router_3_0_rsp_in),
  .floo_wide_i (router_3_0_wide_in),
  .floo_wide_o (router_3_0_wide_out)
);


floo_req_t [NumDirections-1:0] router_3_1_req_in;
floo_rsp_t [NumDirections-1:0] router_3_1_rsp_out;
floo_req_t [NumDirections-1:0] router_3_1_req_out;
floo_rsp_t [NumDirections-1:0] router_3_1_rsp_in;
floo_wide_t [NumDirections-1:0] router_3_1_wide_in;
floo_wide_t [NumDirections-1:0] router_3_1_wide_out;

  assign router_3_1_req_in[Eject] = peripherals_ni_to_router_3_1_req;
  assign router_3_1_req_in[East] = router_4_1_to_router_3_1_req;
  assign router_3_1_req_in[North] = router_3_2_to_router_3_1_req;
  assign router_3_1_req_in[South] = router_3_0_to_router_3_1_req;
  assign router_3_1_req_in[West] = router_2_1_to_router_3_1_req;

  assign router_3_1_to_peripherals_ni_rsp = router_3_1_rsp_out[Eject];
  assign router_3_1_to_router_4_1_rsp = router_3_1_rsp_out[East];
  assign router_3_1_to_router_3_2_rsp = router_3_1_rsp_out[North];
  assign router_3_1_to_router_3_0_rsp = router_3_1_rsp_out[South];
  assign router_3_1_to_router_2_1_rsp = router_3_1_rsp_out[West];

  assign router_3_1_to_peripherals_ni_req = router_3_1_req_out[Eject];
  assign router_3_1_to_router_4_1_req = router_3_1_req_out[East];
  assign router_3_1_to_router_3_2_req = router_3_1_req_out[North];
  assign router_3_1_to_router_3_0_req = router_3_1_req_out[South];
  assign router_3_1_to_router_2_1_req = router_3_1_req_out[West];

  assign router_3_1_rsp_in[Eject] = peripherals_ni_to_router_3_1_rsp;
  assign router_3_1_rsp_in[East] = router_4_1_to_router_3_1_rsp;
  assign router_3_1_rsp_in[North] = router_3_2_to_router_3_1_rsp;
  assign router_3_1_rsp_in[South] = router_3_0_to_router_3_1_rsp;
  assign router_3_1_rsp_in[West] = router_2_1_to_router_3_1_rsp;

  assign router_3_1_wide_in[Eject] = peripherals_ni_to_router_3_1_wide;
  assign router_3_1_wide_in[East] = router_4_1_to_router_3_1_wide;
  assign router_3_1_wide_in[North] = router_3_2_to_router_3_1_wide;
  assign router_3_1_wide_in[South] = router_3_0_to_router_3_1_wide;
  assign router_3_1_wide_in[West] = router_2_1_to_router_3_1_wide;

  assign router_3_1_to_peripherals_ni_wide = router_3_1_wide_out[Eject];
  assign router_3_1_to_router_4_1_wide = router_3_1_wide_out[East];
  assign router_3_1_to_router_3_2_wide = router_3_1_wide_out[North];
  assign router_3_1_to_router_3_0_wide = router_3_1_wide_out[South];
  assign router_3_1_to_router_2_1_wide = router_3_1_wide_out[West];

localparam id_t router_3_1_id = '{x: 4, y: 2};
floo_narrow_wide_router #(
  .NumRoutes (NumDirections),
  .ChannelFifoDepth (2),
  .OutputFifoDepth (2),
  .RouteAlgo (XYRouting),
  .XYRouteOpt(XYRouteOpt),
  .id_t(id_t),
  .border_id_t(floo_narrow_wide_pkg::border_id_t),
  .BorderId(floo_narrow_wide_pkg::BorderId)
) router_3_1 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .id_i (router_3_1_id),
  .id_route_map_i ('0),
  .floo_req_i (router_3_1_req_in),
  .floo_rsp_o (router_3_1_rsp_out),
  .floo_req_o (router_3_1_req_out),
  .floo_rsp_i (router_3_1_rsp_in),
  .floo_wide_i (router_3_1_wide_in),
  .floo_wide_o (router_3_1_wide_out)
);


floo_req_t [NumDirections-1:0] router_3_2_req_in;
floo_rsp_t [NumDirections-1:0] router_3_2_rsp_out;
floo_req_t [NumDirections-1:0] router_3_2_req_out;
floo_rsp_t [NumDirections-1:0] router_3_2_rsp_in;
floo_wide_t [NumDirections-1:0] router_3_2_wide_in;
floo_wide_t [NumDirections-1:0] router_3_2_wide_out;

  assign router_3_2_req_in[Eject] = cva6_ni_to_router_3_2_req;
  assign router_3_2_req_in[East] = router_4_2_to_router_3_2_req;
  assign router_3_2_req_in[North] = router_3_3_to_router_3_2_req;
  assign router_3_2_req_in[South] = router_3_1_to_router_3_2_req;
  assign router_3_2_req_in[West] = router_2_2_to_router_3_2_req;

  assign router_3_2_to_cva6_ni_rsp = router_3_2_rsp_out[Eject];
  assign router_3_2_to_router_4_2_rsp = router_3_2_rsp_out[East];
  assign router_3_2_to_router_3_3_rsp = router_3_2_rsp_out[North];
  assign router_3_2_to_router_3_1_rsp = router_3_2_rsp_out[South];
  assign router_3_2_to_router_2_2_rsp = router_3_2_rsp_out[West];

  assign router_3_2_to_cva6_ni_req = router_3_2_req_out[Eject];
  assign router_3_2_to_router_4_2_req = router_3_2_req_out[East];
  assign router_3_2_to_router_3_3_req = router_3_2_req_out[North];
  assign router_3_2_to_router_3_1_req = router_3_2_req_out[South];
  assign router_3_2_to_router_2_2_req = router_3_2_req_out[West];

  assign router_3_2_rsp_in[Eject] = cva6_ni_to_router_3_2_rsp;
  assign router_3_2_rsp_in[East] = router_4_2_to_router_3_2_rsp;
  assign router_3_2_rsp_in[North] = router_3_3_to_router_3_2_rsp;
  assign router_3_2_rsp_in[South] = router_3_1_to_router_3_2_rsp;
  assign router_3_2_rsp_in[West] = router_2_2_to_router_3_2_rsp;

  assign router_3_2_wide_in[Eject] = cva6_ni_to_router_3_2_wide;
  assign router_3_2_wide_in[East] = router_4_2_to_router_3_2_wide;
  assign router_3_2_wide_in[North] = router_3_3_to_router_3_2_wide;
  assign router_3_2_wide_in[South] = router_3_1_to_router_3_2_wide;
  assign router_3_2_wide_in[West] = router_2_2_to_router_3_2_wide;

  assign router_3_2_to_cva6_ni_wide = router_3_2_wide_out[Eject];
  assign router_3_2_to_router_4_2_wide = router_3_2_wide_out[East];
  assign router_3_2_to_router_3_3_wide = router_3_2_wide_out[North];
  assign router_3_2_to_router_3_1_wide = router_3_2_wide_out[South];
  assign router_3_2_to_router_2_2_wide = router_3_2_wide_out[West];

localparam id_t router_3_2_id = '{x: 4, y: 3};
floo_narrow_wide_router #(
  .NumRoutes (NumDirections),
  .ChannelFifoDepth (2),
  .OutputFifoDepth (2),
  .RouteAlgo (XYRouting),
  .XYRouteOpt(XYRouteOpt),
  .id_t(id_t),
  .border_id_t(floo_narrow_wide_pkg::border_id_t),
  .BorderId(floo_narrow_wide_pkg::BorderId)
) router_3_2 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .id_i (router_3_2_id),
  .id_route_map_i ('0),
  .floo_req_i (router_3_2_req_in),
  .floo_rsp_o (router_3_2_rsp_out),
  .floo_req_o (router_3_2_req_out),
  .floo_rsp_i (router_3_2_rsp_in),
  .floo_wide_i (router_3_2_wide_in),
  .floo_wide_o (router_3_2_wide_out)
);


floo_req_t [NumDirections-1:0] router_3_3_req_in;
floo_rsp_t [NumDirections-1:0] router_3_3_rsp_out;
floo_req_t [NumDirections-1:0] router_3_3_req_out;
floo_rsp_t [NumDirections-1:0] router_3_3_rsp_in;
floo_wide_t [NumDirections-1:0] router_3_3_wide_in;
floo_wide_t [NumDirections-1:0] router_3_3_wide_out;

  assign router_3_3_req_in[Eject] = spm_ni_to_router_3_3_req;
  assign router_3_3_req_in[East] = router_4_3_to_router_3_3_req;
  assign router_3_3_req_in[North] = idma_ni_to_router_3_3_req;
  assign router_3_3_req_in[South] = router_3_2_to_router_3_3_req;
  assign router_3_3_req_in[West] = router_2_3_to_router_3_3_req;

  assign router_3_3_to_spm_ni_rsp = router_3_3_rsp_out[Eject];
  assign router_3_3_to_router_4_3_rsp = router_3_3_rsp_out[East];
  assign router_3_3_to_idma_ni_rsp = router_3_3_rsp_out[North];
  assign router_3_3_to_router_3_2_rsp = router_3_3_rsp_out[South];
  assign router_3_3_to_router_2_3_rsp = router_3_3_rsp_out[West];

  assign router_3_3_to_spm_ni_req = router_3_3_req_out[Eject];
  assign router_3_3_to_router_4_3_req = router_3_3_req_out[East];
  assign router_3_3_to_idma_ni_req = router_3_3_req_out[North];
  assign router_3_3_to_router_3_2_req = router_3_3_req_out[South];
  assign router_3_3_to_router_2_3_req = router_3_3_req_out[West];

  assign router_3_3_rsp_in[Eject] = spm_ni_to_router_3_3_rsp;
  assign router_3_3_rsp_in[East] = router_4_3_to_router_3_3_rsp;
  assign router_3_3_rsp_in[North] = idma_ni_to_router_3_3_rsp;
  assign router_3_3_rsp_in[South] = router_3_2_to_router_3_3_rsp;
  assign router_3_3_rsp_in[West] = router_2_3_to_router_3_3_rsp;

  assign router_3_3_wide_in[Eject] = spm_ni_to_router_3_3_wide;
  assign router_3_3_wide_in[East] = router_4_3_to_router_3_3_wide;
  assign router_3_3_wide_in[North] = idma_ni_to_router_3_3_wide;
  assign router_3_3_wide_in[South] = router_3_2_to_router_3_3_wide;
  assign router_3_3_wide_in[West] = router_2_3_to_router_3_3_wide;

  assign router_3_3_to_spm_ni_wide = router_3_3_wide_out[Eject];
  assign router_3_3_to_router_4_3_wide = router_3_3_wide_out[East];
  assign router_3_3_to_idma_ni_wide = router_3_3_wide_out[North];
  assign router_3_3_to_router_3_2_wide = router_3_3_wide_out[South];
  assign router_3_3_to_router_2_3_wide = router_3_3_wide_out[West];

localparam id_t router_3_3_id = '{x: 4, y: 4};
floo_narrow_wide_router #(
  .NumRoutes (NumDirections),
  .ChannelFifoDepth (2),
  .OutputFifoDepth (2),
  .RouteAlgo (XYRouting),
  .XYRouteOpt(XYRouteOpt),
  .id_t(id_t),
  .border_id_t(floo_narrow_wide_pkg::border_id_t),
  .BorderId(floo_narrow_wide_pkg::BorderId)
) router_3_3 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .id_i (router_3_3_id),
  .id_route_map_i ('0),
  .floo_req_i (router_3_3_req_in),
  .floo_rsp_o (router_3_3_rsp_out),
  .floo_req_o (router_3_3_req_out),
  .floo_rsp_i (router_3_3_rsp_in),
  .floo_wide_i (router_3_3_wide_in),
  .floo_wide_o (router_3_3_wide_out)
);


floo_req_t [West:North] router_4_0_req_in;
floo_rsp_t [West:North] router_4_0_rsp_out;
floo_req_t [West:North] router_4_0_req_out;
floo_rsp_t [West:North] router_4_0_rsp_in;
floo_wide_t [West:North] router_4_0_wide_in;
floo_wide_t [West:North] router_4_0_wide_out;

  assign router_4_0_req_in[East] = router_5_0_to_router_4_0_req;
  assign router_4_0_req_in[North] = router_4_1_to_router_4_0_req;
  assign router_4_0_req_in[South] = hbm_south_2_ni_0_0_to_router_4_0_req;
  assign router_4_0_req_in[West] = router_3_0_to_router_4_0_req;

  assign router_4_0_to_router_5_0_rsp = router_4_0_rsp_out[East];
  assign router_4_0_to_router_4_1_rsp = router_4_0_rsp_out[North];
  assign router_4_0_to_hbm_south_2_ni_0_0_rsp = router_4_0_rsp_out[South];
  assign router_4_0_to_router_3_0_rsp = router_4_0_rsp_out[West];

  assign router_4_0_to_router_5_0_req = router_4_0_req_out[East];
  assign router_4_0_to_router_4_1_req = router_4_0_req_out[North];
  assign router_4_0_to_hbm_south_2_ni_0_0_req = router_4_0_req_out[South];
  assign router_4_0_to_router_3_0_req = router_4_0_req_out[West];

  assign router_4_0_rsp_in[East] = router_5_0_to_router_4_0_rsp;
  assign router_4_0_rsp_in[North] = router_4_1_to_router_4_0_rsp;
  assign router_4_0_rsp_in[South] = hbm_south_2_ni_0_0_to_router_4_0_rsp;
  assign router_4_0_rsp_in[West] = router_3_0_to_router_4_0_rsp;

  assign router_4_0_wide_in[East] = router_5_0_to_router_4_0_wide;
  assign router_4_0_wide_in[North] = router_4_1_to_router_4_0_wide;
  assign router_4_0_wide_in[South] = hbm_south_2_ni_0_0_to_router_4_0_wide;
  assign router_4_0_wide_in[West] = router_3_0_to_router_4_0_wide;

  assign router_4_0_to_router_5_0_wide = router_4_0_wide_out[East];
  assign router_4_0_to_router_4_1_wide = router_4_0_wide_out[North];
  assign router_4_0_to_hbm_south_2_ni_0_0_wide = router_4_0_wide_out[South];
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
  .tile_id_i (5'd12),
  .meip_i (17'b0),
  .mtip_i (mtip_i[221:205]),
  .msip_i (msip_i[221:205]),
  .id_i (compute_tile_4_0_id),
  .floo_req_i (router_4_0_req_in),
  .floo_rsp_o (router_4_0_rsp_out),
  .floo_req_o (router_4_0_req_out),
  .floo_rsp_i (router_4_0_rsp_in),
  .floo_wide_i (router_4_0_wide_in),
  .floo_wide_o (router_4_0_wide_out)
);


floo_req_t [West:North] router_4_1_req_in;
floo_rsp_t [West:North] router_4_1_rsp_out;
floo_req_t [West:North] router_4_1_req_out;
floo_rsp_t [West:North] router_4_1_rsp_in;
floo_wide_t [West:North] router_4_1_wide_in;
floo_wide_t [West:North] router_4_1_wide_out;

  assign router_4_1_req_in[East] = router_5_1_to_router_4_1_req;
  assign router_4_1_req_in[North] = router_4_2_to_router_4_1_req;
  assign router_4_1_req_in[South] = router_4_0_to_router_4_1_req;
  assign router_4_1_req_in[West] = router_3_1_to_router_4_1_req;

  assign router_4_1_to_router_5_1_rsp = router_4_1_rsp_out[East];
  assign router_4_1_to_router_4_2_rsp = router_4_1_rsp_out[North];
  assign router_4_1_to_router_4_0_rsp = router_4_1_rsp_out[South];
  assign router_4_1_to_router_3_1_rsp = router_4_1_rsp_out[West];

  assign router_4_1_to_router_5_1_req = router_4_1_req_out[East];
  assign router_4_1_to_router_4_2_req = router_4_1_req_out[North];
  assign router_4_1_to_router_4_0_req = router_4_1_req_out[South];
  assign router_4_1_to_router_3_1_req = router_4_1_req_out[West];

  assign router_4_1_rsp_in[East] = router_5_1_to_router_4_1_rsp;
  assign router_4_1_rsp_in[North] = router_4_2_to_router_4_1_rsp;
  assign router_4_1_rsp_in[South] = router_4_0_to_router_4_1_rsp;
  assign router_4_1_rsp_in[West] = router_3_1_to_router_4_1_rsp;

  assign router_4_1_wide_in[East] = router_5_1_to_router_4_1_wide;
  assign router_4_1_wide_in[North] = router_4_2_to_router_4_1_wide;
  assign router_4_1_wide_in[South] = router_4_0_to_router_4_1_wide;
  assign router_4_1_wide_in[West] = router_3_1_to_router_4_1_wide;

  assign router_4_1_to_router_5_1_wide = router_4_1_wide_out[East];
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
  .tile_id_i (5'd13),
  .meip_i (17'b0),
  .mtip_i (mtip_i[238:222]),
  .msip_i (msip_i[238:222]),
  .id_i (compute_tile_4_1_id),
  .floo_req_i (router_4_1_req_in),
  .floo_rsp_o (router_4_1_rsp_out),
  .floo_req_o (router_4_1_req_out),
  .floo_rsp_i (router_4_1_rsp_in),
  .floo_wide_i (router_4_1_wide_in),
  .floo_wide_o (router_4_1_wide_out)
);


floo_req_t [West:North] router_4_2_req_in;
floo_rsp_t [West:North] router_4_2_rsp_out;
floo_req_t [West:North] router_4_2_req_out;
floo_rsp_t [West:North] router_4_2_rsp_in;
floo_wide_t [West:North] router_4_2_wide_in;
floo_wide_t [West:North] router_4_2_wide_out;

  assign router_4_2_req_in[East] = router_5_2_to_router_4_2_req;
  assign router_4_2_req_in[North] = router_4_3_to_router_4_2_req;
  assign router_4_2_req_in[South] = router_4_1_to_router_4_2_req;
  assign router_4_2_req_in[West] = router_3_2_to_router_4_2_req;

  assign router_4_2_to_router_5_2_rsp = router_4_2_rsp_out[East];
  assign router_4_2_to_router_4_3_rsp = router_4_2_rsp_out[North];
  assign router_4_2_to_router_4_1_rsp = router_4_2_rsp_out[South];
  assign router_4_2_to_router_3_2_rsp = router_4_2_rsp_out[West];

  assign router_4_2_to_router_5_2_req = router_4_2_req_out[East];
  assign router_4_2_to_router_4_3_req = router_4_2_req_out[North];
  assign router_4_2_to_router_4_1_req = router_4_2_req_out[South];
  assign router_4_2_to_router_3_2_req = router_4_2_req_out[West];

  assign router_4_2_rsp_in[East] = router_5_2_to_router_4_2_rsp;
  assign router_4_2_rsp_in[North] = router_4_3_to_router_4_2_rsp;
  assign router_4_2_rsp_in[South] = router_4_1_to_router_4_2_rsp;
  assign router_4_2_rsp_in[West] = router_3_2_to_router_4_2_rsp;

  assign router_4_2_wide_in[East] = router_5_2_to_router_4_2_wide;
  assign router_4_2_wide_in[North] = router_4_3_to_router_4_2_wide;
  assign router_4_2_wide_in[South] = router_4_1_to_router_4_2_wide;
  assign router_4_2_wide_in[West] = router_3_2_to_router_4_2_wide;

  assign router_4_2_to_router_5_2_wide = router_4_2_wide_out[East];
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
  .tile_id_i (5'd14),
  .meip_i (17'b0),
  .mtip_i (mtip_i[255:239]),
  .msip_i (msip_i[255:239]),
  .id_i (compute_tile_4_2_id),
  .floo_req_i (router_4_2_req_in),
  .floo_rsp_o (router_4_2_rsp_out),
  .floo_req_o (router_4_2_req_out),
  .floo_rsp_i (router_4_2_rsp_in),
  .floo_wide_i (router_4_2_wide_in),
  .floo_wide_o (router_4_2_wide_out)
);


floo_req_t [West:North] router_4_3_req_in;
floo_rsp_t [West:North] router_4_3_rsp_out;
floo_req_t [West:North] router_4_3_req_out;
floo_rsp_t [West:North] router_4_3_rsp_in;
floo_wide_t [West:North] router_4_3_wide_in;
floo_wide_t [West:North] router_4_3_wide_out;

  assign router_4_3_req_in[East] = router_5_3_to_router_4_3_req;
  assign router_4_3_req_in[North] = hbm_north_dram_1_ni_to_router_4_3_req;
  assign router_4_3_req_in[South] = router_4_2_to_router_4_3_req;
  assign router_4_3_req_in[West] = router_3_3_to_router_4_3_req;

  assign router_4_3_to_router_5_3_rsp = router_4_3_rsp_out[East];
  assign router_4_3_to_hbm_north_dram_1_ni_rsp = router_4_3_rsp_out[North];
  assign router_4_3_to_router_4_2_rsp = router_4_3_rsp_out[South];
  assign router_4_3_to_router_3_3_rsp = router_4_3_rsp_out[West];

  assign router_4_3_to_router_5_3_req = router_4_3_req_out[East];
  assign router_4_3_to_hbm_north_dram_1_ni_req = router_4_3_req_out[North];
  assign router_4_3_to_router_4_2_req = router_4_3_req_out[South];
  assign router_4_3_to_router_3_3_req = router_4_3_req_out[West];

  assign router_4_3_rsp_in[East] = router_5_3_to_router_4_3_rsp;
  assign router_4_3_rsp_in[North] = hbm_north_dram_1_ni_to_router_4_3_rsp;
  assign router_4_3_rsp_in[South] = router_4_2_to_router_4_3_rsp;
  assign router_4_3_rsp_in[West] = router_3_3_to_router_4_3_rsp;

  assign router_4_3_wide_in[East] = router_5_3_to_router_4_3_wide;
  assign router_4_3_wide_in[North] = hbm_north_dram_1_ni_to_router_4_3_wide;
  assign router_4_3_wide_in[South] = router_4_2_to_router_4_3_wide;
  assign router_4_3_wide_in[West] = router_3_3_to_router_4_3_wide;

  assign router_4_3_to_router_5_3_wide = router_4_3_wide_out[East];
  assign router_4_3_to_hbm_north_dram_1_ni_wide = router_4_3_wide_out[North];
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
  .tile_id_i (5'd15),
  .meip_i (17'b0),
  .mtip_i (mtip_i[272:256]),
  .msip_i (msip_i[272:256]),
  .id_i (compute_tile_4_3_id),
  .floo_req_i (router_4_3_req_in),
  .floo_rsp_o (router_4_3_rsp_out),
  .floo_req_o (router_4_3_req_out),
  .floo_rsp_i (router_4_3_rsp_in),
  .floo_wide_i (router_4_3_wide_in),
  .floo_wide_o (router_4_3_wide_out)
);


floo_req_t [West:North] router_5_0_req_in;
floo_rsp_t [West:North] router_5_0_rsp_out;
floo_req_t [West:North] router_5_0_req_out;
floo_rsp_t [West:North] router_5_0_rsp_in;
floo_wide_t [West:North] router_5_0_wide_in;
floo_wide_t [West:North] router_5_0_wide_out;

  assign router_5_0_req_in[East] = router_6_0_to_router_5_0_req;
  assign router_5_0_req_in[North] = router_5_1_to_router_5_0_req;
  assign router_5_0_req_in[South] = hbm_south_2_ni_1_0_to_router_5_0_req;
  assign router_5_0_req_in[West] = router_4_0_to_router_5_0_req;

  assign router_5_0_to_router_6_0_rsp = router_5_0_rsp_out[East];
  assign router_5_0_to_router_5_1_rsp = router_5_0_rsp_out[North];
  assign router_5_0_to_hbm_south_2_ni_1_0_rsp = router_5_0_rsp_out[South];
  assign router_5_0_to_router_4_0_rsp = router_5_0_rsp_out[West];

  assign router_5_0_to_router_6_0_req = router_5_0_req_out[East];
  assign router_5_0_to_router_5_1_req = router_5_0_req_out[North];
  assign router_5_0_to_hbm_south_2_ni_1_0_req = router_5_0_req_out[South];
  assign router_5_0_to_router_4_0_req = router_5_0_req_out[West];

  assign router_5_0_rsp_in[East] = router_6_0_to_router_5_0_rsp;
  assign router_5_0_rsp_in[North] = router_5_1_to_router_5_0_rsp;
  assign router_5_0_rsp_in[South] = hbm_south_2_ni_1_0_to_router_5_0_rsp;
  assign router_5_0_rsp_in[West] = router_4_0_to_router_5_0_rsp;

  assign router_5_0_wide_in[East] = router_6_0_to_router_5_0_wide;
  assign router_5_0_wide_in[North] = router_5_1_to_router_5_0_wide;
  assign router_5_0_wide_in[South] = hbm_south_2_ni_1_0_to_router_5_0_wide;
  assign router_5_0_wide_in[West] = router_4_0_to_router_5_0_wide;

  assign router_5_0_to_router_6_0_wide = router_5_0_wide_out[East];
  assign router_5_0_to_router_5_1_wide = router_5_0_wide_out[North];
  assign router_5_0_to_hbm_south_2_ni_1_0_wide = router_5_0_wide_out[South];
  assign router_5_0_to_router_4_0_wide = router_5_0_wide_out[West];

localparam id_t compute_tile_5_0_id = '{x: 6, y: 1};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(6),
  .id_y(1)
) 
`endif
 compute_tile_5_0 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd16),
  .meip_i (17'b0),
  .mtip_i (mtip_i[289:273]),
  .msip_i (msip_i[289:273]),
  .id_i (compute_tile_5_0_id),
  .floo_req_i (router_5_0_req_in),
  .floo_rsp_o (router_5_0_rsp_out),
  .floo_req_o (router_5_0_req_out),
  .floo_rsp_i (router_5_0_rsp_in),
  .floo_wide_i (router_5_0_wide_in),
  .floo_wide_o (router_5_0_wide_out)
);


floo_req_t [West:North] router_5_1_req_in;
floo_rsp_t [West:North] router_5_1_rsp_out;
floo_req_t [West:North] router_5_1_req_out;
floo_rsp_t [West:North] router_5_1_rsp_in;
floo_wide_t [West:North] router_5_1_wide_in;
floo_wide_t [West:North] router_5_1_wide_out;

  assign router_5_1_req_in[East] = router_6_1_to_router_5_1_req;
  assign router_5_1_req_in[North] = router_5_2_to_router_5_1_req;
  assign router_5_1_req_in[South] = router_5_0_to_router_5_1_req;
  assign router_5_1_req_in[West] = router_4_1_to_router_5_1_req;

  assign router_5_1_to_router_6_1_rsp = router_5_1_rsp_out[East];
  assign router_5_1_to_router_5_2_rsp = router_5_1_rsp_out[North];
  assign router_5_1_to_router_5_0_rsp = router_5_1_rsp_out[South];
  assign router_5_1_to_router_4_1_rsp = router_5_1_rsp_out[West];

  assign router_5_1_to_router_6_1_req = router_5_1_req_out[East];
  assign router_5_1_to_router_5_2_req = router_5_1_req_out[North];
  assign router_5_1_to_router_5_0_req = router_5_1_req_out[South];
  assign router_5_1_to_router_4_1_req = router_5_1_req_out[West];

  assign router_5_1_rsp_in[East] = router_6_1_to_router_5_1_rsp;
  assign router_5_1_rsp_in[North] = router_5_2_to_router_5_1_rsp;
  assign router_5_1_rsp_in[South] = router_5_0_to_router_5_1_rsp;
  assign router_5_1_rsp_in[West] = router_4_1_to_router_5_1_rsp;

  assign router_5_1_wide_in[East] = router_6_1_to_router_5_1_wide;
  assign router_5_1_wide_in[North] = router_5_2_to_router_5_1_wide;
  assign router_5_1_wide_in[South] = router_5_0_to_router_5_1_wide;
  assign router_5_1_wide_in[West] = router_4_1_to_router_5_1_wide;

  assign router_5_1_to_router_6_1_wide = router_5_1_wide_out[East];
  assign router_5_1_to_router_5_2_wide = router_5_1_wide_out[North];
  assign router_5_1_to_router_5_0_wide = router_5_1_wide_out[South];
  assign router_5_1_to_router_4_1_wide = router_5_1_wide_out[West];

localparam id_t compute_tile_5_1_id = '{x: 6, y: 2};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(6),
  .id_y(2)
) 
`endif
 compute_tile_5_1 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd17),
  .meip_i (17'b0),
  .mtip_i (mtip_i[306:290]),
  .msip_i (msip_i[306:290]),
  .id_i (compute_tile_5_1_id),
  .floo_req_i (router_5_1_req_in),
  .floo_rsp_o (router_5_1_rsp_out),
  .floo_req_o (router_5_1_req_out),
  .floo_rsp_i (router_5_1_rsp_in),
  .floo_wide_i (router_5_1_wide_in),
  .floo_wide_o (router_5_1_wide_out)
);


floo_req_t [West:North] router_5_2_req_in;
floo_rsp_t [West:North] router_5_2_rsp_out;
floo_req_t [West:North] router_5_2_req_out;
floo_rsp_t [West:North] router_5_2_rsp_in;
floo_wide_t [West:North] router_5_2_wide_in;
floo_wide_t [West:North] router_5_2_wide_out;

  assign router_5_2_req_in[East] = router_6_2_to_router_5_2_req;
  assign router_5_2_req_in[North] = router_5_3_to_router_5_2_req;
  assign router_5_2_req_in[South] = router_5_1_to_router_5_2_req;
  assign router_5_2_req_in[West] = router_4_2_to_router_5_2_req;

  assign router_5_2_to_router_6_2_rsp = router_5_2_rsp_out[East];
  assign router_5_2_to_router_5_3_rsp = router_5_2_rsp_out[North];
  assign router_5_2_to_router_5_1_rsp = router_5_2_rsp_out[South];
  assign router_5_2_to_router_4_2_rsp = router_5_2_rsp_out[West];

  assign router_5_2_to_router_6_2_req = router_5_2_req_out[East];
  assign router_5_2_to_router_5_3_req = router_5_2_req_out[North];
  assign router_5_2_to_router_5_1_req = router_5_2_req_out[South];
  assign router_5_2_to_router_4_2_req = router_5_2_req_out[West];

  assign router_5_2_rsp_in[East] = router_6_2_to_router_5_2_rsp;
  assign router_5_2_rsp_in[North] = router_5_3_to_router_5_2_rsp;
  assign router_5_2_rsp_in[South] = router_5_1_to_router_5_2_rsp;
  assign router_5_2_rsp_in[West] = router_4_2_to_router_5_2_rsp;

  assign router_5_2_wide_in[East] = router_6_2_to_router_5_2_wide;
  assign router_5_2_wide_in[North] = router_5_3_to_router_5_2_wide;
  assign router_5_2_wide_in[South] = router_5_1_to_router_5_2_wide;
  assign router_5_2_wide_in[West] = router_4_2_to_router_5_2_wide;

  assign router_5_2_to_router_6_2_wide = router_5_2_wide_out[East];
  assign router_5_2_to_router_5_3_wide = router_5_2_wide_out[North];
  assign router_5_2_to_router_5_1_wide = router_5_2_wide_out[South];
  assign router_5_2_to_router_4_2_wide = router_5_2_wide_out[West];

localparam id_t compute_tile_5_2_id = '{x: 6, y: 3};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(6),
  .id_y(3)
) 
`endif
 compute_tile_5_2 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd18),
  .meip_i (17'b0),
  .mtip_i (mtip_i[323:307]),
  .msip_i (msip_i[323:307]),
  .id_i (compute_tile_5_2_id),
  .floo_req_i (router_5_2_req_in),
  .floo_rsp_o (router_5_2_rsp_out),
  .floo_req_o (router_5_2_req_out),
  .floo_rsp_i (router_5_2_rsp_in),
  .floo_wide_i (router_5_2_wide_in),
  .floo_wide_o (router_5_2_wide_out)
);


floo_req_t [West:North] router_5_3_req_in;
floo_rsp_t [West:North] router_5_3_rsp_out;
floo_req_t [West:North] router_5_3_req_out;
floo_rsp_t [West:North] router_5_3_rsp_in;
floo_wide_t [West:North] router_5_3_wide_in;
floo_wide_t [West:North] router_5_3_wide_out;

  assign router_5_3_req_in[East] = router_6_3_to_router_5_3_req;
  assign router_5_3_req_in[North] = hbm_north_3_ni_to_router_5_3_req;
  assign router_5_3_req_in[South] = router_5_2_to_router_5_3_req;
  assign router_5_3_req_in[West] = router_4_3_to_router_5_3_req;

  assign router_5_3_to_router_6_3_rsp = router_5_3_rsp_out[East];
  assign router_5_3_to_hbm_north_3_ni_rsp = router_5_3_rsp_out[North];
  assign router_5_3_to_router_5_2_rsp = router_5_3_rsp_out[South];
  assign router_5_3_to_router_4_3_rsp = router_5_3_rsp_out[West];

  assign router_5_3_to_router_6_3_req = router_5_3_req_out[East];
  assign router_5_3_to_hbm_north_3_ni_req = router_5_3_req_out[North];
  assign router_5_3_to_router_5_2_req = router_5_3_req_out[South];
  assign router_5_3_to_router_4_3_req = router_5_3_req_out[West];

  assign router_5_3_rsp_in[East] = router_6_3_to_router_5_3_rsp;
  assign router_5_3_rsp_in[North] = hbm_north_3_ni_to_router_5_3_rsp;
  assign router_5_3_rsp_in[South] = router_5_2_to_router_5_3_rsp;
  assign router_5_3_rsp_in[West] = router_4_3_to_router_5_3_rsp;

  assign router_5_3_wide_in[East] = router_6_3_to_router_5_3_wide;
  assign router_5_3_wide_in[North] = hbm_north_3_ni_to_router_5_3_wide;
  assign router_5_3_wide_in[South] = router_5_2_to_router_5_3_wide;
  assign router_5_3_wide_in[West] = router_4_3_to_router_5_3_wide;

  assign router_5_3_to_router_6_3_wide = router_5_3_wide_out[East];
  assign router_5_3_to_hbm_north_3_ni_wide = router_5_3_wide_out[North];
  assign router_5_3_to_router_5_2_wide = router_5_3_wide_out[South];
  assign router_5_3_to_router_4_3_wide = router_5_3_wide_out[West];

localparam id_t compute_tile_5_3_id = '{x: 6, y: 4};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(6),
  .id_y(4)
) 
`endif
 compute_tile_5_3 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd19),
  .meip_i (17'b0),
  .mtip_i (mtip_i[340:324]),
  .msip_i (msip_i[340:324]),
  .id_i (compute_tile_5_3_id),
  .floo_req_i (router_5_3_req_in),
  .floo_rsp_o (router_5_3_rsp_out),
  .floo_req_o (router_5_3_req_out),
  .floo_rsp_i (router_5_3_rsp_in),
  .floo_wide_i (router_5_3_wide_in),
  .floo_wide_o (router_5_3_wide_out)
);


floo_req_t [West:North] router_6_0_req_in;
floo_rsp_t [West:North] router_6_0_rsp_out;
floo_req_t [West:North] router_6_0_req_out;
floo_rsp_t [West:North] router_6_0_rsp_in;
floo_wide_t [West:North] router_6_0_wide_in;
floo_wide_t [West:North] router_6_0_wide_out;

  assign router_6_0_req_in[East] = hbm_east_ni_0_0_to_router_6_0_req;
  assign router_6_0_req_in[North] = router_6_1_to_router_6_0_req;
  assign router_6_0_req_in[South] = '0;
  assign router_6_0_req_in[West] = router_5_0_to_router_6_0_req;

  assign router_6_0_to_hbm_east_ni_0_0_rsp = router_6_0_rsp_out[East];
  assign router_6_0_to_router_6_1_rsp = router_6_0_rsp_out[North];
  assign router_6_0_to_router_5_0_rsp = router_6_0_rsp_out[West];

  assign router_6_0_to_hbm_east_ni_0_0_req = router_6_0_req_out[East];
  assign router_6_0_to_router_6_1_req = router_6_0_req_out[North];
  assign router_6_0_to_router_5_0_req = router_6_0_req_out[West];

  assign router_6_0_rsp_in[East] = hbm_east_ni_0_0_to_router_6_0_rsp;
  assign router_6_0_rsp_in[North] = router_6_1_to_router_6_0_rsp;
  assign router_6_0_rsp_in[South] = '0;
  assign router_6_0_rsp_in[West] = router_5_0_to_router_6_0_rsp;

  assign router_6_0_wide_in[East] = hbm_east_ni_0_0_to_router_6_0_wide;
  assign router_6_0_wide_in[North] = router_6_1_to_router_6_0_wide;
  assign router_6_0_wide_in[South] = '0;
  assign router_6_0_wide_in[West] = router_5_0_to_router_6_0_wide;

  assign router_6_0_to_hbm_east_ni_0_0_wide = router_6_0_wide_out[East];
  assign router_6_0_to_router_6_1_wide = router_6_0_wide_out[North];
  assign router_6_0_to_router_5_0_wide = router_6_0_wide_out[West];

localparam id_t compute_tile_6_0_id = '{x: 7, y: 1};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(7),
  .id_y(1)
) 
`endif
 compute_tile_6_0 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd20),
  .meip_i (17'b0),
  .mtip_i (mtip_i[357:341]),
  .msip_i (msip_i[357:341]),
  .id_i (compute_tile_6_0_id),
  .floo_req_i (router_6_0_req_in),
  .floo_rsp_o (router_6_0_rsp_out),
  .floo_req_o (router_6_0_req_out),
  .floo_rsp_i (router_6_0_rsp_in),
  .floo_wide_i (router_6_0_wide_in),
  .floo_wide_o (router_6_0_wide_out)
);


floo_req_t [West:North] router_6_1_req_in;
floo_rsp_t [West:North] router_6_1_rsp_out;
floo_req_t [West:North] router_6_1_req_out;
floo_rsp_t [West:North] router_6_1_rsp_in;
floo_wide_t [West:North] router_6_1_wide_in;
floo_wide_t [West:North] router_6_1_wide_out;

  assign router_6_1_req_in[East] = hbm_east_ni_0_1_to_router_6_1_req;
  assign router_6_1_req_in[North] = router_6_2_to_router_6_1_req;
  assign router_6_1_req_in[South] = router_6_0_to_router_6_1_req;
  assign router_6_1_req_in[West] = router_5_1_to_router_6_1_req;

  assign router_6_1_to_hbm_east_ni_0_1_rsp = router_6_1_rsp_out[East];
  assign router_6_1_to_router_6_2_rsp = router_6_1_rsp_out[North];
  assign router_6_1_to_router_6_0_rsp = router_6_1_rsp_out[South];
  assign router_6_1_to_router_5_1_rsp = router_6_1_rsp_out[West];

  assign router_6_1_to_hbm_east_ni_0_1_req = router_6_1_req_out[East];
  assign router_6_1_to_router_6_2_req = router_6_1_req_out[North];
  assign router_6_1_to_router_6_0_req = router_6_1_req_out[South];
  assign router_6_1_to_router_5_1_req = router_6_1_req_out[West];

  assign router_6_1_rsp_in[East] = hbm_east_ni_0_1_to_router_6_1_rsp;
  assign router_6_1_rsp_in[North] = router_6_2_to_router_6_1_rsp;
  assign router_6_1_rsp_in[South] = router_6_0_to_router_6_1_rsp;
  assign router_6_1_rsp_in[West] = router_5_1_to_router_6_1_rsp;

  assign router_6_1_wide_in[East] = hbm_east_ni_0_1_to_router_6_1_wide;
  assign router_6_1_wide_in[North] = router_6_2_to_router_6_1_wide;
  assign router_6_1_wide_in[South] = router_6_0_to_router_6_1_wide;
  assign router_6_1_wide_in[West] = router_5_1_to_router_6_1_wide;

  assign router_6_1_to_hbm_east_ni_0_1_wide = router_6_1_wide_out[East];
  assign router_6_1_to_router_6_2_wide = router_6_1_wide_out[North];
  assign router_6_1_to_router_6_0_wide = router_6_1_wide_out[South];
  assign router_6_1_to_router_5_1_wide = router_6_1_wide_out[West];

localparam id_t compute_tile_6_1_id = '{x: 7, y: 2};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(7),
  .id_y(2)
) 
`endif
 compute_tile_6_1 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd21),
  .meip_i (17'b0),
  .mtip_i (mtip_i[374:358]),
  .msip_i (msip_i[374:358]),
  .id_i (compute_tile_6_1_id),
  .floo_req_i (router_6_1_req_in),
  .floo_rsp_o (router_6_1_rsp_out),
  .floo_req_o (router_6_1_req_out),
  .floo_rsp_i (router_6_1_rsp_in),
  .floo_wide_i (router_6_1_wide_in),
  .floo_wide_o (router_6_1_wide_out)
);


floo_req_t [West:North] router_6_2_req_in;
floo_rsp_t [West:North] router_6_2_rsp_out;
floo_req_t [West:North] router_6_2_req_out;
floo_rsp_t [West:North] router_6_2_rsp_in;
floo_wide_t [West:North] router_6_2_wide_in;
floo_wide_t [West:North] router_6_2_wide_out;

  assign router_6_2_req_in[East] = hbm_east_ni_0_2_to_router_6_2_req;
  assign router_6_2_req_in[North] = router_6_3_to_router_6_2_req;
  assign router_6_2_req_in[South] = router_6_1_to_router_6_2_req;
  assign router_6_2_req_in[West] = router_5_2_to_router_6_2_req;

  assign router_6_2_to_hbm_east_ni_0_2_rsp = router_6_2_rsp_out[East];
  assign router_6_2_to_router_6_3_rsp = router_6_2_rsp_out[North];
  assign router_6_2_to_router_6_1_rsp = router_6_2_rsp_out[South];
  assign router_6_2_to_router_5_2_rsp = router_6_2_rsp_out[West];

  assign router_6_2_to_hbm_east_ni_0_2_req = router_6_2_req_out[East];
  assign router_6_2_to_router_6_3_req = router_6_2_req_out[North];
  assign router_6_2_to_router_6_1_req = router_6_2_req_out[South];
  assign router_6_2_to_router_5_2_req = router_6_2_req_out[West];

  assign router_6_2_rsp_in[East] = hbm_east_ni_0_2_to_router_6_2_rsp;
  assign router_6_2_rsp_in[North] = router_6_3_to_router_6_2_rsp;
  assign router_6_2_rsp_in[South] = router_6_1_to_router_6_2_rsp;
  assign router_6_2_rsp_in[West] = router_5_2_to_router_6_2_rsp;

  assign router_6_2_wide_in[East] = hbm_east_ni_0_2_to_router_6_2_wide;
  assign router_6_2_wide_in[North] = router_6_3_to_router_6_2_wide;
  assign router_6_2_wide_in[South] = router_6_1_to_router_6_2_wide;
  assign router_6_2_wide_in[West] = router_5_2_to_router_6_2_wide;

  assign router_6_2_to_hbm_east_ni_0_2_wide = router_6_2_wide_out[East];
  assign router_6_2_to_router_6_3_wide = router_6_2_wide_out[North];
  assign router_6_2_to_router_6_1_wide = router_6_2_wide_out[South];
  assign router_6_2_to_router_5_2_wide = router_6_2_wide_out[West];

localparam id_t compute_tile_6_2_id = '{x: 7, y: 3};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(7),
  .id_y(3)
) 
`endif
 compute_tile_6_2 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd22),
  .meip_i (17'b0),
  .mtip_i (mtip_i[391:375]),
  .msip_i (msip_i[391:375]),
  .id_i (compute_tile_6_2_id),
  .floo_req_i (router_6_2_req_in),
  .floo_rsp_o (router_6_2_rsp_out),
  .floo_req_o (router_6_2_req_out),
  .floo_rsp_i (router_6_2_rsp_in),
  .floo_wide_i (router_6_2_wide_in),
  .floo_wide_o (router_6_2_wide_out)
);


floo_req_t [West:North] router_6_3_req_in;
floo_rsp_t [West:North] router_6_3_rsp_out;
floo_req_t [West:North] router_6_3_req_out;
floo_rsp_t [West:North] router_6_3_rsp_in;
floo_wide_t [West:North] router_6_3_wide_in;
floo_wide_t [West:North] router_6_3_wide_out;

  assign router_6_3_req_in[East] = hbm_east_ni_0_3_to_router_6_3_req;
  assign router_6_3_req_in[North] = '0;
  assign router_6_3_req_in[South] = router_6_2_to_router_6_3_req;
  assign router_6_3_req_in[West] = router_5_3_to_router_6_3_req;

  assign router_6_3_to_hbm_east_ni_0_3_rsp = router_6_3_rsp_out[East];
  assign router_6_3_to_router_6_2_rsp = router_6_3_rsp_out[South];
  assign router_6_3_to_router_5_3_rsp = router_6_3_rsp_out[West];

  assign router_6_3_to_hbm_east_ni_0_3_req = router_6_3_req_out[East];
  assign router_6_3_to_router_6_2_req = router_6_3_req_out[South];
  assign router_6_3_to_router_5_3_req = router_6_3_req_out[West];

  assign router_6_3_rsp_in[East] = hbm_east_ni_0_3_to_router_6_3_rsp;
  assign router_6_3_rsp_in[North] = '0;
  assign router_6_3_rsp_in[South] = router_6_2_to_router_6_3_rsp;
  assign router_6_3_rsp_in[West] = router_5_3_to_router_6_3_rsp;

  assign router_6_3_wide_in[East] = hbm_east_ni_0_3_to_router_6_3_wide;
  assign router_6_3_wide_in[North] = '0;
  assign router_6_3_wide_in[South] = router_6_2_to_router_6_3_wide;
  assign router_6_3_wide_in[West] = router_5_3_to_router_6_3_wide;

  assign router_6_3_to_hbm_east_ni_0_3_wide = router_6_3_wide_out[East];
  assign router_6_3_to_router_6_2_wide = router_6_3_wide_out[South];
  assign router_6_3_to_router_5_3_wide = router_6_3_wide_out[West];

localparam id_t compute_tile_6_3_id = '{x: 7, y: 4};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(7),
  .id_y(4)
) 
`endif
 compute_tile_6_3 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd23),
  .meip_i (17'b0),
  .mtip_i (mtip_i[408:392]),
  .msip_i (msip_i[408:392]),
  .id_i (compute_tile_6_3_id),
  .floo_req_i (router_6_3_req_in),
  .floo_rsp_o (router_6_3_rsp_out),
  .floo_req_o (router_6_3_req_out),
  .floo_rsp_i (router_6_3_rsp_in),
  .floo_wide_i (router_6_3_wide_in),
  .floo_wide_o (router_6_3_wide_out)
);



endmodule
