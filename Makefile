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
clean: clean-vsim clean-vcs clean-spyglass clean-jobs clean-sources clean-vivado clean-bender

############
# Programs #
############

BENDER     	?= bender
VSIM       	?= vsim
VCS			?= vcs
SPYGLASS   	?= sg_shell
VERIBLE_FMT	?= verible-verilog-format

#####################
# Compilation Flags #
#####################

BENDER_FLAGS += -t rtl
BENDER_FLAGS += -t test

TB_DUT ?= tb_floo_compute_tile_array
SIM_TIME ?= 1500000

# VSIM
VLOG_ARGS += -suppress vlog-2583
VLOG_ARGS += -suppress vlog-13314
VLOG_ARGS += -suppress vlog-13233
VLOG_ARGS += -timescale \"1 ns / 1 ps\"
ifdef DMA_TESTNODE
	VLOG_ARGS += +define+DMA_TESTNODE
endif

$(warning $(VLOG_ARGS))

VSIM_FLAGS += -64
VSIM_FLAGS += -t 1ps
VSIM_FLAGS += -sv_seed 0

# VCS
VLOGAN_ARGS += -full64
VLOGAN_ARGS += -kdb
VLOGAN_ARGS += -timescale=1ns/1ns
ifdef DMA_TESTNODE
	VLOGAN_ARGS += +define+DMA_TESTNODE
endif

VCS_FLAGS += -full64 # additional compile param because ecad-1 doesn't have all the 32 bit libraries installed
VCS_FLAGS += -Mlib=work-vcs
VCS_FLAGS += -Mdir=work-vcs
VCS_FLAGS += -kdb
SIMV_FLAGS =

#SIMV_FLAGS += +vcs+dumpvars+test.vcd
SIMV_FLAGS += +vcs+finish+$(SIM_TIME) # maximum simulation time in ns

# Set the job name and directory if specified
ifdef JOB_NAME
	VSIM_FLAGS += +JOB_NAME=$(JOB_NAME)
	SIMV_FLAGS += +JOB_NAME=$(JOB_NAME)
endif
ifdef JOB_DIR
	VSIM_FLAGS += +JOB_DIR=$(JOB_DIR)
	SIMV_FLAGS += +JOB_DIR=$(JOB_DIR)
endif
ifdef LOG_FILE
	VSIM_FLAGS += -l $(LOG_FILE)
	VSIM_FLAGS += -nostdout
endif

# Automatically open the waveform if a wave.tcl file is present
VSIM_FLAGS_GUI += -do "log -r /*"
VSIM_FLAGS_GUI += -voptargs=+acc
ifneq ("$(wildcard hw/tb/wave/$(TB_DUT).wave.tcl)","")
    VSIM_FLAGS_GUI += -do "source hw/tb/wave/$(TB_DUT).wave.tcl"
endif

###########
# FlooGen #
###########

FLOOGEN ?= floogen

FLOOGEN_OUT_DIR ?= $(MKFILE_DIR)generated
FLOOGEN_PKG_OUT_DIR ?= $(MKFILE_DIR)hw
FLOOGEN_CFG_DIR ?= $(MKFILE_DIR)floogen/examples
FLOOGEN_TPL_DIR ?= $(MKFILE_DIR)floogen/templates

FLOOGEN_PKG_CFG ?= $(shell find $(FLOOGEN_CFG_DIR) -name "*_pkg.yml")
FLOOGEN_PKG_SRC ?= $(patsubst $(FLOOGEN_CFG_DIR)/%_pkg.yml,$(FLOOGEN_PKG_OUT_DIR)/floo_%_pkg.sv,$(FLOOGEN_PKG_CFG))
FLOOGEN_TPL ?= $(shell find $(FLOOGEN_TPL_DIR) -name "*.mako")

.PHONY: install-floogen pkg-sources sources clean-sources clean-bender

install-floogen:
	@which $(FLOOGEN) > /dev/null || (echo "Installing floogen..." && pip install .)

pkg-sources: install-floogen $(FLOOGEN_PKG_SRC)
$(FLOOGEN_PKG_OUT_DIR)/floo_%_pkg.sv: $(FLOOGEN_CFG_DIR)/%_pkg.yml $(FLOOGEN_TPL)
	$(FLOOGEN) -c $< --only-pkg --pkg-outdir $(FLOOGEN_PKG_OUT_DIR) $(FLOOGEN_ARGS)

sources: install-floogen
	$(FLOOGEN) -c $(FLOOGEN_CFG) -o $(FLOOGEN_OUT_DIR) --pkg-outdir $(FLOOGEN_PKG_OUT_DIR) $(FLOOGEN_ARGS)

clean-sources:
	rm -rf $(FLOOGEN_OUT_DIR)
#	rm -f $(FLOOGEN_PKG_SRC)

clean-bender:
	rm -rf .bender
	rm -rf Bender.lock

######################
# Traffic Generation #
######################

