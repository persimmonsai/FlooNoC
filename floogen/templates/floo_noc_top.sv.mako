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

// AUTOMATICALLY GENERATED! DO NOT EDIT!

module ${noc.name}_floo_noc
  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;
  import hbm_pd_pkg::*;
#(
  ${noc.render_cut_param()}
) (
  input logic clk_i,
  input logic rst_ni,
  input logic test_enable_i,

  ${noc.render_tile_ports()}
  ${noc.render_ports()}
);

${noc.render_links()}
${noc.render_nis()}
${noc.render_routers()}

endmodule
