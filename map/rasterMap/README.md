The climate data are downloaded from [WorldClim](http://worldclim.org/).

1. plotting samples onto the 19 environmental variables with R packages raster and dismo

2. extract environmental data of my samples and do the PCA analysis of environmental data with R package vegan

3. Plot the samples' PC values out with R package scatterplot3d or ggplot2 (2 dimensional plot)

All the scripts involved are in rasterMap.R

It turned out that PC1 explaining over 50% of the variation separates lowland and highland populations and it represents environmenatl variables bio2, bio4 and bio7.

PC2 explaining around 23% of the total variation separates mainly SW_US vs the other three highland populations, and it represents environmental variables bio3, bio12, bio14, bio17, bio18, bio19.
 
Bio9, mean temperature of driest quater, clearly show the difference between three groups: 1) SW_US; 2) MexHigh, MexLow, Andes; 3) MexLow and SA_Low.
