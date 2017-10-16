#!/bin/bash
#PBS  -o ${PBS_JOBNAME}.o${PBS_JOBID}
#PBS  -e ${PBS_JOBNAME}.e${PBS_JOBID}
#PBS -N unix
#PBS -l vmem=256Gb,pmem=8Gb,mem=256Gb,nodes=1:ppn=32:ib,walltime=48:00:00
   cd $PBS_O_WORKDIR
module use /data004/software/GIF/modules

module load parallel
module load R

#for f in *.mafs.gz; do echo "zcat $f | awk -v OFS="\t" '(\$5 != "N") && (\$4==\$5 && \$6<=0.0001){print \$1, \$2, \$3, \$4, \$5, \$6}' > $(basename $f| sed 's/mafs\.gz/derived\.homo\.txt/g')"; done 

#zcat RIMMA0383_SW_US.mafs.gz | awk -v OFS="\t" '($5 != "N") && ($5 == $3 || $5==$4) && ($6>=0.05){print $1, $2, $3, $4, $5, $6}' > RIMMA0383_SW_US.hetero.maf
#zcat RIMMA0384_SW_US.mafs.gz | awk -v OFS="\t" '($5 != "N") && ($5 == $3 || $5==$4) && ($6>=0.05){print $1, $2, $3, $4, $5, $6}' > RIMMA0384_SW_US.hetero.maf
#zcat RIMMA0385_SW_US.mafs.gz | awk -v OFS="\t" '($5 != "N") && ($5 == $3 || $5==$4) && ($6>=0.05){print $1, $2, $3, $4, $5, $6}' > RIMMA0385_SW_US.hetero.maf
#zcat RIMMA0387_SW_US.mafs.gz | awk -v OFS="\t" '($5 != "N") && ($5 == $3 || $5==$4) && ($6>=0.05){print $1, $2, $3, $4, $5, $6}' > RIMMA0387_SW_US.hetero.maf
#zcat RIMMA0415_SW_US.mafs.gz | awk -v OFS="\t" '($5 != "N") && ($5 == $3 || $5==$4) && ($6>=0.05){print $1, $2, $3, $4, $5, $6}' > RIMMA0415_SW_US.hetero.maf
#zcat RIMMA1012_SW_US.mafs.gz | awk -v OFS="\t" '($5 != "N") && ($5 == $3 || $5==$4) && ($6>=0.05){print $1, $2, $3, $4, $5, $6}' > RIMMA1012_SW_US.hetero.maf


for f in RIMMA*_Andean.mafs.gz; do zcat $f | awk -v OFS="\t" '($5 != "N") && ($5 == $3 || $5==$4) && ($6>=0.05){print $1, $2, $3, $4, $5, $6}' | wc -l >> Andean.hetero.counts; done
for f in RIMMA*_Mex_Lowland.mafs.gz; do zcat $f | awk -v OFS="\t" '($5 != "N") && ($5 == $3 || $5==$4) && ($6>=0.05){print $1, $2, $3, $4, $5, $6}' | wc -l >> Mex_Lowland.hetero.counts; done
for f in RIMMA*_Mex_Highland.mafs.gz; do zcat $f | awk -v OFS="\t" '($5 != "N") && ($5 == $3 || $5==$4) && ($6>=0.05){print $1, $2, $3, $4, $5, $6}' | wc -l >> Mex_Highland.hetero.counts; done
for f in RIMMA*_Gua_Highland.mafs.gz; do zcat $f | awk -v OFS="\t" '($5 != "N") && ($5 == $3 || $5==$4) && ($6>=0.05){print $1, $2, $3, $4, $5, $6}' | wc -l >> Gua_Highland.hetero.counts; done
for f in RIMMA*_SA_Lowland.mafs.gz; do zcat $f | awk -v OFS="\t" '($5 != "N") && ($5 == $3 || $5==$4) && ($6>=0.05){print $1, $2, $3, $4, $5, $6}' | wc -l >> SA_Lowland.hetero.counts; done


#for f in Andes.*.load.txt; do wc -l $f >> Andes.positiveGerpSites; done
#for f in SW_US.*.load.txt; do wc -l $f >> SW_US.positiveGerpSites; done
#for f in Mex_Highland.*.load.txt; do wc -l $f >> Mex_Highland.positiveGerpSites; done
#for f in Mex_Lowland.*.load.txt; do wc -l $f >> Mex_Lowland.positiveGerpSites; done
#for f in SA_Lowland.*.load.txt; do wc -l $f >> SA_Lowland.positiveGerpSites; done
#for f in Gua_Highland.*.load.txt; do wc -l $f >> Gua_Highland.positiveGerpSites; done

#for f in *.positiveGerpSites; do perl -p -i -e 's/\.RIMMA[0-9]*\.load.txt//g' $f; done
