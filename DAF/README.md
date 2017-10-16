#Scripts to calculate deleterious allele frequency, taking MexHigh as an example

1. subset SNPs to the deleterious ones 
'vcftools --vcf zea_secondRound_filtered.recode.vcf --keep MexHigh.txt --min-alleles 2 --max-alleles 2 --recode --out MexHigh

vcftools --vcf MexHigh.recode.vcf --positions-overlap delSites.txt --recode --out MexHigh.delSites'

2. determine which allele is deleterious allele

'Rscript combineTwoFiles.R -i MexHigh.delSites.recode.vcf -o MexHigh.delSites.MajorAllele.txt'

3. calculate deleterious allele frequencies
'perl DeleteriousAlleleFrequency.6.pl MexHigh.delSites.MajorAllele.txt MexHigh.DAF.txt'

4. plot it out with the following R script
DAFplot.R

