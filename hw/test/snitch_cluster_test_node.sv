
// Simple random simulation to generate 
module snitch_cluster_test_node
    import snitch_cluster_test_pkg::*; // Simulation setting parameter modified through macro for each difference testbench
    import floo_narrow_wide_pkg::*; // Address map to access DMA
#(
  // Additional simulation input port to control simulation behaviour
  parameter int unsigned id_x = 1,
  parameter int unsigned id_y = 1
) (
  input  logic     clk_i,
  input  logic     rst_ni,

  input  logic                                   sa_rst_ni,
  input  logic [snitch_cluster_test_pkg::NrCores-1:0] debug_req_i,
  input  logic [snitch_cluster_test_pkg::NrCores-1:0] meip_i,
  input  logic [snitch_cluster_test_pkg::NrCores-1:0] mtip_i,
  input  logic [snitch_cluster_test_pkg::NrCores-1:0] msip_i,
  input  axi_narrow_in_req_t    narrow_in_req_i,
  output axi_narrow_in_rsp_t    narrow_in_resp_o,
  output axi_narrow_out_req_t   narrow_out_req_o,
  input  axi_narrow_out_rsp_t   narrow_out_resp_i,
  output axi_wide_out_req_t     wide_out_req_o,
  input  axi_wide_out_rsp_t     wide_out_resp_i,
  input  axi_wide_in_req_t      wide_in_req_i,
  output axi_wide_in_rsp_t      wide_in_resp_o
);
  // Make its switch able between DMA and normal AXI package

  // Convert between id_i of base 1 to base 0 index
  localparam int unsigned x = id_x-1;
  localparam int unsigned y = id_y-1;

  localparam string NarrowDmaName = $sformatf("narrow_dma_%0d_%0d", x, y);
  localparam string WideDmaName   = $sformatf("wide_dma_%0d_%0d", x, y);

  // Assign unique job ID for each DMA test node
  localparam int unsigned Index = y * NumX + x+1;

  // *** Use ID Table, so this hard code assignment is not required ***
  // For XY routing algorithm WITHOUT UseIdTable
  // XYAddrOffsetX = addr_offset_bits
  // XYAddrOffsetY = addr_offset_bits + num_x_bits
  // addr_offset_bits is most number of address bit use by user node and visible to user.
  // Higher bit than addr_offset_bits use for routing algorithm and 
  // total number of AXI address bit need to sufficient large to have x y address bit attach onto its.
  localparam logic [AxiNarrowInAddrWidth-1:0] MemBaseAddr =
      (x+1) << XYAddrOffsetX | (y+1) << XYAddrOffsetY;

  logic [1:0] end_of_sim;

  floo_dma_test_node #(
    .TA             ( ApplTime              ),
    .TT             ( TestTime              ),
    .DataWidth      ( AxiNarrowInDataWidth  ),
    .AddrWidth      ( AxiNarrowInAddrWidth  ),
    .UserWidth      ( AxiNarrowInUserWidth  ),
    .AxiIdInWidth   ( AxiNarrowOutIdWidth   ),
    .AxiIdOutWidth  ( AxiNarrowInIdWidth    ),
    .MemBaseAddr    ( MemBaseAddr           ),
    .MemSize        ( MemSize               ),
    .NumAxInFlight  ( 2*NarrowMaxTxnsPerId  ),
    .axi_in_req_t   ( axi_narrow_out_req_t  ),
    .axi_in_rsp_t   ( axi_narrow_out_rsp_t  ),
    .axi_out_req_t  ( axi_narrow_in_req_t   ),
    .axi_out_rsp_t  ( axi_narrow_in_rsp_t   ),
    .JobId          ( 100 + Index           )
  ) i_narrow_dma_node (
    .clk_i          ( clk                   ),
    .rst_ni         ( rst_n                 ),
    .axi_in_req_i   ( narrow_in_req_i       ),
    .axi_in_rsp_o   ( narrow_in_resp_o      ),
    .axi_out_req_o  ( narrow_out_req_o      ),
    .axi_out_rsp_i  ( narrow_out_resp_i     ),
    .end_of_sim_o   ( end_of_sim[0]         )
  );

  floo_dma_test_node #(
    .TA             ( ApplTime            ),
    .TT             ( TestTime            ),
    .DataWidth      ( AxiWideInDataWidth  ),
    .AddrWidth      ( AxiWideInAddrWidth  ),
    .UserWidth      ( AxiWideInUserWidth  ),
    .AxiIdInWidth   ( AxiWideOutIdWidth   ),
    .AxiIdOutWidth  ( AxiWideInIdWidth    ),
    .MemBaseAddr    ( MemBaseAddr         ),
    .MemSize        ( MemSize             ),
    .NumAxInFlight  ( 2*WideMaxTxnsPerId  ),
    .axi_in_req_t   ( axi_wide_out_req_t  ),
    .axi_in_rsp_t   ( axi_wide_out_rsp_t  ),
    .axi_out_req_t  ( axi_wide_in_req_t   ),
    .axi_out_rsp_t  ( axi_wide_in_rsp_t   ),
    .JobId          ( Index               )
  ) i_wide_dma_node (
    .clk_i          ( clk                 ),
    .rst_ni         ( rst_n               ),
    .axi_in_req_i   ( wide_in_req_i       ),
    .axi_in_rsp_o   ( wide_in_resp_o      ),
    .axi_out_req_o  ( wide_out_req_o      ),
    .axi_out_rsp_i  ( wide_out_resp_i     ),
    .end_of_sim_o   ( end_of_sim[1]       )
  );

  axi_bw_monitor #(
    .req_t      ( axi_narrow_in_req_t ),
    .rsp_t      ( axi_narrow_in_rsp_t ),
    .AxiIdWidth ( AxiNarrowInIdWidth  ),
    .Name       ( NarrowDmaName       )
  ) i_axi_narrow_bw_monitor (
    .clk_i        ( clk                   ),
    .en_i         ( rst_n                 ),
    .end_of_sim_i ( &end_of_sim           ),
    // Monitor on master interface
    .req_i        ( narrow_out_req_o      ),
    .rsp_i        ( narrow_out_resp_i     ),
    .ar_in_flight_o(                      ),
    .aw_in_flight_o(                      )
    );

  axi_bw_monitor #(
    .req_t      ( axi_wide_in_req_t ),
    .rsp_t      ( axi_wide_in_rsp_t ),
    .AxiIdWidth ( AxiWideInIdWidth  ),
    .Name       ( WideDmaName       )
  ) i_axi_wide_bw_monitor (
    .clk_i        ( clk                 ),
    .en_i         ( rst_n               ),
    .end_of_sim_i ( &end_of_sim         ),
    // Monitor on master interface
    .req_i        ( wide_out_req_o      ),
    .rsp_i        ( wide_out_resp_i     ),
    .ar_in_flight_o(                    ),
    .aw_in_flight_o(                    )
    );

  initial begin
    wait(&end_of_sim);
    // Wait for some time for ending other running thread as well
    #1000ns;
    // Stop the simulation
    $stop;
  end

endmodule