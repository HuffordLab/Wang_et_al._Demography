# Introduction
During maize range expansion from the origin, mostly few whole infructescences were selected for seeds and split off to occupy new territory, taking with only a small portion of alleles from the original population.
As a result, the maize population may exhibit a gradual decline of heterozygosity and a continuous reduction of effective population size during its expansion.
The analyses were conducted to detect the hypothesis pattern of gradual decline of heterozygosity from the origin.

# Precessing the raw data

## Downloading
The SNP data from seeds across the America were analyzed. It was downloaded from [here](http://23.253.100.239/dvn/dv/devseedsofdiscoverydvn/faces/study/StudyPage.xhtml?globalId=hdl:11529/10034&studyListingIndex=0_1c7111b5466565dd0eebfa2607c3) and the related sample info was downloaded from [here](http://germinate.seedsofdiscovery.org/maize/#browse-accessions). 

## clean-up
1. put SNP data from each chromosome into one file

```
cat All_SeeD_2.7_chr*_no_filter.unimputed.hmp.txt >> All_SeeD_2.7_no_filter.unimputed.hmp.txt
```

2. keep only biallelic sites, and remove redundant columns

```
awk '{ if (NR==1) print $0; else if ($2 ~ /^[ATCG]\/[ATCG]$/) print $0;}' All_SeeD_2.7_no_filter.unimputed.hmp.txt | cut -f-5,16- > All_SeeD_2.7_biallelic.unimputed.hmp.txt
```

3. print the sample IDs to a file

```
awk 'NR==1' All_SeeD_2.7_biallelic.unimputed.hmp.txt | cut -f6- | sed 's/\:[A-Z0-9]*\:[0-9]*\:[0-9]*//g' > samples.txt
```

## calculate the geographic distance in km 
1. connect sample ID to gid, then link gid to the location info (sampleID.gid.location.R)
2. calculate the geographical distance from the longitude and latitude info (geoDisFromLongiLatiDecimal.py)
```
python geoDisFromLongiLatiDecimal.py sampleID.gid.location.R sampleID.gid.location.txt sampleID.geodis.txt
```
The geographical distance in kilometers was calculated based on great circle distances using the haversine. 
The idea was borrowed from [Ramachandran et al. 2005](http://www.pnas.org/content/102/44/15942.short). 
The equation is shown ![here](https://github.com/HuffordLab/Wang_Private/blob/master/demography/analyses/serialFounderEffects/equation_geoDis_from_longi_latitude.png).

# estimate the genetic diversity and the correlation between geographical distance and genetic diversity

percentage of polymorphism per sample

    * using custom R script (calcPercPolymFromSNPdata.R) to calculate the percentage of polymorphic sites for each sample
    * estimate the correlation between the geographical distance and percentage of polymorphic sites and plot it out with R script (geoDis.polymorphism.correlation.R)
    color.He.from.Balsas.R
  
