// Copyright 2020 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

/// RTL Top-level for `fesvr` simulation.
module tb_floo_bin;
  import "DPI-C" function int fesvr_tick();

  // This can't have a unit otherwise the simulation will not advance, for
  // whatever reason.
  // verilog_lint: waive explicit-parameter-storage-type
  localparam TCK = 1ns;

  logic rst_ni, clk_i;

  floo_testharness i_floo_testharness (
      .clk_i,
      .rst_ni
  );

  initial begin
    rst_ni = 0;
    #10ns;
    rst_ni = 1;
    #10ns;
    rst_ni = 0;
    #10ns;
    rst_ni = 1;
  end

  // Generate reset and clock.
  initial begin
    forever begin
      clk_i = 1;
      #(TCK / 2);
      clk_i = 0;
      #(TCK / 2);
    end
  end

  // Start `fesvr`.
  initial begin
    automatic int exit_code;
    while ((exit_code = fesvr_tick()) == 0) #200ns;
    exit_code >>= 1;
    if (exit_code > 0) begin
      $error("[FAILURE] Finished with exit code %2d", exit_code);
    end else begin
      $info("[SUCCESS] Program finished successfully");
    end
    $finish;
  end

  // Temporary Force reset to enable only one cluster at cluster x=0, y=0 that have addresss mapped to 0x1000_0000
  initial begin
    force i_floo_testharness.i_compute_tile_array_floo_noc.compute_tile_0_1.i_snitch_cluster.rst_ni = 1'b0;
    force i_floo_testharness.i_compute_tile_array_floo_noc.compute_tile_1_0.i_snitch_cluster.rst_ni = 1'b0;
    force i_floo_testharness.i_compute_tile_array_floo_noc.compute_tile_1_1.i_snitch_cluster.rst_ni = 1'b0;
    // #500 release tb_top.dut_top.dut_block.dut_signal;
  end

endmodule
