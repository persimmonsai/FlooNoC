#!/bin/bash
# Copyright 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Tim Fischer <fischeti@iis.ee.ethz.ch>

tb_dut="tb_floo_compute_tile_array"
job_type="compute_tile_array"

print_jobs="true"
rw_type=("read" "write")
traffic_type=("memory" "memory_rand" "random" "mgr_rand" "onehop")
repeat_num_test=(10 50 50 50 10) # match with traffic_type
#repeat_num_test=(1 1 1 1 1) # match with traffic_type
out_dir=$PWD"/test/jobs"
# Burst num
num_narrow_bursts_range=(1 50)
num_wide_bursts_range=(1 120)
# Burst length
narrow_burst_length_range=(1 5)
wide_burst_length_range=(10 50)
# Generate random variable
NUM_NR_BURST_RANGE=$((${num_narrow_bursts_range[0]}-${num_narrow_bursts_range[1]}+1))
NUM_WD_BURST_RANGE=$((${num_wide_bursts_range[0]}-${num_wide_bursts_range[1]}+1))
LEN_NR_BURST_RANGE=$((${narrow_burst_length_range[0]}-${narrow_burst_length_range[1]}+1))
LEN_WD_BURST_RANGE=$((${wide_burst_length_range[0]}-${wide_burst_length_range[1]}+1))
RANDOM=$$

make clean-test-random
mkdir -p ${out_dir}
# One time build of VCS simulation binary
make -C simulation/dma_test bin/floo_noc_batch.vcs TB_DUT=$tb_dut 2>&1 | tee ${out_dir}/vcs_build_bin.log

# Running the simulation
for rw in ${rw_type[@]}
do
    for (( tf_idx=0; tf_idx<${#traffic_type[@]}; tf_idx++ ))
    do
        tf=${traffic_type[$tf_idx]}
        rp=${repeat_num_test[$tf_idx]}
        for (( i=1; i<=$rp; i++ ))
        do
            num_narrow_bursts=$(($(($RANDOM%$NUM_NR_BURST_RANGE))+${num_narrow_bursts_range[0]}))
            num_wide_bursts=$(($(($RANDOM%$NUM_WD_BURST_RANGE))+${num_wide_bursts_range[0]}))
            narrow_burst_length=$(($(($RANDOM%$LEN_NR_BURST_RANGE))+${narrow_burst_length_range[0]}))
            wide_burst_length=$(($(($RANDOM%$LEN_WD_BURST_RANGE))+${wide_burst_length_range[0]}))
            # Jobs name
            job_name="${rw}_${tf}_${i}"
            job_dir="${out_dir}/${job_name}"
            # Print Jobs status
            if [ $print_jobs == "true" ]
            then
                echo "r/w : $rw"
                echo "  traffic : $tf"
                echo "  repeat_num : $rp"
                echo "    idx : $i"
                echo "    job_name : $job_name"
                echo "    job_dir : $job_dir"
                echo "    num_narrow_bursts : $num_narrow_bursts"
                echo "    narrow_burst_length : $narrow_burst_length"
                echo "    num_wide_bursts : $num_wide_bursts"
                echo "    wide_burst_length : $wide_burst_length"
            fi
            # Generate the job files
            mkdir -p $job_dir
            make jobs TRAFFIC_TB=$job_type TRAFFIC_TYPE=$tf TRAFFIC_RW=$rw TRAFFIC_OUTDIR=$job_dir \
                TRAFFIC_NR_BURST_NUM=$num_narrow_bursts TRAFFIC_NR_BURST_LEN=$narrow_burst_length \
                TRAFFIC_WD_BURST_NUM=$num_wide_bursts TRAFFIC_WD_BURST_LEN=$wide_burst_length 2>&1 | tee $job_dir/job_stats.log
            # Run the simulation
            #make run-vcs-batch TB_DUT=$tb_dut JOB_NAME=$job_type JOB_DIR=$job_dir DMA_TESTNODE=TRUE 2>&1 | tee ${out_dir}/${job_name}_sim_stats.log
            make dma_test-run-vcs-batch JOB_NAME=$job_type JOB_DIR=$job_dir 2>&1 | tee ${out_dir}/${job_name}_sim_stats.log
        done
    done
    echo ""
done

# Report Post Processing
