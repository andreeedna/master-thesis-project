#!/bin/bash

## ---------------------------
##
## Script name: FASTQC.sh
##
## Purpose of script:
##	perform an automatic analysis of quality reads with fastqc
##
## Usage:
##	./FASTQC.sh <fastq_dir> <fastqc_dir>
##
## Author: Andrea Ninni
##
## Copyright (c) Andrea Ninni, 2022
## Email: andrea.ninni@uniroma2.it
##
## ---------------------------
##
## Notes:
##	before running the script you need to install fastqc on command-line
##	*sudo apt install fastqc*
##
## ---------------------------

in_dir=$1
out_dir=$2

mkdir fastqc_analysis

for forward in `ls $in_dir/*R1*`; do
reverse=${forward/R1/R2}

name=$(basename $forward)
base=${name/_R1*/}

mkdir $out_dir/$base

fastqc $forward -o $out_dir/$base
fastqc $reverse -o $out_dir/$base

done
