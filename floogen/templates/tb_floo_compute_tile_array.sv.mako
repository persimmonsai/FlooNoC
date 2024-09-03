<%
  import datetime
  NUM_X = noc.routers[0].array[0]
  NUM_Y = noc.routers[0].array[1]
  num_core = NUM_X * NUM_Y * noc.num_snitch_core
  irq_bit_num = num_core + 1 # +1 for CVA6 core
%>\
// Copyright ${datetime.datetime.now().year} ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

`include "common_cells/assertions.svh"
`include "floo_noc/typedef.svh"

module tb_floo_compute_tile_array;

  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;

  // Import simulation parameter
  import compute_tile_array_test_pkg::*;

  logic clk, rst_n;

  clk_rst_gen #(
      .ClkPeriod   (CyclTime),
      .RstClkCycles(5)
  ) i_clk_gen (
      .clk_o (clk),
      .rst_no(rst_n)
  );

  //////////////////////////////////
  //   Endpoint Simulation Model  //
  //////////////////////////////////

  ${noc.render_tb_endpoint()}
  //////////////////////////////////
  //   Compute Tile Array (DUT)   //
  //////////////////////////////////

  ${noc.name}_floo_noc i_${noc.name}_floo_noc (
      .clk_i(clk),
      .rst_ni(rst_n),
      .test_enable_i(1'b0),
      
      ${noc.render_tb_dut_tile_ports()}
      ${noc.render_tb_dut_ports()}
  );

  logic [${len(cp_tiles)+endpoint_dma_num-1}:0] endsim_cluster;
  // Get end_of_sim signal inside DUT
% for i in range(0,len(cp_tiles)):
  assign endsim_cluster[${i}] = &tb_floo_compute_tile_array.i_${noc.name}_floo_noc.compute_tile_${str(cp_tiles[i].id.x)}_${str(cp_tiles[i].id.y)}.i_snitch_cluster_test_node.end_of_sim;
% endfor
<% i = 0 %>\
% for ep in endpoint_dma:
  % for ep_mgr_prot in ep.mgr_port_protocol:
    assign endsim_cluster[${i+len(cp_tiles)}] = &tb_floo_compute_tile_array.i_floo_${ep_mgr_prot}_${ep.name}_model.end_of_sim;
  <% i += 1 %>\
  % endfor
% endfor

  initial begin
    wait (&endsim_cluster);
    // Wait for some time
    #100ns;
    // Stop the simulation
    $display("-- End Simulation --");
    $finish;
  end

endmodule
