// Copyright 2024 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

// AUTOMATICALLY GENERATED! DO NOT EDIT!

module chiplet_floo_noc
  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;
(
  input logic clk_i,
  input logic rst_ni,
  input logic test_enable_i,

  input logic [288:1] mtip_i, 
  input logic [288:1] msip_i, 
`ifndef TARGET_DMA_TEST
  input  occamy_pkg::sram_cfgs_t  sram_cfgs_i,
`endif
  output axi_narrow_out_req_t             [7:0] hbm_north_narrow_req_o,
  input axi_narrow_out_rsp_t             [7:0] hbm_north_narrow_rsp_i,
  output axi_wide_out_req_t             [7:0] hbm_north_wide_req_o,
  input axi_wide_out_rsp_t             [7:0] hbm_north_wide_rsp_i,
  output axi_narrow_out_req_t             [7:0] hbm_south_narrow_req_o,
  input axi_narrow_out_rsp_t             [7:0] hbm_south_narrow_rsp_i,
  output axi_wide_out_req_t             [7:0] hbm_south_wide_req_o,
  input axi_wide_out_rsp_t             [7:0] hbm_south_wide_rsp_i,
  input axi_narrow_in_req_t              pcie_narrow_req_i,
  output axi_narrow_in_rsp_t              pcie_narrow_rsp_o,
  output axi_narrow_out_req_t              pcie_narrow_req_o,
  input axi_narrow_out_rsp_t              pcie_narrow_rsp_i,
  output axi_narrow_out_req_t              peripherals_narrow_req_o,
  input axi_narrow_out_rsp_t              peripherals_narrow_rsp_i,
  input axi_narrow_in_req_t              jtag_narrow_req_i,
  output axi_narrow_in_rsp_t              jtag_narrow_rsp_o,
  output axi_narrow_out_req_t              jtag_narrow_req_o,
  input axi_narrow_out_rsp_t              jtag_narrow_rsp_i,
  input axi_narrow_in_req_t              cva6_narrow_req_i,
  output axi_narrow_in_rsp_t              cva6_narrow_rsp_o,
  output axi_wide_out_req_t              spm_wide_wide_req_o,
  input axi_wide_out_rsp_t              spm_wide_wide_rsp_i,
  output axi_narrow_out_req_t              spm_narrow_narrow_req_o,
  input axi_narrow_out_rsp_t              spm_narrow_narrow_rsp_i,
  input axi_wide_in_req_t              idma_wide_req_i,
  output axi_wide_in_rsp_t              idma_wide_rsp_o,
  output axi_narrow_out_req_t              idma_narrow_req_o,
  input axi_narrow_out_rsp_t              idma_narrow_rsp_i,
  output axi_wide_out_req_t              zero_mem_wide_req_o,
  input axi_wide_out_rsp_t              zero_mem_wide_rsp_i

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

floo_req_t router_0_0_to_cva6_ni_req;
floo_rsp_t cva6_ni_to_router_0_0_rsp;
floo_wide_t router_0_0_to_cva6_ni_wide;

floo_req_t router_0_1_to_router_0_0_req;
floo_rsp_t router_0_0_to_router_0_1_rsp;
floo_wide_t router_0_1_to_router_0_0_wide;

floo_req_t router_0_1_to_router_0_2_req;
floo_rsp_t router_0_2_to_router_0_1_rsp;
floo_wide_t router_0_1_to_router_0_2_wide;

floo_req_t router_0_1_to_router_1_1_req;
floo_rsp_t router_1_1_to_router_0_1_rsp;
floo_wide_t router_0_1_to_router_1_1_wide;

floo_req_t router_0_1_to_jtag_ni_req;
floo_rsp_t jtag_ni_to_router_0_1_rsp;
floo_wide_t router_0_1_to_jtag_ni_wide;

floo_req_t router_0_2_to_router_0_1_req;
floo_rsp_t router_0_1_to_router_0_2_rsp;
floo_wide_t router_0_2_to_router_0_1_wide;

floo_req_t router_0_2_to_router_0_3_req;
floo_rsp_t router_0_3_to_router_0_2_rsp;
floo_wide_t router_0_2_to_router_0_3_wide;

floo_req_t router_0_2_to_router_1_2_req;
floo_rsp_t router_1_2_to_router_0_2_rsp;
floo_wide_t router_0_2_to_router_1_2_wide;

floo_req_t router_0_2_to_peripherals_ni_req;
floo_rsp_t peripherals_ni_to_router_0_2_rsp;
floo_wide_t router_0_2_to_peripherals_ni_wide;

floo_req_t router_0_3_to_router_0_2_req;
floo_rsp_t router_0_2_to_router_0_3_rsp;
floo_wide_t router_0_3_to_router_0_2_wide;

floo_req_t router_0_3_to_router_1_3_req;
floo_rsp_t router_1_3_to_router_0_3_rsp;
floo_wide_t router_0_3_to_router_1_3_wide;

floo_req_t router_0_3_to_hbm_north_ni_0_0_req;
floo_rsp_t hbm_north_ni_0_0_to_router_0_3_rsp;
floo_wide_t router_0_3_to_hbm_north_ni_0_0_wide;

floo_req_t router_0_3_to_pcie_ni_req;
floo_rsp_t pcie_ni_to_router_0_3_rsp;
floo_wide_t router_0_3_to_pcie_ni_wide;

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

floo_req_t router_4_0_to_router_5_0_req;
floo_rsp_t router_5_0_to_router_4_0_rsp;
floo_wide_t router_4_0_to_router_5_0_wide;

floo_req_t router_4_0_to_hbm_south_ni_4_0_req;
floo_rsp_t hbm_south_ni_4_0_to_router_4_0_rsp;
floo_wide_t router_4_0_to_hbm_south_ni_4_0_wide;

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

floo_req_t router_4_3_to_hbm_north_ni_4_0_req;
floo_rsp_t hbm_north_ni_4_0_to_router_4_3_rsp;
floo_wide_t router_4_3_to_hbm_north_ni_4_0_wide;

floo_req_t router_5_0_to_router_4_0_req;
floo_rsp_t router_4_0_to_router_5_0_rsp;
floo_wide_t router_5_0_to_router_4_0_wide;

floo_req_t router_5_0_to_router_5_1_req;
floo_rsp_t router_5_1_to_router_5_0_rsp;
floo_wide_t router_5_0_to_router_5_1_wide;

floo_req_t router_5_0_to_router_6_0_req;
floo_rsp_t router_6_0_to_router_5_0_rsp;
floo_wide_t router_5_0_to_router_6_0_wide;

floo_req_t router_5_0_to_hbm_south_ni_5_0_req;
floo_rsp_t hbm_south_ni_5_0_to_router_5_0_rsp;
floo_wide_t router_5_0_to_hbm_south_ni_5_0_wide;

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

floo_req_t router_5_3_to_hbm_north_ni_5_0_req;
floo_rsp_t hbm_north_ni_5_0_to_router_5_3_rsp;
floo_wide_t router_5_3_to_hbm_north_ni_5_0_wide;

floo_req_t router_6_0_to_router_5_0_req;
floo_rsp_t router_5_0_to_router_6_0_rsp;
floo_wide_t router_6_0_to_router_5_0_wide;

floo_req_t router_6_0_to_router_6_1_req;
floo_rsp_t router_6_1_to_router_6_0_rsp;
floo_wide_t router_6_0_to_router_6_1_wide;

floo_req_t router_6_0_to_router_7_0_req;
floo_rsp_t router_7_0_to_router_6_0_rsp;
floo_wide_t router_6_0_to_router_7_0_wide;

floo_req_t router_6_0_to_hbm_south_ni_6_0_req;
floo_rsp_t hbm_south_ni_6_0_to_router_6_0_rsp;
floo_wide_t router_6_0_to_hbm_south_ni_6_0_wide;

floo_req_t router_6_1_to_router_5_1_req;
floo_rsp_t router_5_1_to_router_6_1_rsp;
floo_wide_t router_6_1_to_router_5_1_wide;

floo_req_t router_6_1_to_router_6_0_req;
floo_rsp_t router_6_0_to_router_6_1_rsp;
floo_wide_t router_6_1_to_router_6_0_wide;

floo_req_t router_6_1_to_router_6_2_req;
floo_rsp_t router_6_2_to_router_6_1_rsp;
floo_wide_t router_6_1_to_router_6_2_wide;

floo_req_t router_6_1_to_router_7_1_req;
floo_rsp_t router_7_1_to_router_6_1_rsp;
floo_wide_t router_6_1_to_router_7_1_wide;

floo_req_t router_6_2_to_router_5_2_req;
floo_rsp_t router_5_2_to_router_6_2_rsp;
floo_wide_t router_6_2_to_router_5_2_wide;

floo_req_t router_6_2_to_router_6_1_req;
floo_rsp_t router_6_1_to_router_6_2_rsp;
floo_wide_t router_6_2_to_router_6_1_wide;

floo_req_t router_6_2_to_router_6_3_req;
floo_rsp_t router_6_3_to_router_6_2_rsp;
floo_wide_t router_6_2_to_router_6_3_wide;

floo_req_t router_6_2_to_router_7_2_req;
floo_rsp_t router_7_2_to_router_6_2_rsp;
floo_wide_t router_6_2_to_router_7_2_wide;

floo_req_t router_6_3_to_router_5_3_req;
floo_rsp_t router_5_3_to_router_6_3_rsp;
floo_wide_t router_6_3_to_router_5_3_wide;

floo_req_t router_6_3_to_router_6_2_req;
floo_rsp_t router_6_2_to_router_6_3_rsp;
floo_wide_t router_6_3_to_router_6_2_wide;

floo_req_t router_6_3_to_router_7_3_req;
floo_rsp_t router_7_3_to_router_6_3_rsp;
floo_wide_t router_6_3_to_router_7_3_wide;

floo_req_t router_6_3_to_hbm_north_ni_6_0_req;
floo_rsp_t hbm_north_ni_6_0_to_router_6_3_rsp;
floo_wide_t router_6_3_to_hbm_north_ni_6_0_wide;

floo_req_t router_7_0_to_router_6_0_req;
floo_rsp_t router_6_0_to_router_7_0_rsp;
floo_wide_t router_7_0_to_router_6_0_wide;

floo_req_t router_7_0_to_router_7_1_req;
floo_rsp_t router_7_1_to_router_7_0_rsp;
floo_wide_t router_7_0_to_router_7_1_wide;

floo_req_t router_7_0_to_hbm_south_ni_7_0_req;
floo_rsp_t hbm_south_ni_7_0_to_router_7_0_rsp;
floo_wide_t router_7_0_to_hbm_south_ni_7_0_wide;

floo_req_t router_7_0_to_zero_mem_ni_req;
floo_rsp_t zero_mem_ni_to_router_7_0_rsp;
floo_wide_t router_7_0_to_zero_mem_ni_wide;

floo_req_t router_7_1_to_router_6_1_req;
floo_rsp_t router_6_1_to_router_7_1_rsp;
floo_wide_t router_7_1_to_router_6_1_wide;

floo_req_t router_7_1_to_router_7_0_req;
floo_rsp_t router_7_0_to_router_7_1_rsp;
floo_wide_t router_7_1_to_router_7_0_wide;

floo_req_t router_7_1_to_router_7_2_req;
floo_rsp_t router_7_2_to_router_7_1_rsp;
floo_wide_t router_7_1_to_router_7_2_wide;

floo_req_t router_7_1_to_idma_ni_req;
floo_rsp_t idma_ni_to_router_7_1_rsp;
floo_wide_t router_7_1_to_idma_ni_wide;

floo_req_t router_7_2_to_router_6_2_req;
floo_rsp_t router_6_2_to_router_7_2_rsp;
floo_wide_t router_7_2_to_router_6_2_wide;

floo_req_t router_7_2_to_router_7_1_req;
floo_rsp_t router_7_1_to_router_7_2_rsp;
floo_wide_t router_7_2_to_router_7_1_wide;

floo_req_t router_7_2_to_router_7_3_req;
floo_rsp_t router_7_3_to_router_7_2_rsp;
floo_wide_t router_7_2_to_router_7_3_wide;

floo_req_t router_7_2_to_spm_narrow_ni_req;
floo_rsp_t spm_narrow_ni_to_router_7_2_rsp;
floo_wide_t router_7_2_to_spm_narrow_ni_wide;

floo_req_t router_7_3_to_router_6_3_req;
floo_rsp_t router_6_3_to_router_7_3_rsp;
floo_wide_t router_7_3_to_router_6_3_wide;

floo_req_t router_7_3_to_router_7_2_req;
floo_rsp_t router_7_2_to_router_7_3_rsp;
floo_wide_t router_7_3_to_router_7_2_wide;

floo_req_t router_7_3_to_hbm_north_ni_7_0_req;
floo_rsp_t hbm_north_ni_7_0_to_router_7_3_rsp;
floo_wide_t router_7_3_to_hbm_north_ni_7_0_wide;

floo_req_t router_7_3_to_spm_wide_ni_req;
floo_rsp_t spm_wide_ni_to_router_7_3_rsp;
floo_wide_t router_7_3_to_spm_wide_ni_wide;

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

floo_req_t hbm_north_ni_5_0_to_router_5_3_req;
floo_rsp_t router_5_3_to_hbm_north_ni_5_0_rsp;
floo_wide_t hbm_north_ni_5_0_to_router_5_3_wide;

floo_req_t hbm_north_ni_6_0_to_router_6_3_req;
floo_rsp_t router_6_3_to_hbm_north_ni_6_0_rsp;
floo_wide_t hbm_north_ni_6_0_to_router_6_3_wide;

floo_req_t hbm_north_ni_7_0_to_router_7_3_req;
floo_rsp_t router_7_3_to_hbm_north_ni_7_0_rsp;
floo_wide_t hbm_north_ni_7_0_to_router_7_3_wide;

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

floo_req_t hbm_south_ni_5_0_to_router_5_0_req;
floo_rsp_t router_5_0_to_hbm_south_ni_5_0_rsp;
floo_wide_t hbm_south_ni_5_0_to_router_5_0_wide;

floo_req_t hbm_south_ni_6_0_to_router_6_0_req;
floo_rsp_t router_6_0_to_hbm_south_ni_6_0_rsp;
floo_wide_t hbm_south_ni_6_0_to_router_6_0_wide;

floo_req_t hbm_south_ni_7_0_to_router_7_0_req;
floo_rsp_t router_7_0_to_hbm_south_ni_7_0_rsp;
floo_wide_t hbm_south_ni_7_0_to_router_7_0_wide;

floo_req_t pcie_ni_to_router_0_3_req;
floo_rsp_t router_0_3_to_pcie_ni_rsp;
floo_wide_t pcie_ni_to_router_0_3_wide;

floo_req_t peripherals_ni_to_router_0_2_req;
floo_rsp_t router_0_2_to_peripherals_ni_rsp;
floo_wide_t peripherals_ni_to_router_0_2_wide;

floo_req_t jtag_ni_to_router_0_1_req;
floo_rsp_t router_0_1_to_jtag_ni_rsp;
floo_wide_t jtag_ni_to_router_0_1_wide;

floo_req_t cva6_ni_to_router_0_0_req;
floo_rsp_t router_0_0_to_cva6_ni_rsp;
floo_wide_t cva6_ni_to_router_0_0_wide;

floo_req_t spm_wide_ni_to_router_7_3_req;
floo_rsp_t router_7_3_to_spm_wide_ni_rsp;
floo_wide_t spm_wide_ni_to_router_7_3_wide;

floo_req_t spm_narrow_ni_to_router_7_2_req;
floo_rsp_t router_7_2_to_spm_narrow_ni_rsp;
floo_wide_t spm_narrow_ni_to_router_7_2_wide;

floo_req_t idma_ni_to_router_7_1_req;
floo_rsp_t router_7_1_to_idma_ni_rsp;
floo_wide_t idma_ni_to_router_7_1_wide;

floo_req_t zero_mem_ni_to_router_7_0_req;
floo_rsp_t router_7_0_to_zero_mem_ni_rsp;
floo_wide_t zero_mem_ni_to_router_7_0_wide;



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

localparam id_t hbm_north_ni_5_0_id = '{x: 6, y: 5};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_north_ni_5_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_north_narrow_req_o[5] ),
  .axi_narrow_out_rsp_i ( hbm_north_narrow_rsp_i[5] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_north_wide_req_o[5] ),
  .axi_wide_out_rsp_i ( hbm_north_wide_rsp_i[5] ),
  .id_i             ( hbm_north_ni_5_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_north_ni_5_0_to_router_5_3_req   ),
  .floo_rsp_i       ( router_5_3_to_hbm_north_ni_5_0_rsp   ),
  .floo_wide_o      ( hbm_north_ni_5_0_to_router_5_3_wide  ),
  .floo_req_i       ( router_5_3_to_hbm_north_ni_5_0_req   ),
  .floo_rsp_o       ( hbm_north_ni_5_0_to_router_5_3_rsp   ),
  .floo_wide_i      ( router_5_3_to_hbm_north_ni_5_0_wide  )
);

