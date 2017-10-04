#!/bin/bash

BAMLIST=$1
OUTFILE=$(echo ${BAMLIST} | sed 's/\.bamlist//')
nIND=$(wc -l ${BAMLIST} | cut -d ' ' -f1)
minInd=$(( ${nIND}/2 ))



/data004/software/GIF/packages/ANGSD/0.614/angsd -SNP_pval 1e-6 -GL 2 -doMajorMinor 1 -doMaf 1 -rf chr.txt -bam ${BAMLIST} -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd ${minInd} -P 8 -anc /home/lwang/lwang/Zea_mays.AGPv3/Zea_mays.AGPv3.22.dna.genome.fa -doGeno 4 -doPost 1 -postCutoff 0.95 -out ${OUTFILE}
perl convertDoGeno2egglib.pl <(zcat ${OUTFILE}.geno.gz) > ${OUTFILE}.egglibInput.txt

