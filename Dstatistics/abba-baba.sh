#!/bin/bash

BAMLIST=$1
OUTFILE=$(echo ${BAMLIST} | sed 's/\.bamlist//')



/data004/software/GIF/packages/ANGSD/0.614/angsd -doAbbababa 1 -blockSize 1000 -anc /home/lwang/lwang/SRA/Tripsacum/Tripsacum.fa -doCounts 1 -bam ${BAMLIST} -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd 3 -P 8 -checkBamHeaders 0 -rf /home/lwang/lwang/SRA/scaffoldNamesWithData.txt -out ${OUTFILE}

#jackKnife.R is provided with angsd.
Rscript jackKnife.R file=${OUTFILE}.abbababa indNames=${BAMLIST} outfile=${OUTFILE}

