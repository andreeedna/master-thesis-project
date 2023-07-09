#!/bin/bash

#input directory (fastq files)
in_dir=fastq_files
#output directory (trimmed fastq files)
trim_dir=trimmed_fastq

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
