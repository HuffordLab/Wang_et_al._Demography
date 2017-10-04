library(ggplot2)
lnames <- load("boxplot.window.RData")
lnames
Andes <- andean
Andes.theta <- Andes$tW/Andes$nSites
Andes.pi <- Andes$tP/Andes$nSites
SW_US.theta <- SW_US$tW/SW_US$nSites
SW_US.pi <- SW_US$tP/SW_US$nSites
SA_Lowland.theta <- SA_Lowland$tW/SA_Lowland$nSites
SA_Lowland.pi <- SA_Lowland$tP/SA_Lowland$nSites
MexLowland.theta <- MexLowland$tW/MexLowland$nSites
MexLowland.pi <- MexLowland$tP/MexLowland$nSites
MexHighland.theta <- MexHighland$tW/MexHighland$nSites
MexHighland.pi <- MexHighland$tP/MexHighland$nSites
GuaHighland.theta <- GuaHighland$tW/GuaHighland$nSites
GuaHighland.pi <- GuaHighland$tP/GuaHighland$nSites
Andes["pop"] <- rep("Andes", length(Andes$nSites))
head(Andes)
Andes["pi"] <- Andes.pi
Andes["theta"] <- Andes.theta
Andes["pop"] <- rep("Andes", length(Andes$nSites))
SA_Lowland["pi"] <- SA_Lowland.pi
SA_Lowland["theta"] <- SA_Lowland.theta
SA_Lowland["pop"] <- rep("SA_Low", length(SA_Lowland$nSites))
MexLowland["pi"] <- MexLowland.pi
MexLowland["theta"] <- MexLowland.theta
MexLowland["pop"] <- rep("MexLow", length(MexLowland$nSites))
MexHighland["pi"] <- MexHighland.pi
MexHighland["theta"] <- MexHighland.theta
MexHighland["pop"] <- rep("MexHigh", length(MexHighland$nSites))
GuaHighland["pi"] <- GuaHighland.pi
GuaHighland["theta"] <- GuaHighland.theta
GuaHighland["pop"] <- rep("GuaHigh", length(GuaHighland$nSites))
SW_US["pi"] <- SW_US.pi
SW_US["theta"] <- SW_US.theta
SW_US["pop"] <- rep("SW_US", length(SW_US$nSites))
combine <- rbind(Andes, SA_Lowland, MexHighland, MexLowland, SW_US, GuaHighland)
head(combine)
colorder <- c( "Andes", "SA_Low", "MexHigh", "MexLow", "SW_US", "GuaHigh")
ylim1 = boxplot.stats(combine$theta)$stats[c(1, 5)]
ggplot(data=combine, aes(x=pop, y=theta)) + geom_boxplot(aes(fill=pop)) + xlab("") + coord_cartesian(ylim = ylim1*1.05) + scale_x_discrete(limits=colorder,labels=c("Andes","SA_Low","MexHigh","MexLow", "SW_US", "GuaHigh")) + theme_bw()
ggsave("ggplot.boxplot.theta.pdf")

ylim1 = boxplot.stats(combine$pi)$stats[c(1, 5)]
ggplot(data=combine, aes(x=pop, y=pi)) + geom_boxplot(aes(fill=pop), outlier.shape=NA) + xlab("") + coord_cartesian(ylim = ylim1*1.05) + scale_x_discrete(limits=colorder,labels=c("Andes","SA_Low","MexHigh","MexLow", "SW_US", "GuaHigh")) + theme_bw()
ggsave("ggplot.boxplot.pi.pdf")
savehistory("ggplot.boxplot.R")

median(Andes$pi)
median(SA_Lowland$pi)
median(MexHighland$pi)
median(MexLowland$pi)
median(GuaHighland$pi)
median(SW_US$pi)

wilcox.test(MexHighland$pi, MexLowland$pi, alternative="greater")
wilcox.test(MexHighland$pi, SA_Lowland$pi, alternative="greater")
wilcox.test(MexHighland$pi, GuaHighland$pi, alternative="greater")
wilcox.test(MexHighland$pi, SW_US$pi, alternative="greater")

wilcox.test(SW_US$pi, MexLowland$pi, alternative="greater")
wilcox.test(SW_US$pi, SA_Lowland$pi, alternative="greater")
wilcox.test(SW_US$pi, GuaHighland$pi, alternative="greater")


wilcox.test(MexLowland$pi, SA_Lowland$pi, alternative="greater")
wilcox.test(MexLowland$pi, GuaHighland$pi, alternative="greater")

wilcox.test(GuaHighland$pi, SA_Lowland$pi, alternative="greater")