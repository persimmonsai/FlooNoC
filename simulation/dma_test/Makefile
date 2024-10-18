# Copyright 2022 ETH Zurich and University of Bologna.
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

# Author: Michael Rogenmoser <michaero@iis.ee.ethz.ch>
# Author: Tim Fischer <fischeti@iis.ee.ethz.ch>

##########
# Common #
##########

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR  := $(dir $(MKFILE_PATH))

.PHONY: all clean
all: compile-vsim
clean: clean-vsim clean-vcs clean-bender clean-log

############
# Programs #
############

BENDER     	?= bender
VSIM       	?= vsim
VCS			?= vcs

#####################
# Compilation Flags #
#####################

BENDER_FLAGS += -t rtl
BENDER_FLAGS += -t test
BENDER_FLAGS += -t dma_test # use for local simulation of FlooNoC system

# VSIM
VLOG_ARGS += -suppress vlog-2583
VLOG_ARGS += -suppress vlog-13314
VLOG_ARGS += -suppress vlog-13233
VLOG_ARGS += -timescale \"1 ns / 1 ps\"

$(warning $(VLOG_ARGS))

# VCS
VLOGAN_ARGS += -full64
VLOGAN_ARGS += -kdb
VLOGAN_ARGS += -assert svaext
#VLOGAN_ARGS += -assert disable_cover
VLOGAN_ARGS += -timescale=1ns/1ns
VLOGAN_ARGS += -debug_access+all

VCS_FLAGS += -full64 # additional compile param because ecad-1 doesn't have all the 32 bit libraries installed
VCS_FLAGS += -Mlib=work-vcs
VCS_FLAGS += -Mdir=work-vcs
VCS_FLAGS += -kdb
VCS_FLAGS += -debug_access+all

# Automatically open the waveform if a wave.tcl file is present
VSIM_FLAGS_GUI += -do "log -r /*"
VSIM_FLAGS_GUI += -voptargs=+acc
ifneq ("$(wildcard hw/tb/wave/$(TB_DUT).wave.tcl)","")
    VSIM_FLAGS_GUI += -do "source hw/tb/wave/$(TB_DUT).wave.tcl"
endif

clean-bender:
	rm -rf .bender
	rm -rf Bender.lock

clean-log:
	rm -rf bin
	rm -rf logs

########################
# QuestaSim Simulation #
########################

.PHONY: compile-vsim run-vsim run-vsim-batch clean-vsim

scripts/compile_vsim.tcl: Bender.yml
	mkdir -p scripts
	echo 'set ROOT [file normalize [file dirname [info script]]/..]' > scripts/compile_vsim.tcl
	$(BENDER) script vsim --vlog-arg="$(VLOG_ARGS)" $(BENDER_FLAGS) | grep -v "set ROOT" >> scripts/compile_vsim.tcl
	echo >> scripts/compile_vsim.tcl

compile-vsim: scripts/compile_vsim.tcl
	$(VSIM) -64 -c -do "source scripts/compile_vsim.tcl; quit"

run-vsim:
	$(VSIM) $(VSIM_FLAGS) $(VSIM_FLAGS_GUI) $(TB_DUT)

run-vsim-batch:
	$(VSIM) -c $(VSIM_FLAGS) $(TB_DUT) -do "run -all; quit"

clean-vsim:
	rm -rf scripts/compile_vsim.tcl
	rm -rf modelsim.ini
	rm -rf transcript
	rm -rf work*

##################
# VCS Simulation #
##################

.PHONY: compile-vcs compile-vcs-batch run-vcs run-vcs-batch clean-vcs

work-vcs/compile_vcs.sh: Bender.yml
	mkdir -p work-vcs
	echo 'set ROOT [file normalize [file dirname [info script]]/..]' > work-vcs/compile_vcs.sh
	$(BENDER) script vcs --vlog-arg="$(VLOGAN_ARGS)" $(BENDER_FLAGS) | grep -v "set ROOT" >> work-vcs/compile_vcs.sh
	chmod +x work-vcs/compile_vcs.sh

compile-vcs-batch: work-vcs/compile_vcs.sh
	work-vcs/compile_vcs.sh > work-vcs/parsing.log

compile-vcs: compile-vcs-batch

bin/floo_noc_gui.vcs: compile-vcs
	mkdir -p bin
	$(VCS) $(VCS_FLAGS) -o bin/floo_noc_gui.vcs $(TB_DUT) 2>&1 | tee work-vcs/compile.log

bin/floo_noc_batch.vcs: compile-vcs-batch
	mkdir -p bin
	$(VCS) $(VCS_FLAGS) -o bin/floo_noc_batch.vcs $(TB_DUT) 2>&1 | tee work-vcs/compile.log

run-vcs:
	./bin/floo_noc_gui.vcs $(SIMV_FLAGS)

run-vcs-batch:
	./bin/floo_noc_batch.vcs $(SIMV_FLAGS)

clean-vcs:
	rm -rf work-vcs/compile_vcs.sh
	rm -rf bin
	rm -rf work-vcs
	rm -rf AN.DB
	rm -rf simv.daidir
	rm -rf elabMhIdDidWork.txt
	rm -rf ucli.key
	rm -rf vc_hdrs.h
	rm -rf simv
	rm -rf novas.rc
	rm -rf novas.conf
	rm -rf novas_dump.log
	rm -rf Makefile.Msimdepends
	rm -rf Makefile.Msimdepends.vlib_analyze_DEFAULT.dep
	rm -rf verdi_config_file
	rm -rf verdiLog
	rm -rf simv.vdb
	rm -rf sysBusyPLog
