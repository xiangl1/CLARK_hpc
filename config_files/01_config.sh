#!/bin/bash

export DATA_DIR="/rsgrps/bhurwitz/hurwitzlab/data/raw/GWATTS/WGS/BugMixing"
export OUT_DIR="/rsgrps/bhurwitz/xiang/fizkin_project/6_pure_bugmixing/fastq"
export PROJECT_DIR="/rsgrps/bhurwitz/xiang/whole_genome_sequencing/"
export WORKER_DIR="$PROJECT_DIR/scripts/bam_to_fastq_scripts/workers"
export STDERR_DIR="$OUT_DIR/err"
export STDOUT_DIR="$OUT_DIR/out"

export INDEX_FILE="/rsgrps/bhurwitz/xiang/list"


# make index file for while loop
#ls $DATA_DIR > "$PROJECT_DIR/DFU_Deng_or/DFU_Deng_or_list.txt" 

# make output directer
if [[ ! -e "$OUT_DIR" ]]; then
      mkdir $OUT_DIR
fi

#make std directer
if [[ ! -e "$STDERR_DIR" ]]; then
      mkdir $STDERR_DIR
fi

if [[ ! -e "$STDOUT_DIR" ]]; then
      mkdir $STDOUT_DIR
fi
