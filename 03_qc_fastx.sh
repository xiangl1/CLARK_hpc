#!/bin/bash

source ./config_files/03_config.sh

JOB_ID=`qsub -e "$STDERR_DIR" -o "$STDOUT_DIR" $WORKER_DIR/03-run-fastx.sh`
echo Submitted job \"$JOB_ID.\"
