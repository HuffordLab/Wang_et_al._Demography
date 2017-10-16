# Welcome to `Demography and its effect on mutation load in maize` project

This is a research repo for our project entitled "**The interplay of demography and selection during maize domestication and expansion**". The preprint manuscript could be found via [bioRxiv](https://www.biorxiv.org/content/early/2017/03/07/114579).

## License
This repo is free and open source for research usage, licensed under [GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html).

## Introduction
This study illustrates how demographic factors such as population size change and gene flow, in combination with natural selection, have historically shaped diversity across maize genomes and populations.
Despite increases in census size, maize experienced several millennia of decline in diversity after the onset of domestication and during its spread across the Americas.
This "cost of domestication" has increased the prevalence of deleterious alleles in maize relative to its wild progenitor,  particularly in the Andes where maize appears to have undergone a dramatic founder event.
During migration, certain populations of maize also captured new alleles from wild relatives, a process that appears to have reduced the burden of deleterious alleles.

## Architecture about this Repo

To guide the visitors having a better idea about the repo, here we briefly introduce the directory system. 

1. **trim_mapping_MD**: Here we stored scripts used to trim fastq reads, map reads to the reference genome, mark duplicate and indel realignment of the bam files.
2. **map**: Code to generate the sample distribution map. 
3. **GATK_SNPcalling**: Scripts documenting SNP calling pipeline in GATK. 
4. **GeneticDiversityNeutralTestWithAngsd**: Scripts to calculate theta, pi and Tajima's D in ANGSD.
5. **DAF**: Code to calculate derived allele frequency.
6. **NGSadmix**: Scripts to find admixture proportions from NGS data. 
7. **PCA**: Scripts to conduct principle component analysis with both Angsd (taking bam files) and GCTA (with GBS data).
8. **NJtree**: Scripts to construct NJ tree starting from a VCF file. 
9. **msmc**: Here we deposited scripts utilized in the msmc analyses.
10. **serialFounderEffects**: Scripts to calculate the percentage of heterozygous sites, distance from domestication center and linear regression between them.
11. **inbreedingCoefficients**: Code used to calculate inbreeding coefficients.
12. **ROH**: Scripts employed to compute Runs of Homozygosity per individual.
13. **Dstatistics**: Scripts to calculate D statistics in ANGSD.
14. **fd_introgression**: Scripts to compute fd statistics.
15. **mutationLoad**: Codes used for estimate number of deleterious alleles 
16. **Figures**: R code used to generate figures in the paper. 

