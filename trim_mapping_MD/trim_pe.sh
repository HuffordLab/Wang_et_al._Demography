#!/bin/bash
progdir='/data004/software/GIF/packages/trimmomatic/0.32' FILE1=$1
FILE2=$2
OUT1=$( basename ${FILE1%%.*} )
OUT2=$( basename ${FILE2%%.*} )
java -jar ${progdir}/trimmomatic-0.32.jar PE -phred33 -threads 6 ${FILE1} ${FILE2} ${OUT1}_paired.fq ${OUT1}_unpaired.fq ${OUT2}_paired.fq ${OUT2}_unpaired.fq ILLUMINACLIP:${progdir}/adapters/TruSeq3-PE.fa:2:30:10 LEADING:15 TRAILING:15 SLIDINGWINDOW:4:15 MINLEN:50