// Copyright 2022 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// Michael Rogenmoser <michaero@iis.ee.ethz.ch>
// Tim Fischer <fischeti@iis.ee.ethz.ch>

`include "floo_noc/typedef.svh"

/// A mesh topology with configurable number of rows and columns
module floo_mesh
import floo_pkg::*;
#(
  parameter int unsigned NumX = 4,
  parameter int unsigned NumY = 4,
  parameter int unsigned NumVirtChannels = 1,
  parameter int unsigned NumPhysChannels = 1,
  parameter route_algo_e RouteAlgo       = IdTable,
  parameter type flit_t = logic,
  parameter type xy_id_t = logic
) (
  input logic clk_i,
  input logic rst_ni,
  // Connect with compute cluster
  input  logic  [NumX-1:0][NumY-1:0][NumVirtChannels-1:0]  valid_i,
  output logic  [NumX-1:0][NumY-1:0][NumVirtChannels-1:0]  ready_o,
  input  flit_t [NumX-1:0][NumY-1:0][NumPhysChannels-1:0]  data_i,
  // Connect with compute cluster
  output logic  [NumX-1:0][NumY-1:0][NumVirtChannels-1:0] valid_o,
  input  logic  [NumX-1:0][NumY-1:0][NumVirtChannels-1:0] ready_i,
  output flit_t [NumX-1:0][NumY-1:0][NumPhysChannels-1:0] data_o
);

  flit_t  [NumX-2:0][NumY-1:0][NumPhysChannels-1:0] pos_x_flit;
  logic   [NumX-2:0][NumY-1:0][NumVirtChannels-1:0] pos_x_ready, pos_x_valid;
  flit_t  [NumX-2:0][NumY-1:0][NumPhysChannels-1:0] neg_x_flit;
  logic   [NumX-2:0][NumY-1:0][NumVirtChannels-1:0] neg_x_ready, neg_x_valid;
  flit_t  [NumX-1:0][NumY-2:0][NumPhysChannels-1:0] pos_y_flit;
  logic   [NumX-1:0][NumY-2:0][NumVirtChannels-1:0] pos_y_ready, pos_y_valid;
  flit_t  [NumX-1:0][NumY-2:0][NumPhysChannels-1:0] neg_y_flit;
  logic   [NumX-1:0][NumY-2:0][NumVirtChannels-1:0] neg_y_ready, neg_y_valid;

  for (genvar x = 0; x < NumX; x++) begin : gen_x
    for (genvar y = 0; y < NumY; y++) begin : gen_y
      xy_id_t current_id;
      assign current_id = '{x: x, y: y}; // Generate x-y ID for each router

      // NumDirections = 5 for Eject, North, South, East, West
      flit_t  [NumDirections-1:0][NumPhysChannels-1:0] in_flit;
      logic   [NumDirections-1:0][NumVirtChannels-1:0] in_ready, in_valid;
      flit_t  [NumDirections-1:0][NumPhysChannels-1:0] out_flit;
      logic   [NumDirections-1:0][NumVirtChannels-1:0] out_ready, out_valid;

      always_comb begin
        in_flit[West:North] = '0;
        in_valid[West:North] = '0;
        out_ready[West:North] = '0;

        in_valid[Eject] = valid_i[x][y];
        in_flit[Eject] = data_i[x][y];
        ready_o[x][y] = in_ready[Eject];
        valid_o[x][y] = out_valid[Eject];
        data_o[x][y] = out_flit[Eject];
        out_ready[Eject] = ready_i[x][y];

        // Y
        if (y < NumY-1) begin
          in_flit[North]    = neg_y_flit[x][y];
          in_valid[North]   = neg_y_valid[x][y];
          neg_y_ready[x][y] = in_ready[North];
          pos_y_flit[x][y]  = out_flit[North];
          pos_y_valid[x][y] = out_valid[North];
          out_ready[North]  = pos_y_ready[x][y];
        end
        if (y > 0) begin
          in_flit[South]      = pos_y_flit[x][y-1];
          in_valid[South]     = pos_y_valid[x][y-1];
          pos_y_ready[x][y-1] = in_ready[South];
          neg_y_flit[x][y-1]  = out_flit[South];
          neg_y_valid[x][y-1] = out_valid[South];
          out_ready[South]    = neg_y_ready[x][y-1];
        end

        // X
        if (x < NumX-1) begin
          in_flit[East]     = neg_x_flit[x][y];
          in_valid[East]    = neg_x_valid[x][y];
          neg_x_ready[x][y] = in_ready[East];
          pos_x_flit[x][y]  = out_flit[East];
          pos_x_valid[x][y] = out_valid[East];
          out_ready[East]   = pos_x_ready[x][y];
        end
        if (x > 0) begin
          in_flit[West]      = pos_x_flit[x-1][y];
          in_valid[West]     = pos_x_valid[x-1][y];
          pos_x_ready[x-1][y] = in_ready[West];
          neg_x_flit[x-1][y]  = out_flit[West];
          neg_x_valid[x-1][y] = out_valid[West];
          out_ready[West]    = neg_x_ready[x-1][y];
        end
      end

      // One router per connection
      floo_router #(
        .NumPhysChannels ( NumPhysChannels ),
        .NumVirtChannels ( NumVirtChannels ),
        .NumRoutes       ( 5               ),
        .flit_t          ( flit_t          ),
        .RouteAlgo       ( RouteAlgo       ),
        .ChannelFifoDepth( 2               ),
        .IdWidth         ( $bits(xy_id_t)  ),
        .id_t            ( xy_id_t         ),
        .addr_rule_t     ( logic           ),
        .NumAddrRules    ( 1               )
      ) i_floo_router (
        .clk_i,
        .rst_ni,
        .test_enable_i  ( 1'b0       ),

        .xy_id_i        ( current_id ),
        .id_route_map_i ( '0         ),

        .valid_i        ( in_valid  ),
        .ready_o        ( in_ready  ),
        .data_i         ( in_flit   ),

        .valid_o        ( out_valid ),
        .ready_i        ( out_ready ),
        .data_o         ( out_flit  )
      );

    end
  end

endmodule
