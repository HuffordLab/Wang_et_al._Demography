#!/bin/bash
#define samples in the pop
IND1="RIMMA0466"
IND2="RIMMA0468"
IND3="RIMMA0662"



NUMS="1 2 3 4 5 6 7 8 9 10"
POP="Andean"




parallel --jobs 32 "vcftools --gzvcf landrace_palmarChico.chr{}.phased.vcf --indv ${IND1} --recode --out ${IND1}.chr{}" ::: 1 2 3 4 5 6 7 8 9 10
parallel --jobs 32 "vcftools --gzvcf landrace_palmarChico.chr{}.phased.vcf --indv ${IND2} --recode --out ${IND2}.chr{}" ::: 1 2 3 4 5 6 7 8 9 10
parallel --jobs 32 "vcftools --gzvcf landrace_palmarChico.chr{}.phased.vcf --indv ${IND3} --recode --out ${IND3}.chr{}" ::: 1 2 3 4 5 6 7 8 9 10


gzip *.vcf

 
parallel --jobs 32 "generate_multihetsep.py --mask ${IND1}_chr{}_mask.bed.gz --mask ${IND2}_chr{}_mask.bed.gz --mask ${IND3}_chr{}_mask.bed.gz --mask ~/lwang/SNPable/maskintrogression/chr{}.mappability.mask.txt.gz ${IND1}.chr{}.recode.vcf.gz ${IND2}.chr{}.recode.vcf.gz ${IND3}.chr{}.recode.vcf.gz > ${POP}_chr{}.txt" ::: 1 2 3 4 5 6 7 8 9 10