localparam id_t hbm_north_ni_6_0_id = '{x: 7, y: 5};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_north_ni_6_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_north_narrow_req_o[6] ),
  .axi_narrow_out_rsp_i ( hbm_north_narrow_rsp_i[6] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_north_wide_req_o[6] ),
  .axi_wide_out_rsp_i ( hbm_north_wide_rsp_i[6] ),
  .id_i             ( hbm_north_ni_6_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_north_ni_6_0_to_router_6_3_req   ),
  .floo_rsp_i       ( router_6_3_to_hbm_north_ni_6_0_rsp   ),
  .floo_wide_o      ( hbm_north_ni_6_0_to_router_6_3_wide  ),
  .floo_req_i       ( router_6_3_to_hbm_north_ni_6_0_req   ),
  .floo_rsp_o       ( hbm_north_ni_6_0_to_router_6_3_rsp   ),
  .floo_wide_i      ( router_6_3_to_hbm_north_ni_6_0_wide  )
);

localparam id_t hbm_north_ni_7_0_id = '{x: 8, y: 5};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_north_ni_7_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_north_narrow_req_o[7] ),
  .axi_narrow_out_rsp_i ( hbm_north_narrow_rsp_i[7] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_north_wide_req_o[7] ),
  .axi_wide_out_rsp_i ( hbm_north_wide_rsp_i[7] ),
  .id_i             ( hbm_north_ni_7_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_north_ni_7_0_to_router_7_3_req   ),
  .floo_rsp_i       ( router_7_3_to_hbm_north_ni_7_0_rsp   ),
  .floo_wide_o      ( hbm_north_ni_7_0_to_router_7_3_wide  ),
  .floo_req_i       ( router_7_3_to_hbm_north_ni_7_0_req   ),
  .floo_rsp_o       ( hbm_north_ni_7_0_to_router_7_3_rsp   ),
  .floo_wide_i      ( router_7_3_to_hbm_north_ni_7_0_wide  )
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

