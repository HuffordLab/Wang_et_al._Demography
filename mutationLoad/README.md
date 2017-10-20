The folder gave scripts and some intermediate files when calculating burden of deleterious alleles in teosinte and Mexican lowland maize. 
More details could be referred to the methods part of the paper.
The pipeline was described in the "20160709_gerpLoad_TeoMaize.sh".
Some intermediate files are too big to share on github. Thus, i made them available through [Cyverse](/iplant/home/lilepisorus/GERPload). Let me know if you need someone. 
 
1. calculate the drived allele frequency in HMP3

If you are working with a different SNP dataset in maize, **hmp32_skinny.txt** is the file you could used to correct reference bias of GERP scores. 

2. process my SNP vcf file to contain Sorghum alleles and the raw GERP scores

3. combine the hm32_skinny.txt with my SNP file

4. bin the derived allele frequency into 1% bin; based on the derived allele frequency bin and GERP scores to calculate the frequency of SNPs in each GERP category

**binDerivedAlleleFreq.R**

4. correct GERP scores if B73!= Sorghum allele, and compute the number of deleterious alleles

**loadit_LiMod.R**