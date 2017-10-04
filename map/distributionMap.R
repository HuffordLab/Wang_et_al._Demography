
library(ggmap)
myLocation <- c(-112, -15, -70, 38)
myMap <- get_map(location=myLocation, source="stamen", maptype="watercolor", crop=FALSE)
ggmap(myMap)
mymarkers <- read.delim("/Users/wangli/ParallelAdaptation/Genome_Passport_firstVersion_Li.txt", header=T)
head(mymarkers)
names(mymarkers)[3] <- "population"
ggmap(myMap) + geom_point(aes(x=Long, y=Lat, color=population), data=mymarkers, size=3) + xlab("longitude") + ylab("latitude") + ggtitle("distribution of samples")
ggsave("distributionMap.pdf")

myLocation <- c(-122, -25, -60, 48)
myMap <- get_map(location=myLocation, source="google", maptype="satellite", crop=FALSE)
ggmap(myMap) + geom_point(aes(x=Long, y=Lat, color=population), data=mymarkers, size=3) + xlab("longitude") + ylab("latitude") + ggtitle("distribution of samples")
ggsave("distributionMap3.pdf")


