#!/bin/bash

BAMLIST=$1
nInd=$((`wc -l $1`))
OUTFILE=$(echo ${BAMLIST} | sed 's/\.bamlist//')


angsd -bam ${BAMLIST}  -doMaf 1 -doMajorMinor 1 -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd ${nInd} -doSaf 1 -anc /home/lwang/reference/Zea_mays.AGPv3.22.dna.genome.fa -GL 2 -P 4 -out ${OUTFILE} -fold 1
~/bin/ANGSD0.614/misc/realSFS ${OUTFILE}.saf ${nInd} -P 4 > ${OUTFILE}.sfs
angsd -bam ${BAMLIST}  -doMaf 1 -doMajorMinor 1 -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd ${nInd} -doSaf 1 -anc /home/lwang/reference/Zea_mays.AGPv3.22.dna.genome.fa -GL 2 -P 4 -out ${OUTFILE} -fold 1 -doThetas 1 -pest ${OUTFILE}.sfs
/home/lwang/bin/ANGSD0.614/misc/thetaStat make_bed ${OUTFILE}.thetas.gz
/home/lwang/bin/ANGSD0.614/misc/thetaStat do_stat ${OUTFILE}.thetas.gz -nChr ${nInd} -win 100000 -step 100000 -outnames ${OUTFILE}.thetasWindow100kb