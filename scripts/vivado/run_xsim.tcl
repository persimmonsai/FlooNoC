# Copyright (c) 2020 ETH Zurich, University of Bologna
#
# Copyright and related rights are licensed under the Solderpad Hardware
# License, Version 0.51 (the "License"); you may not use this file except in
# compliance with the License.  You may obtain a copy of the License at
# http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
# or agreed to in writing, software, hardware and materials distributed under
# this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.
#
# Wolfgang Roenninger <wroennin@ethz.ch>


####################################################################################################
# This script runs xsim in vivado
####################################################################################################

set tb_name tb_floo_compute_tile_array

# set script root to location where this script is located
set SCRIPT_ROOT [file normalize [file dirname [info script]]]

# check if the enviroment variables are set, if not, set default to genesys2
# if {![info exists ::env(XILINX_PART)]} {
# 	puts "Set default XILINX_PART"
# 	set env(XILINX_PART) "xcu250-figd2104-2l-e"
# }
# if {![info exists ::env(XILINX_BOARD)]} {
# 	puts "Set default XILINX_BOARD"
# 	set env(XILINX_BOARD) "xilinx.com:au250:part0:1.3"
# }
set env(XILINX_BOARD) "xilinx.com:vcu128:part0:1.0"
set env(XILINX_PART) "xcvu37p-fsvh2892-2l-e"

####################################################################################################
# Create project
####################################################################################################

set project $tb_name

create_project $project . -force
# create_project $project . -force -part $::env(XILINX_PART)
set_property board_part $::env(XILINX_BOARD) [current_project]

# set number of threads
set_param general.maxThreads 4

####################################################################################################
# add design sources
####################################################################################################

source $SCRIPT_ROOT/add_sources.tcl
set_property top $tb_name [get_filesets sim_1]
set_property top_lib xil_defaultlib [get_filesets sim_1]

# Define XSIM
set_property verilog_define {TARGET_SIMULATION TARGET_FPGA TARGET_TEST TARGET_VIVADO TARGET_XILINX XSIM} [get_filesets sim_1]

####################################################################################################
# Simulate tc_sram_xilinx with one port
####################################################################################################

#set_property generic NumPorts=32'd1 [get_fileset sim_1]
update_ip_catalog

set_property top $tb_name [current_fileset]
update_compile_order -fileset sources_1

launch_simulation

run -all

close_sim

# ####################################################################################################
# # Simulate tc_sram_xilinx with two ports
# ####################################################################################################

# set_property generic NumPorts=32'd2 [get_fileset sim_1]
# update_ip_catalog

# update_compile_order -fileset sources_1

# launch_simulation

# run -all

# close_sim
