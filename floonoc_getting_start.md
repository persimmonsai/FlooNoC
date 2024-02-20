
cd FlooNoC

# Install floogen package from pypoject.toml meta file
pip install .

## Questa Simulation
# vsim got error sometime at first complie
make compile-sim VSIM="vsim"
make run-sim-batch VSIM_TB_DUT=tb_floo_rob VSIM="vsim -nocvg"

# (Additionally) The above script will run the following command
floogen -c /home/attapon/Persimmons/FlooNoC/floogen/examples/narrow_wide_pkg.yml --only-pkg --pkg-outdir /home/attapon/Persimmons/FlooNoC/hw 
floogen -c /home/attapon/Persimmons/FlooNoC/floogen/examples/axi_pkg.yml --only-pkg --pkg-outdir /home/attapon/Persimmons/FlooNoC/hw 
mkdir -p scripts
echo 'set ROOT [file normalize [file dirname [info script]]/..]' > scripts/compile_vsim.tcl
bender script vsim --vlog-arg="-suppress vlog-2583 -suppress vlog-13314 -suppress vlog-13233 -timescale \"1 ns / 1 ps\"" -t rtl -t test | grep -v "set ROOT" >> scripts/compile_vsim.tcl
echo >> scripts/compile_vsim.tcl
vsim -64 -c -do "source scripts/compile_vsim.tcl; quit"
# (Additionally) Run this command to start simulation
vsim -nocvg -64 -t 1ps -sv_seed 0 -do "log -r /*" -voptargs=+acc -do "source hw/tb/wave/tb_floo_rob.wave.tcl" tb_floo_rob

## Vivado Simulation
floogen -c /home/attapon/Persimmons/FlooNoC/floogen/examples/narrow_wide_pkg.yml --only-pkg --pkg-outdir /home/attapon/Persimmons/FlooNoC/hw 
floogen -c /home/attapon/Persimmons/FlooNoC/floogen/examples/axi_pkg.yml --only-pkg --pkg-outdir /home/attapon/Persimmons/FlooNoC/hw 
./scripts/run_xsim.sh
