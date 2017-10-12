admix2 <- t(as.matrix(read.table("allSamples.K2.qopt")))
head(admix2)
pop <- read.table("pop.info", as.is=T, header=F)
head(pop)
admix2 <- admix2[, order(pop[,1])]
admix2
pop<-pop[order(pop[,1]),]
pop <- as.matrix(pop)
pdf("allSamples.K2.pdf")
barplot(admix2, col=1:2, space=0, border=NA, xlab="", ylab="K=2")
text(tapply(1:nrow(pop), pop[, 1], mean), -0.05, unique(pop[,1]), xpd=T)
dev.off()

admix3 <- t(as.matrix(read.table("allSamples.K3.qopt")))
pop <- read.table("pop.info", as.is=T, header=F)
head(pop)
admix3 <- admix3[, order(pop[,1])]
pop<-pop[order(pop[,1]),]
pop <- as.matrix(pop)
pdf("allSamples.K3.pdf")
barplot(admix3, col=1:3, space=0, border=NA, xlab="", ylab="K=3")
text(tapply(1:nrow(pop), pop[, 1], mean), -0.05, unique(pop[,1]), xpd=T)
dev.off()


admix4 <- t(as.matrix(read.table("allSamples.K4.qopt")))
pop <- read.table("pop.info", as.is=T, header=F)
head(pop)
admix4 <- admix4[, order(pop[,1])]
pop<-pop[order(pop[,1]),]
pop <- as.matrix(pop)
pdf("allSamples.K4.pdf")
barplot(admix4, col=1:4, space=0, border=NA, xlab="", ylab="K=4")
text(tapply(1:nrow(pop), pop[, 1], mean), -0.05, unique(pop[,1]), xpd=T)
dev.off()

admix5 <- t(as.matrix(read.table("allSamples.K5.qopt")))
pop <- read.table("pop.info", as.is=T, header=F)
head(pop)
admix5 <- admix5[, order(pop[,1])]
pop<-pop[order(pop[,1]),]
pop <- as.matrix(pop)
pdf("allSamples.K5.pdf")
barplot(admix5, col=1:5, space=0, border=NA, xlab="", ylab="K=5")
text(tapply(1:nrow(pop), pop[, 1], mean), -0.05, unique(pop[,1]), xpd=T)
dev.off()

admix6 <- t(as.matrix(read.table("allSamples.K6.qopt")))
pop <- read.table("pop.info", as.is=T, header=F)
head(pop)
admix6 <- admix6[, order(pop[,1])]
pop<-pop[order(pop[,1]),]
pop <- as.matrix(pop)
pdf("allSamples.K6.pdf")
barplot(admix6, col=1:6, space=0, border=NA, xlab="", ylab="K=6")
text(tapply(1:nrow(pop), pop[, 1], mean), -0.05, unique(pop[,1]), xpd=T)
dev.off()

admix7 <- t(as.matrix(read.table("allSamples.K7.qopt")))
pop <- read.table("pop.info", as.is=T, header=F)
head(pop)
admix7 <- admix7[, order(pop[,1])]
pop<-pop[order(pop[,1]),]
pop <- as.matrix(pop)
pdf("allSamples.K7.pdf")
barplot(admix7, col=1:7, space=0, border=NA, xlab="", ylab="K=7")
text(tapply(1:nrow(pop), pop[, 1], mean), -0.05, unique(pop[,1]), xpd=T)
dev.off()

admix8 <- t(as.matrix(read.table("allSamples.K8.qopt")))
pop <- read.table("pop.info", as.is=T, header=F)
head(pop)
admix8 <- admix8[, order(pop[,1])]
pop<-pop[order(pop[,1]),]
pop <- as.matrix(pop)
pdf("allSamples.K8.pdf")
barplot(admix8, col=1:8, space=0, border=NA, xlab="", ylab="K=8")
text(tapply(1:nrow(pop), pop[, 1], mean), -0.05, unique(pop[,1]), xpd=T)
dev.off()

admix9 <- t(as.matrix(read.table("allSamples.K9.qopt")))
pop <- read.table("pop.info", as.is=T, header=F)
head(pop)
admix9 <- admix9[, order(pop[,1])]
pop<-pop[order(pop[,1]),]
pop <- as.matrix(pop)
pdf("allSamples.K9.pdf")
barplot(admix9, col=1:9, space=0, border=NA, xlab="", ylab="K=9")
text(tapply(1:nrow(pop), pop[, 1], mean), -0.05, unique(pop[,1]), xpd=T)
dev.off()

admix10 <- t(as.matrix(read.table("allSamples.K10.qopt")))
pop <- read.table("pop.info", as.is=T, header=F)
head(pop)
admix10 <- admix10[, order(pop[,1])]
pop<-pop[order(pop[,1]),]
pop <- as.matrix(pop)
pdf("allSamples.K10.pdf")
barplot(admix10, col=1:10, space=0, border=NA, xlab="", ylab="K=10")
text(tapply(1:nrow(pop), pop[, 1], mean), -0.05, unique(pop[,1]), xpd=T)
dev.off()


pdf("allSamples.K2_6.pdf")
par(mfrow=c(5,1))
barplot(admix2, col=1:2, space=0, border=NA, xlab="", ylab="K=2")
barplot(admix3, col=1:3, space=0, border=NA, xlab="", ylab="K=3")
barplot(admix4, col=1:4, space=0, border=NA, xlab="", ylab="K=4")
barplot(admix5, col=1:5, space=0, border=NA, xlab="", ylab="K=5")
barplot(admix6, col=1:6, space=0, border=NA, xlab="", ylab="K=6")
text(tapply(1:nrow(pop), pop[, 1], mean), -0.05, unique(pop[,1]), xpd=T)
dev.off()
savehistory("NGSadmix.plot.R")
