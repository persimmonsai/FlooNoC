
`include "common_cells/registers.svh"
`include "axi/assign.svh"

module chiplet_soc
  import floo_pkg::*;
  import floo_narrow_wide_pkg::*;
(
    input logic clk_i,
    input logic rst_ni,
    input logic test_mode_i,

    input logic [312:0] mtip_i,
    input logic [312:0] msip_i,

    /// HBM Ports from FlooNoC
    input  floo_req_t  [3:0] hbm_north_floo_req_i,
    input  floo_rsp_t  [3:0] hbm_north_floo_rsp_i,
    input  floo_wide_t [3:0] hbm_north_floo_wide_i,
    output floo_req_t  [3:0] hbm_north_floo_req_o,
    output floo_rsp_t  [3:0] hbm_north_floo_rsp_o,
    output floo_wide_t [3:0] hbm_north_floo_wide_o,
    input  floo_req_t  [3:0] hbm_south_floo_req_i,
    input  floo_rsp_t  [3:0] hbm_south_floo_rsp_i,
    input  floo_wide_t [3:0] hbm_south_floo_wide_i,
    output floo_req_t  [3:0] hbm_south_floo_req_o,
    output floo_rsp_t  [3:0] hbm_south_floo_rsp_o,
    output floo_wide_t [3:0] hbm_south_floo_wide_o,
    input  floo_req_t  [3:0] hbm_west_floo_req_i,
    input  floo_rsp_t  [3:0] hbm_west_floo_rsp_i,
    input  floo_wide_t [3:0] hbm_west_floo_wide_i,
    output floo_req_t  [3:0] hbm_west_floo_req_o,
    output floo_rsp_t  [3:0] hbm_west_floo_rsp_o,
    output floo_wide_t [3:0] hbm_west_floo_wide_o,
    input  floo_req_t  [3:0] hbm_east_floo_req_i,
    input  floo_rsp_t  [3:0] hbm_east_floo_rsp_i,
    input  floo_wide_t [3:0] hbm_east_floo_wide_i,
    output floo_req_t  [3:0] hbm_east_floo_req_o,
    output floo_rsp_t  [3:0] hbm_east_floo_rsp_o,
    output floo_wide_t [3:0] hbm_east_floo_wide_o,

    input axi_narrow_in_req_t              idma_narrow_req_i,
    output axi_narrow_in_rsp_t              idma_narrow_rsp_o,
    input axi_wide_in_req_t              idma_wide_req_i,
    output axi_wide_in_rsp_t              idma_wide_rsp_o,
    output axi_narrow_out_req_t              idma_narrow_req_o,
    input axi_narrow_out_rsp_t              idma_narrow_rsp_i,
    output axi_wide_out_req_t              idma_wide_req_o,
    input axi_wide_out_rsp_t              idma_wide_rsp_i,
    output axi_narrow_out_req_t              spm_narrow_req_o,
    input axi_narrow_out_rsp_t              spm_narrow_rsp_i,
    output axi_wide_out_req_t              spm_wide_req_o,
    input axi_wide_out_rsp_t              spm_wide_rsp_i,
    input axi_narrow_in_req_t              cva6_narrow_req_i,
    output axi_narrow_in_rsp_t              cva6_narrow_rsp_o,
    output axi_narrow_out_req_t              cva6_narrow_req_o,
    input axi_narrow_out_rsp_t              cva6_narrow_rsp_i,
    output axi_narrow_out_req_t              peripherals_narrow_req_o,
    input axi_narrow_out_rsp_t              peripherals_narrow_rsp_i,
    output axi_wide_out_req_t              peripherals_wide_req_o,
    input axi_wide_out_rsp_t              peripherals_wide_rsp_i,
    input axi_narrow_in_req_t              jtag_narrow_req_i,
    output axi_narrow_in_rsp_t              jtag_narrow_rsp_o,
    output axi_narrow_out_req_t              jtag_narrow_req_o,
    input axi_narrow_out_rsp_t              jtag_narrow_rsp_i,
    output axi_wide_out_req_t              zero_mem_wide_req_o,
    input axi_wide_out_rsp_t              zero_mem_wide_rsp_i
);


