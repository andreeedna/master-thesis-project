#!/bin/bash

#input directory (fastq)
in_dir=fastq_files
#output directory (fastqc analysis)
out_dir=fastqc_analysis

mkdir fastqc_analysis

for forward in `ls $in_dir/*R1*`; do
reverse=${forward/R1/R2}

name=$(basename $forward)
base=${name/_R1*/}

mkdir $out_dir/$base

fastqc $forward -o $out_dir/$base
fastqc $reverse -o $out_dir/$base

done
