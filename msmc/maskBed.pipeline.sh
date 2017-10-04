#!/bin/bash

IND1=$1
POP1=$2
DEP1=$3

parallel --jobs 32 "samtools mpileup -q 30 -Q 20 -C 50 -u -r {} -f ~/lwang/Zea_mays.AGPv3/Zea_mays.AGPv3.22.dna.genome.fa ~/lwang/bam/${IND1}_${POP1}.IndelRealigned.bam | bcftools view -cgI - | bamCaller.py ${DEP1} ~/lwang/msmcWithAngsd/${IND1}_chr{}_mask.bed.gz" ::: 1 2 3 4 5 6 7 8 9 10





