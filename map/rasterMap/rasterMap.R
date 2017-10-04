library(raster)
library(dismo)

files <- list.files(path="~/raster/", pattern="tif", full.names=T)
files
vars <- seq(1, 19, 1)
grids <- sapply(vars, function(x) {
  patt <- paste('bio', x, '_', sep='')
  tiles <- files[grep(patt, files)]
  merged <- eval(parse(text=paste('merge(', toString(paste('raster(', tiles, ')', 
                sep='"')), ')', sep='')))
})
names(grids) <- paste('bio', vars, sep='')
names(grids)
s <- stack(grids)
# quick plot to make sure nothing went drastically wrong
plot(s)

ext <- extent(-120, -70, -15, 38)
s.crop <- crop(s, ext)
plot(s.crop)

distri <- read.delim("Genome_Passport_firstVersion_Li.txt", header=T)
distri <- distri[, 3:5]
distri
SW_US <- distri[1:6, 2:3]
MexHigh <- distri[c(7,8,9,11,12,13), 2:3]
MexLow <- distri[c(10,14,15,19,20), 2:3]
Andes <- distri[c(21:23, 25, 31), 2:3]
SA_Low <- distri[c(24, 26:30), 2:3]
GuaHigh <- distri[16:18, 2:3]

pdf("meanAnnualTemperature.pdf")
plot(s.crop, 1)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("meanDiurnalRange.pdf")
plot(s.crop, 2)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("Isothermality.pdf")
plot(s.crop, 3)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("TemperatureSeasonality.pdf")
plot(s.crop, 4)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("MaxTemWarmMonth.pdf")
plot(s.crop, 5)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("MinTemColdMonth.pdf")
plot(s.crop, 6)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("TemAnnualRange.pdf")
plot(s.crop, 7)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("MeanTemWetQuater.pdf")
plot(s.crop, 8)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("MeanTemDryQuater.pdf")
plot(s.crop, 9)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("MeanTemWarmQuater.pdf")
plot(s.crop, 10)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("MeanTemColdQuater.pdf")
plot(s.crop, 11)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("AnnualPrecipitation.pdf")
plot(s.crop, 12)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("PrecipitationWetMonth.pdf")
plot(s.crop, 13)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("PrecipitationDryMonth.pdf")
plot(s.crop, 14)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("PrecipitationSeasonality.pdf")
plot(s.crop, 15)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("PrecipitationWetQuater.pdf")
plot(s.crop, 16)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("PrecipitationDryQuater.pdf")
plot(s.crop, 17)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("PrecipitationWarmQuater.pdf")
plot(s.crop, 18)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()

pdf("PrecipitationColdQuater.pdf")
plot(s.crop, 19)
points(MexHigh$Long, MexHigh$Lat, col="black", pch=20, cex=1)
points(MexLow$Long, MexLow$Lat, col="purple", pch=20, cex=1)
points(GuaHigh$Long, GuaHigh$Lat, col="blue", pch=20, cex=1)
points(SW_US$Long, SW_US$Lat, col="red", pch=20, cex=1)
points(Andes$Long, Andes$Lat, col="brown", pch=20, cex=1)
points(SA_Low$Long, SA_Low$Lat, col="DeepPink", pch=20, cex=1)
dev.off()


install.packages("vegan")
library(vegan)


install.packages("scatterplot3d")
library(scatterplot3d)

distri.lonLat <- distri[, -1]
head(distri.lonLat)
distri.lonLat <- distri.lonLat[, c(2, 1)]
head(distri.lonLat)
presVals <- extract(s.crop, distri.lonLat)
summary(presVals)
presVals <- presVals[-26, ] # remove the sample with NAs for all environmental variables
presVals
write.table(presVals, file="19environmentalData4Samples.txt", sep="\t", quote=F, row.names=T)

presVals.stand <- scale(presVals)
PCA <- rda(presVals.stand)
PCA

pdf("PCAenvironmentalVariables.pdf")
biplot(PCA, display='species')
dev.off()

ev <- PCA$CA$eig
evplot <- function(ev)
{
# Broken stick model (MacArthur 1957)
n <- length(ev)
bsm <- data.frame(j=seq(1:n), p=0)
bsm$p[1] <- 1/n
for (i in 2:n) bsm$p[i] <- bsm$p[i-1] + (1/(n + 1 - i))
bsm$p <- 100*bsm$p/n
# Plot eigenvalues and % of variation for each axis
op <- par(mfrow=c(2,1))
barplot(ev, main="Eigenvalues", col="bisque", las=2)
abline(h=mean(ev), col="red")
legend("topright", "Average eigenvalue", lwd=1, col=2, bty="n")
barplot(t(cbind(100*ev/sum(ev), bsm$p[n:1])), beside=TRUE, 
main="% variation", col=c("bisque",2), las=2)
legend("topright", c("% eigenvalue", "Broken stick model"), 
pch=15, col=c("bisque",2), bty="n")
par(op)
} ##end up the definition of equation

pdf("choosePCs.pdf")
evplot (ev)
dev.off()

PCs <- PCA$CA$u
head(PCs)
write.table(PCs, file="PCs.samples.txt", sep="\t", quote=F, row.names=T)
# do a little modifiction of file PCs.samples.txt, add colname pop for the first column.
PCs <- read.delim("PCs.samples.txt", header=T)
head(PCs)

PCs$pcolor[PCs$pop=="SW_US"] <- "red"
PCs$pcolor[PCs$pop=="Mex_Highland"] <- "black"
PCs$pcolor[PCs$pop=="Mex_Lowland"] <- "purple"
PCs$pcolor[PCs$pop=="Gua_Highland"] <- "blue"
PCs$pcolor[PCs$pop=="Andes"] <- "brown"
PCs$pcolor[PCs$pop=="SA_Lowland"] <- "DeepPink"

pdf("3DplotOf3PCs.pdf")
with(PCs, {
s3d <- scatterplot3d(PC1, PC2, PC3, color=pcolor, pch=19, main="3-D scatterplot of the first three PCs of 19 environmental variables", xlab="PC1(51.8%)", ylab="PC2(22.8%)", zlab="PC3(14.3%)")
legend("topleft", inset=0.05, bty="n", cex=0.5, title="populations", c("Andes", "GuaHigh", "MexHigh", "MexLow", "SA_Low", "SW_US"), fill=c("brown", "blue", "black", "purple", "DeepPink", "red"))
})
dev.off()


library(ggplot2)
ggplot(data=PCs, aes(x=PC1, y=PC2, color=pop)) + ggtitle("scatterplot of the first two PCs of 19 environmental variables") + xlab("PC1(51.8%)") + ylab("PC2(22.8%)") + geom_point(size=4) + theme(legend.position=c(0.9, 0.85)) 
ggsave("2dPlotPCs.pdf")
