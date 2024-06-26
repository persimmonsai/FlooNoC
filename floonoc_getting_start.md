
cd FlooNoC

# Install floogen package from pypoject.toml meta file
pip install .

## Questa 2023 Simulation (Must run on Questa 2023)
# vsim got error sometime at first complie
make compile-sim VSIM="vsim"
# Select display or not display and run simulation from the below command
# - run simulation without display waveform. 
make run-sim-batch VSIM="vsim" VSIM_TB_DUT=tb_floo_rob
# - run simulation with display waveform. The result will store on "vsim.wlf" file
make run-sim VSIM="vsim" VSIM_TB_DUT=tb_floo_rob
# start run all simulation from Questa console
run -all

## View simulation waveform on Questa GUI
vsim -view generated/tb_floo_rob.wlf
# Configuration waeform viewer
source hw/tb/wave/tb_floo_rob.wave.tcl

# (Additional info) The above script will run the following command
floogen -c floogen/examples/narrow_wide_pkg.yml --only-pkg --pkg-outdir hw 
floogen -c floogen/examples/axi_pkg.yml --only-pkg --pkg-outdir hw 
mkdir -p scripts
echo 'set ROOT [file normalize [file dirname [info script]]/..]' > scripts/compile_vsim.tcl
bender script vsim --vlog-arg="-suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale \"1 ns / 1 ps\"" -t rtl -t test | grep -v "set ROOT" >> scripts/compile_vsim.tcl
echo >> scripts/compile_vsim.tcl
vsim -64 -c -do "source scripts/compile_vsim.tcl; quit"
# (Additional info) Run this command to start simulation
vsim -nocvg -64 -t 1ps -sv_seed 0 -do "log -r /*" -voptargs=+acc -do "source hw/tb/wave/tb_floo_rob.wave.tcl" tb_floo_rob

## Vivado 2023.2 Simulation (Not working due to limit system verilog testbench feature support on Vivado-sim)
floogen -c floogen/examples/narrow_wide_pkg.yml --only-pkg --pkg-outdir hw 
floogen -c floogen/examples/axi_pkg.yml --only-pkg --pkg-outdir hw 
./scripts/run_xsim.sh

## Simulation with VCS
# Generate sv file following network configuration .yml by using floogen
# Simple configuration with 2x2 compute tile cluster
floogen -c floogen/examples/compute_tile_array.yml --outdir hw --pkg-outdir hw --visualize
# More complex configuration with 5x4 compute tile cluster and HBM connect to all border endpoint
floogen -c floogen/examples/compute_tile_array_5x4.yml --outdir hw --pkg-outdir hw --visualize
# Generate DMA Jobs file to control the simulation
make jobs TRAFFIC_TB=compute_tile_array TRAFFIC_TYPE=random
# Run simulation in batch mode
make run-vcs-batch TB_DUT=tb_floo_compute_tile_array JOB_NAME=compute_tile_array
# Run simulation in GUI mode
make run-vcs TB_DUT=tb_floo_compute_tile_array JOB_NAME=compute_tile_array
# Clean previos simulation result
make clean-vcs

## Synthesis design with Vivado
./scripts/run_xsynth.sh

## Synthesis design with Fusion Compiler
# Create script for synopsys fc from bender
bender script synopsys > synopsys.tcl
# Open fc_shell
/opt/tools/synopsys/fusioncompiler/V-2023.12/bin/fc_shell -container
# Compile design in fc_shell
source synopsys.tcl

# (Additional info) check for license status
/opt/tools/synopsys/scl/2023.09/linux64/bin/lmstat -c 27020@license-server -a


## (Additional info) Debugging Tips
# Generate small DMA Jobs
util/gen_jobs.py --out_dir hw/test/jobs --tb compute_tile_array --traffic_type hbm --rw read --num_narrow_bursts 2 --num_wide_bursts 3


