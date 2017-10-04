#!/bin/bash
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=94:00:00
#SBATCH --job-name=GATK
#SBATCH --output=GATK_%j.out 
#SBATCH --error=GATK_%j.err
#SBATCH --mail-user=lilepisorus@gmail.com   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END

cd $SLURM_SUBMIT_DIR
ulimit -s unlimited
module load vcftools
cd vcf
vcffiles=(*.vcf)
vcf-concat ${vcffiles[@]} >> ../combined_final.vcf


#if you want stats at the end of the job
#ssh condo "qstat -f ${SLURM_JOB_ID} | head"
