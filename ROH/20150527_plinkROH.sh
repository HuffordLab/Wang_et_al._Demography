#!/bin/bash
#PBS  -o ${PBS_JOBNAME}.o${PBS_JOBID}
#PBS  -e ${PBS_JOBNAME}.e${PBS_JOBID}
#PBS -N plink
#PBS -l vmem=256Gb,pmem=4Gb,mem=256Gb,nodes=1:ppn=32:ib,walltime=48:00:00
   cd $PBS_O_WORKDIR
module use /data004/software/GIF/modules
module load vcftools
module load R
module load parallel
module load plink


#Filtering the raw vcf files to 1) only contain chrmosomes 2) only biallelic SNPs 3) remove sites which are indicated as "LowQual" and "FAIL"
#include SNPs on the 10 chromosomes
vcftools --vcf zeamays_gatk_htc_filtered_SNPs.vcf --chr 1 --chr 2 --chr 3 --chr 4 --chr 5 --chr 6 --chr 7 --chr 8 --chr 9 --chr 10 --remove-filtered LowQual --remove-filtered FAIL --min-alleles 2 --max-alleles 2 --recode --out zea_firstRound_filtered
#thin the SNPs to contain only one SNP in a 2kb window
vcftools --vcf zea_firstRound_filtered.recode.vcf --minQ 100 --mac 1 --remove mexicana.luxurians.txt --thin 2000 --recode --out maize.thin
#convert to the plink format
vcftools --vcf maize.thin.recode.vcf --plink --out maize.thin

#Run the ROHs analysis
#plink --file maize.thin --out thin2kb.50snpWindow --homozyg-window-snp 50 --homozyg-snp 25 --homozyg-kb 500 --homozyg-gap 1000 --homozyg-window-missing 5 --homozyg-window-threshold .001 --homozyg-window-het 2 --homozyg-density 50
#plink --file maize.thin --out thin2kb.50snpWindow.1het --homozyg-window-snp 50 --homozyg-snp 25 --homozyg-kb 500 --homozyg-gap 1000 --homozyg-window-missing 5 --homozyg-window-threshold .001 --homozyg-window-het 1 --homozyg-density 50
#plink --file maize.thin --out thin2kb.20snpWindow.1het --homozyg-window-snp 20 --homozyg-snp 10 --homozyg-kb 500 --homozyg-gap 1000 --homozyg-window-missing 5 --homozyg-window-threshold .001 --homozyg-window-het 1 --homozyg-density 50
#plink --file maize.thin --out ROH100kb.20snpWindow.1het --homozyg-window-snp 20 --homozyg-snp 10 --homozyg-kb 100 --homozyg-gap 1000 --homozyg-window-missing 2 --homozyg-window-threshold .05 --homozyg-window-het 1 --homozyg-density 50
#plink --file maize.thin --out ROH100kb.10snpWindow.1het --homozyg-window-snp 10 --homozyg-snp 10 --homozyg-kb 100 --homozyg-gap 1000 --homozyg-window-missing 1 --homozyg-window-threshold .001 --homozyg-window-het 0 --homozyg-density 50
plink --file maize.thin --out ROH300kb.20snpWindow.1het --homozyg-window-snp 20 --homozyg-snp 10 --homozyg-kb 300 --homozyg-gap 1000 --homozyg-window-missing 2 --homozyg-window-threshold .05 --homozyg-window-het 1 --homozyg-density 50

