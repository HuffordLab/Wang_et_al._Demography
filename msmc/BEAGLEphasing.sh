#!/bin/bash


for chr in $NUMS
do java -Xmx240g -jar /data004/software/GIF/packages/beagle/4.r1274//b4.r1274.jar gtgl=landrace_palmarChico_filtered.recode.vcf nthreads=32 phase-its=32 chrom=$chr ref=~/lwang/Hapmap2_landraces/chr$chr.beaglePhased.vcf impute=false out=landrace_palmarChico.chr$chr.phased
done



