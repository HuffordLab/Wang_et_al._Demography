#To calculate fd statistic
* genotype calling in Angsd (Angsd_doGeno.sh)
* perl script to convert the doGeno output to the input required by egglib_sliding_windows.py (convertDoGeno2egglib.pl)
* running the python script egglib_sliding_windows.py to calculate pi, Dxy, S, D, and fd in sliding windows

The discription of fd can be found in [Martin et al. 2015](http://mbe.oxfordjournals.org/content/32/1/244.short). 

egglib_sliding_windows.py was originally from [this repo](https://github.com/johnomics/Martin_Davey_Jiggins_evaluating_introgression_statistics).

The commands to run the three steps are in doGeno_egglib.sub

An example file of the egglib_sliding_windows.py is given as egglibInput.example.txt


