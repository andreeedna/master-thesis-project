#!/bin/bash

## ---------------------------
##
## Script name: TRIMMING.sh
##
## Purpose of script:
##      perform an automatic reads trimming
##
## Usage:
##      ./TRIMMING.sh <fastq_dir> <fastq_trim_dir>
##
## Author: Andrea Ninni
##
## Copyright (c) Andrea Ninni, 2022
## Email: andrea.ninni@uniroma2.it
##
## ---------------------------
##
## Notes:
##      before running the script you need to install Trimmomatic
##      *automatic install with ./requirement.txt*
##
##	remember to modify the trimming parameters based on your quality analysis
##
## ---------------------------

in_dir=$1
trim_dir=$2

mkdir $trim_dir

for forward in `ls $in_dir/*R1*`; do
reverse=${forward/R1/R2}
echo $forward
echo $reverse

basename_file=$(basename $forward)

trimlog=$trim_dir/${basename_file/_R1_*/_trimlog.txt}
for_pai=$trim_dir/${basename_file/_R1_*/_R1_pai.fastq.gz}
for_unp=$trim_dir/${basename_file/_R1_*/_R1_unp.fastq.gz}
rev_pai=$trim_dir/${basename_file/_R1_*/_R2_pai.fastq.gz}
rev_unp=$trim_dir/${basename_file/_R1_*/_R2_unp.fastq.gz}

#STD TRIMMING PARAMETERS
java -jar Trimmomatic-0.39/trimmomatic-0.39.jar PE -phred33 -threads 8 \
-trimlog $trimlog \
$forward $reverse \
$for_pai $for_unp $rev_pai $rev_unp \
HEADCROP:10 TRAILING:28 LEADING:28 MINLEN:15 

done
