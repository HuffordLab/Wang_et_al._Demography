
library(ggmap)

myLocation <- c(-122, -25, -60, 48)
myMap <- get_map(location=myLocation, source="google", maptype="satellite", crop=FALSE)

mymarkers <- read.delim("Genome_Passport_firstVersion_Li.txt", header=T)
names(mymarkers)[3] <- "population"
levels(mymarkers$population) <- c(levels(mymarkers$population), "GuaHigh", "MexHigh", "MexLow", "SA_Low")
mymarkers$population[mymarkers$population=="Gua_Highland"] <- "GuaHigh"
mymarkers$population[mymarkers$population=="Mex_Highland"] <- "MexHigh"
mymarkers$population[mymarkers$population=="Mex_Lowland"] <- "MexLow"
mymarkers$population[mymarkers$population=="SA_Lowland"] <- "SA_Low"
ggmap(myMap) + geom_point(aes(x=Long, y=Lat, color=population), data=mymarkers, size=3) + xlab("longitude") + ylab("latitude") + ggtitle("distribution of samples")
