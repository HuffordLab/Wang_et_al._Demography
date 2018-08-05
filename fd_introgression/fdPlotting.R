library(ggplot2)

#MexHigh
MexHigh <- read.csv("MexHigh_MexLow_mexicana.egglibOutput.txt", header=T)
head(MexHigh)
MexHigh <- MexHigh[complete.cases(MexHigh[,28]), ]
head(MexHigh)

lm_eqn = function(m) {
  l <- list(a = format(coef(m)[1], digits = 2),
      b = format(abs(coef(m)[2]), digits = 2),
      r = format(sqrt(summary(m)$r.squared), digits = 3),
      p = format(summary(m)$coef[2, 4], digits = 3));
  if (coef(m)[2] >= 0)  {
    eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(R)~"="~r*","~~italic(P)~"="~p,l)
  } else {
    eq <- substitute(italic(y) == a - b %.% italic(x)*","~~italic(R)~"="~r*","~~italic(P)~"="~p,l)    
  }
  as.character(as.expression(eq));                 
}


MexHigh.subset <- subset(MexHigh, MexHigh$D>0)
MexHigh.subset <- MexHigh.subset[order(-MexHigh.subset[,28]), ]

length(MexHigh.subset$fd)
length(MexHigh$fd)

MexHigh.subset2 <- subset(MexHigh.subset, MexHigh.subset$fd>0 & MexHigh.subset$fd<=1)

##90% quantitle in SA_Low 0.3629
MexHigh.subset3 <- subset(MexHigh.subset2, MexHigh.subset2$fd > 0.3629)
write.table(MexHigh.subset3[, c(1,3,4)], file="MexHigh.introRegion.90%cutoff", quote=F, sep="\t", row.names=F)

ggplot(data=MexHigh.subset2, aes(x=P2_pi, y=fd)) + stat_smooth(method = "lm", se=FALSE, color="red", formula = y ~ x) + geom_point() + xlab("pairwise nucleotide difference within Mexican Highland population") + ylab("fd") + theme_bw() +  geom_text(color="blue", aes(x = 0.2, y = 1.05, label = lm_eqn(lm(fd ~ P2_pi, MexHigh.subset2))), parse = TRUE) 
ggsave("MexHigh.pi.fd.correlation.pdf")

ggplot(data=MexHigh.subset2, aes(x=P2_P3Dxy, y=fd)) + stat_smooth(method = "lm", se=FALSE, color="red", formula = y ~ x) + geom_point() + xlab("Dxy between P2 and P3 within Mexican Highland population") + ylab("fd") + theme_bw() +  geom_text(color="blue", aes(x = 0.13, y = 1.05, label = lm_eqn(lm(fd ~ P2_P3Dxy, MexHigh.subset2))), parse = TRUE) 
ggsave("MexHigh.DxyP2P3.fd.correlation.pdf")

p <- ggplot(data=MexHigh.subset2, aes(x=position/1000000, y=fd)) + geom_smooth(method="loess", size=1, formula = y ~ x, color="red") + xlab("physical position (Mb)") + ylab("fd") + ggtitle("fd in 10kb non-overlapping windows")
p + facet_wrap(~ scaffold, nrow=2, ncol=5)
ggsave("fd.track.MexHigh.pdf")

MexHigh.subset2["pop"] <- "MexHigh"

#GuaHigh
GuaHigh <- read.csv("GuaHigh_MexLow_mexicana.egglibOutput.txt", header=T)
head(GuaHigh)
GuaHigh <- GuaHigh[complete.cases(GuaHigh[,28]), ]
head(GuaHigh)
GuaHigh.subset <- subset(GuaHigh, GuaHigh$D>0)
GuaHigh.subset <- GuaHigh.subset[order(-GuaHigh.subset[,28]), ]
length(GuaHigh.subset$fd)
length(GuaHigh$fd)
GuaHigh.subset2 <- subset(GuaHigh.subset, GuaHigh.subset$fd>0 & GuaHigh.subset$fd<=1)
GuaHigh.subset2["pop"] <- "GuaHigh"
##90% quantitle in SA_Low 0.3629
GuaHigh.subset3 <- subset(GuaHigh.subset2, GuaHigh.subset2$fd > 0.3629)
write.table(GuaHigh.subset3[, c(1,3,4)], file="GuaHigh.introRegion.90%cutoff", quote=F, sep="\t", row.names=F)

