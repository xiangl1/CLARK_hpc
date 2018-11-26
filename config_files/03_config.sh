#!/bin/bash

export PROJECT_DIR="/rsgrps/bhurwitz/xiang/whole_genome_sequencing"
export DATA_DIR="/rsgrps/bhurwitz/xiang/anvio_for_fiz/fastq_data"
export FASTQ_DIR="$DATA_DIR/sap_pyo"
export OUT_DIR="$DATA_DIR/sap_pyo_pure_trimed"
export BIN_DIR="/rsgrps/bhurwitz/hurwitzlab/bin"
export WORKER_DIR="$PROJECT_DIR/scripts/qc_fastx/workers"

export STDERR_DIR="$DATA_DIR/err"
export STDOUT_DIR="$DATA_DIR/out"

export INDEX_FILE="$DATA_DIR/pyo_list"

# make output directer
if [[ ! -e "$OUT_DIR" ]]; then
      mkdir $OUT_DIR
fi

if [[ ! -e "$STDERR_DIR" ]]; then
      mkdir $STDERR_DIR
fi

if [[ ! -e "$STDOUT_DIR" ]]; then
      mkdir $STDOUT_DIR
fi