localparam id_t hbm_south_ni_5_0_id = '{x: 6, y: 0};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_south_ni_5_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_south_narrow_req_o[5] ),
  .axi_narrow_out_rsp_i ( hbm_south_narrow_rsp_i[5] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_south_wide_req_o[5] ),
  .axi_wide_out_rsp_i ( hbm_south_wide_rsp_i[5] ),
  .id_i             ( hbm_south_ni_5_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_south_ni_5_0_to_router_5_0_req   ),
  .floo_rsp_i       ( router_5_0_to_hbm_south_ni_5_0_rsp   ),
  .floo_wide_o      ( hbm_south_ni_5_0_to_router_5_0_wide  ),
  .floo_req_i       ( router_5_0_to_hbm_south_ni_5_0_req   ),
  .floo_rsp_o       ( hbm_south_ni_5_0_to_router_5_0_rsp   ),
  .floo_wide_i      ( router_5_0_to_hbm_south_ni_5_0_wide  )
);

localparam id_t hbm_south_ni_6_0_id = '{x: 7, y: 0};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_south_ni_6_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_south_narrow_req_o[6] ),
  .axi_narrow_out_rsp_i ( hbm_south_narrow_rsp_i[6] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_south_wide_req_o[6] ),
  .axi_wide_out_rsp_i ( hbm_south_wide_rsp_i[6] ),
  .id_i             ( hbm_south_ni_6_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_south_ni_6_0_to_router_6_0_req   ),
  .floo_rsp_i       ( router_6_0_to_hbm_south_ni_6_0_rsp   ),
  .floo_wide_o      ( hbm_south_ni_6_0_to_router_6_0_wide  ),
  .floo_req_i       ( router_6_0_to_hbm_south_ni_6_0_req   ),
  .floo_rsp_o       ( hbm_south_ni_6_0_to_router_6_0_rsp   ),
  .floo_wide_i      ( router_6_0_to_hbm_south_ni_6_0_wide  )
);

