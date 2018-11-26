#!/bin/bash

#PBS -N bam_to_fastq
#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l select=1:ncpus=2:mem=4gb
#PBS -l place=pack:shared
#PBS -l walltime=24:00:00
#PBS -l cput=48:00:00
#PBS -m bea
#PBS -M xiangl1@email.arizona.edu

echo Host `hostname`

echo Started `date`

source  /rsgrps/bhurwitz/xiang/whole_genome_sequencing/scripts/bam_to_fastq_scripts/config.sh

# using samtools
module load samtools

# while loop read the file 
while read INPUT_FILE_NAME; do
    INPUT_FILE="$DATA_DIR/$INPUT_FILE_NAME"      
    OUT_FILE_NAME=`echo $INPUT_FILE_NAME | sed -e "s/.bam/.fastq/g"`  
    OUT_FILE="$OUT_DIR/$OUT_FILE_NAME"
    
    samtools bam2fq "$INPUT_FILE" > "$OUT_FILE"

done < "$INDEX_FILE" 

echo Finishied `date`
