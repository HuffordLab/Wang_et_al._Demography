#!/bin/bash

#PBS -o ${PBS_JOBNAME}.o${PBS_JOBID}
#PBS -e ${PBS_JOBNAME}.e${PBS_JOBID}
#PBS -N msmc
#PBS -q testq1
#PBS -l vmem=256Gb,pmem=4Gb,mem=256Gb,nodes=1:ppn=32:ib,walltime=300:00:00


cd $PBS_O_WORKDIR



module use /data004/software/GIF/modules
module load beagle
module load vcftools
module load parallel
module load msmc2
module load python/3.4.1
module load perl

./BEAGLEphasing.sh

./maskBed.pipeline.sh RIMMA0466 Andean 34
./maskBed.pipeline.sh RIMMA0468 Andean 30
./maskBed.pipeline.sh RIMMA0662 Andean 28

./msmcInput.sh

/data004/software/GIF/packages/msmc/20160720/build/release/msmc2 -m 0.0012 -p 5*4+25*2+5*4 -o Andes.msmc2 Andean_chr1.txt Andean_chr2.txt Andean_chr3.txt Andean_chr4.txt Andean_chr5.txt Andean_chr6.txt Andean_chr7.txt Andean_chr8.txt Andean_chr9.txt Andean_chr10.txt


