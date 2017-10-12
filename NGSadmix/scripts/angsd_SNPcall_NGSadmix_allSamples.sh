#!/bin/bash
#PBS  -o ${PBS_JOBNAME}.o${PBS_JOBID}
#PBS  -e ${PBS_JOBNAME}.e${PBS_JOBID}
#PBS -N NGSadmix
#PBS -q testq
#PBS -l vmem=256Gb,pmem=4Gb,mem=256Gb,nodes=1:ppn=32:ib,walltime=120:00:00
   cd $PBS_O_WORKDIR
module use /data004/software/GIF/modules
module load NGSadmix
module load parallel

/data004/software/GIF/packages/ANGSD/0.614/angsd -bam allSamples.bamlist -doMaf 1 -doMajorMinor 1 -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd 24 -anc /home/lwang/lwang/Zea_mays.AGPv3/Zea_mays.AGPv3.22.dna.genome.fa -GL 2 -doGlf 2 -SNP_pval 1e-6 -P 32 -out allSamples

sed 's/\-nan/0.333333/g' allSamples.beagle > allSamples.beagle.corrected
NGSadmix -likes allSamples.beagle.corrected -K 2 -P 32 -o allSamples.K2 
NGSadmix -likes allSamples.beagle.corrected -K 3 -P 32 -o allSamples.K3 
NGSadmix -likes allSamples.beagle.corrected -K 4 -P 32 -o allSamples.K4 
NGSadmix -likes allSamples.beagle.corrected -K 5 -P 32 -o allSamples.K5 
NGSadmix -likes allSamples.beagle.corrected -K 6 -P 32 -o allSamples.K6 
NGSadmix -likes allSamples.beagle.corrected -K 7 -P 32 -o allSamples.K7 
NGSadmix -likes allSamples.beagle.corrected -K 8 -P 32 -o allSamples.K8 
NGSadmix -likes allSamples.beagle.corrected -K 9 -P 32 -o allSamples.K9 
NGSadmix -likes allSamples.beagle.corrected -K 10 -P 32 -o allSamples.K10 


