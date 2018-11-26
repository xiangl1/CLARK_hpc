#!/bin/bash

#Change CWD to your working directory for running clark 
export CWD="/rsgrps/bhurwitz/xiang/whole_genome_sequencing"
export DAT="$CWD/DFU_Deng_longitudinal"
export SCRIPT_DIR="$CWD/scripts/hpc_CLARK"
export WORKERS_DIR="$CWD/scripts/hpc_CLARK/workers"
export FASTA_DIR="$DAT/fizkin_screen_out/screened"
export BIN="/rsgrps/bhurwitz/hurwitzlab/bin"

# CLARK location
export CLARK_DIR="$BIN/CLARK"
export SET_CLARK_DB="$BIN/CLARK/set_targets.sh"
export CLARK="$BIN/CLARK/classify_metagenome.sh"
export CLARK_ABUN="$BIN/CLARK/estimate_abundance.sh"
# mode of execution: 0 (full), 1 (default), 2 (express) or 3 (spectrum).
export CLARK_MODE=1
export CLARK_OUT_DIR="$DAT/screen_clark_out"
export CLARK_DB_FILE="$SCRIPT_DIR/clark_dbs"
export CLARK_DB_DIR="$BIN/CLARK/Database/"

function init_dir {
    for dir in $*; do
        if [ -d "$dir" ]; then
            rm -rf $dir/*
        else
            mkdir -p "$dir"
        fi
    done
}

function lc() {
    wc -l $1 | cut -d ' ' -f 1
}