ggplot(data=GuaHigh.subset2, aes(x=P2_pi, y=fd)) + stat_smooth(method = "lm", se=FALSE, color="red", formula = y ~ x) + geom_point() + xlab("pairwise nucleotide difference within Guatamalan Highland population") + ylab("fd")  + theme_bw() +  geom_text(color="blue", aes(x = 0.2, y = 1.05, label = lm_eqn(lm(fd ~ P2_pi, GuaHigh.subset2))), parse = TRUE) 
ggsave("GuaHigh.pi.fd.correlation.pdf")

p <- ggplot(data=GuaHigh.subset2, aes(x=position/1000000, y=fd)) +  geom_smooth(method="loess", size=1, formula = y ~ x, color="red") + xlab("physical position (Mb)") + ylab("fd") + ggtitle("fd in 10kb non-overlapping windows")
p + facet_wrap(~ scaffold, nrow=2, ncol=5)
ggsave("fd.track.GuaHigh.pdf")

#SW_US
SW_US <- read.csv("SW_US_MexLow_mexicana.egglibOutput.txt", header=T)
head(SW_US)
SW_US <- SW_US[complete.cases(SW_US[,28]), ]
head(SW_US)
SW_US.subset <- subset(SW_US, SW_US$D>0)
SW_US.subset <- SW_US.subset[order(-SW_US.subset[,28]), ]
length(SW_US.subset$fd)
length(SW_US$fd)
SW_US.subset2 <- subset(SW_US.subset, SW_US.subset$fd>0 & SW_US.subset$fd<=1)
SW_US.subset2["pop"] <- "SW_US"

##90% quantitle in SA_Low 0.3629
SW_US.subset3 <- subset(SW_US.subset2, SW_US.subset2$fd > 0.3629)
write.table(SW_US.subset3[, c(1,3,4)], file="SW_US.introRegion.90%cutoff", quote=F, sep="\t", row.names=F)

ggplot(data=SW_US.subset2, aes(x=P2_pi, y=fd)) + stat_smooth(method = "lm", se=FALSE, color="red", formula = y ~ x) + geom_point() + xlab("pairwise nucleotide difference within SW_US Highland population") + ylab("fd") + theme_bw() +  geom_text(color="blue", aes(x = 0.2, y = 1.05, label = lm_eqn(lm(fd ~ P2_pi, SW_US.subset2))), parse = TRUE) 
ggsave("SW_US.pi.fd.correlation.pdf")

p <- ggplot(data=SW_US.subset2, aes(x=position/1000000, y=fd)) +  geom_smooth(method="loess", size=1, formula = y ~ x, color="red") + xlab("physical position (Mb)") + ylab("fd") + ggtitle("fd in 10kb non-overlapping windows")
p + facet_wrap(~ scaffold, nrow=2, ncol=5)
ggsave("fd.track.SW_US.pdf")

#Andes
Andes <- read.csv("Andes_MexLow_mexicana.egglibOutput.txt", header=T)
head(Andes)
Andes <- Andes[complete.cases(Andes[,28]), ]
head(Andes)
Andes.subset <- subset(Andes, Andes$D>0)
Andes.subset <- Andes.subset[order(-Andes.subset[,28]), ]
length(Andes.subset$fd)
length(Andes$fd)
Andes.subset2 <- subset(Andes.subset, Andes.subset$fd>0 & Andes.subset$fd<=1)
Andes.subset2["pop"] <- "Andes"
##90% quantitle in SA_Low 0.3629
Andes.subset3 <- subset(Andes.subset2, Andes.subset2$fd > 0.3629)
write.table(Andes.subset3[, c(1,3,4)], file="Andes.introRegion.90%cutoff", quote=F, sep="\t", row.names=F)


