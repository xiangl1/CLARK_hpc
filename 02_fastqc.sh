#!/bin/bash

source ./config_files/02_config.sh

JOB_ID=`qsub -e "$STDERR_DIR" -o "$STDOUT_DIR" $WORKER_DIR/02-run-fastqc.sh`
echo Submitted job \"$JOB_ID.\"
