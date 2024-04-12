<%!
    import datetime
%>\
// Copyright ${datetime.datetime.now().year} ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

`include "common_cells/assertions.svh"
`include "floo_noc/typedef.svh"

module tb_floo_${noc.name};

  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;

  // Import simulation parameter
  import ${noc.name}_test_pkg::*;

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

  logic [snitch_cluster_pkg::NrCores-1:0] msip_i;
  assign msip_i = 'b0;  // unused port for snitch cluster

  ${noc.name}_floo_noc i_${noc.name}_floo_noc (
      .clk_i(clk),
      .rst_ni(rst_n),
      .test_enable_i(1'b0),

      .msip_i(msip_i),

      ${noc.render_tb_dut_ports()}
  );

  logic [${len(cp_tiles)-1}:0] endsim_cluster;
  // Get end_of_sim signal inside DUT
% for i in range(0,len(cp_tiles)):
  assign endsim_cluster[${i}] = &tb_floo_${noc.name}.i_${noc.name}_floo_noc.compute_tile_${str(cp_tiles[i].id.x)}_${str(cp_tiles[i].id.y)}.i_snitch_cluster_test_node.end_of_sim;
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