localparam id_t hbm_south_ni_7_0_id = '{x: 8, y: 0};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) hbm_south_ni_7_0 (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( hbm_south_narrow_req_o[7] ),
  .axi_narrow_out_rsp_i ( hbm_south_narrow_rsp_i[7] ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o ( hbm_south_wide_req_o[7] ),
  .axi_wide_out_rsp_i ( hbm_south_wide_rsp_i[7] ),
  .id_i             ( hbm_south_ni_7_0_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( hbm_south_ni_7_0_to_router_7_0_req   ),
  .floo_rsp_i       ( router_7_0_to_hbm_south_ni_7_0_rsp   ),
  .floo_wide_o      ( hbm_south_ni_7_0_to_router_7_0_wide  ),
  .floo_req_i       ( router_7_0_to_hbm_south_ni_7_0_req   ),
  .floo_rsp_o       ( hbm_south_ni_7_0_to_router_7_0_rsp   ),
  .floo_wide_i      ( router_7_0_to_hbm_south_ni_7_0_wide  )
);

localparam id_t pcie_ni_id = '{x: 0, y: 4};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b1),
  .EnWideSbrPort(1'b0),
  .EnWideMgrPort(1'b0)
) pcie_ni (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( pcie_narrow_req_i ),
  .axi_narrow_in_rsp_o  ( pcie_narrow_rsp_o ),
  .axi_narrow_out_req_o ( pcie_narrow_req_o ),
  .axi_narrow_out_rsp_i ( pcie_narrow_rsp_i ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o (    ),
  .axi_wide_out_rsp_i ( '0 ),
  .id_i             ( pcie_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( pcie_ni_to_router_0_3_req   ),
  .floo_rsp_i       ( router_0_3_to_pcie_ni_rsp   ),
  .floo_wide_o      ( pcie_ni_to_router_0_3_wide  ),
  .floo_req_i       ( router_0_3_to_pcie_ni_req   ),
  .floo_rsp_o       ( pcie_ni_to_router_0_3_rsp   ),
  .floo_wide_i      ( router_0_3_to_pcie_ni_wide  )
);

localparam id_t peripherals_ni_id = '{x: 0, y: 3};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b0),
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
  .axi_wide_out_req_o (    ),
  .axi_wide_out_rsp_i ( '0 ),
  .id_i             ( peripherals_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( peripherals_ni_to_router_0_2_req   ),
  .floo_rsp_i       ( router_0_2_to_peripherals_ni_rsp   ),
  .floo_wide_o      ( peripherals_ni_to_router_0_2_wide  ),
  .floo_req_i       ( router_0_2_to_peripherals_ni_req   ),
  .floo_rsp_o       ( peripherals_ni_to_router_0_2_rsp   ),
  .floo_wide_i      ( router_0_2_to_peripherals_ni_wide  )
);

localparam id_t jtag_ni_id = '{x: 0, y: 2};


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
  .floo_req_o       ( jtag_ni_to_router_0_1_req   ),
  .floo_rsp_i       ( router_0_1_to_jtag_ni_rsp   ),
  .floo_wide_o      ( jtag_ni_to_router_0_1_wide  ),
  .floo_req_i       ( router_0_1_to_jtag_ni_req   ),
  .floo_rsp_o       ( jtag_ni_to_router_0_1_rsp   ),
  .floo_wide_i      ( router_0_1_to_jtag_ni_wide  )
);

localparam id_t cva6_ni_id = '{x: 0, y: 1};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b0),
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
  .axi_narrow_out_req_o (    ),
  .axi_narrow_out_rsp_i ( '0 ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o (    ),
  .axi_wide_out_rsp_i ( '0 ),
  .id_i             ( cva6_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( cva6_ni_to_router_0_0_req   ),
  .floo_rsp_i       ( router_0_0_to_cva6_ni_rsp   ),
  .floo_wide_o      ( cva6_ni_to_router_0_0_wide  ),
  .floo_req_i       ( router_0_0_to_cva6_ni_req   ),
  .floo_rsp_o       ( cva6_ni_to_router_0_0_rsp   ),
  .floo_wide_i      ( router_0_0_to_cva6_ni_wide  )
);

localparam id_t spm_wide_ni_id = '{x: 9, y: 4};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b0),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b1),
  .EnWideMgrPort(1'b0)
) spm_wide_ni (
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
  .axi_wide_out_req_o ( spm_wide_wide_req_o ),
  .axi_wide_out_rsp_i ( spm_wide_wide_rsp_i ),
  .id_i             ( spm_wide_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( spm_wide_ni_to_router_7_3_req   ),
  .floo_rsp_i       ( router_7_3_to_spm_wide_ni_rsp   ),
  .floo_wide_o      ( spm_wide_ni_to_router_7_3_wide  ),
  .floo_req_i       ( router_7_3_to_spm_wide_ni_req   ),
  .floo_rsp_o       ( spm_wide_ni_to_router_7_3_rsp   ),
  .floo_wide_i      ( router_7_3_to_spm_wide_ni_wide  )
);

localparam id_t spm_narrow_ni_id = '{x: 9, y: 3};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b0),
  .EnWideMgrPort(1'b0)
) spm_narrow_ni (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( spm_narrow_narrow_req_o ),
  .axi_narrow_out_rsp_i ( spm_narrow_narrow_rsp_i ),
  .axi_wide_in_req_i  ( '0 ),
  .axi_wide_in_rsp_o  (    ),
  .axi_wide_out_req_o (    ),
  .axi_wide_out_rsp_i ( '0 ),
  .id_i             ( spm_narrow_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( spm_narrow_ni_to_router_7_2_req   ),
  .floo_rsp_i       ( router_7_2_to_spm_narrow_ni_rsp   ),
  .floo_wide_o      ( spm_narrow_ni_to_router_7_2_wide  ),
  .floo_req_i       ( router_7_2_to_spm_narrow_ni_req   ),
  .floo_rsp_o       ( spm_narrow_ni_to_router_7_2_rsp   ),
  .floo_wide_i      ( router_7_2_to_spm_narrow_ni_wide  )
);

localparam id_t idma_ni_id = '{x: 9, y: 2};


floo_narrow_wide_chimney  #(
  .EnNarrowSbrPort(1'b1),
  .EnNarrowMgrPort(1'b0),
  .EnWideSbrPort(1'b0),
  .EnWideMgrPort(1'b1)
) idma_ni (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .sram_cfg_i ( '0 ),
  .axi_narrow_in_req_i  ( '0 ),
  .axi_narrow_in_rsp_o  (    ),
  .axi_narrow_out_req_o ( idma_narrow_req_o ),
  .axi_narrow_out_rsp_i ( idma_narrow_rsp_i ),
  .axi_wide_in_req_i  ( idma_wide_req_i ),
  .axi_wide_in_rsp_o  ( idma_wide_rsp_o ),
  .axi_wide_out_req_o (    ),
  .axi_wide_out_rsp_i ( '0 ),
  .id_i             ( idma_ni_id    ),
  .route_table_i    ( '0                          ),
  .floo_req_o       ( idma_ni_to_router_7_1_req   ),
  .floo_rsp_i       ( router_7_1_to_idma_ni_rsp   ),
  .floo_wide_o      ( idma_ni_to_router_7_1_wide  ),
  .floo_req_i       ( router_7_1_to_idma_ni_req   ),
  .floo_rsp_o       ( idma_ni_to_router_7_1_rsp   ),
  .floo_wide_i      ( router_7_1_to_idma_ni_wide  )
);

localparam id_t zero_mem_ni_id = '{x: 9, y: 1};


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
  .floo_req_o       ( zero_mem_ni_to_router_7_0_req   ),
  .floo_rsp_i       ( router_7_0_to_zero_mem_ni_rsp   ),
  .floo_wide_o      ( zero_mem_ni_to_router_7_0_wide  ),
  .floo_req_i       ( router_7_0_to_zero_mem_ni_req   ),
  .floo_rsp_o       ( zero_mem_ni_to_router_7_0_rsp   ),
  .floo_wide_i      ( router_7_0_to_zero_mem_ni_wide  )
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
  assign router_0_0_req_in[West] = cva6_ni_to_router_0_0_req;

  assign router_0_0_to_router_1_0_rsp = router_0_0_rsp_out[East];
  assign router_0_0_to_router_0_1_rsp = router_0_0_rsp_out[North];
  assign router_0_0_to_hbm_south_ni_0_0_rsp = router_0_0_rsp_out[South];
  assign router_0_0_to_cva6_ni_rsp = router_0_0_rsp_out[West];

  assign router_0_0_to_router_1_0_req = router_0_0_req_out[East];
  assign router_0_0_to_router_0_1_req = router_0_0_req_out[North];
  assign router_0_0_to_hbm_south_ni_0_0_req = router_0_0_req_out[South];
  assign router_0_0_to_cva6_ni_req = router_0_0_req_out[West];

  assign router_0_0_rsp_in[East] = router_1_0_to_router_0_0_rsp;
  assign router_0_0_rsp_in[North] = router_0_1_to_router_0_0_rsp;
  assign router_0_0_rsp_in[South] = hbm_south_ni_0_0_to_router_0_0_rsp;
  assign router_0_0_rsp_in[West] = cva6_ni_to_router_0_0_rsp;

  assign router_0_0_wide_in[East] = router_1_0_to_router_0_0_wide;
  assign router_0_0_wide_in[North] = router_0_1_to_router_0_0_wide;
  assign router_0_0_wide_in[South] = hbm_south_ni_0_0_to_router_0_0_wide;
  assign router_0_0_wide_in[West] = cva6_ni_to_router_0_0_wide;

  assign router_0_0_to_router_1_0_wide = router_0_0_wide_out[East];
  assign router_0_0_to_router_0_1_wide = router_0_0_wide_out[North];
  assign router_0_0_to_hbm_south_ni_0_0_wide = router_0_0_wide_out[South];
  assign router_0_0_to_cva6_ni_wide = router_0_0_wide_out[West];

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
  assign router_0_1_req_in[West] = jtag_ni_to_router_0_1_req;

  assign router_0_1_to_router_1_1_rsp = router_0_1_rsp_out[East];
  assign router_0_1_to_router_0_2_rsp = router_0_1_rsp_out[North];
  assign router_0_1_to_router_0_0_rsp = router_0_1_rsp_out[South];
  assign router_0_1_to_jtag_ni_rsp = router_0_1_rsp_out[West];

  assign router_0_1_to_router_1_1_req = router_0_1_req_out[East];
  assign router_0_1_to_router_0_2_req = router_0_1_req_out[North];
  assign router_0_1_to_router_0_0_req = router_0_1_req_out[South];
  assign router_0_1_to_jtag_ni_req = router_0_1_req_out[West];

  assign router_0_1_rsp_in[East] = router_1_1_to_router_0_1_rsp;
  assign router_0_1_rsp_in[North] = router_0_2_to_router_0_1_rsp;
  assign router_0_1_rsp_in[South] = router_0_0_to_router_0_1_rsp;
  assign router_0_1_rsp_in[West] = jtag_ni_to_router_0_1_rsp;

  assign router_0_1_wide_in[East] = router_1_1_to_router_0_1_wide;
  assign router_0_1_wide_in[North] = router_0_2_to_router_0_1_wide;
  assign router_0_1_wide_in[South] = router_0_0_to_router_0_1_wide;
  assign router_0_1_wide_in[West] = jtag_ni_to_router_0_1_wide;

  assign router_0_1_to_router_1_1_wide = router_0_1_wide_out[East];
  assign router_0_1_to_router_0_2_wide = router_0_1_wide_out[North];
  assign router_0_1_to_router_0_0_wide = router_0_1_wide_out[South];
  assign router_0_1_to_jtag_ni_wide = router_0_1_wide_out[West];

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
  assign router_0_2_req_in[West] = peripherals_ni_to_router_0_2_req;

  assign router_0_2_to_router_1_2_rsp = router_0_2_rsp_out[East];
  assign router_0_2_to_router_0_3_rsp = router_0_2_rsp_out[North];
  assign router_0_2_to_router_0_1_rsp = router_0_2_rsp_out[South];
  assign router_0_2_to_peripherals_ni_rsp = router_0_2_rsp_out[West];

  assign router_0_2_to_router_1_2_req = router_0_2_req_out[East];
  assign router_0_2_to_router_0_3_req = router_0_2_req_out[North];
  assign router_0_2_to_router_0_1_req = router_0_2_req_out[South];
  assign router_0_2_to_peripherals_ni_req = router_0_2_req_out[West];

  assign router_0_2_rsp_in[East] = router_1_2_to_router_0_2_rsp;
  assign router_0_2_rsp_in[North] = router_0_3_to_router_0_2_rsp;
  assign router_0_2_rsp_in[South] = router_0_1_to_router_0_2_rsp;
  assign router_0_2_rsp_in[West] = peripherals_ni_to_router_0_2_rsp;

  assign router_0_2_wide_in[East] = router_1_2_to_router_0_2_wide;
  assign router_0_2_wide_in[North] = router_0_3_to_router_0_2_wide;
  assign router_0_2_wide_in[South] = router_0_1_to_router_0_2_wide;
  assign router_0_2_wide_in[West] = peripherals_ni_to_router_0_2_wide;

  assign router_0_2_to_router_1_2_wide = router_0_2_wide_out[East];
  assign router_0_2_to_router_0_3_wide = router_0_2_wide_out[North];
  assign router_0_2_to_router_0_1_wide = router_0_2_wide_out[South];
  assign router_0_2_to_peripherals_ni_wide = router_0_2_wide_out[West];

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
  assign router_0_3_req_in[West] = pcie_ni_to_router_0_3_req;

  assign router_0_3_to_router_1_3_rsp = router_0_3_rsp_out[East];
  assign router_0_3_to_hbm_north_ni_0_0_rsp = router_0_3_rsp_out[North];
  assign router_0_3_to_router_0_2_rsp = router_0_3_rsp_out[South];
  assign router_0_3_to_pcie_ni_rsp = router_0_3_rsp_out[West];

  assign router_0_3_to_router_1_3_req = router_0_3_req_out[East];
  assign router_0_3_to_hbm_north_ni_0_0_req = router_0_3_req_out[North];
  assign router_0_3_to_router_0_2_req = router_0_3_req_out[South];
  assign router_0_3_to_pcie_ni_req = router_0_3_req_out[West];

  assign router_0_3_rsp_in[East] = router_1_3_to_router_0_3_rsp;
  assign router_0_3_rsp_in[North] = hbm_north_ni_0_0_to_router_0_3_rsp;
  assign router_0_3_rsp_in[South] = router_0_2_to_router_0_3_rsp;
  assign router_0_3_rsp_in[West] = pcie_ni_to_router_0_3_rsp;

  assign router_0_3_wide_in[East] = router_1_3_to_router_0_3_wide;
  assign router_0_3_wide_in[North] = hbm_north_ni_0_0_to_router_0_3_wide;
  assign router_0_3_wide_in[South] = router_0_2_to_router_0_3_wide;
  assign router_0_3_wide_in[West] = pcie_ni_to_router_0_3_wide;

  assign router_0_3_to_router_1_3_wide = router_0_3_wide_out[East];
  assign router_0_3_to_hbm_north_ni_0_0_wide = router_0_3_wide_out[North];
  assign router_0_3_to_router_0_2_wide = router_0_3_wide_out[South];
  assign router_0_3_to_pcie_ni_wide = router_0_3_wide_out[West];

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

  assign router_4_0_req_in[East] = router_5_0_to_router_4_0_req;
  assign router_4_0_req_in[North] = router_4_1_to_router_4_0_req;
  assign router_4_0_req_in[South] = hbm_south_ni_4_0_to_router_4_0_req;
  assign router_4_0_req_in[West] = router_3_0_to_router_4_0_req;

  assign router_4_0_to_router_5_0_rsp = router_4_0_rsp_out[East];
  assign router_4_0_to_router_4_1_rsp = router_4_0_rsp_out[North];
  assign router_4_0_to_hbm_south_ni_4_0_rsp = router_4_0_rsp_out[South];
  assign router_4_0_to_router_3_0_rsp = router_4_0_rsp_out[West];

  assign router_4_0_to_router_5_0_req = router_4_0_req_out[East];
  assign router_4_0_to_router_4_1_req = router_4_0_req_out[North];
  assign router_4_0_to_hbm_south_ni_4_0_req = router_4_0_req_out[South];
  assign router_4_0_to_router_3_0_req = router_4_0_req_out[West];

  assign router_4_0_rsp_in[East] = router_5_0_to_router_4_0_rsp;
  assign router_4_0_rsp_in[North] = router_4_1_to_router_4_0_rsp;
  assign router_4_0_rsp_in[South] = hbm_south_ni_4_0_to_router_4_0_rsp;
  assign router_4_0_rsp_in[West] = router_3_0_to_router_4_0_rsp;

  assign router_4_0_wide_in[East] = router_5_0_to_router_4_0_wide;
  assign router_4_0_wide_in[North] = router_4_1_to_router_4_0_wide;
  assign router_4_0_wide_in[South] = hbm_south_ni_4_0_to_router_4_0_wide;
  assign router_4_0_wide_in[West] = router_3_0_to_router_4_0_wide;

  assign router_4_0_to_router_5_0_wide = router_4_0_wide_out[East];
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

  assign router_4_3_req_in[East] = router_5_3_to_router_4_3_req;
  assign router_4_3_req_in[North] = hbm_north_ni_4_0_to_router_4_3_req;
  assign router_4_3_req_in[South] = router_4_2_to_router_4_3_req;
  assign router_4_3_req_in[West] = router_3_3_to_router_4_3_req;

  assign router_4_3_to_router_5_3_rsp = router_4_3_rsp_out[East];
  assign router_4_3_to_hbm_north_ni_4_0_rsp = router_4_3_rsp_out[North];
  assign router_4_3_to_router_4_2_rsp = router_4_3_rsp_out[South];
  assign router_4_3_to_router_3_3_rsp = router_4_3_rsp_out[West];

  assign router_4_3_to_router_5_3_req = router_4_3_req_out[East];
  assign router_4_3_to_hbm_north_ni_4_0_req = router_4_3_req_out[North];
  assign router_4_3_to_router_4_2_req = router_4_3_req_out[South];
  assign router_4_3_to_router_3_3_req = router_4_3_req_out[West];

  assign router_4_3_rsp_in[East] = router_5_3_to_router_4_3_rsp;
  assign router_4_3_rsp_in[North] = hbm_north_ni_4_0_to_router_4_3_rsp;
  assign router_4_3_rsp_in[South] = router_4_2_to_router_4_3_rsp;
  assign router_4_3_rsp_in[West] = router_3_3_to_router_4_3_rsp;

  assign router_4_3_wide_in[East] = router_5_3_to_router_4_3_wide;
  assign router_4_3_wide_in[North] = hbm_north_ni_4_0_to_router_4_3_wide;
  assign router_4_3_wide_in[South] = router_4_2_to_router_4_3_wide;
  assign router_4_3_wide_in[West] = router_3_3_to_router_4_3_wide;

  assign router_4_3_to_router_5_3_wide = router_4_3_wide_out[East];
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


floo_req_t [West:North] router_5_0_req_in;
floo_rsp_t [West:North] router_5_0_rsp_out;
floo_req_t [West:North] router_5_0_req_out;
floo_rsp_t [West:North] router_5_0_rsp_in;
floo_wide_t [West:North] router_5_0_wide_in;
floo_wide_t [West:North] router_5_0_wide_out;

  assign router_5_0_req_in[East] = router_6_0_to_router_5_0_req;
  assign router_5_0_req_in[North] = router_5_1_to_router_5_0_req;
  assign router_5_0_req_in[South] = hbm_south_ni_5_0_to_router_5_0_req;
  assign router_5_0_req_in[West] = router_4_0_to_router_5_0_req;

  assign router_5_0_to_router_6_0_rsp = router_5_0_rsp_out[East];
  assign router_5_0_to_router_5_1_rsp = router_5_0_rsp_out[North];
  assign router_5_0_to_hbm_south_ni_5_0_rsp = router_5_0_rsp_out[South];
  assign router_5_0_to_router_4_0_rsp = router_5_0_rsp_out[West];

  assign router_5_0_to_router_6_0_req = router_5_0_req_out[East];
  assign router_5_0_to_router_5_1_req = router_5_0_req_out[North];
  assign router_5_0_to_hbm_south_ni_5_0_req = router_5_0_req_out[South];
  assign router_5_0_to_router_4_0_req = router_5_0_req_out[West];

  assign router_5_0_rsp_in[East] = router_6_0_to_router_5_0_rsp;
  assign router_5_0_rsp_in[North] = router_5_1_to_router_5_0_rsp;
  assign router_5_0_rsp_in[South] = hbm_south_ni_5_0_to_router_5_0_rsp;
  assign router_5_0_rsp_in[West] = router_4_0_to_router_5_0_rsp;

  assign router_5_0_wide_in[East] = router_6_0_to_router_5_0_wide;
  assign router_5_0_wide_in[North] = router_5_1_to_router_5_0_wide;
  assign router_5_0_wide_in[South] = hbm_south_ni_5_0_to_router_5_0_wide;
  assign router_5_0_wide_in[West] = router_4_0_to_router_5_0_wide;

  assign router_5_0_to_router_6_0_wide = router_5_0_wide_out[East];
  assign router_5_0_to_router_5_1_wide = router_5_0_wide_out[North];
  assign router_5_0_to_hbm_south_ni_5_0_wide = router_5_0_wide_out[South];
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
  .tile_id_i (5'd20),
  .meip_i (9'b0),
  .mtip_i (mtip_i[189:181]),
  .msip_i (msip_i[189:181]),
  .id_i (compute_tile_5_0_id),
  .floo_req_i (router_5_0_req_in),
  .floo_rsp_o (router_5_0_rsp_out),
  .floo_req_o (router_5_0_req_out),
  .floo_rsp_i (router_5_0_rsp_in),
  .floo_wide_i (router_5_0_wide_in),
  .floo_wide_o (router_5_0_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
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
  .tile_id_i (5'd21),
  .meip_i (9'b0),
  .mtip_i (mtip_i[198:190]),
  .msip_i (msip_i[198:190]),
  .id_i (compute_tile_5_1_id),
  .floo_req_i (router_5_1_req_in),
  .floo_rsp_o (router_5_1_rsp_out),
  .floo_req_o (router_5_1_req_out),
  .floo_rsp_i (router_5_1_rsp_in),
  .floo_wide_i (router_5_1_wide_in),
  .floo_wide_o (router_5_1_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
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
  .tile_id_i (5'd22),
  .meip_i (9'b0),
  .mtip_i (mtip_i[207:199]),
  .msip_i (msip_i[207:199]),
  .id_i (compute_tile_5_2_id),
  .floo_req_i (router_5_2_req_in),
  .floo_rsp_o (router_5_2_rsp_out),
  .floo_req_o (router_5_2_req_out),
  .floo_rsp_i (router_5_2_rsp_in),
  .floo_wide_i (router_5_2_wide_in),
  .floo_wide_o (router_5_2_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_5_3_req_in;
floo_rsp_t [West:North] router_5_3_rsp_out;
floo_req_t [West:North] router_5_3_req_out;
floo_rsp_t [West:North] router_5_3_rsp_in;
floo_wide_t [West:North] router_5_3_wide_in;
floo_wide_t [West:North] router_5_3_wide_out;

  assign router_5_3_req_in[East] = router_6_3_to_router_5_3_req;
  assign router_5_3_req_in[North] = hbm_north_ni_5_0_to_router_5_3_req;
  assign router_5_3_req_in[South] = router_5_2_to_router_5_3_req;
  assign router_5_3_req_in[West] = router_4_3_to_router_5_3_req;

  assign router_5_3_to_router_6_3_rsp = router_5_3_rsp_out[East];
  assign router_5_3_to_hbm_north_ni_5_0_rsp = router_5_3_rsp_out[North];
  assign router_5_3_to_router_5_2_rsp = router_5_3_rsp_out[South];
  assign router_5_3_to_router_4_3_rsp = router_5_3_rsp_out[West];

  assign router_5_3_to_router_6_3_req = router_5_3_req_out[East];
  assign router_5_3_to_hbm_north_ni_5_0_req = router_5_3_req_out[North];
  assign router_5_3_to_router_5_2_req = router_5_3_req_out[South];
  assign router_5_3_to_router_4_3_req = router_5_3_req_out[West];

  assign router_5_3_rsp_in[East] = router_6_3_to_router_5_3_rsp;
  assign router_5_3_rsp_in[North] = hbm_north_ni_5_0_to_router_5_3_rsp;
  assign router_5_3_rsp_in[South] = router_5_2_to_router_5_3_rsp;
  assign router_5_3_rsp_in[West] = router_4_3_to_router_5_3_rsp;

  assign router_5_3_wide_in[East] = router_6_3_to_router_5_3_wide;
  assign router_5_3_wide_in[North] = hbm_north_ni_5_0_to_router_5_3_wide;
  assign router_5_3_wide_in[South] = router_5_2_to_router_5_3_wide;
  assign router_5_3_wide_in[West] = router_4_3_to_router_5_3_wide;

  assign router_5_3_to_router_6_3_wide = router_5_3_wide_out[East];
  assign router_5_3_to_hbm_north_ni_5_0_wide = router_5_3_wide_out[North];
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
  .tile_id_i (5'd23),
  .meip_i (9'b0),
  .mtip_i (mtip_i[216:208]),
  .msip_i (msip_i[216:208]),
  .id_i (compute_tile_5_3_id),
  .floo_req_i (router_5_3_req_in),
  .floo_rsp_o (router_5_3_rsp_out),
  .floo_req_o (router_5_3_req_out),
  .floo_rsp_i (router_5_3_rsp_in),
  .floo_wide_i (router_5_3_wide_in),
  .floo_wide_o (router_5_3_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_6_0_req_in;
floo_rsp_t [West:North] router_6_0_rsp_out;
floo_req_t [West:North] router_6_0_req_out;
floo_rsp_t [West:North] router_6_0_rsp_in;
floo_wide_t [West:North] router_6_0_wide_in;
floo_wide_t [West:North] router_6_0_wide_out;

  assign router_6_0_req_in[East] = router_7_0_to_router_6_0_req;
  assign router_6_0_req_in[North] = router_6_1_to_router_6_0_req;
  assign router_6_0_req_in[South] = hbm_south_ni_6_0_to_router_6_0_req;
  assign router_6_0_req_in[West] = router_5_0_to_router_6_0_req;

  assign router_6_0_to_router_7_0_rsp = router_6_0_rsp_out[East];
  assign router_6_0_to_router_6_1_rsp = router_6_0_rsp_out[North];
  assign router_6_0_to_hbm_south_ni_6_0_rsp = router_6_0_rsp_out[South];
  assign router_6_0_to_router_5_0_rsp = router_6_0_rsp_out[West];

  assign router_6_0_to_router_7_0_req = router_6_0_req_out[East];
  assign router_6_0_to_router_6_1_req = router_6_0_req_out[North];
  assign router_6_0_to_hbm_south_ni_6_0_req = router_6_0_req_out[South];
  assign router_6_0_to_router_5_0_req = router_6_0_req_out[West];

  assign router_6_0_rsp_in[East] = router_7_0_to_router_6_0_rsp;
  assign router_6_0_rsp_in[North] = router_6_1_to_router_6_0_rsp;
  assign router_6_0_rsp_in[South] = hbm_south_ni_6_0_to_router_6_0_rsp;
  assign router_6_0_rsp_in[West] = router_5_0_to_router_6_0_rsp;

  assign router_6_0_wide_in[East] = router_7_0_to_router_6_0_wide;
  assign router_6_0_wide_in[North] = router_6_1_to_router_6_0_wide;
  assign router_6_0_wide_in[South] = hbm_south_ni_6_0_to_router_6_0_wide;
  assign router_6_0_wide_in[West] = router_5_0_to_router_6_0_wide;

  assign router_6_0_to_router_7_0_wide = router_6_0_wide_out[East];
  assign router_6_0_to_router_6_1_wide = router_6_0_wide_out[North];
  assign router_6_0_to_hbm_south_ni_6_0_wide = router_6_0_wide_out[South];
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
  .tile_id_i (5'd24),
  .meip_i (9'b0),
  .mtip_i (mtip_i[225:217]),
  .msip_i (msip_i[225:217]),
  .id_i (compute_tile_6_0_id),
  .floo_req_i (router_6_0_req_in),
  .floo_rsp_o (router_6_0_rsp_out),
  .floo_req_o (router_6_0_req_out),
  .floo_rsp_i (router_6_0_rsp_in),
  .floo_wide_i (router_6_0_wide_in),
  .floo_wide_o (router_6_0_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_6_1_req_in;
floo_rsp_t [West:North] router_6_1_rsp_out;
floo_req_t [West:North] router_6_1_req_out;
floo_rsp_t [West:North] router_6_1_rsp_in;
floo_wide_t [West:North] router_6_1_wide_in;
floo_wide_t [West:North] router_6_1_wide_out;

  assign router_6_1_req_in[East] = router_7_1_to_router_6_1_req;
  assign router_6_1_req_in[North] = router_6_2_to_router_6_1_req;
  assign router_6_1_req_in[South] = router_6_0_to_router_6_1_req;
  assign router_6_1_req_in[West] = router_5_1_to_router_6_1_req;

  assign router_6_1_to_router_7_1_rsp = router_6_1_rsp_out[East];
  assign router_6_1_to_router_6_2_rsp = router_6_1_rsp_out[North];
  assign router_6_1_to_router_6_0_rsp = router_6_1_rsp_out[South];
  assign router_6_1_to_router_5_1_rsp = router_6_1_rsp_out[West];

  assign router_6_1_to_router_7_1_req = router_6_1_req_out[East];
  assign router_6_1_to_router_6_2_req = router_6_1_req_out[North];
  assign router_6_1_to_router_6_0_req = router_6_1_req_out[South];
  assign router_6_1_to_router_5_1_req = router_6_1_req_out[West];

  assign router_6_1_rsp_in[East] = router_7_1_to_router_6_1_rsp;
  assign router_6_1_rsp_in[North] = router_6_2_to_router_6_1_rsp;
  assign router_6_1_rsp_in[South] = router_6_0_to_router_6_1_rsp;
  assign router_6_1_rsp_in[West] = router_5_1_to_router_6_1_rsp;

  assign router_6_1_wide_in[East] = router_7_1_to_router_6_1_wide;
  assign router_6_1_wide_in[North] = router_6_2_to_router_6_1_wide;
  assign router_6_1_wide_in[South] = router_6_0_to_router_6_1_wide;
  assign router_6_1_wide_in[West] = router_5_1_to_router_6_1_wide;

  assign router_6_1_to_router_7_1_wide = router_6_1_wide_out[East];
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
  .tile_id_i (5'd25),
  .meip_i (9'b0),
  .mtip_i (mtip_i[234:226]),
  .msip_i (msip_i[234:226]),
  .id_i (compute_tile_6_1_id),
  .floo_req_i (router_6_1_req_in),
  .floo_rsp_o (router_6_1_rsp_out),
  .floo_req_o (router_6_1_req_out),
  .floo_rsp_i (router_6_1_rsp_in),
  .floo_wide_i (router_6_1_wide_in),
  .floo_wide_o (router_6_1_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_6_2_req_in;
floo_rsp_t [West:North] router_6_2_rsp_out;
floo_req_t [West:North] router_6_2_req_out;
floo_rsp_t [West:North] router_6_2_rsp_in;
floo_wide_t [West:North] router_6_2_wide_in;
floo_wide_t [West:North] router_6_2_wide_out;

  assign router_6_2_req_in[East] = router_7_2_to_router_6_2_req;
  assign router_6_2_req_in[North] = router_6_3_to_router_6_2_req;
  assign router_6_2_req_in[South] = router_6_1_to_router_6_2_req;
  assign router_6_2_req_in[West] = router_5_2_to_router_6_2_req;

  assign router_6_2_to_router_7_2_rsp = router_6_2_rsp_out[East];
  assign router_6_2_to_router_6_3_rsp = router_6_2_rsp_out[North];
  assign router_6_2_to_router_6_1_rsp = router_6_2_rsp_out[South];
  assign router_6_2_to_router_5_2_rsp = router_6_2_rsp_out[West];

  assign router_6_2_to_router_7_2_req = router_6_2_req_out[East];
  assign router_6_2_to_router_6_3_req = router_6_2_req_out[North];
  assign router_6_2_to_router_6_1_req = router_6_2_req_out[South];
  assign router_6_2_to_router_5_2_req = router_6_2_req_out[West];

  assign router_6_2_rsp_in[East] = router_7_2_to_router_6_2_rsp;
  assign router_6_2_rsp_in[North] = router_6_3_to_router_6_2_rsp;
  assign router_6_2_rsp_in[South] = router_6_1_to_router_6_2_rsp;
  assign router_6_2_rsp_in[West] = router_5_2_to_router_6_2_rsp;

  assign router_6_2_wide_in[East] = router_7_2_to_router_6_2_wide;
  assign router_6_2_wide_in[North] = router_6_3_to_router_6_2_wide;
  assign router_6_2_wide_in[South] = router_6_1_to_router_6_2_wide;
  assign router_6_2_wide_in[West] = router_5_2_to_router_6_2_wide;

  assign router_6_2_to_router_7_2_wide = router_6_2_wide_out[East];
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
  .tile_id_i (5'd26),
  .meip_i (9'b0),
  .mtip_i (mtip_i[243:235]),
  .msip_i (msip_i[243:235]),
  .id_i (compute_tile_6_2_id),
  .floo_req_i (router_6_2_req_in),
  .floo_rsp_o (router_6_2_rsp_out),
  .floo_req_o (router_6_2_req_out),
  .floo_rsp_i (router_6_2_rsp_in),
  .floo_wide_i (router_6_2_wide_in),
  .floo_wide_o (router_6_2_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_6_3_req_in;
floo_rsp_t [West:North] router_6_3_rsp_out;
floo_req_t [West:North] router_6_3_req_out;
floo_rsp_t [West:North] router_6_3_rsp_in;
floo_wide_t [West:North] router_6_3_wide_in;
floo_wide_t [West:North] router_6_3_wide_out;

  assign router_6_3_req_in[East] = router_7_3_to_router_6_3_req;
  assign router_6_3_req_in[North] = hbm_north_ni_6_0_to_router_6_3_req;
  assign router_6_3_req_in[South] = router_6_2_to_router_6_3_req;
  assign router_6_3_req_in[West] = router_5_3_to_router_6_3_req;

  assign router_6_3_to_router_7_3_rsp = router_6_3_rsp_out[East];
  assign router_6_3_to_hbm_north_ni_6_0_rsp = router_6_3_rsp_out[North];
  assign router_6_3_to_router_6_2_rsp = router_6_3_rsp_out[South];
  assign router_6_3_to_router_5_3_rsp = router_6_3_rsp_out[West];

  assign router_6_3_to_router_7_3_req = router_6_3_req_out[East];
  assign router_6_3_to_hbm_north_ni_6_0_req = router_6_3_req_out[North];
  assign router_6_3_to_router_6_2_req = router_6_3_req_out[South];
  assign router_6_3_to_router_5_3_req = router_6_3_req_out[West];

  assign router_6_3_rsp_in[East] = router_7_3_to_router_6_3_rsp;
  assign router_6_3_rsp_in[North] = hbm_north_ni_6_0_to_router_6_3_rsp;
  assign router_6_3_rsp_in[South] = router_6_2_to_router_6_3_rsp;
  assign router_6_3_rsp_in[West] = router_5_3_to_router_6_3_rsp;

  assign router_6_3_wide_in[East] = router_7_3_to_router_6_3_wide;
  assign router_6_3_wide_in[North] = hbm_north_ni_6_0_to_router_6_3_wide;
  assign router_6_3_wide_in[South] = router_6_2_to_router_6_3_wide;
  assign router_6_3_wide_in[West] = router_5_3_to_router_6_3_wide;

  assign router_6_3_to_router_7_3_wide = router_6_3_wide_out[East];
  assign router_6_3_to_hbm_north_ni_6_0_wide = router_6_3_wide_out[North];
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
  .tile_id_i (5'd27),
  .meip_i (9'b0),
  .mtip_i (mtip_i[252:244]),
  .msip_i (msip_i[252:244]),
  .id_i (compute_tile_6_3_id),
  .floo_req_i (router_6_3_req_in),
  .floo_rsp_o (router_6_3_rsp_out),
  .floo_req_o (router_6_3_req_out),
  .floo_rsp_i (router_6_3_rsp_in),
  .floo_wide_i (router_6_3_wide_in),
  .floo_wide_o (router_6_3_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_7_0_req_in;
floo_rsp_t [West:North] router_7_0_rsp_out;
floo_req_t [West:North] router_7_0_req_out;
floo_rsp_t [West:North] router_7_0_rsp_in;
floo_wide_t [West:North] router_7_0_wide_in;
floo_wide_t [West:North] router_7_0_wide_out;

  assign router_7_0_req_in[East] = zero_mem_ni_to_router_7_0_req;
  assign router_7_0_req_in[North] = router_7_1_to_router_7_0_req;
  assign router_7_0_req_in[South] = hbm_south_ni_7_0_to_router_7_0_req;
  assign router_7_0_req_in[West] = router_6_0_to_router_7_0_req;

  assign router_7_0_to_zero_mem_ni_rsp = router_7_0_rsp_out[East];
  assign router_7_0_to_router_7_1_rsp = router_7_0_rsp_out[North];
  assign router_7_0_to_hbm_south_ni_7_0_rsp = router_7_0_rsp_out[South];
  assign router_7_0_to_router_6_0_rsp = router_7_0_rsp_out[West];

  assign router_7_0_to_zero_mem_ni_req = router_7_0_req_out[East];
  assign router_7_0_to_router_7_1_req = router_7_0_req_out[North];
  assign router_7_0_to_hbm_south_ni_7_0_req = router_7_0_req_out[South];
  assign router_7_0_to_router_6_0_req = router_7_0_req_out[West];

  assign router_7_0_rsp_in[East] = zero_mem_ni_to_router_7_0_rsp;
  assign router_7_0_rsp_in[North] = router_7_1_to_router_7_0_rsp;
  assign router_7_0_rsp_in[South] = hbm_south_ni_7_0_to_router_7_0_rsp;
  assign router_7_0_rsp_in[West] = router_6_0_to_router_7_0_rsp;

  assign router_7_0_wide_in[East] = zero_mem_ni_to_router_7_0_wide;
  assign router_7_0_wide_in[North] = router_7_1_to_router_7_0_wide;
  assign router_7_0_wide_in[South] = hbm_south_ni_7_0_to_router_7_0_wide;
  assign router_7_0_wide_in[West] = router_6_0_to_router_7_0_wide;

  assign router_7_0_to_zero_mem_ni_wide = router_7_0_wide_out[East];
  assign router_7_0_to_router_7_1_wide = router_7_0_wide_out[North];
  assign router_7_0_to_hbm_south_ni_7_0_wide = router_7_0_wide_out[South];
  assign router_7_0_to_router_6_0_wide = router_7_0_wide_out[West];

localparam id_t compute_tile_7_0_id = '{x: 8, y: 1};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(8),
  .id_y(1)
) 
`endif
 compute_tile_7_0 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd28),
  .meip_i (9'b0),
  .mtip_i (mtip_i[261:253]),
  .msip_i (msip_i[261:253]),
  .id_i (compute_tile_7_0_id),
  .floo_req_i (router_7_0_req_in),
  .floo_rsp_o (router_7_0_rsp_out),
  .floo_req_o (router_7_0_req_out),
  .floo_rsp_i (router_7_0_rsp_in),
  .floo_wide_i (router_7_0_wide_in),
  .floo_wide_o (router_7_0_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_7_1_req_in;
floo_rsp_t [West:North] router_7_1_rsp_out;
floo_req_t [West:North] router_7_1_req_out;
floo_rsp_t [West:North] router_7_1_rsp_in;
floo_wide_t [West:North] router_7_1_wide_in;
floo_wide_t [West:North] router_7_1_wide_out;

  assign router_7_1_req_in[East] = idma_ni_to_router_7_1_req;
  assign router_7_1_req_in[North] = router_7_2_to_router_7_1_req;
  assign router_7_1_req_in[South] = router_7_0_to_router_7_1_req;
  assign router_7_1_req_in[West] = router_6_1_to_router_7_1_req;

  assign router_7_1_to_idma_ni_rsp = router_7_1_rsp_out[East];
  assign router_7_1_to_router_7_2_rsp = router_7_1_rsp_out[North];
  assign router_7_1_to_router_7_0_rsp = router_7_1_rsp_out[South];
  assign router_7_1_to_router_6_1_rsp = router_7_1_rsp_out[West];

  assign router_7_1_to_idma_ni_req = router_7_1_req_out[East];
  assign router_7_1_to_router_7_2_req = router_7_1_req_out[North];
  assign router_7_1_to_router_7_0_req = router_7_1_req_out[South];
  assign router_7_1_to_router_6_1_req = router_7_1_req_out[West];

  assign router_7_1_rsp_in[East] = idma_ni_to_router_7_1_rsp;
  assign router_7_1_rsp_in[North] = router_7_2_to_router_7_1_rsp;
  assign router_7_1_rsp_in[South] = router_7_0_to_router_7_1_rsp;
  assign router_7_1_rsp_in[West] = router_6_1_to_router_7_1_rsp;

  assign router_7_1_wide_in[East] = idma_ni_to_router_7_1_wide;
  assign router_7_1_wide_in[North] = router_7_2_to_router_7_1_wide;
  assign router_7_1_wide_in[South] = router_7_0_to_router_7_1_wide;
  assign router_7_1_wide_in[West] = router_6_1_to_router_7_1_wide;

  assign router_7_1_to_idma_ni_wide = router_7_1_wide_out[East];
  assign router_7_1_to_router_7_2_wide = router_7_1_wide_out[North];
  assign router_7_1_to_router_7_0_wide = router_7_1_wide_out[South];
  assign router_7_1_to_router_6_1_wide = router_7_1_wide_out[West];

localparam id_t compute_tile_7_1_id = '{x: 8, y: 2};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(8),
  .id_y(2)
) 
`endif
 compute_tile_7_1 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd29),
  .meip_i (9'b0),
  .mtip_i (mtip_i[270:262]),
  .msip_i (msip_i[270:262]),
  .id_i (compute_tile_7_1_id),
  .floo_req_i (router_7_1_req_in),
  .floo_rsp_o (router_7_1_rsp_out),
  .floo_req_o (router_7_1_req_out),
  .floo_rsp_i (router_7_1_rsp_in),
  .floo_wide_i (router_7_1_wide_in),
  .floo_wide_o (router_7_1_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_7_2_req_in;
floo_rsp_t [West:North] router_7_2_rsp_out;
floo_req_t [West:North] router_7_2_req_out;
floo_rsp_t [West:North] router_7_2_rsp_in;
floo_wide_t [West:North] router_7_2_wide_in;
floo_wide_t [West:North] router_7_2_wide_out;

  assign router_7_2_req_in[East] = spm_narrow_ni_to_router_7_2_req;
  assign router_7_2_req_in[North] = router_7_3_to_router_7_2_req;
  assign router_7_2_req_in[South] = router_7_1_to_router_7_2_req;
  assign router_7_2_req_in[West] = router_6_2_to_router_7_2_req;

  assign router_7_2_to_spm_narrow_ni_rsp = router_7_2_rsp_out[East];
  assign router_7_2_to_router_7_3_rsp = router_7_2_rsp_out[North];
  assign router_7_2_to_router_7_1_rsp = router_7_2_rsp_out[South];
  assign router_7_2_to_router_6_2_rsp = router_7_2_rsp_out[West];

  assign router_7_2_to_spm_narrow_ni_req = router_7_2_req_out[East];
  assign router_7_2_to_router_7_3_req = router_7_2_req_out[North];
  assign router_7_2_to_router_7_1_req = router_7_2_req_out[South];
  assign router_7_2_to_router_6_2_req = router_7_2_req_out[West];

  assign router_7_2_rsp_in[East] = spm_narrow_ni_to_router_7_2_rsp;
  assign router_7_2_rsp_in[North] = router_7_3_to_router_7_2_rsp;
  assign router_7_2_rsp_in[South] = router_7_1_to_router_7_2_rsp;
  assign router_7_2_rsp_in[West] = router_6_2_to_router_7_2_rsp;

  assign router_7_2_wide_in[East] = spm_narrow_ni_to_router_7_2_wide;
  assign router_7_2_wide_in[North] = router_7_3_to_router_7_2_wide;
  assign router_7_2_wide_in[South] = router_7_1_to_router_7_2_wide;
  assign router_7_2_wide_in[West] = router_6_2_to_router_7_2_wide;

  assign router_7_2_to_spm_narrow_ni_wide = router_7_2_wide_out[East];
  assign router_7_2_to_router_7_3_wide = router_7_2_wide_out[North];
  assign router_7_2_to_router_7_1_wide = router_7_2_wide_out[South];
  assign router_7_2_to_router_6_2_wide = router_7_2_wide_out[West];

localparam id_t compute_tile_7_2_id = '{x: 8, y: 3};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(8),
  .id_y(3)
) 
`endif
 compute_tile_7_2 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd30),
  .meip_i (9'b0),
  .mtip_i (mtip_i[279:271]),
  .msip_i (msip_i[279:271]),
  .id_i (compute_tile_7_2_id),
  .floo_req_i (router_7_2_req_in),
  .floo_rsp_o (router_7_2_rsp_out),
  .floo_req_o (router_7_2_req_out),
  .floo_rsp_i (router_7_2_rsp_in),
  .floo_wide_i (router_7_2_wide_in),
  .floo_wide_o (router_7_2_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);


floo_req_t [West:North] router_7_3_req_in;
floo_rsp_t [West:North] router_7_3_rsp_out;
floo_req_t [West:North] router_7_3_req_out;
floo_rsp_t [West:North] router_7_3_rsp_in;
floo_wide_t [West:North] router_7_3_wide_in;
floo_wide_t [West:North] router_7_3_wide_out;

  assign router_7_3_req_in[East] = spm_wide_ni_to_router_7_3_req;
  assign router_7_3_req_in[North] = hbm_north_ni_7_0_to_router_7_3_req;
  assign router_7_3_req_in[South] = router_7_2_to_router_7_3_req;
  assign router_7_3_req_in[West] = router_6_3_to_router_7_3_req;

  assign router_7_3_to_spm_wide_ni_rsp = router_7_3_rsp_out[East];
  assign router_7_3_to_hbm_north_ni_7_0_rsp = router_7_3_rsp_out[North];
  assign router_7_3_to_router_7_2_rsp = router_7_3_rsp_out[South];
  assign router_7_3_to_router_6_3_rsp = router_7_3_rsp_out[West];

  assign router_7_3_to_spm_wide_ni_req = router_7_3_req_out[East];
  assign router_7_3_to_hbm_north_ni_7_0_req = router_7_3_req_out[North];
  assign router_7_3_to_router_7_2_req = router_7_3_req_out[South];
  assign router_7_3_to_router_6_3_req = router_7_3_req_out[West];

  assign router_7_3_rsp_in[East] = spm_wide_ni_to_router_7_3_rsp;
  assign router_7_3_rsp_in[North] = hbm_north_ni_7_0_to_router_7_3_rsp;
  assign router_7_3_rsp_in[South] = router_7_2_to_router_7_3_rsp;
  assign router_7_3_rsp_in[West] = router_6_3_to_router_7_3_rsp;

  assign router_7_3_wide_in[East] = spm_wide_ni_to_router_7_3_wide;
  assign router_7_3_wide_in[North] = hbm_north_ni_7_0_to_router_7_3_wide;
  assign router_7_3_wide_in[South] = router_7_2_to_router_7_3_wide;
  assign router_7_3_wide_in[West] = router_6_3_to_router_7_3_wide;

  assign router_7_3_to_spm_wide_ni_wide = router_7_3_wide_out[East];
  assign router_7_3_to_hbm_north_ni_7_0_wide = router_7_3_wide_out[North];
  assign router_7_3_to_router_7_2_wide = router_7_3_wide_out[South];
  assign router_7_3_to_router_6_3_wide = router_7_3_wide_out[West];

localparam id_t compute_tile_7_3_id = '{x: 8, y: 4};
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(8),
  .id_y(4)
) 
`endif
 compute_tile_7_3 (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (5'd31),
  .meip_i (9'b0),
  .mtip_i (mtip_i[288:280]),
  .msip_i (msip_i[288:280]),
  .id_i (compute_tile_7_3_id),
  .floo_req_i (router_7_3_req_in),
  .floo_rsp_o (router_7_3_rsp_out),
  .floo_req_o (router_7_3_req_out),
  .floo_rsp_i (router_7_3_rsp_in),
  .floo_wide_i (router_7_3_wide_in),
  .floo_wide_o (router_7_3_wide_out)
`ifndef TARGET_DMA_TEST
  ,.sram_cfgs_i (sram_cfgs_i)
`endif
);



endmodule
