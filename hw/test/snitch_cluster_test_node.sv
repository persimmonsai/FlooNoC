
`include "test_snitch_cluster_pkg.svh"

// Simple random simulation to generate 
module snitch_cluster_test_node
  import compute_tile_array_test_pkg::*; // Simulation setting parameter modified through macro for each difference testbench
  import floo_narrow_wide_pkg::sam_rule_t;  // Address map to access DMA
#(
    // Additional simulation input port to control simulation behaviour
    parameter int unsigned id_x = 1,
    parameter int unsigned id_y = 1
) (
    input logic clk_i,
    input logic rst_ni,

    //input logic sa_rst_ni,
    input logic [test_snitch_cluster_pkg::NrCores-1:0] debug_req_i,
    input logic [test_snitch_cluster_pkg::NrCores-1:0] meip_i,
    input logic [test_snitch_cluster_pkg::NrCores-1:0] mtip_i,
    input logic [test_snitch_cluster_pkg::NrCores-1:0] msip_i,
    input test_snitch_cluster_pkg::narrow_in_req_t narrow_in_req_i,
    output test_snitch_cluster_pkg::narrow_in_resp_t narrow_in_resp_o,
    output test_snitch_cluster_pkg::narrow_out_req_t narrow_out_req_o,
    input test_snitch_cluster_pkg::narrow_out_resp_t narrow_out_resp_i,
    output test_snitch_cluster_pkg::wide_out_req_t wide_out_req_o,
    input test_snitch_cluster_pkg::wide_out_resp_t wide_out_resp_i,
    input test_snitch_cluster_pkg::wide_in_req_t wide_in_req_i,
    output test_snitch_cluster_pkg::wide_in_resp_t wide_in_resp_o
);
  // Make its switch able between DMA and normal AXI package

  // Convert between id_i of base 1 to base 0 index
  localparam int unsigned x = id_x - 1;
  localparam int unsigned y = id_y - 1;

  localparam string NarrowDmaName = $sformatf("narrow_dma_%0d_%0d", x, y);
  localparam string WideDmaName = $sformatf("wide_dma_%0d_%0d", x, y);

  // Assign unique job ID for each DMA test node
  localparam int unsigned Index = y * NumX + x + 1;

  localparam sam_rule_t local_addrmap = find_addrmap_by_xy_id(id_x, id_y);
  localparam logic [test_snitch_cluster_pkg::AddrWidth-1:0] DMAMemBaseAddr = local_addrmap.start_addr;  // byte unit
  localparam logic [test_snitch_cluster_pkg::AddrWidth-1:0] DMAMemSize = local_addrmap.end_addr - local_addrmap.start_addr; // byte unit

  logic [1:0] end_of_sim;

  floo_dma_test_node #(
      .TA           (ApplTime),
      .TT           (TestTime),
      .DataWidth    (test_snitch_cluster_pkg::NarrowDataWidth),
      .AddrWidth    (test_snitch_cluster_pkg::AddrWidth),
      .UserWidth    (test_snitch_cluster_pkg::NarrowUserWidth),
      .AxiIdInWidth (test_snitch_cluster_pkg::NarrowIdWidthIn),
      .AxiIdOutWidth(test_snitch_cluster_pkg::NarrowIdWidthOut),
      .MemBaseAddr  (DMAMemBaseAddr),
      .MemSize      (DMAMemSize),
      .NumAxInFlight(2 * NarrowMaxTxnsPerId),
      .axi_in_req_t (test_snitch_cluster_pkg::narrow_in_req_t),
      .axi_in_rsp_t (test_snitch_cluster_pkg::narrow_in_resp_t),
      .axi_out_req_t(test_snitch_cluster_pkg::narrow_out_req_t),
      .axi_out_rsp_t(test_snitch_cluster_pkg::narrow_out_resp_t),
      .JobId        (1000 + Index)
  ) i_narrow_dma_node (
      .clk_i        (clk_i),
      .rst_ni       (rst_ni),
      .axi_in_req_i (narrow_in_req_i),
      .axi_in_rsp_o (narrow_in_resp_o),
      .axi_out_req_o(narrow_out_req_o),
      .axi_out_rsp_i(narrow_out_resp_i),
      .end_of_sim_o (end_of_sim[0])
  );

  floo_dma_test_node #(
      .TA           (ApplTime),
      .TT           (TestTime),
      .DataWidth    (test_snitch_cluster_pkg::WideDataWidth),
      .AddrWidth    (test_snitch_cluster_pkg::AddrWidth),
      .UserWidth    (test_snitch_cluster_pkg::WideUserWidth),
      .AxiIdInWidth (test_snitch_cluster_pkg::WideIdWidthIn),
      .AxiIdOutWidth(test_snitch_cluster_pkg::WideIdWidthOut),
      .MemBaseAddr  (DMAMemBaseAddr),
      .MemSize      (DMAMemSize),
      .NumAxInFlight(2 * WideMaxTxnsPerId),
      .axi_in_req_t (test_snitch_cluster_pkg::wide_in_req_t),
      .axi_in_rsp_t (test_snitch_cluster_pkg::wide_in_resp_t),
      .axi_out_req_t(test_snitch_cluster_pkg::wide_out_req_t),
      .axi_out_rsp_t(test_snitch_cluster_pkg::wide_out_resp_t),
      .JobId        (Index)
  ) i_wide_dma_node (
      .clk_i        (clk_i),
      .rst_ni       (rst_ni),
      .axi_in_req_i (wide_in_req_i),
      .axi_in_rsp_o (wide_in_resp_o),
      .axi_out_req_o(wide_out_req_o),
      .axi_out_rsp_i(wide_out_resp_i),
      .end_of_sim_o (end_of_sim[1])
  );

  axi_bw_monitor #(
      .req_t     (test_snitch_cluster_pkg::narrow_out_req_t),
      .rsp_t     (test_snitch_cluster_pkg::narrow_out_resp_t),
      .AxiIdWidth(test_snitch_cluster_pkg::NarrowIdWidthOut),
      .Name      (NarrowDmaName)
  ) i_axi_narrow_bw_monitor (
      .clk_i         (clk_i),
      .en_i          (rst_ni),
      .end_of_sim_i  (&end_of_sim),
      // Monitor on master interface
      .req_i         (narrow_out_req_o),
      .rsp_i         (narrow_out_resp_i),
      .ar_in_flight_o(),
      .aw_in_flight_o()
  );

  axi_bw_monitor #(
      .req_t     (test_snitch_cluster_pkg::wide_out_req_t),
      .rsp_t     (test_snitch_cluster_pkg::wide_out_resp_t),
      .AxiIdWidth(test_snitch_cluster_pkg::WideIdWidthOut),
      .Name      (WideDmaName)
  ) i_axi_wide_bw_monitor (
      .clk_i         (clk_i),
      .en_i          (rst_ni),
      .end_of_sim_i  (&end_of_sim),
      // Monitor on master interface
      .req_i         (wide_out_req_o),
      .rsp_i         (wide_out_resp_i),
      .ar_in_flight_o(),
      .aw_in_flight_o()
  );

  //   initial begin
  //     wait (&end_of_sim);
  //     // Wait for some time for ending other running thread as well
  //     #200000ns;
  //     // Stop the simulation
  //     $display("-- End Simulation --");
  //     $stop;
  //   end

endmodule
