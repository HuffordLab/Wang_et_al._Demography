#First, phasing SNPs called by GATK with BEAGLE

./BEAGLEphasing.sh

#Second, using msmcInput.sh to generate the msmc input file.
Two levels of filtering were conducted:
* filter for sites with base quality over 20 and mapping qualtiy over 30 and its depth is between 1/2 and twice of the mean depth. This mask file can be generated via maskBed.pipeline.sh.
* Filter for sites which are mappable. The mappablility mask file can be generated via the pipeline documented in mappabilityMask.pdf.

#Third, run msmc via msmc.Andes.sh

#Fourth using popSize_plot.py to convert the msmc output file to the real time and effective population size.
python popSize_plot.py input output

#Finally, bootstrapping the input files with bootstrapMSMC.sub and running each of the 10 bootstrap inputs independently with the same parameter in msmc2


 
