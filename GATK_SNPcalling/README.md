# GATK SNP calling

1. This step needs little preparation. First you need to create intervals to feed them manually. I did this using Bedtools, you can do this with simple Unix commands as well.

```fasta_length.py /work/LAS/mhufford-lab/lwang/AGPv3/Zea_mays.AGPv3.22.dna.genome.fa > genome_length.txt```

**convert to windows and add 1 to the starting base (this avoids overlap between co-ordinates)**

```bedtools makewindows -w 100000 -g genome_length.txt |  awk '{print $1"\t"$2+1"\t"$3}' > genome_100kb_coords.bed```
```sed -i 's/\t/:/1' genome_100kb_coords.bed```
```sed -i 's/\t/-/1' genome_100kb_coords.bed```

2. Next create an array of all the BAM files that you need to run the commands for

```unset -v bamfiles```
```bamfiles=(*_IndelRealigned.bam)```
```for bam in ${bamfiles[@]}; do \```
```echo -en "-I ${bam} "; \```
```done > temp```

3. Now create list of commands for running them parallelly on numerous processors.

```while read line; ```
```do g=$(echo $line |sed 's/:/_/g' | sed 's/-/_/g');``` 
```echo -n "java -Xmx16g -Djava.io.tmpdir=\${TMPDIR} -jar /opt/rit/app/gatk/3.6/lib/GenomeAnalysisTK.jar -T HaplotypeCaller -R /work/LAS/mhufford-lab/lwang/AGPv3/Zea_mays.AGPv3.22.dna.genome.fa $(cat temp) -L "${line}" --genotyping_mode DISCOVERY -stand_emit_conf 10 -stand_call_conf 30 -o /work/LAS/mhufford-lab/lwang/SNPcalling/vcf/"${g}".vcf";```
```printf "\n";```
```done < genome_100kb_coords.bed  > gatk.cmds```

4. You can run this in a PBS script using “Parallel”. Typical PBS submission script will look like this:
 
```parallel --jobs 8 --sshloginfile <(scontrol show hostname) --joblog gatk_progress_00.log --workdir $PWD < gatk.cmds```

5. concatenate all of those small vcfs into a big vcf file (filterVCF.sub.sbatch)

```module load vcftools```
```cd vcf```
```vcffiles=(*.vcf)```
```vcf-concat ${vcffiles[@]} >> ../combined_final.vcf```

6. sort and filter vcf (filterSNP.sub.sbatch)






