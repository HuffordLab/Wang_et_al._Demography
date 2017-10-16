#!/bin/bash
#PBS  -o ${PBS_JOBNAME}.o${PBS_JOBID}
#PBS  -e ${PBS_JOBNAME}.e${PBS_JOBID}
#PBS -N unix
#PBS -l vmem=256Gb,pmem=4Gb,mem=256Gb,nodes=1:ppn=32:ib,walltime=48:00:00
   cd $PBS_O_WORKDIR
module use /data004/software/GIF/modules

module load parallel
module load R

#for f in *.mafs.gz; do echo "zcat $f | awk -v OFS="\t" '(\$5 != "N") && (\$4==\$5 && \$6<=0.0001){print \$1, \$2, \$3, \$4, \$5, \$6}' > $(basename $f| sed 's/mafs\.gz/derived\.homo\.txt/g')"; done 

zcat RIMMA0383_SW_US.mafs.gz | awk -v OFS="\t" '($5 != "N") && ($4==$5 && $6<=0.0001){print $1, $2, $3, $4, $5, $6}' | wc -l >> SW_US.derived.homo.txt
zcat RIMMA0384_SW_US.mafs.gz | awk -v OFS="\t" '($5 != "N") && ($4==$5 && $6<=0.0001){print $1, $2, $3, $4, $5, $6}' | wc -l >> SW_US.derived.homo.txt
zcat RIMMA0385_SW_US.mafs.gz | awk -v OFS="\t" '($5 != "N") && ($4==$5 && $6<=0.0001){print $1, $2, $3, $4, $5, $6}' | wc -l >> SW_US.derived.homo.txt
zcat RIMMA0387_SW_US.mafs.gz | awk -v OFS="\t" '($5 != "N") && ($4==$5 && $6<=0.0001){print $1, $2, $3, $4, $5, $6}' | wc -l >> SW_US.derived.homo.txt
zcat RIMMA0415_SW_US.mafs.gz | awk -v OFS="\t" '($5 != "N") && ($4==$5 && $6<=0.0001){print $1, $2, $3, $4, $5, $6}' | wc -l >> SW_US.derived.homo.txt
zcat RIMMA1012_SW_US.mafs.gz | awk -v OFS="\t" '($5 != "N") && ($4==$5 && $6<=0.0001){print $1, $2, $3, $4, $5, $6}' | wc -l >> SW_US.derived.homo.txt



#for f in Andes.*.load.txt; do wc -l $f >> Andes.positiveGerpSites; done
#for f in SW_US.*.load.txt; do wc -l $f >> SW_US.positiveGerpSites; done
#for f in Mex_Highland.*.load.txt; do wc -l $f >> Mex_Highland.positiveGerpSites; done
#for f in Mex_Lowland.*.load.txt; do wc -l $f >> Mex_Lowland.positiveGerpSites; done
#for f in SA_Lowland.*.load.txt; do wc -l $f >> SA_Lowland.positiveGerpSites; done
#for f in Gua_Highland.*.load.txt; do wc -l $f >> Gua_Highland.positiveGerpSites; done

#for f in *.positiveGerpSites; do perl -p -i -e 's/\.RIMMA[0-9]*\.load.txt//g' $f; done
