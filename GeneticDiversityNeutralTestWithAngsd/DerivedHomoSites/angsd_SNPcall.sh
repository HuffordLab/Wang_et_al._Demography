#!/bin/bash

INFILE=$1
OUTFILE=$(basename ${INFILE} | sed 's/\.bamlist//g')

/data004/software/GIF/packages/ANGSD/0.614/angsd -bam ${INFILE} -doMaf 1 -doMajorMinor 1 -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd 1 -anc /home/lwang/lwang/SRA/Tripsacum/Tripsacum.fa -checkBamHeaders 0 -rf scaffoldNamesWithData.txt -GL 2 -P 5 -out ${OUTFILE}
