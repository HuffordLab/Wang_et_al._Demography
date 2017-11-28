This folder provides scripts used for calculating the burden of deleterious alleles in teosinte and Mexican lowland maize and some intermediate files generated during analysis. More details could be found in the methods section of [the paper](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-017-1346-4).

The pipeline to run this analysis on a local compute cluster is in "20160709_gerpLoad_TeoMaize.sh".

Some intermediate files are too big to share on github. Thus, i made them available through [Cyverse curated data](https://doi.org/10.7946/P2QW7V). 
 
Analysis steps carried out in 20160709_gerpLoad_TeoMaize.sh:

1. calculate the derived allele frequency in HMP3

Use maize Hapmap 3.2 imputed SNP data as the original input for this step. 

If you are working with a different SNP dataset in maize, **hmp32_skinny.txt** is the file you could used to correct reference bias of GERP scores. 

2. process my SNP vcf file (par_MexLow_commonSites.withSorghumAllele.gerp.vcf) to contain Sorghum alleles and the raw GERP scores

3. combine the hm32_skinny.txt with my SNP file (par_MexLow_commonSites.withSorghumAllele.gerp.vcf)

4. bin the derived allele frequency into 1% bin; based on the derived allele frequency bin and GERP scores to calculate the frequency of SNPs in each GERP category using **binDerivedAlleleFreq.R**

5. correct GERP scores if B73!= Sorghum allele, and compute the number of deleterious alleles using **loadit_LiMod.R**
