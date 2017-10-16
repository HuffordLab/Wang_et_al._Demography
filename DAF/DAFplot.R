library(data.table)
library(ggplot2)

#Andes <- read.delim("Andes.DAF.txt", header=F)
#Andes.subset <- subset(Andes, Andes$V21>0)

#MexHigh <- read.delim("MexHigh.DAF.txt", header=F)
#head(MexHigh)
#summary(MexHigh$V22)
#MexHigh.subset <- subset(MexHigh, MexHigh$V22>0)
#summary(MexHigh.subset$V22)

#SA_Low <- read.delim("SA_Low.DAF.txt", header=F)
#head(SA_Low)
#SA_Low.subset <- subset(SA_Low, SA_Low$V22 > 0)

#GuaHigh <- read.delim("GuaHigh.DAF.txt", header=F)
#GuaHigh.subset <- subset(GuaHigh, GuaHigh$V19 > 0)

#SW_US <- read.delim("SW_US.DAF.txt", header=F)
#head(SW_US)
#SW_US.subset <- subset(SW_US, SW_US$V22>0)

#MexLow <- read.delim("MexLow.DAF.txt", header=F)
#MexLow.subset <- subset(MexLow, MexLow$V21 > 0)

#save(Andes.subset, MexHigh.subset, SW_US.subset, SA_Low.subset, MexLow.subset, GuaHigh.subset, file="sixPop.DAF.RData")
load("sixPop.DAF.RData")

Andes.DAF <- as.data.frame(table(Andes.subset$V21))
names(Andes.DAF)[1] <- "DAF"
sum.Andes <- sum(Andes.DAF$Freq)
Andes.DAF["freq"] <- Andes.DAF$Freq/sum.Andes
Andes.DAF["group"] <- "Andes"

MexHigh.DAF <- as.data.frame(table(MexHigh.subset$V22))
names(MexHigh.DAF)[1] <- "DAF"
sum.MexHigh <- sum(MexHigh.DAF$Freq)
MexHigh.DAF["freq"] <- MexHigh.DAF$Freq/sum.MexHigh
MexHigh.DAF["group"] <- "MexHigh"

MexLow.DAF <- as.data.frame(table(MexLow.subset$V21))
names(MexLow.DAF)[1] <- "DAF"
sum.MexLow <- sum(MexLow.DAF$Freq)
MexLow.DAF["freq"] <- MexLow.DAF$Freq/sum.MexLow
MexLow.DAF["group"] <- "MexLow"

GuaHigh.DAF <- as.data.frame(table(GuaHigh.subset$V19))
names(GuaHigh.DAF)[1] <- "DAF"
sum.GuaHigh <- sum(GuaHigh.DAF$Freq)
GuaHigh.DAF["freq"] <- GuaHigh.DAF$Freq/sum.GuaHigh
GuaHigh.DAF["group"] <- "GuaHigh"

SW_US.DAF <- as.data.frame(table(SW_US.subset$V22))
names(SW_US.DAF)[1] <- "DAF"
sum.SW_US <- sum(SW_US.DAF$Freq)
SW_US.DAF["freq"] <- SW_US.DAF$Freq/sum.SW_US
SW_US.DAF["group"] <- "SW_US"

SA_Low.DAF <- as.data.frame(table(SA_Low.subset$V22))
names(SA_Low.DAF)[1] <- "DAF"
sum.SA_Low <- sum(SA_Low.DAF$Freq)
SA_Low.DAF["freq"] <- SA_Low.DAF$Freq/sum.SA_Low
SA_Low.DAF["group"] <- "SA_Low"

df <- rbind(Andes.DAF, MexHigh.DAF, MexLow.DAF, GuaHigh.DAF, SW_US.DAF, SA_Low.DAF)
write.table(df, file="SixPOPdaf.txt", sep="\t", quote=F, row.names=F)

ggplot(data=df, aes(x=DAF, y=freq, group=group, color=group)) + geom_point(aes(color=group))+theme_bw() + geom_line(aes(color=group)) + ylab("frequency") + theme(legend.position=c(0.9, 0.85), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + xlab("deleterious allele frequency (DAF)")
ggsave("sixPopDAFplot.pdf")

df <- df[-c(33:38), ]
ggplot(data=df, aes(x=DAF, y=freq, group=group, color=group)) + geom_point(aes(color=group))+theme_bw() + geom_line(aes(color=group)) + ylab("frequency") + theme(legend.position=c(0.9, 0.85), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + xlab("deleterious allele frequency (DAF)")
ggsave("sixPopDAFplot_withoutGuaHigh.pdf")