TRAFFIC_GEN ?= util/gen_jobs.py
TRAFFIC_TB ?= compute_tile_array
TRAFFIC_TYPE ?= random
TRAFFIC_RW ?= read
TRAFFIC_OUTDIR ?= hw/test/jobs

TRAFFIC_NR_BURST_NUM ?= 10
TRAFFIC_NR_BURST_LEN ?= 1
TRAFFIC_WD_BURST_NUM ?= 100
TRAFFIC_WD_BURST_LEN ?= 16

.PHONY: jobs clean-jobs
jobs: $(TRAFFIC_GEN)
	mkdir -p $(TRAFFIC_OUTDIR)
	$(TRAFFIC_GEN) --out_dir $(TRAFFIC_OUTDIR) --tb $(TRAFFIC_TB) --traffic_type $(TRAFFIC_TYPE) --rw $(TRAFFIC_RW) \
		--num_narrow_bursts $(TRAFFIC_NR_BURST_NUM) --num_wide_bursts $(TRAFFIC_WD_BURST_NUM) \
		--narrow_burst_length $(TRAFFIC_NR_BURST_LEN) --wide_burst_length $(TRAFFIC_WD_BURST_LEN)

clean-jobs:
	rm -rf $(TRAFFIC_OUTDIR)

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

scripts/compile_vcs.sh: Bender.yml
	mkdir -p scripts
	echo 'set ROOT [file normalize [file dirname [info script]]/..]' > scripts/compile_vcs.sh
	$(BENDER) script vcs --vlog-arg="$(VLOGAN_ARGS)" $(BENDER_FLAGS) | grep -v "set ROOT" >> scripts/compile_vcs.sh
	chmod +x scripts/compile_vcs.sh

compile-vcs: VLOGAN_ARGS+=-debug_access+all
compile-vcs: scripts/compile_vcs.sh
	scripts/compile_vcs.sh

compile-vcs-batch: scripts/compile_vcs.sh
	scripts/compile_vcs.sh

run-vcs: VCS_FLAGS+=-debug_access+all
run-vcs: SIMV_FLAGS+=-gui=elite
run-vcs: compile-vcs
	$(VCS) $(VCS_FLAGS) $(TB_DUT)
	./simv $(SIMV_FLAGS)

run-vcs-batch: compile-vcs-batch
	$(VCS) $(VCS_FLAGS) $(TB_DUT)
	./simv $(SIMV_FLAGS)

clean-vcs:
	rm -rf scripts/compile_vcs.sh
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

#############################################
# Random testing for Compute tile structure #
#############################################

.PHONY: test-random clean-test-random

test-random:
	util/test_random_compute_tile.sh 2>&1 | tee test_random.log

clean-test-random:
	rm -rf test/jobs
	rm -rf test_random.log

####################
# Vivado Synthesis #
####################

.PHONY: vivado-synth vivado-synth-batch clean-vivado

scripts/vivado/add_sources.tcl: Bender.yml
	echo 'set ROOT [file normalize [file dirname [info script]]/../..]' > scripts/vivado/add_sources.tcl
#	$(BENDER) script vivado $(BENDER_FLAGS) | grep -v "set ROOT" >> scripts/vivado/add_sources.tcl
	$(BENDER) script vivado -t rtl | grep -v "set ROOT" >> scripts/vivado/add_sources.tcl

vivado-synth: scripts/vivado/add_sources.tcl
	vivado -source scripts/vivado/run_xsynth.tcl

vivado-synth-batch: scripts/add_sources.tcl
	vivado -mode batch -source scripts/vivado/run_xsynth.tcl

clean-vivado:
	rm -rf scripts/vivado/add_sources.tcl
	rm -rf .bender
	rm -rf .Xil
	rm -rf floonoc.cache
	rm -rf floonoc.hw
	rm -rf floonoc.ip_user_files
	rm -rf floonoc.runs
	rm -rf floonoc.sim
	rm -rf floonoc.cache
	rm -rf floonoc.xpr
	rm -rf vivado.*
	rm -rf vivado_*

####################
# Spyglass Linting #
####################

SP_TOP_MODULE ?= floo_mesh

.PHONY: run-spyglass clean-spyglass

spyglass/sources.f:
	$(BENDER) script flist -t spyglass | grep -v "set ROOT" >> spyglass/sources.f
	echo >> spyglass/sources.f

run-spyglass: spyglass/sources.f
	echo "set TOP_MODULE ${SP_TOP_MODULE}" > spyglass/set_top.tcl
	cd spyglass && $(SPYGLASS) -tcl set_top.tcl -tcl run_spyglass_lint.tcl
	rm spyglass/set_top.tcl

clean-spyglass:
	rm -f spyglass/sources.f
	rm -rf spyglass/reports
	rm -rf spyglass/floo_noc*
	rm -f spyglass/sg_shell_command.log
	rm -f spyglass/set_top.tcl
