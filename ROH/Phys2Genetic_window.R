# Usage: Rscript Phys2Genetic.R -i ROH300kb.20snpWindow.1het.hom.simplified -o ROH300kb.20snpWindow.1het.hom.withCM

library(optparse)

option_list <- list(make_option(c('-i','--in_file'), action='store', type='character', default=NULL, help='Input file'),
make_option(c('-o','--out_file'), action='store', type='character', default=NULL, help='Output file')
                    )
opt <- parse_args(OptionParser(option_list = option_list))



window <- read.delim(opt$in_file, header=T)
head(window)
map<-read.table("Ogut2015GeneticMap0.2cMresolution.txt", header=T) # load map
head(map)
chrLengths <- c(301476924,237917468,232245527,242062272,217959525,169407836,176826311,175377492,157038028,149632204) # these are full lengths for version 3 genome. 

window$start.cM <- NA
for(i in 1:nrow(window)){
lowerIndex <- which(map$chromosome == window$CHR[i] & map$position <= window$POS1[i])
belowPhys <- max(map$position[lowerIndex[length(lowerIndex)]],1,na.rm=T)
belowGen <- max(map$cM[lowerIndex[length(lowerIndex)]],map$cM[which(map$chromosome==window$CHR[i])][1]-1,na.rm=T)
higherIndex <- which(map$chromosome == window$CHR[i] & map$position >= window$POS1[i])
abovePhys <- min(map$position[higherIndex[1]],chrLengths[window$CHR[i]],na.rm=T)
aboveGen <- min(map$cM[higherIndex[1]],map$cM[which(map$chromosome==window$CHR[i])][length(which(map$chromosome==window$CHR[i]))]+1,na.rm=T)
scale <- {window$POS1[i]-belowPhys}/{abovePhys-belowPhys}
newGen <- {aboveGen-belowGen}*scale + belowGen
window$start.cM[i] <- newGen
}
head(window)

window$end.cM <- NA
for(i in 1:nrow(window)){
lowerIndex <- which(map$chromosome == window$CHR[i] & map$position <= window$POS2[i])
belowPhys <- max(map$position[lowerIndex[length(lowerIndex)]],1,na.rm=T)
belowGen <- max(map$cM[lowerIndex[length(lowerIndex)]],map$cM[which(map$chromosome==window$CHR[i])][1]-1,na.rm=T)
higherIndex <- which(map$chromosome == window$CHR[i] & map$position >= window$POS2[i])
abovePhys <- min(map$position[higherIndex[1]],chrLengths[window$CHR[i]],na.rm=T)
aboveGen <- min(map$cM[higherIndex[1]],map$cM[which(map$chromosome==window$CHR[i])][length(which(map$chromosome==window$CHR[i]))]+1,na.rm=T)
scale <- {window$POS2[i]-belowPhys}/{abovePhys-belowPhys}
newGen <- {aboveGen-belowGen}*scale + belowGen
window$end.cM[i] <- newGen
}
head(window)
 
window["cM"] <- window$end.cM - window$start.cM

write.table(window, file=opt$out_file, sep="\t", quote=F, row.names=F, col.names=F)


