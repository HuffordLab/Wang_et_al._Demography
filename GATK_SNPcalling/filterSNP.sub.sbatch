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
module load perl
module load java

RAW="combined_final.vcf"
REFERENCE="/work/LAS/mhufford-lab/lwang/AGPv3/Zea_mays.AGPv3.22.dna.genome.fa"
GATK="/opt/rit/app/gatk/3.6/lib/"
MAXDEPTH=$(grep -oh ";DP=.*;" combined_final.vcf | cut -d ";" -f 2 | cut -d "="  -f 2 | sort -rn -k1,1 | awk 'NR==1{print $0*5}')
#perl vcfsorter.pl /work/LAS/mhufford-lab/lwang/AGPv3/Zea_mays.AGPv3.22.dna.genome.dict ${RAW} > ${RAW%.*}_sorted.vcf
#sed -i '$d' combined_final_sorted.vcf #delete the last line of a file
#cat missing.vcf >> combined_final_sorted.vcf #Seems the vcf is not complete, adding the remaining called sites
java -Xmx120g -Djava.io.tmpdir=$TMPDIR -jar ${GATK}/GenomeAnalysisTK.jar \
  -T SelectVariants \
  -R ${REFERENCE} \
  -V ${RAW%.*}_sorted2.vcf \
  -selectType SNP \
  -o ${RAW%.*}_sorted_SNPs.vcf
 
java -Xmx120g -Djava.io.tmpdir=$TMPDIR -jar ${GATK}/GenomeAnalysisTK.jar \
  -T VariantFiltration \
  -R ${REFERENCE} \
  -V ${RAW%.*}_sorted_SNPs.vcf \
  --filterExpression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || DP > ${MAXDEPTH}" \
  --filterName "FAIL" \
  -o ${RAW%.*}_sorted_filtered_SNPs.vcf
 
java -Xmx120g -Djava.io.tmpdir=$TMPDIR -jar ${GATK}/GenomeAnalysisTK.jar \
  -T SelectVariants \
  -R ${REFERENCE} \
  -V ${RAW%.*}_sorted2.vcf \
  -selectType INDEL \
  -o ${RAW%.*}_sorted_indels.vcf
 
java -Xmx120g -Djava.io.tmpdir=$TMPDIR -jar ${GATK}/GenomeAnalysisTK.jar \
  -T VariantFiltration \
  -R ${REFERENCE} \
  -V ${RAW%.*}_sorted_indels.vcf \
  --filterExpression "QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0" \
  --filterName "FAIL" \
  -o ${RAW%.*}_sorted_filtered_indels.vcf

vcftools --vcf combined_final_sorted_filtered_SNPs.vcf --remove-filtered LowQual --remove-filtered FAIL --min-alleles 2 --max-alleles 2 --recode --out landrace_palmarChico_filtered

#if you want stats at the end of the job
#ssh condo "qstat -f ${SLURM_JOB_ID} | head"
