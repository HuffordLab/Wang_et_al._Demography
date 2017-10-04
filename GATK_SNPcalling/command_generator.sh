#!/bin/bash

while read line; 
do g=$(echo $line |sed 's/:/_/g' | sed 's/-/_/g'); 
echo -n "java -Xmx16g -Djava.io.tmpdir=\${TMPDIR} -jar /opt/rit/app/gatk/3.6/lib/GenomeAnalysisTK.jar -T HaplotypeCaller -R /work/LAS/mhufford-lab/lwang/AGPv3/Zea_mays.AGPv3.22.dna.genome.fa $(cat temp) -L "${line}" --genotyping_mode DISCOVERY -stand_emit_conf 10 -stand_call_conf 30 -o /work/LAS/mhufford-lab/lwang/SNPcalling/vcf/"${g}".vcf";
printf "\n";
done < genome_100kb_coords.bed  > gatk.cmds

