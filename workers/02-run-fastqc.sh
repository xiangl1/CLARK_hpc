#!/bin/bash

#PBS -N fastqc
#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l select=1:ncpus=4:mem=16gb
#PBS -l place=pack:shared
#PBS -l walltime=24:00:00
#PBS -l cput=96:00:00
#PBS -m bea
#PBS -M xiangl1@email.arizona.edu
#PBS -l cput=24:00:00

echo Host `hostname`

echo Started `date`

source  /rsgrps/bhurwitz/xiang/whole_genome_sequencing/scripts/fastqc/config.sh
# using samtools
module load fastqc

# while loop read the file 
while read INPUT_FILE_NAME; do
    INPUT_FILE="$DATA_DIR/$INPUT_FILE_NAME"      
    
    fastqc -o "$OUT_DIR" "$INPUT_FILE"

done < "$INDEX_FILE" 

echo Finishied `date`
