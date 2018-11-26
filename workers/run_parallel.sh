#!/bin/bash

#PBS -N taxa_percent
#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l select=1:ncpus=28:mem=168gb
#PBS -l walltime=24:00:00
#PBS -l cput=672:00:00
#PBS -l place=pack:shared
#PBS -m bea
#PBS -M xiangl1@email.arizona.edu


parallel -j 10 -k < /rsgrps/bhurwitz/xiang/matou_virus/domain_organism/percent_job_list 
