#!/bin/bash

#input directory
in_dir=trimmed_fastq
#this is the reference genome fasta - before must run bowtie-build
reference=FR694649.1.fasta
#output directory
out_dir=output

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
