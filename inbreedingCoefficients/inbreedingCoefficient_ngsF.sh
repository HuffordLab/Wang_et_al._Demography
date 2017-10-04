#!/bin/bash

/home/lwang/bin/angsd0.614/angsd -bam SWus_samples.txt -doMaf 1 -doMajorMinor 1 -uniqueOnly 1 -minMapQ 30 -minQ 20 -minInd 6 -anc /home/lwang/Zea_mays_v3/Zea_mays.AGPv3.22.dna.genome.fa -GL 2 -doGlf 3 -SNP_pval 1e-6 -P 10 -out SWus_noInbreedCoef
nsites=$((`zcat SWus_noInbreedCoef.mafs.gz | wc -l`-1))
/home/lwang/bin/ngsF/ngsF -n_ind 6 -n_sites $nsites -glf SWus_noInbreedCoef.glf -out SWus_indF -n_threads 30 -init_values u

