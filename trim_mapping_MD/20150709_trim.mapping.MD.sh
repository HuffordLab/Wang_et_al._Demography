#!/bin/bash
R1=$1
R2=$2
R1_base=$(echo $1 | sed 's/\.fastq//g')
R2_base=$(echo $2 | sed 's/\.fastq//g')

./trim_pe.sh ${R1} ${R2}
bwa mem -t 64 -M ~/lwang/Zea_mays.AGPv3/Zea_mays.AGPv3.22.dna.genome.fa ${R1_base}_paired.fq  ${R2_base}_paired.fq> ${TMPDIR}/paired.sam
bwa mem -t 64 -M ~/lwang/Zea_mays.AGPv3/Zea_mays.AGPv3.22.dna.genome.fa ${R1_base}_unpaired.fq  > ${TMPDIR}/R1_unpaired.sam
bwa mem -t 64 -M ~/lwang/Zea_mays.AGPv3/Zea_mays.AGPv3.22.dna.genome.fa ${R2_base}_unpaired.fq  > ${TMPDIR}/R2_unpaired.sam

samtools view -bS -o paired.bam ${TMPDIR}/paired.sam
samtools view -bS -o R1_unpaired.bam ${TMPDIR}/R1_unpaired.sam
samtools view -bS -o R2_unpaired.bam ${TMPDIR}/R2_unpaired.sam

#five to six hours for add read groups for each bam
java -Xmx240g -Djava.io.tmpdir=${TMPDIR} -jar /data004/software/GIF/packages/picard-tools/1.106/AddOrReplaceReadGroups.jar INPUT=paired.bam OUTPUT=paired_RG.bam SORT_ORDER=coordinate RGID=paired RGLB=paired RGPL=illumina RGPU=diploperennis RGSM=diploperennis VALIDATION_STRINGENCY=LENIENT TMP_DIR=${TMPDIR}
java -Xmx240g -Djava.io.tmpdir=${TMPDIR} -jar /data004/software/GIF/packages/picard-tools/1.106/AddOrReplaceReadGroups.jar INPUT=R1_unpaired.bam OUTPUT=R1_unpaired_RG.bam SORT_ORDER=coordinate RGID=R1_unpaired RGLB=R1_unpaired RGPL=illumina RGPU=diploperennis RGSM=diploperennis VALIDATION_STRINGENCY=LENIENT TMP_DIR=${TMPDIR}
java -Xmx240g -Djava.io.tmpdir=${TMPDIR} -jar /data004/software/GIF/packages/picard-tools/1.106/AddOrReplaceReadGroups.jar INPUT=R2_unpaired.bam OUTPUT=R2_unpaired_RG.bam SORT_ORDER=coordinate RGID=R2_unpaired RGLB=R2_unpaired RGPL=illumina RGPU=diploperennis RGSM=diploperennis VALIDATION_STRINGENCY=LENIENT TMP_DIR=${TMPDIR}

# three to four hours for merging bam files

java -Xmx240g -Djava.io.tmpdir=${TMPDIR} -jar /data004/software/GIF/packages/picard-tools/1.106/MergeSamFiles.jar INPUT=paired_RG.bam INPUT=R1_unpaired_RG.bam INPUT=R2_unpaired_RG.bam OUTPUT=diploperennis.bam SORT_ORDER=coordinate ASSUME_SORTED=false VALIDATION_STRINGENCY=LENIENT TMP_DIR=${TMPDIR}



java -Xmx240g -Djava.io.tmpdir=${TMPDIR} -jar /data004/software/GIF/packages/picard-tools/1.106/MarkDuplicates.jar INPUT=diploperennis.bam OUTPUT=diploperennis.MD.bam METRICS_FILE=diploperennis.MD.txt ASSUME_SORTED=true REMOVE_Duplicates=true VALIDATION_STRINGENCY=LENIENT CREATE_INDEX=TRUE TMP_DIR=${TMPDIR}


java -Xmx240g -jar /data004/software/GIF/packages/gatk/3.1-1/GenomeAnalysisTK.jar -allowPotentiallyMisencodedQuals -I diploperennis.MD.bam -R ~/lwang/Zea_mays.AGPv3/Zea_mays.AGPv3.22.dna.genome.fa -T RealignerTargetCreator -o diploperennis.forIndelRealigner.intervals

java -Xmx240g -jar /data004/software/GIF/packages/gatk/3.1-1/GenomeAnalysisTK.jar -allowPotentiallyMisencodedQuals -I diploperennis.MD.bam -R ~/lwang/Zea_mays.AGPv3/Zea_mays.AGPv3.22.dna.genome.fa -T IndelRealigner -targetIntervals diploperennis.forIndelRealigner.intervals -o diploperennis.IndelRealigned.bam


samtools index diploperennis.IndelRealigned.bam
