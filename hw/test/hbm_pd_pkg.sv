
`include "axi/typedef.svh"

// Package wrapper for HBM PD
// It made with assumtion that all HBM controller in the system have
// the same configuration and interface type except address mapped.
package hbm_pd_pkg;

  typedef struct packed {
    logic [31:0] idx;
    logic [47:0] start_addr;
    logic [47:0] end_addr;
  } xbar_rule_48_t;

  typedef xbar_rule_48_t xbar_rule_t;
  localparam int unsigned XbarRuleNum = 2;

  localparam int unsigned AxiAddrWidth = 48;
  localparam int unsigned AxiNarrowDataWidth = 64;
  localparam int unsigned AxiNarrowIdWidth = 5;
  localparam int unsigned AxiNarrowUserWidth = 1;
  localparam int unsigned AxiWideDataWidth = 512;
  localparam int unsigned AxiWideIdWidth = 6;
  localparam int unsigned AxiWideUserWidth = 1;
  localparam int unsigned AxiJoinDataWidth = 512;
  localparam int unsigned AxiJoinIdWidth = 7;
  localparam int unsigned AxiJoinUserWidth = 1;

  typedef logic [AxiAddrWidth-1:0] addr_t;
  typedef logic [AxiNarrowDataWidth-1:0] narrow_data_t;
  typedef logic [AxiNarrowDataWidth/8-1:0] narrow_strb_t;
  typedef logic [AxiNarrowIdWidth-1:0] narrow_id_t;
  typedef logic [AxiNarrowUserWidth-1:0] narrow_user_t;
  typedef logic [AxiWideDataWidth-1:0] wide_data_t;
  typedef logic [AxiWideDataWidth/8-1:0] wide_strb_t;
  typedef logic [AxiWideIdWidth-1:0] wide_id_t;
  typedef logic [AxiWideUserWidth-1:0] wide_user_t;
  typedef logic [AxiJoinDataWidth-1:0] join_data_t;
  typedef logic [AxiJoinDataWidth/8-1:0] join_strb_t;
  typedef logic [AxiJoinIdWidth-1:0] join_id_t;
  typedef logic [AxiJoinUserWidth-1:0] join_user_t;

  `AXI_TYPEDEF_ALL_CT(axi_narrow, axi_narrow_req_type, axi_narrow_rsp_type,
                      addr_t, narrow_id_t, narrow_data_t, narrow_strb_t, narrow_user_t)
  `AXI_TYPEDEF_ALL_CT(axi_wide, axi_wide_req_type, axi_wide_rsp_type,
                      addr_t, wide_id_t, wide_data_t, wide_strb_t, wide_user_t)
  `AXI_TYPEDEF_ALL_CT(axi_join, axi_join_req_type, axi_join_rsp_type,
                      addr_t, join_id_t, join_data_t, join_strb_t, join_user_t)

  // Declare Xbar Configuration
  localparam axi_pkg::xbar_cfg_t HbmCfgXbar = '{
  NoSlvPorts:         1,
  NoMstPorts:         2,
  MaxSlvTrans:        32,
  MaxMstTrans:        32,
  FallThrough:        0,
  LatencyMode:        axi_pkg::CUT_ALL_PORTS,
  PipelineStages:     0,
  AxiIdWidthSlvPorts: 5,
  AxiIdUsedSlvPorts:  5,
  UniqueIds:          0,
  AxiAddrWidth:       48,
  AxiDataWidth:       64,
  NoAddrRules:        2
};


endpackage
// verilog_lint: waive-off line-length