ggplot(data=Andes.subset2, aes(x=P2_pi, y=fd)) + stat_smooth(method = "lm", se=FALSE, color="red", formula = y ~ x) + geom_point() + xlab("pairwise nucleotide difference within Andes population") + ylab("fd") + theme_bw() +  geom_text(color="blue", aes(x = 0.2, y = 1.05, label = lm_eqn(lm(fd ~ P2_pi, Andes.subset2))), parse = TRUE) 
ggsave("Andes.pi.fd.correlation.pdf")

p <- ggplot(data=Andes.subset2, aes(x=position/1000000, y=fd)) +  geom_smooth(method="loess", size=1, formula = y ~ x, color="red") + xlab("physical position (Mb)") + ylab("fd") + ggtitle("fd in 10kb non-overlapping windows")
p + facet_wrap(~ scaffold, nrow=2, ncol=5)
ggsave("fd.track.Andes.pdf")



#SA_Low
SA_Low <- read.csv("SA_Low_MexLow_mexicana.egglibOutput.txt", header=T)
head(SA_Low)
SA_Low <- SA_Low[complete.cases(SA_Low[,28]), ]
head(SA_Low)
SA_Low.subset <- subset(SA_Low, SA_Low$D>0)
SA_Low.subset <- SA_Low.subset[order(-SA_Low.subset[,28]), ]
length(SA_Low.subset$fd)
length(SA_Low$fd)
SA_Low.subset2 <- subset(SA_Low.subset, SA_Low.subset$fd>0 & SA_Low.subset$fd<=1)
SA_Low.subset2["pop"] <- "SA_Low"

ggplot(data=SA_Low.subset2, aes(x=P2_pi, y=fd)) + stat_smooth(method = "lm", se=FALSE, color="red", formula = y ~ x) + geom_point() + xlab("pairwise nucleotide difference within SA_Low population") + ylab("fd") + theme_bw() +  geom_text(color="blue", aes(x = 0.2, y = 1.05, label = lm_eqn(lm(fd ~ P2_pi, SA_Low.subset2))), parse = TRUE) 
ggsave("SA_Low.pi.fd.correlation.pdf")

p <- ggplot(data=SA_Low.subset2, aes(x=position/1000000, y=fd)) +  geom_smooth(method="loess", size=1, formula = y ~ x, color="red") + xlab("physical position (Mb)") + ylab("fd") + ggtitle("fd in 10kb non-overlapping windows")
p + facet_wrap(~ scaffold, nrow=2, ncol=5)
ggsave("fd.track.SA_Low.pdf")


#combine

combine <- rbind(MexHigh.subset2, GuaHigh.subset2, SW_US.subset2, Andes.subset2, SA_Low.subset2)

##ANOVA analysis of fd values among populations
attach(combine)
ANOVA <- aov(fd ~ pop)
summary(ANOVA)
TukeyHSD(ANOVA)
#It shows that all pair comparisons have a significant p value (p < 0.005)

##boxplot of fd among populations
ylim1 = boxplot.stats(combine$fd)$stats[c(1, 5)]
colorder <- c("Andes", "SA_Low", "MexHigh", "SW_US", "GuaHigh")
ggplot(data=combine, aes(x=pop, y=fd)) + geom_boxplot(aes(fill=pop))+ xlab("")  + coord_cartesian(ylim = ylim1*1.05) + theme_bw() + ggtitle("boxplot of fd in non-overlapping 10kb windows among populations") +scale_x_discrete(limits=colorder,labels=c("Andes","SA_Low","MexHigh", "SW_US", "GuaHigh")) + ylab("fd") + theme_bw() + theme(legend.position=c(0.85, 0.9))
ggsave("fd.boxplot.pdf")
# boxplot is not as good as density plot to show the difference of fd among populations.

ggplot(data=combine, aes(x=fd, color=pop, group=pop)) + geom_density(alpha=0.25) + theme_bw()
ggsave("fd.densityPlot.pdf")

p <- ggplot(data=combine, aes(x=position/1000000, y=fd, color=pop, group=pop)) +  geom_smooth(method="loess", size=1, formula = y ~ x)  + xlab("physical position (Mb)") + ylab("fd") + ggtitle("loess regression of fd in 10kb non-overlapping windows") + theme_bw()
p + facet_wrap(~ scaffold, nrow=2, ncol=5)
ggsave("fd.track.allPop.pdf")

