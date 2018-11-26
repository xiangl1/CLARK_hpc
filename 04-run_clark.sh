#!/bin/bash

source ./config_files/04_config.sh

PROG=`basename $0 ".sh"`
STDERR_DIR="$CLARK_OUT_DIR/custom/err/$PROG"
STDOUT_DIR="$CLARK_OUT_DIR/custom/out/$PROG"

init_dir "$STDERR_DIR" "$STDOUT_DIR"

if [[ ! -d "$CLARK_OUT_DIR" ]]; then
    mkdir -p "$CLARK_OUT_DIR"
fi

cd "$FASTA_DIR"

export FILES_LIST="fasta_list"

find . -type f -name \*.fasta | sed "s/^\.\///" > $FILES_LIST

NUM_FILES=$(lc $FILES_LIST)

echo Found \"$NUM_FILES\" files in \"$FASTA_DIR\"

if [ $NUM_FILES -gt 0 ]; then
    JOB_ID=`qsub -v SCRIPT_DIR,WORKERS_DIR,CLARK,CLARK_DB_FILE,CLARK_DB_DIR,CLARK_MODE,FASTA_DIR,CLARK_OUT_DIR,FILES_LIST -N run-clark -e "$STDERR_DIR" -o "$STDOUT_DIR" $WORKERS_DIR/04-run-clark.sh`

    if [ "${JOB_ID}x" != "x" ]; then
        echo Job: \"$JOB_ID\"
    else
        echo Problem submitting job.
    fi
else
    echo Nothing to do.
fi