// HBM NoC partial bus
  floo_req_t hbm_north_dram_0_floo_req_o;
  floo_rsp_t hbm_north_dram_0_floo_rsp_o;
  floo_wide_t hbm_north_dram_0_floo_wide_o;
  floo_req_t hbm_north_dram_0_floo_req_i;
  floo_rsp_t hbm_north_dram_0_floo_rsp_i;
  floo_wide_t hbm_north_dram_0_floo_wide_i;
  floo_req_t hbm_north_dram_1_floo_req_o;
  floo_rsp_t hbm_north_dram_1_floo_rsp_o;
  floo_wide_t hbm_north_dram_1_floo_wide_o;
  floo_req_t hbm_north_dram_1_floo_req_i;
  floo_rsp_t hbm_north_dram_1_floo_rsp_i;
  floo_wide_t hbm_north_dram_1_floo_wide_i;
  floo_req_t hbm_north_2_floo_req_o;
  floo_rsp_t hbm_north_2_floo_rsp_o;
  floo_wide_t hbm_north_2_floo_wide_o;
  floo_req_t hbm_north_2_floo_req_i;
  floo_rsp_t hbm_north_2_floo_rsp_i;
  floo_wide_t hbm_north_2_floo_wide_i;
  floo_req_t hbm_north_3_floo_req_o;
  floo_rsp_t hbm_north_3_floo_rsp_o;
  floo_wide_t hbm_north_3_floo_wide_o;
  floo_req_t hbm_north_3_floo_req_i;
  floo_rsp_t hbm_north_3_floo_rsp_i;
  floo_wide_t hbm_north_3_floo_wide_i;
  floo_req_t [1:0] hbm_south_0_floo_req_o;
  floo_rsp_t [1:0] hbm_south_0_floo_rsp_o;
  floo_wide_t [1:0] hbm_south_0_floo_wide_o;
  floo_req_t [1:0] hbm_south_0_floo_req_i;
  floo_rsp_t [1:0] hbm_south_0_floo_rsp_i;
  floo_wide_t [1:0] hbm_south_0_floo_wide_i;
  floo_req_t [1:0] hbm_south_2_floo_req_o;
  floo_rsp_t [1:0] hbm_south_2_floo_rsp_o;
  floo_wide_t [1:0] hbm_south_2_floo_wide_o;
  floo_req_t [1:0] hbm_south_2_floo_req_i;
  floo_rsp_t [1:0] hbm_south_2_floo_rsp_i;
  floo_wide_t [1:0] hbm_south_2_floo_wide_i;


  // HBM assign combined bus
  assign hbm_north_floo_req_o[0:0] = hbm_north_dram_0_floo_req_o;
  assign hbm_north_floo_rsp_o[0:0] = hbm_north_dram_0_floo_rsp_o;
  assign hbm_north_floo_wide_o[0:0] = hbm_north_dram_0_floo_wide_o;
  assign hbm_north_dram_0_floo_req_i = hbm_north_floo_req_i[0:0];
  assign hbm_north_dram_0_floo_rsp_i = hbm_north_floo_rsp_i[0:0];
  assign hbm_north_dram_0_floo_wide_i = hbm_north_floo_wide_i[0:0];
  assign hbm_north_floo_req_o[1:1] = hbm_north_dram_1_floo_req_o;
  assign hbm_north_floo_rsp_o[1:1] = hbm_north_dram_1_floo_rsp_o;
  assign hbm_north_floo_wide_o[1:1] = hbm_north_dram_1_floo_wide_o;
  assign hbm_north_dram_1_floo_req_i = hbm_north_floo_req_i[1:1];
  assign hbm_north_dram_1_floo_rsp_i = hbm_north_floo_rsp_i[1:1];
  assign hbm_north_dram_1_floo_wide_i = hbm_north_floo_wide_i[1:1];
  assign hbm_north_floo_req_o[2:2] = hbm_north_2_floo_req_o;
  assign hbm_north_floo_rsp_o[2:2] = hbm_north_2_floo_rsp_o;
  assign hbm_north_floo_wide_o[2:2] = hbm_north_2_floo_wide_o;
  assign hbm_north_2_floo_req_i = hbm_north_floo_req_i[2:2];
  assign hbm_north_2_floo_rsp_i = hbm_north_floo_rsp_i[2:2];
  assign hbm_north_2_floo_wide_i = hbm_north_floo_wide_i[2:2];
  assign hbm_north_floo_req_o[3:3] = hbm_north_3_floo_req_o;
  assign hbm_north_floo_rsp_o[3:3] = hbm_north_3_floo_rsp_o;
  assign hbm_north_floo_wide_o[3:3] = hbm_north_3_floo_wide_o;
  assign hbm_north_3_floo_req_i = hbm_north_floo_req_i[3:3];
  assign hbm_north_3_floo_rsp_i = hbm_north_floo_rsp_i[3:3];
  assign hbm_north_3_floo_wide_i = hbm_north_floo_wide_i[3:3];
  assign hbm_south_floo_req_o[1:0] = hbm_south_0_floo_req_o;
  assign hbm_south_floo_rsp_o[1:0] = hbm_south_0_floo_rsp_o;
  assign hbm_south_floo_wide_o[1:0] = hbm_south_0_floo_wide_o;
  assign hbm_south_0_floo_req_i = hbm_south_floo_req_i[1:0];
  assign hbm_south_0_floo_rsp_i = hbm_south_floo_rsp_i[1:0];
  assign hbm_south_0_floo_wide_i = hbm_south_floo_wide_i[1:0];
  assign hbm_south_floo_req_o[3:2] = hbm_south_2_floo_req_o;
  assign hbm_south_floo_rsp_o[3:2] = hbm_south_2_floo_rsp_o;
  assign hbm_south_floo_wide_o[3:2] = hbm_south_2_floo_wide_o;
  assign hbm_south_2_floo_req_i = hbm_south_floo_req_i[3:2];
  assign hbm_south_2_floo_rsp_i = hbm_south_floo_rsp_i[3:2];
  assign hbm_south_2_floo_wide_i = hbm_south_floo_wide_i[3:2];

  chiplet_floo_noc i_chiplet_floo_noc (
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .test_enable_i(1'b0),

      .mtip_i('0),
      .msip_i('0),

      .hbm_north_dram_0_floo_req_i(hbm_north_dram_0_floo_req_i),
      .hbm_north_dram_0_floo_rsp_i(hbm_north_dram_0_floo_rsp_i),
      .hbm_north_dram_0_floo_wide_i(hbm_north_dram_0_floo_wide_i),
      .hbm_north_dram_0_floo_req_o(hbm_north_dram_0_floo_req_o),
      .hbm_north_dram_0_floo_rsp_o(hbm_north_dram_0_floo_rsp_o),
      .hbm_north_dram_0_floo_wide_o(hbm_north_dram_0_floo_wide_o),
      .hbm_north_dram_1_floo_req_i(hbm_north_dram_1_floo_req_i),
      .hbm_north_dram_1_floo_rsp_i(hbm_north_dram_1_floo_rsp_i),
      .hbm_north_dram_1_floo_wide_i(hbm_north_dram_1_floo_wide_i),
      .hbm_north_dram_1_floo_req_o(hbm_north_dram_1_floo_req_o),
      .hbm_north_dram_1_floo_rsp_o(hbm_north_dram_1_floo_rsp_o),
      .hbm_north_dram_1_floo_wide_o(hbm_north_dram_1_floo_wide_o),
      .hbm_north_2_floo_req_i(hbm_north_2_floo_req_i),
      .hbm_north_2_floo_rsp_i(hbm_north_2_floo_rsp_i),
      .hbm_north_2_floo_wide_i(hbm_north_2_floo_wide_i),
      .hbm_north_2_floo_req_o(hbm_north_2_floo_req_o),
      .hbm_north_2_floo_rsp_o(hbm_north_2_floo_rsp_o),
      .hbm_north_2_floo_wide_o(hbm_north_2_floo_wide_o),
      .hbm_north_3_floo_req_i(hbm_north_3_floo_req_i),
      .hbm_north_3_floo_rsp_i(hbm_north_3_floo_rsp_i),
      .hbm_north_3_floo_wide_i(hbm_north_3_floo_wide_i),
      .hbm_north_3_floo_req_o(hbm_north_3_floo_req_o),
      .hbm_north_3_floo_rsp_o(hbm_north_3_floo_rsp_o),
      .hbm_north_3_floo_wide_o(hbm_north_3_floo_wide_o),
      .hbm_south_0_floo_req_i(hbm_south_0_floo_req_i),
      .hbm_south_0_floo_rsp_i(hbm_south_0_floo_rsp_i),
      .hbm_south_0_floo_wide_i(hbm_south_0_floo_wide_i),
      .hbm_south_0_floo_req_o(hbm_south_0_floo_req_o),
      .hbm_south_0_floo_rsp_o(hbm_south_0_floo_rsp_o),
      .hbm_south_0_floo_wide_o(hbm_south_0_floo_wide_o),
      .hbm_south_2_floo_req_i(hbm_south_2_floo_req_i),
      .hbm_south_2_floo_rsp_i(hbm_south_2_floo_rsp_i),
      .hbm_south_2_floo_wide_i(hbm_south_2_floo_wide_i),
      .hbm_south_2_floo_req_o(hbm_south_2_floo_req_o),
      .hbm_south_2_floo_rsp_o(hbm_south_2_floo_rsp_o),
      .hbm_south_2_floo_wide_o(hbm_south_2_floo_wide_o),
      .hbm_west_floo_req_i(hbm_west_floo_req_i),
      .hbm_west_floo_rsp_i(hbm_west_floo_rsp_i),
      .hbm_west_floo_wide_i(hbm_west_floo_wide_i),
      .hbm_west_floo_req_o(hbm_west_floo_req_o),
      .hbm_west_floo_rsp_o(hbm_west_floo_rsp_o),
      .hbm_west_floo_wide_o(hbm_west_floo_wide_o),
      .hbm_east_floo_req_i(hbm_east_floo_req_i),
      .hbm_east_floo_rsp_i(hbm_east_floo_rsp_i),
      .hbm_east_floo_wide_i(hbm_east_floo_wide_i),
      .hbm_east_floo_req_o(hbm_east_floo_req_o),
      .hbm_east_floo_rsp_o(hbm_east_floo_rsp_o),
      .hbm_east_floo_wide_o(hbm_east_floo_wide_o),
      .idma_narrow_req_i(idma_narrow_req_i),
      .idma_narrow_rsp_o(idma_narrow_rsp_o),
      .idma_wide_req_i(idma_wide_req_i),
      .idma_wide_rsp_o(idma_wide_rsp_o),
      .idma_narrow_req_o(idma_narrow_req_o),
      .idma_narrow_rsp_i(idma_narrow_rsp_i),
      .idma_wide_req_o(idma_wide_req_o),
      .idma_wide_rsp_i(idma_wide_rsp_i),
      .spm_narrow_req_o(spm_narrow_req_o),
      .spm_narrow_rsp_i(spm_narrow_rsp_i),
      .spm_wide_req_o(spm_wide_req_o),
      .spm_wide_rsp_i(spm_wide_rsp_i),
      .cva6_narrow_req_i(cva6_narrow_req_i),
      .cva6_narrow_rsp_o(cva6_narrow_rsp_o),
      .cva6_narrow_req_o(cva6_narrow_req_o),
      .cva6_narrow_rsp_i(cva6_narrow_rsp_i),
      .peripherals_narrow_req_o(peripherals_narrow_req_o),
      .peripherals_narrow_rsp_i(peripherals_narrow_rsp_i),
      .peripherals_wide_req_o(peripherals_wide_req_o),
      .peripherals_wide_rsp_i(peripherals_wide_rsp_i),
      .jtag_narrow_req_i(jtag_narrow_req_i),
      .jtag_narrow_rsp_o(jtag_narrow_rsp_o),
      .jtag_narrow_req_o(jtag_narrow_req_o),
      .jtag_narrow_rsp_i(jtag_narrow_rsp_i),
      .zero_mem_wide_req_o(zero_mem_wide_req_o),
      .zero_mem_wide_rsp_i(zero_mem_wide_rsp_i)

  );

endmodule