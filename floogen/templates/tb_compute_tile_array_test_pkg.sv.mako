// Copyright 2022 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Tim Fischer <fischeti@iis.ee.ethz.ch>

`include "common_cells/assertions.svh"
`include "floo_noc/typedef.svh"

// Simulation parameter for compute tile array model
package compute_tile_array_test_pkg;

  import floo_narrow_wide_pkg::sam_rule_t;
  import floo_narrow_wide_pkg::Sam;
  import floo_narrow_wide_pkg::SamNumRules;
  import floo_narrow_wide_pkg::axi_narrow_in_addr_t;

  // Simulation parameter
  localparam time CyclTime = 10ns;  // clock period 
  localparam time ApplTime = 2ns;
  localparam time TestTime = 8ns;

  // System parameters
  localparam int unsigned NumX = ${noc.routers[0].array[0]};
  localparam int unsigned NumY = ${noc.routers[0].array[1]};

  localparam int unsigned HBMLatency = 100;  // latency in cycle before HBM sent response

  // DMA test node parameter (snitch cluster behaviour)
  localparam int unsigned NarrowMaxTxnsPerId = 4;
  localparam int unsigned WideMaxTxnsPerId = 32;

  // Support function to find address map by xy id
  function sam_rule_t find_addrmap_by_xy_id(int unsigned id_x, int unsigned id_y);
    // Used input from global variable space expect target id
    for (int unsigned i = 0; i < SamNumRules; i++) begin
      if ((Sam[i].idx.x == id_x) && (Sam[i].idx.y == id_y)) begin
        return Sam[i];
      end
    end
  endfunction

endpackage
