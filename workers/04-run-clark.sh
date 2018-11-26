#!/bin/bash

####Adjust memory as needed for size of input####

#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l jobtype=large_smp
#PBS -l select=15:ncpus=16:mem=15gb
#PBS -l walltime=48:00:00
#PBS -l cput=48:00:00
#PBS -l place=pack
#PBS -l pvmem=200gb
#PBS -M xiangl1@email.arizona.edu
#PBS -m bea

source /usr/share/Modules/init/bash

set -u

CONFIG="$SCRIPT_DIR/config.sh"
COMMON="$WORKERS_DIR/common.sh"

if [ -e $CONFIG ]; then
  . "$CONFIG"
else
  echo Missing common \"$CONFIG\"
  exit 1
fi

if [ -e $COMMON ]; then
  . "$COMMON"
else
  echo Missing common \"$COMMON\"
  exit 1
fi

if [ -z $SCRIPT_DIR ]; then
  echo Missing SCRIPT_DIR
  exit 2
fi

echo Started $(date)

echo Host $(hostname)

cd "$FASTA_DIR"

TMP_FILES=$(mktemp)

get_lines $FILES_LIST $TMP_FILES

NUM_FILES=$(lc $TMP_FILES)

echo Processing \"$NUM_FILES\" input files

#
# Read the CLARK_DB_FILE and use each line to launch CLARK
#
 if [ -e $CLARK_DB_FILE ]; then
     while read CLARK_DB TAXA_RANK; do
       #echo Running $(basename $SET_CLARK_DB) using this db: \"$CLARK_DB\" in \"$CLARK_DB_DIR\" with taxa rank: \"$TAXA_RANK\"
        cd $CLARK_DIR

        #$SET_CLARK_DB $CLARK_DB_DIR $CLARK_DB $TAXA_RANK

     	while read FASTA; do

         FILE="$FASTA_DIR/$FASTA"

         CLARK_OUT="$CLARK_OUT_DIR/$CLARK_DB"
         OUTPUT_FILE="$CLARK_OUT/$(basename $FILE ".fa").clark"
         CSV="$CLARK_OUT/$(basename $FILE ".fa").clark.csv"
         OUTPUT_SP="$CLARK_OUT/$(basename $FILE ".fa").clark_species"
         ##OUTPUT_FAM="$CLARK_OUT/$(basename $FILE ".fa").clark_family"
         ##OUTPUT_GENUS="$CLARK_OUT/$(basename $FILE ".fa").clark_genus"
        

         if [[ ! -d $CLARK_OUT ]]; then
             mkdir -p $CLARK_OUT
         fi

         if [[ -e $OUTPUT_FILE ]]; then
         	rm -rf $OUTPUT_FILE
            touch $OUTPUT_FILE
         fi

         cd $CLARK_DIR
         echo Running $(basename $CLARK) on \"$FILE\" using this db: \"$CLARK_DB\"
         `$CLARK -O $FILE -R $OUTPUT_FILE -m $CLARK_MODE -n 12 --extended`
         echo Running $(basename $CLARK_ABUN) on \"$OUTPUT_FILE\" using this db dir: \"$CLARK_DB_DIR\"
         $CLARK_ABUN -F $CSV -D $CLARK_DB_DIR > $OUTPUT_SP
         ##$CLARK_ABUN -F $CSV -D $CLARK_DB_DIR --family > $OUTPUT_FAM
         ##$CLARK_ABUN -F $CSV -D $CLARK_DB_DIR --genus > $OUTPUT_GENUS

		done < "$FASTA_DIR/$FILES_LIST"
     done < "$CLARK_DB_FILE"
 else
     echo "Cannot find CLARK_DB_FILE $CLARK_DB_FILE"
 fi

echo Finished $(date)
