// Copyright 2022 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// This file is auto-generated. Do not edit! Edit the template file instead

`include "axi/typedef.svh"

package floo_narrow_wide_pkg;

  import floo_pkg::*;

  ////////////////////////
  //   AXI Parameters   //
  ////////////////////////

  typedef enum logic [3:0] {
    NarrowAw = 0,
    NarrowW = 1,
    NarrowAr = 2,
    WideAr = 3,
    NarrowB = 4,
    NarrowR = 5,
    WideB = 6,
    WideAw = 7,
    WideW = 8,
    WideR = 9,
    NumAxiChannels = 10
  } axi_ch_e;


  localparam int unsigned AxiNarrowInAddrWidth = 48;
  localparam int unsigned AxiNarrowInDataWidth = 64;
  localparam int unsigned AxiNarrowInIdWidth = 4;
  localparam int unsigned AxiNarrowInUserWidth = 5;


  localparam int unsigned AxiNarrowOutAddrWidth = 48;
  localparam int unsigned AxiNarrowOutDataWidth = 64;
  localparam int unsigned AxiNarrowOutIdWidth = 10;
  localparam int unsigned AxiNarrowOutUserWidth = 5;


  localparam int unsigned AxiWideInAddrWidth = 48;
  localparam int unsigned AxiWideInDataWidth = 512;
  localparam int unsigned AxiWideInIdWidth = 4;
  localparam int unsigned AxiWideInUserWidth = 1;


  localparam int unsigned AxiWideOutAddrWidth = 48;
  localparam int unsigned AxiWideOutDataWidth = 512;
  localparam int unsigned AxiWideOutIdWidth = 10;
  localparam int unsigned AxiWideOutUserWidth = 1;


  localparam int unsigned AxiJoinOutAddrWidth = 48;
  localparam int unsigned AxiJoinOutDataWidth = 512;
  localparam int unsigned AxiJoinOutIdWidth = 11;
  localparam int unsigned AxiJoinOutUserWidth = 1;


  typedef logic [47:0] axi_narrow_in_addr_t;
  typedef logic [63:0] axi_narrow_in_data_t;
  typedef logic [7:0] axi_narrow_in_strb_t;
  typedef logic [3:0] axi_narrow_in_id_t;
  typedef logic [4:0] axi_narrow_in_user_t;
  `AXI_TYPEDEF_ALL_CT(axi_narrow_in, axi_narrow_in_req_t, axi_narrow_in_rsp_t, axi_narrow_in_addr_t,
                      axi_narrow_in_id_t, axi_narrow_in_data_t, axi_narrow_in_strb_t,
                      axi_narrow_in_user_t)


  typedef logic [47:0] axi_narrow_out_addr_t;
  typedef logic [63:0] axi_narrow_out_data_t;
  typedef logic [7:0] axi_narrow_out_strb_t;
  typedef logic [9:0] axi_narrow_out_id_t;
  typedef logic [4:0] axi_narrow_out_user_t;
  `AXI_TYPEDEF_ALL_CT(axi_narrow_out, axi_narrow_out_req_t, axi_narrow_out_rsp_t,
                      axi_narrow_out_addr_t, axi_narrow_out_id_t, axi_narrow_out_data_t,
                      axi_narrow_out_strb_t, axi_narrow_out_user_t)


  typedef logic [47:0] axi_wide_in_addr_t;
  typedef logic [511:0] axi_wide_in_data_t;
  typedef logic [63:0] axi_wide_in_strb_t;
  typedef logic [3:0] axi_wide_in_id_t;
  typedef logic [0:0] axi_wide_in_user_t;
  `AXI_TYPEDEF_ALL_CT(axi_wide_in, axi_wide_in_req_t, axi_wide_in_rsp_t, axi_wide_in_addr_t,
                      axi_wide_in_id_t, axi_wide_in_data_t, axi_wide_in_strb_t, axi_wide_in_user_t)


  typedef logic [47:0] axi_wide_out_addr_t;
  typedef logic [511:0] axi_wide_out_data_t;
  typedef logic [63:0] axi_wide_out_strb_t;
  typedef logic [9:0] axi_wide_out_id_t;
  typedef logic [0:0] axi_wide_out_user_t;
  `AXI_TYPEDEF_ALL_CT(axi_wide_out, axi_wide_out_req_t, axi_wide_out_rsp_t, axi_wide_out_addr_t,
                      axi_wide_out_id_t, axi_wide_out_data_t, axi_wide_out_strb_t,
                      axi_wide_out_user_t)


  typedef logic [47:0] axi_join_out_addr_t;
  typedef logic [511:0] axi_join_out_data_t;
  typedef logic [63:0] axi_join_out_strb_t;
  typedef logic [10:0] axi_join_out_id_t;
  typedef logic [0:0] axi_join_out_user_t;
  `AXI_TYPEDEF_ALL_CT(axi_join_out, axi_join_out_req_t, axi_join_out_rsp_t, axi_join_out_addr_t,
                      axi_join_out_id_t, axi_join_out_data_t, axi_join_out_strb_t,
                      axi_join_out_user_t)



  /////////////////////////
  //   Header Typedefs   //
  /////////////////////////

  localparam route_algo_e RouteAlgo = XYRouting;
  localparam bit XYRouteOpt = 1'b0;
  localparam bit UseIdTable = 1'b1;
  localparam int unsigned NumXBits = 4;
  localparam int unsigned NumYBits = 3;
  localparam int unsigned XYAddrOffsetX = 40;
  localparam int unsigned XYAddrOffsetY = 44;
  localparam int unsigned IdAddrOffset = 0;


  typedef logic [3:0] rob_idx_t;
  typedef logic [3:0] x_bits_t;
  typedef logic [2:0] y_bits_t;
  typedef struct packed {
    x_bits_t x;
    y_bits_t y;
  } id_t;

  typedef struct packed {
    y_bits_t north;
    x_bits_t west;
    y_bits_t south;
    x_bits_t east;
  } border_id_t;

  typedef logic route_t;
  typedef id_t dst_t;


  typedef struct packed {
    logic rob_req;
    rob_idx_t rob_idx;
    dst_t dst_id;
    id_t src_id;
    logic last;
    logic atop;
    axi_ch_e axi_ch;
  } hdr_t;



  /////////////////////
  //   Address Map   //
  /////////////////////

  localparam int unsigned SamNumRules = 55;

  typedef struct packed {
    id_t idx;
    logic [47:0] start_addr;
    logic [47:0] end_addr;
  } sam_rule_t;

  localparam sam_rule_t [SamNumRules-1:0] Sam = '{
      '{
          idx: '{x: 1, y: 1},
          start_addr: 48'h000010000000,
          end_addr: 48'h000010040000
      },  // cluster_ni_0_0
      '{
          idx: '{x: 1, y: 2},
          start_addr: 48'h000010040000,
          end_addr: 48'h000010080000
      },  // cluster_ni_0_1
      '{
          idx: '{x: 1, y: 3},
          start_addr: 48'h000010080000,
          end_addr: 48'h0000100c0000
      },  // cluster_ni_0_2
      '{
          idx: '{x: 1, y: 4},
          start_addr: 48'h0000100c0000,
          end_addr: 48'h000010100000
      },  // cluster_ni_0_3
      '{
          idx: '{x: 2, y: 1},
          start_addr: 48'h000010100000,
          end_addr: 48'h000010140000
      },  // cluster_ni_1_0
      '{
          idx: '{x: 2, y: 2},
          start_addr: 48'h000010140000,
          end_addr: 48'h000010180000
      },  // cluster_ni_1_1
      '{
          idx: '{x: 2, y: 3},
          start_addr: 48'h000010180000,
          end_addr: 48'h0000101c0000
      },  // cluster_ni_1_2
      '{
          idx: '{x: 2, y: 4},
          start_addr: 48'h0000101c0000,
          end_addr: 48'h000010200000
      },  // cluster_ni_1_3
      '{
          idx: '{x: 3, y: 1},
          start_addr: 48'h000010200000,
          end_addr: 48'h000010240000
      },  // cluster_ni_2_0
      '{
          idx: '{x: 3, y: 2},
          start_addr: 48'h000010240000,
          end_addr: 48'h000010280000
      },  // cluster_ni_2_1
      '{
          idx: '{x: 3, y: 3},
          start_addr: 48'h000010280000,
          end_addr: 48'h0000102c0000
      },  // cluster_ni_2_2
      '{
          idx: '{x: 3, y: 4},
          start_addr: 48'h0000102c0000,
          end_addr: 48'h000010300000
      },  // cluster_ni_2_3
      '{
          idx: '{x: 4, y: 1},
          start_addr: 48'h000010300000,
          end_addr: 48'h000010340000
      },  // cluster_ni_3_0
      '{
          idx: '{x: 4, y: 2},
          start_addr: 48'h000010340000,
          end_addr: 48'h000010380000
      },  // cluster_ni_3_1
      '{
          idx: '{x: 4, y: 3},
          start_addr: 48'h000010380000,
          end_addr: 48'h0000103c0000
      },  // cluster_ni_3_2
      '{
          idx: '{x: 4, y: 4},
          start_addr: 48'h0000103c0000,
          end_addr: 48'h000010400000
      },  // cluster_ni_3_3
      '{
          idx: '{x: 5, y: 1},
          start_addr: 48'h000010400000,
          end_addr: 48'h000010440000
      },  // cluster_ni_4_0
      '{
          idx: '{x: 5, y: 2},
          start_addr: 48'h000010440000,
          end_addr: 48'h000010480000
      },  // cluster_ni_4_1
      '{
          idx: '{x: 5, y: 3},
          start_addr: 48'h000010480000,
          end_addr: 48'h0000104c0000
      },  // cluster_ni_4_2
      '{
          idx: '{x: 5, y: 4},
          start_addr: 48'h0000104c0000,
          end_addr: 48'h000010500000
      },  // cluster_ni_4_3
      '{
          idx: '{x: 6, y: 1},
          start_addr: 48'h000010500000,
          end_addr: 48'h000010540000
      },  // cluster_ni_5_0
      '{
          idx: '{x: 6, y: 2},
          start_addr: 48'h000010540000,
          end_addr: 48'h000010580000
      },  // cluster_ni_5_1
      '{
          idx: '{x: 6, y: 3},
          start_addr: 48'h000010580000,
          end_addr: 48'h0000105c0000
      },  // cluster_ni_5_2
      '{
          idx: '{x: 6, y: 4},
          start_addr: 48'h0000105c0000,
          end_addr: 48'h000010600000
      },  // cluster_ni_5_3
      '{
          idx: '{x: 7, y: 1},
          start_addr: 48'h000010600000,
          end_addr: 48'h000010640000
      },  // cluster_ni_6_0
      '{
          idx: '{x: 7, y: 2},
          start_addr: 48'h000010640000,
          end_addr: 48'h000010680000
      },  // cluster_ni_6_1
      '{
          idx: '{x: 7, y: 3},
          start_addr: 48'h000010680000,
          end_addr: 48'h0000106c0000
      },  // cluster_ni_6_2
      '{
          idx: '{x: 7, y: 4},
          start_addr: 48'h0000106c0000,
          end_addr: 48'h000010700000
      },  // cluster_ni_6_3
      '{
          idx: '{x: 8, y: 1},
          start_addr: 48'h000010700000,
          end_addr: 48'h000010740000
      },  // cluster_ni_7_0
      '{
          idx: '{x: 8, y: 2},
          start_addr: 48'h000010740000,
          end_addr: 48'h000010780000
      },  // cluster_ni_7_1
      '{
          idx: '{x: 8, y: 3},
          start_addr: 48'h000010780000,
          end_addr: 48'h0000107c0000
      },  // cluster_ni_7_2
      '{
          idx: '{x: 8, y: 4},
          start_addr: 48'h0000107c0000,
          end_addr: 48'h000010800000
      },  // cluster_ni_7_3
      '{
          idx: '{x: 1, y: 5},
          start_addr: 48'h001000000000,
          end_addr: 48'h001040000000
      },  // hbm_north_ni_0_0
      '{
          idx: '{x: 2, y: 5},
          start_addr: 48'h001040000000,
          end_addr: 48'h001080000000
      },  // hbm_north_ni_1_0
      '{
          idx: '{x: 3, y: 5},
          start_addr: 48'h001080000000,
          end_addr: 48'h0010c0000000
      },  // hbm_north_ni_2_0
      '{
          idx: '{x: 4, y: 5},
          start_addr: 48'h0010c0000000,
          end_addr: 48'h001100000000
      },  // hbm_north_ni_3_0
      '{
          idx: '{x: 5, y: 5},
          start_addr: 48'h001100000000,
          end_addr: 48'h001140000000
      },  // hbm_north_ni_4_0
      '{
          idx: '{x: 6, y: 5},
          start_addr: 48'h001140000000,
          end_addr: 48'h001180000000
      },  // hbm_north_ni_5_0
      '{
          idx: '{x: 7, y: 5},
          start_addr: 48'h001180000000,
          end_addr: 48'h0011c0000000
      },  // hbm_north_ni_6_0
      '{
          idx: '{x: 8, y: 5},
          start_addr: 48'h0011c0000000,
          end_addr: 48'h001200000000
      },  // hbm_north_ni_7_0
      '{
          idx: '{x: 1, y: 0},
          start_addr: 48'h000200000000,
          end_addr: 48'h000240000000
      },  // hbm_south_ni_0_0
      '{
          idx: '{x: 2, y: 0},
          start_addr: 48'h000240000000,
          end_addr: 48'h000280000000
      },  // hbm_south_ni_1_0
      '{
          idx: '{x: 3, y: 0},
          start_addr: 48'h000280000000,
          end_addr: 48'h0002c0000000
      },  // hbm_south_ni_2_0
      '{
          idx: '{x: 4, y: 0},
          start_addr: 48'h0002c0000000,
          end_addr: 48'h000300000000
      },  // hbm_south_ni_3_0
      '{
          idx: '{x: 5, y: 0},
          start_addr: 48'h000300000000,
          end_addr: 48'h000340000000
      },  // hbm_south_ni_4_0
      '{
          idx: '{x: 6, y: 0},
          start_addr: 48'h000340000000,
          end_addr: 48'h000380000000
      },  // hbm_south_ni_5_0
      '{
          idx: '{x: 7, y: 0},
          start_addr: 48'h000380000000,
          end_addr: 48'h0003c0000000
      },  // hbm_south_ni_6_0
      '{
          idx: '{x: 8, y: 0},
          start_addr: 48'h0003c0000000,
          end_addr: 48'h000400000000
      },  // hbm_south_ni_7_0
      '{
          idx: '{x: 0, y: 4},
          start_addr: 48'h000020000000,
          end_addr: 48'h000070000000
      },  // pcie_ni
      '{
          idx: '{x: 0, y: 3},
          start_addr: 48'h000001000000,
          end_addr: 48'h00000f000000
      },  // peripherals_ni
      '{
          idx: '{x: 0, y: 2},
          start_addr: 48'h000000000000,
          end_addr: 48'h000000001000
      },  // jtag_ni
      '{
          idx: '{x: 9, y: 4},
          start_addr: 48'h000071000000,
          end_addr: 48'h000071100000
      },  // spm_wide_ni
      '{
          idx: '{x: 9, y: 3},
          start_addr: 48'h000070000000,
          end_addr: 48'h000070080000
      },  // spm_narrow_ni
      '{
          idx: '{x: 9, y: 2},
          start_addr: 48'h000011000000,
          end_addr: 48'h000011010000
      },  // idma_ni
      '{
          idx: '{x: 9, y: 1},
          start_addr: 48'h008000000000,
          end_addr: 48'h008200000000
      }  // zero_mem_ni

  };


  ////////////////////////
  //   Flits Typedefs   //
  ////////////////////////

  typedef struct packed {
    hdr_t hdr;
    axi_narrow_in_aw_chan_t aw;
  } floo_narrow_aw_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_narrow_in_w_chan_t w;
    logic [13:0] rsvd;
  } floo_narrow_w_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_narrow_in_b_chan_t b;
    logic [64:0] rsvd;
  } floo_narrow_b_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_narrow_in_ar_chan_t ar;
    logic [5:0] rsvd;
  } floo_narrow_ar_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_narrow_in_r_chan_t r;
  } floo_narrow_r_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_wide_in_aw_chan_t aw;
    logic [489:0] rsvd;
  } floo_wide_aw_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_wide_in_w_chan_t w;
  } floo_wide_w_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_wide_in_b_chan_t b;
    logic [68:0] rsvd;
  } floo_wide_b_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_wide_in_ar_chan_t ar;
    logic [9:0] rsvd;
  } floo_wide_ar_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_wide_in_r_chan_t r;
    logic [57:0] rsvd;
  } floo_wide_r_flit_t;

  typedef struct packed {
    hdr_t hdr;
    logic [91:0] rsvd;
  } floo_req_generic_flit_t;

  typedef struct packed {
    hdr_t hdr;
    logic [75:0] rsvd;
  } floo_rsp_generic_flit_t;

  typedef struct packed {
    hdr_t hdr;
    logic [577:0] rsvd;
  } floo_wide_generic_flit_t;



  //////////////////////////
  //   Channel Typedefs   //
  //////////////////////////

  typedef union packed {
    floo_narrow_aw_flit_t narrow_aw;
    floo_narrow_w_flit_t narrow_w;
    floo_narrow_ar_flit_t narrow_ar;
    floo_wide_ar_flit_t wide_ar;
    floo_req_generic_flit_t generic;
  } floo_req_chan_t;

  typedef union packed {
    floo_narrow_b_flit_t narrow_b;
    floo_narrow_r_flit_t narrow_r;
    floo_wide_b_flit_t wide_b;
    floo_rsp_generic_flit_t generic;
  } floo_rsp_chan_t;

  typedef union packed {
    floo_wide_aw_flit_t wide_aw;
    floo_wide_w_flit_t wide_w;
    floo_wide_r_flit_t wide_r;
    floo_wide_generic_flit_t generic;
  } floo_wide_chan_t;



  ///////////////////////
  //   Link Typedefs   //
  ///////////////////////

  typedef struct packed {
    logic valid;
    logic ready;
    floo_req_chan_t req;
  } floo_req_t;

  typedef struct packed {
    logic valid;
    logic ready;
    floo_rsp_chan_t rsp;
  } floo_rsp_t;

  typedef struct packed {
    logic valid;
    logic ready;
    floo_wide_chan_t wide;
  } floo_wide_t;


endpackage
