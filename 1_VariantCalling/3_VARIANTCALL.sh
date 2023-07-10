#!/bin/bash

## ---------------------------
##
## Script name: VARIANTCALL.sh
##
## Purpose of script:
##	perform an automatic variant calling
##
## Usage:
##      ./VARIANTCALL.sh <fastq_trim_dir> <reference_genome> <output_dir>
##
## Author: Andrea Ninni
##
## Copyright (c) Andrea Ninni, 2022
## Email: andrea.ninni@uniroma2.it
##
## ---------------------------
##
## Notes:
##      before running the script you need to install bowtie2, samtools and bcftools
##	on commandline:
##      *sudo apt install bowtie2 samtools bcftools*
##
##	before running the script the genome must index the genome:
##	*bowtie2-build <reference_in> <bt2_index_base>*
##
## ---------------------------


in_dir=$1
reference=$2 #this must be with .fasta extecion
out_dir=$3

mkdir $out_dir

for forward_pai in `ls $in_dir/*R1*pai*`; do
reverse_pai=${forward_pai/R1/R2}

name=$(basename $forward_pai)
base=$out_dir/${name/_R1*/}

bowtie2 --no-unal -p 4 -x $reference -1 $forward_pai -2 $reverse_pai -S $base.sam
samtools view -bt $reference -o $base.bam $base.sam
samtools sort $base.bam -o $base.sorted.bam
samtools index $base.sorted.bam
bcftools mpileup -f $reference $base.sorted.bam | bcftools call -mv -Ov > $base.snp.vcf

#filter
bcftools filter -Oz -e 'POS<10' $sort > $base.filtvcf.gz
bcftools index $out_dir/$base.filtvcf.gz
bcftools consensus -f $ref $base.filtvcf.gz -o $base.fa

#ANNOTATION PERFORMED WITH snpEff (https://pcingola.github.io/SnpEff/)
#I edited the snpEff.config file adding the Caretta caretta Mitochondrial genome annotation (genes.gbk)
java -jar snpEff/snpEff.jar eff Caretta $base.snp.vcf > $base.annotato.vcf

done
