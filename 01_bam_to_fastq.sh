#!/bin/bash

source ./config_files/01_config.sh

JOB_ID=`qsub -e "$STDERR_DIR" -o "$STDOUT_DIR" $WORKER_DIR/01-run-bam2fq.sh`
echo Submitted job \"$JOB_ID.\"
