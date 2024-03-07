#!/bin/bash
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

set -e
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

#VIVADO_VER="2020.2"

bender script vivado -t rtl > ${ROOT}/scripts/vivado/add_sources.tcl
# mkdir -p scripts
# echo 'set ROOT [file normalize [file dirname [info script]]/..]' > ${ROOT}/scripts/vivado/add_sources.tcl
# bender script vivado-sim -t rtl -t test | grep -v "set ROOT" >> ${ROOT}/scripts/vivado/add_sources.tcl

#vivado-${VIVADO_VER} vivado -mode batch -source ${ROOT}/scripts/vivado/run_xsim.tcl
#vivado -mode batch -source ${ROOT}/scripts/vivado/run_xsim.tcl
vivado -source ${ROOT}/scripts/vivado/run_xsynth.tcl



