// Copyright 2022 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Michael Rogenmoser <michaero@iis.ee.ethz.ch>

`include "common_cells/registers.svh"

module floo_route_select
  import floo_pkg::*;
#(
    parameter int unsigned NumRoutes = 1,
    parameter type flit_t = logic,
    parameter route_algo_e RouteAlgo = IdTable,
    parameter bit LockRouting = 1'b1,
    /// Used for ID-based and XY routing
    parameter int unsigned IdWidth = 0,
    parameter type border_id_t = logic,
    parameter border_id_t BorderId = 0,
    /// Used for ID-based routing
    parameter int unsigned NumAddrRules  = 1, // initial to 1 to avoid id_route_map_i start from -1:0
    parameter type addr_rule_t = logic,
    parameter type id_t = logic [IdWidth-1:0],
    /// Used for source-based routing
    parameter int unsigned RouteSelWidth = $clog2(NumRoutes)
) (
    input logic clk_i,
    input logic rst_ni,
    input logic test_enable_i,

    input id_t                           xy_id_i,
    input addr_rule_t [NumAddrRules-1:0] id_route_map_i,

    input  flit_t                 channel_i,
    input  logic                  valid_i,
    input  logic                  ready_i,
    output flit_t                 channel_o,
    output logic  [NumRoutes-1:0] route_sel_o  // One-hot route

);

  logic [NumRoutes-1:0] route_sel;

  if (RouteAlgo == IdIsPort) begin : gen_id_is_port
    // Routing assuming the ID is the port to be taken

    assign channel_o = channel_i;

    // One-hot encoding of the decoded route
    always_comb begin : proc_route_sel
      route_sel = '0;
      route_sel[channel_i.hdr.dst_id] = 1'b1;
    end

  end else if (RouteAlgo == IdTable) begin : gen_id_table
    // Routing based on an ID table passed into the router (TBD parameter or signal)
    // Assumes an ID field present in the flit_t

    typedef logic [$clog2(NumRoutes)-1:0] out_id_t;
    out_id_t out_id;

    assign channel_o = channel_i;

    addr_decode #(
        .NoIndices(NumRoutes),
        .NoRules  (NumAddrRules),
        .addr_t   (id_t),
        .rule_t   (addr_rule_t),
        .Napot    (0)
    ) i_id_decode (
        .addr_i          (channel_i.hdr.dst_id),
        .addr_map_i      (id_route_map_i),
        .idx_o           (out_id),
        .dec_valid_o     (),
        .dec_error_o     (),
        .default_idx_i   ('0),
        .en_default_idx_i('0)
    );

    // One-hot encoding of the decoded route
    always_comb begin : proc_route_sel
      route_sel = '0;
      route_sel[out_id] = 1'b1;
    end

  end else if (RouteAlgo == SourceRouting) begin : gen_consumption
    // Routing based on a consumable header in the flit
    always_comb begin : proc_route_sel
      route_sel = '0;
      route_sel[channel_i.hdr.dst_id[RouteSelWidth-1:0]] = 1'b1;
      channel_o = channel_i;
      channel_o.hdr.dst_id = channel_i.hdr.dst_id >> RouteSelWidth;
    end

  end else if (RouteAlgo == XYRouting) begin : gen_xy_routing
    // Routing based on simple XY routing
    // Assumes an even-bit ID field in the flit_t used for xy
    // assert ((IdWidth/2)*2 == IdWidth);
    // assert (NumRoutes == 5);

    // Port map:
    //   - 0: target/destination
    //   - 1: upper bits decreasing (South)
    //   - 2: lower bits decreasing (West )
    //   - 3: upper bits increasing (North)
    //   - 4: lower bits increasing (East )

    // One-hot encoding of the decoded route

    id_t id_in;
    assign id_in = id_t'(channel_i.hdr.dst_id);
    logic xy_not_equal;
    logic no_route_detect;
    assign xy_not_equal = (id_in.x != xy_id_i.x) && (id_in.y != xy_id_i.y);

    always_comb begin : proc_route_sel
      route_sel = '0;
      no_route_detect = 1'b0;
      if (id_in == xy_id_i) begin
        route_sel[Eject] = 1'b1;
        // Special condition to avoid routing to border of XY mesh that there is no router placed, and 
        // that is not a destination since both X and Y direction is not equal
      end else if (xy_not_equal) begin
        // Expect to route to route_sel[West] if that is not a border
        if ((id_in.x < xy_id_i.x) && (xy_id_i.x - 1 != BorderId.west)) begin
          route_sel[West] = 1'b1;
          // Expect to route to route_sel[East] if that is not a border
        end else if ((id_in.x > xy_id_i.x) && (xy_id_i.x + 1 != BorderId.east)) begin
          route_sel[East] = 1'b1;
          // Expect to route to route_sel[South] if that is not a border
        end else if ((id_in.y < xy_id_i.y) && (xy_id_i.y - 1 != BorderId.south)) begin
          route_sel[South] = 1'b1;
          // Expect to route to route_sel[North] if that is not a border
        end else if ((id_in.y > xy_id_i.y) && (xy_id_i.y + 1 != BorderId.north)) begin
          route_sel[North] = 1'b1;
`ifdef VCS
        end else begin
          no_route_detect = 1'b1;
`endif
        end
        // Routing straight forward to the destination when X or Y position is match
      end else if (id_in.x == xy_id_i.x) begin
        if (id_in.y < xy_id_i.y) begin
          route_sel[South] = 1'b1;
        end else begin
          route_sel[North] = 1'b1;
        end
      end else begin
        if (id_in.x < xy_id_i.x) begin
          route_sel[West] = 1'b1;
        end else begin
          route_sel[East] = 1'b1;
        end
      end
    end

    always @(posedge clk_i) begin
      if (ready_i && valid_i && no_route_detect)
        $error("Unknown direction to route in case both X and Y position mismatch");
    end

    assign channel_o = channel_i;

  end else begin : gen_err
    // Unknown or unimplemented routing otherwise
    initial begin
      $fatal(1, "Routing algorithm unknown");
    end
  end

  if (LockRouting) begin : gen_lock
    logic locked_route_d, locked_route_q;
    logic [NumRoutes-1:0] route_sel_q;

    assign route_sel_o = locked_route_q ? route_sel_q : route_sel;

    always_comb begin
      locked_route_d = locked_route_q;

      if (ready_i && valid_i) begin
        locked_route_d = ~channel_i.hdr.last;

      end
    end

    always @(posedge clk_i) begin
      if (ready_i && valid_i && locked_route_q && (route_sel_q != route_sel))
        $warning("Mismatch in route selection!");
    end

    `FF(locked_route_q, locked_route_d, '0)
    `FFL(route_sel_q, route_sel, ~locked_route_q, '0)

  end else begin : gen_no_lock
    assign route_sel_o = route_sel;
  end

endmodule
