
// Simple random simulation to generate 
module dma_test_node
  import compute_tile_array_test_pkg::*; // Simulation setting parameter modified through macro for each difference testbench
  import floo_narrow_wide_pkg::sam_rule_t;  // Address map to access DMA
#(
    // Additional simulation input port to control simulation behaviour
    parameter int unsigned id_x = 1,
    parameter int unsigned id_y = 1,
    parameter logic is_narrow = 1'b1,
    parameter type axi_out_req_t = logic,
    parameter type axi_out_rsp_t = logic,
    parameter type axi_in_req_t = logic,
    parameter type axi_in_rsp_t = logic,
    parameter int unsigned AxiAddrWidth = 48,
    parameter int unsigned AxiDataWidth = 64,
    parameter int unsigned AxiUserWidth = 1,
    parameter int unsigned AxiOutIdWidth = 1,
    parameter int unsigned AxiInIdWidth = 4,
    parameter int unsigned MaxTxnsPerId = 3
) (
    input logic clk_i,
    input logic rst_ni,

    input  axi_out_req_t axi_in_req_i,
    output axi_out_rsp_t axi_in_resp_o,
    output axi_in_req_t  axi_out_req_o,
    input  axi_in_rsp_t  axi_out_resp_i
);
  // Make its switch able between DMA and normal AXI package

  // Convert between id_i of base 1 to base 0 index
  localparam int unsigned x = id_x - 1;
  localparam int unsigned y = id_y - 1;

  localparam string TypeName = is_narrow ? "narrow" : "wide";
  localparam string DmaName = $sformatf("%s_dma_%0d_%0d", TypeName, x, y);

  // Assign unique job ID for each DMA test node
  localparam int unsigned Index = y * NumX + x + 1;
  localparam int unsigned JobId = is_narrow ? Index + 1000 : Index;

  localparam sam_rule_t local_addrmap = find_addrmap_by_xy_id(id_x, id_y);
  localparam logic [AxiAddrWidth-1:0] DMAMemBaseAddr = local_addrmap.start_addr;  // byte unit
  localparam logic [AxiAddrWidth-1:0] DMAMemSize = local_addrmap.end_addr - local_addrmap.start_addr; // byte unit

  logic end_of_sim;

  floo_dma_test_node #(
      .TA           (ApplTime),
      .TT           (TestTime),
      .DataWidth    (AxiDataWidth),
      .AddrWidth    (AxiAddrWidth),
      .UserWidth    (AxiUserWidth),
      .AxiIdInWidth (AxiOutIdWidth),
      .AxiIdOutWidth(AxiInIdWidth),
      .MemBaseAddr  (DMAMemBaseAddr),
      .MemSize      (DMAMemSize),
      .NumAxInFlight(2 * MaxTxnsPerId),
      .axi_in_req_t (axi_out_req_t),
      .axi_in_rsp_t (axi_out_rsp_t),
      .axi_out_req_t(axi_in_req_t),
      .axi_out_rsp_t(axi_in_rsp_t),
      .JobId        (JobId)
  ) i_dma_node (
      .clk_i        (clk_i),
      .rst_ni       (rst_ni),
      .axi_in_req_i (axi_in_req_i),
      .axi_in_rsp_o (axi_in_resp_o),
      .axi_out_req_o(axi_out_req_o),
      .axi_out_rsp_i(axi_out_resp_i),
      .end_of_sim_o (end_of_sim)
  );

  axi_bw_monitor #(
      .req_t     (axi_in_req_t),
      .rsp_t     (axi_in_rsp_t),
      .AxiIdWidth(AxiInIdWidth),
      .Name      (DmaName)
  ) i_axi_bw_monitor (
      .clk_i         (clk_i),
      .en_i          (rst_ni),
      .end_of_sim_i  (&end_of_sim),
      // Monitor on master interface
      .req_i         (axi_out_req_o),
      .rsp_i         (axi_out_resp_i),
      .ar_in_flight_o(),
      .aw_in_flight_o()
  );

endmodule
