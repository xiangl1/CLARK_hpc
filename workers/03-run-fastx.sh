#!/bin/bash

#PBS -N fastx
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

source  /rsgrps/bhurwitz/xiang/whole_genome_sequencing/scripts/qc_fastx/config.sh
# using fastqc and fastx
module load fastqc
module load fastx

# while loop read the file 
while read FILE TRIMF TRIML CLIPL FILTERQ FILTERP; do
    INPUT_FILE=$FASTQ_DIR/$FILE
    TRIMMED_FILE=`echo $FILE | sed -e "s/.fastq/_trimmed.fastq/g"`
    
    $BIN_DIR/fastx_trimmer -v -f ${TRIMF} -l ${TRIML} -i $INPUT_FILE -o $OUT_DIR/$TRIMMED_FILE

    CLIPPED_FILE=`echo $TRIMMED_FILE | sed -e "s/.fastq/.clipped.fastq/g"`

    $BIN_DIR/fastx_clipper -v -l ${CLIPL} -i $OUT_DIR/$TRIMMED_FILE -o $OUT_DIR/$CLIPPED_FILE

    QUALITY_FILE=`echo $CLIPPED_FILE | sed -e "s/.fastq/.qil.fastq/g"`

    $BIN_DIR/fastq_quality_filter -q ${FILTERQ} -p ${FILTERP} -i $OUT_DIR/$CLIPPED_FILE -o $OUT_DIR/$QUALITY_FILE

    COLLAPED_FILE=`echo $QUALITY_FILE | sed -e "s/.trimmed.clipped.qil.fastq/.fasta/g"`
    $BIN_DIR/fastx_collapser -v -i $OUT_DIR/$QUALITY_FILE -o $OUT_DIR/$COLLAPED_FILE
    
#    `rm -rf $OUT_DIR/*.fastq`
done < "$INDEX_FILE" 

echo Finishied `date`