##fd track for each chromosome

chr1 <- subset(combine, combine$scaffold==1)
chr2 <- subset(combine, combine$scaffold==2)
chr3 <- subset(combine, combine$scaffold==3)
chr4 <- subset(combine, combine$scaffold==4)
chr5 <- subset(combine, combine$scaffold==5)
chr6 <- subset(combine, combine$scaffold==6)
chr7 <- subset(combine, combine$scaffold==7)
chr8 <- subset(combine, combine$scaffold==8)
chr9 <- subset(combine, combine$scaffold==9)
chr10 <- subset(combine, combine$scaffold==10)

ggplot(data=chr1, aes(x=position/1000000, y=fd, color=pop, group=pop)) +  geom_smooth(method="loess", size=0.5, formula = y ~ x, span=0.01)  + xlab("physical position (Mb)") + ylab("fd") + ggtitle("loess regression of fd in 10kb non-overlapping windows on chr1") + theme_bw()+  theme(legend.position=c(0.9, 0.87), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave("fd.track.chr1.allPop.pdf")

ggplot(data=chr2, aes(x=position/1000000, y=fd, color=pop, group=pop)) +  geom_smooth(method="loess", size=0.5, formula = y ~ x, span=0.01)  + xlab("physical position (Mb)") + ylab("fd") + ggtitle("loess regression of fd in 10kb non-overlapping windows on chr2") + theme_bw()+ theme(legend.position=c(0.1, 0.87), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave("fd.track.chr2.allPop.pdf")

ggplot(data=chr3, aes(x=position/1000000, y=fd, color=pop, group=pop)) +  geom_smooth(method="loess", size=0.5, formula = y ~ x, span=0.01)  + xlab("physical position (Mb)") + ylab("fd") + ggtitle("loess regression of fd in 10kb non-overlapping windows on chr3") + theme_bw()+ theme(legend.position=c(0.9, 0.87), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave("fd.track.chr3.allPop.pdf")

ggplot(data=chr4, aes(x=position/1000000, y=fd, color=pop, group=pop)) +  geom_smooth(method="loess", size=0.5, formula = y ~ x, span=0.01)  + xlab("physical position (Mb)") + ylab("fd") + ggtitle("loess regression of fd in 10kb non-overlapping windows on chr4") + theme_bw()+ theme(legend.position=c(0.1, 0.87), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave("fd.track.chr4.allPop.pdf")

ggplot(data=chr5, aes(x=position/1000000, y=fd, color=pop, group=pop)) +  geom_smooth(method="loess", size=0.5, formula = y ~ x, span=0.01)  + xlab("physical position (Mb)") + ylab("fd") + ggtitle("loess regression of fd in 10kb non-overlapping windows on chr5") + theme_bw()+ theme(legend.position=c(0.1, 0.87), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave("fd.track.chr5.allPop.pdf")

ggplot(data=chr6, aes(x=position/1000000, y=fd, color=pop, group=pop)) +  geom_smooth(method="loess", size=0.5, formula = y ~ x, span=0.01)  + xlab("physical position (Mb)") + ylab("fd") + ggtitle("loess regression of fd in 10kb non-overlapping windows on chr6") + theme_bw()+ theme(legend.position=c(0.9, 0.87), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave("fd.track.chr6.allPop.pdf")

ggplot(data=chr7, aes(x=position/1000000, y=fd, color=pop, group=pop)) +  geom_smooth(method="loess", size=0.5, formula = y ~ x, span=0.01)  + xlab("physical position (Mb)") + ylab("fd") + ggtitle("loess regression of fd in 10kb non-overlapping windows on chr7") + theme_bw()+ theme(legend.position=c(0.9, 0.87), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave("fd.track.chr7.allPop.pdf")

ggplot(data=chr8, aes(x=position/1000000, y=fd, color=pop, group=pop)) +  geom_smooth(method="loess", size=0.5, formula = y ~ x, span=0.01)  + xlab("physical position (Mb)") + ylab("fd") + ggtitle("loess regression of fd in 10kb non-overlapping windows on chr8") + theme_bw()+ theme(legend.position=c(0.9, 0.87), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave("fd.track.chr8.allPop.pdf")

ggplot(data=chr9, aes(x=position/1000000, y=fd, color=pop, group=pop)) +  geom_smooth(method="loess", size=0.5, formula = y ~ x, span=0.01)  + xlab("physical position (Mb)") + ylab("fd") + ggtitle("loess regression of fd in 10kb non-overlapping windows on chr9") + theme_bw()+ theme(legend.position=c(0.1, 0.87), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave("fd.track.chr9.allPop.pdf")

ggplot(data=chr10, aes(x=position/1000000, y=fd, color=pop, group=pop)) +  geom_smooth(method="loess", size=0.5, formula = y ~ x, span=0.01)  + xlab("physical position (Mb)") + ylab("fd") + ggtitle("loess regression of fd in 10kb non-overlapping windows on chr10") + theme_bw()+ theme(legend.position=c(0.9, 0.87), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave("fd.track.chr10.allPop.pdf")

ggplot(data=chr3, aes(x=position/1000000, y=fd, color=pop, group=pop)) +  geom_smooth(method="loess", size=1, span=0.01, formula = y ~ x)  + xlab("physical position (Mb)") + scale_x_continuous(breaks=c(25, 50, 75, 100, 125, 150, 175, 200, 225)) + ylab("fd") + ggtitle("loess regression of fd in 10kb non-overlapping windows on chr3") + theme_bw()+ theme(legend.position=c(0.9, 0.87))
ggsave("fd.track.chr3.allPop.span0.01.pdf")

##plot the fd regression in a new style
cen <- read.delim("AGPv3CentromerePos.txt", sep="")
names(cen)[1] <- "scaffold"
cen$scaffold <- factor(cen$scaffold)
cen["end.new"] <- cen$end * 1000000
cen["start.new"] <- cen$start.Mb. * 1000000


p <- ggplot(data=combine, aes(x=position/1000000, y=fd, color=pop, group=pop)) +  geom_smooth(method="loess", size=1, formula = y ~ x)  + xlab("physical position (Mb)") + ylab("fd") + ggtitle("loess regression of fd in 10kb non-overlapping windows") + theme_bw()
p + facet_wrap(~ scaffold, nrow=2, ncol=5)
ggsave("fd.track.allPop.pdf")

p <- ggplot(data=combine, aes(x=position/1000000, y=fd, color=pop, group=pop)) + xlab("physical position (Mb)") + ylab("fd") + theme_bw()+  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + geom_smooth(method="loess", size=1, formula = y ~ x, span=0.01) + facet_grid(scaffold ~ ., scales="free_y") 
p  + scale_x_continuous(breaks=c(0, 25, 50, 75, 100, 125, 150, 175, 200, 225, 250, 275, 300)) + geom_rect(data=cen, aes(xmin=start.Mb., xmax=end), ymin=0, ymax=1, fill="grey")
ggsave("fd.track.allPop.new.pdf")

cen <- read.delim("AGPv3CentromerePos_mod.txt", sep="")
names(cen)[1] <- "scaffold"
cen["mean"] <- (cen$start.Mb. + cen$end)/2

p <- ggplot(data=combine, aes(x=position/1000000, y=fd, color=pop, group=pop)) + xlab("physical position (Mb)") + ylab("fd") + theme_bw()+  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + geom_smooth(method="loess", size=0.5, formula = y ~ x, span=0.01) + facet_grid(scaffold ~ .) 
p  + scale_x_continuous(breaks=c(0, 25, 50, 75, 100, 125, 150, 175, 200, 225, 250, 275, 300)) + geom_vline(aes(xintercept=mean), data=cen, col="grey60") + scale_y_continuous(limits=c(0, 0.5), breaks=c(0.2, 0.4))
ggsave("fd.track.allPop.new.pdf")

##90% quantitle in SA_Low 0.3629
MexHigh.subset3 <- subset(MexHigh.subset2, MexHigh.subset2$fd > 0.3629)
write.table(MexHigh.subset3[, c(1,3,4)], file="MexHigh.introRegion.90%cutoff", quote=F, sep="\t", row.names=F)









