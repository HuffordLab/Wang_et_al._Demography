#!/bin/bash
#PBS  -o ${PBS_JOBNAME}.o${PBS_JOBID}
#PBS  -e ${PBS_JOBNAME}.e${PBS_JOBID}
#PBS -N vcftools
#PBS -l vmem=256Gb,pmem=8Gb,mem=256Gb,nodes=1:ppn=32:ib,walltime=48:00:00
#PBS -m ae -M lilepisorus@gmail.com
   cd $PBS_O_WORKDIR
module use /data004/software/GIF/modules
module load vcftools
module load R

##the input files were from HMP3 imputed SNPs
vcftools --gzvcf merged_flt_c1.imputed.vcf.gz --freq --chr 1 --out chr1
vcftools --gzvcf merged_flt_c2.imputed.vcf.gz --freq --chr 2 --out chr2
vcftools --gzvcf merged_flt_c3.imputed.vcf.gz --freq --chr 3 --out chr3
vcftools --gzvcf merged_flt_c4.imputed.vcf.gz --freq --chr 4 --out chr4
vcftools --gzvcf merged_flt_c5.imputed.vcf.gz --freq --chr 5 --out chr5
vcftools --gzvcf merged_flt_c6.imputed.vcf.gz --freq --chr 6 --out chr6
vcftools --gzvcf merged_flt_c7.imputed.vcf.gz --freq --chr 7 --out chr7
vcftools --gzvcf merged_flt_c8.imputed.vcf.gz --freq --chr 8 --out chr8
vcftools --gzvcf merged_flt_c9.imputed.vcf.gz --freq --chr 9 --out chr9
vcftools --gzvcf merged_flt_c10.imputed.vcf.gz --freq --chr 10 --out chr10

#Make single file

	 cat *.frq > hm32.freqs.txt
 
#Format

	cat hm32.freqs.txt|  perl -ne 'while(<>){ next if $_=~m/CHROM/; next if $_=~m/INS/; next if $_=~m/DEL/; @cols=split("\t",$_); next if $cols[2]>2; $_=~s/\:/\t/g; chomp $_; @newcols=split("\t",$_);  if($newcols[5]==1){$newcols[6]="NA"; $newcols[7]="NA";}; print "@newcols\n";}' > hm32_formatted.txt &

#Add a header, and file ```hm32.formatted.txt``` should look like:

#	chrom pos nalleles n allele1 freq1 allele2 freq2
#	10 228730 2 2404 A 0.982113 T 0.0178869
#	10 228769 2 2420 A 0.995868 G 0.00413223
#	10 228807 2 2420 A 0.995868 G 0.00413223
#	10 228821 2 2420 T 0.996694 A 0.00330579
#	10 228828 2 2420 G 0.999174 A 0.000826446
#	10 228831 2 2420 G 0.998347 T 0.00165289
#	10 228839 2 2420 A 0.997934 G 0.00206612

#determine the sorghum allele status and GERP scores for each HMP3 SNP
join -1 1 -2 1 <(awk -v OFS="\t" '{print $1"_"$2, $4}' AllChr.SorghumAllele | sort -k1,1) <(awk -v OFS="\t" 'NR!=1 {print $1"_"$2, $4, $5, $6, $7, $8}' hm32_formatted.txt | sort -k1,1) | sed -e 's/\_/\t/g' | sort -n -k1,1 -n -k2,2 > hm32_formatted_sorghumAllele.txt

#reformat the file to only include the derived allele and its frequency based on the ancestral state of Sorghum allele
#This will generate hm32_skinny.txt file
R CMD BATCH derivedAlleleFreq.R
##If you are working with a different SNP dataset, hmp32_skinny.txt is the file you could used to correct reference bias. 

##process the my SNP vcf file 
	cut -f 1,2,4,5 par_MexLow_commonSites.withSorghumAllele.gerp.vcf > firstfourcols.txt



	less par_MexLow_commonSites.withSorghumAllele.gerp.vcf | cut -f 10-18 | perl -ne 'while(<>){ @genos=split("\t",$_); foreach $mygeno (@genos){ $mygeno=~m/^([01\.]\/[01\.])\:/; print $1,"\t"; } print "\n"; }' > genos.txt

	cut -f 10-18 par_MexLow_commonSites.withSorghumAllele.gerp.vcf | head -1 > genolabs.txt
	
	cat genolabs.txt genos.txt > newgenos.txt


	cut -f 19,20 par_MexLow_commonSites.withSorghumAllele.gerp.vcf > sorgerp.txt

	paste firstfourcols.txt newgenos.txt sorgerp.txt > gerpfile.txt
	cat gerpfile.txt | perl -ne 'while(<>){ $_=~s/0\/1/1/g; $_=~s/0\/0/0/g; $_=~s/1\/1/2/g; $_=~s/\.\/\./NA/g; print $_ }' > gerpskinny.txt

##combine the hm32_skinny.txt with my SNP file
join -1 1 -2 1 <(awk -v OFS="\t" '{print $1"_"$2, $4, $5}' hm32_skinny.txt | sort -k1,1) <(awk -v OFS="\t" '{print $1"_"$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15}' gerpskinny.txt | sort -k1,1) | sed -e 's/\_/\t/g' | sort -n -k1,1 -n -k2,2 > gerpSkinny_derAlleleFreq.txt

#use R script to generate mbig file. This will generate the "TeoMaize.mbig.txt" file
R CMD BATCH binDerivedAlleleFreq.R

#using the "TeoMaize.mbig.txt" as input and the R script to quantify number of deleterious alleles / fixed and segregated deleterious alleles.

R CMD BATCH loadit_LiMod.R