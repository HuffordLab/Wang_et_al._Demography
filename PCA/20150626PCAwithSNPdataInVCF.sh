#!/bin/bash
#PBS  -o ${PBS_JOBNAME}.o${PBS_JOBID}
#PBS  -e ${PBS_JOBNAME}.e${PBS_JOBID}
#PBS -N PCA
#PBS -l vmem=256Gb,pmem=4Gb,mem=256Gb,nodes=1:ppn=32:ib,walltime=48:00:00
   cd $PBS_O_WORKDIR
module use /data004/software/GIF/modules
module load vcftools/0.1.13
module load plink2
module load GCTA

##the file "All_SeeD_2.7_biallelic.unimputed.hmp.vcf" containing duplicate samples, it will cause problem for the gcta analysis. 
awk 'NR==1' All_SeeD_2.7_biallelic.unimputed.hmp.vcf > samplesAll.txt

awk '{for (i=1;i<=NF;i++) print $i}' samplesAll.txt > AllSamples.txt

cat AllSamples.txt | uniq -c | awk '$1>1 {print $2}' > nonUniqueSamples.txt

/data004/software/GIF/packages/vcftools/0.1.13/bin/vcftools --vcf All_SeeD_2.7_biallelic.unimputed.hmp.vcf --remove nonUniqueSamples.txt --recode --out ./PCA/All_SeeD_uniqueSample

cd ./PCA
awk -v OFS="\t" '$3=$1"_"$2' All_SeeD_uniqueSample.recode.vcf > All_SeeD_uniqueSample.vcf
sed -i 's/\#CHROM\_POS/ID/g' All_SeeD_uniqueSample.vcf

#plink --vcf All_SeeD_uniqueSample.vcf --make-bed --keep-allele-order --out All_SeeD_bfile

gcta64 --bfile All_SeeD_bfile --make-grm --autosome --out All_SeeD_grm --thread-num 32
gcta64 --grm All_SeeD_grm --pca 3 --out All_SeeD_pca --thread-num 32



