// Copyright 2022 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Tim Fischer <fischeti@iis.ee.ethz.ch>

`include "common_cells/assertions.svh"
`include "floo_noc/typedef.svh"

// Simulation parameter for compute tile array model
package compute_tile_test_pkg;

  import floo_narrow_wide_pkg::addr_map_rule_t;
  import floo_narrow_wide_pkg::AddrMap;
  import floo_narrow_wide_pkg::AddrMapNumRules;
  import floo_narrow_wide_pkg::axi_narrow_in_addr_t;

  // Simulation parameter
  localparam time CyclTime = 10ns;  // clock period 
  localparam time ApplTime = 2ns;
  localparam time TestTime = 8ns;

  // System parameters
  localparam int unsigned NumX = 2;
  localparam int unsigned NumY = 2;
  // localparam int unsigned NumMax = (NumX > NumY) ? NumX : NumY;

  localparam int unsigned HBMLatency = 100;  // latency in cycle before HBM sent response
  localparam axi_narrow_in_addr_t HBMSize = 48'h10000;  // 64KB
  localparam axi_narrow_in_addr_t MemSize = HBMSize;

  // `ASSERT_INIT(NotEnoughXBits, $clog2(NumX + 2) <= $bits(x_bits_t))
  // `ASSERT_INIT(NotEnoughYBits, $clog2(NumY + 2) <= $bits(y_bits_t))
  // `ASSERT_INIT(NotEnoughAddrOffset, $clog2(HBMSize) <= XYAddrOffsetX)

  // DMA test node parameter (snitch cluster behaviour)
  localparam int unsigned NarrowMaxTxnsPerId = 4;
  localparam int unsigned WideMaxTxnsPerId = 32;

  // Snitch cluster parameter
  //localparam int unsigned NrCores = 4;

  // Support function to find address map by xy id
  function addr_map_rule_t find_addrmap_by_xy_id(int unsigned id_x, int unsigned id_y);
    // Used input from global variable space expect target id
    for (int unsigned i = 0; i < AddrMapNumRules; i++) begin
      if ((AddrMap[i].idx.x == id_x) && (AddrMap[i].idx.y == id_y)) begin
        return AddrMap[i];
      end
    end
  endfunction

endpackage
