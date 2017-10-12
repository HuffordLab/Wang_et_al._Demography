library(ggplot2)
df <- read.delim("ROH300kb.20snpWindow.1het.hom", sep="")
head(df)


levels(df$FID)[which(levels(df$FID)=="RIMMA0383")] <- "SW_US"
levels(df$FID)[which(levels(df$FID)=="RIMMA0384")] <- "SW_US"
levels(df$FID)[which(levels(df$FID)=="RIMMA0385")] <- "SW_US"
levels(df$FID)[which(levels(df$FID)=="RIMMA0387")] <- "SW_US"
levels(df$FID)[which(levels(df$FID)=="RIMMA0415")] <- "SW_US"
levels(df$FID)[which(levels(df$FID)=="RIMMA1012")] <- "SW_US"
levels(df$FID)[which(levels(df$FID)=="RIMMA0670")] <- "Gua_Highland"
levels(df$FID)[which(levels(df$FID)=="RIMMA1007")] <- "Gua_Highland"
levels(df$FID)[which(levels(df$FID)=="RIMMA1008")] <- "Gua_Highland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0421")] <- "Mex_Highland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0438")] <- "Mex_Highland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0623")] <- "Mex_Highland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0626")] <- "Mex_Highland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0672")] <- "Mex_Highland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0677")] <- "Mex_Highland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0409")] <- "Mex_Lowland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0703")] <- "Mex_Lowland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0720")] <- "Mex_Lowland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0733")] <- "Mex_Lowland"
levels(df$FID)[which(levels(df$FID)=="RIMMA1010")] <- "Mex_Lowland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0390")] <- "SA_Lowland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0392")] <- "SA_Lowland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0393")] <- "SA_Lowland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0395")] <- "SA_Lowland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0398")] <- "SA_Lowland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0399")] <- "SA_Lowland"
levels(df$FID)[which(levels(df$FID)=="RIMMA0466")] <- "Andes"
levels(df$FID)[which(levels(df$FID)=="RIMMA0468")] <- "Andes"
levels(df$FID)[which(levels(df$FID)=="RIMMA0662")] <- "Andes"
levels(df$FID)[which(levels(df$FID)=="RIMMA0665")] <- "Andes"
levels(df$FID)[which(levels(df$FID)=="RIMMA0625")] <- "Andes"

length(df$FID)
names(df)[1] <- "pop"
library(plyr)

df.transform <- ddply(df, "IID", summarize, sum.KB=sum(KB))
df.transform
df.transform
df.transform <- df.transform[-17, ]
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0383")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0384")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0385")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0387")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0415")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA1012")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0670")] <- "Gua_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA1007")] <- "Gua_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA1008")] <- "Gua_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0421")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0438")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0623")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0626")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0672")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0677")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0409")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0703")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0720")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0733")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA1010")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0390")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0392")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0393")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0395")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0398")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0399")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0466")] <- "Andes"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0468")] <- "Andes"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0662")] <- "Andes"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0665")] <- "Andes"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0625")] <- "Andes"
df.transform
colorder <- c( "Andes", "SA_Lowland", "Mex_Highland", "Mex_Lowland", "SW_US", "Gua_Highland")
names(df.transform)[1] <- "pop"
df.transform
ggplot(df.transform, aes(x=pop, y=sum.KB)) + geom_boxplot(aes(fill=pop)) + xlab("") +scale_x_discrete(limits=colorder,labels=c("Andes","SA_Low","MexHigh","MexLow", "SW_US", "GuaHigh")) + theme_bw() + ylab("sum length of ROHs(kb)")
ggsave("ROH300kb.20SNP.1het.sum.pdf")

Andes <- subset(df.transform, df.transform$pop == "Andes")
SA_Lowland <- subset(df.transform, df.transform$pop == "SA_Lowland")
Mex_Lowland <- subset(df.transform, df.transform$pop == "Mex_Lowland")
Gua_Highland <- subset(df.transform, df.transform$pop == "Gua_Highland")
Mex_Highland <- subset(df.transform, df.transform$pop == "Mex_Highland")
SW_US <- subset(df.transform, df.transform$pop == "SW_US")
median(Andes$sum.KB)
median(SA_Lowland$sum.KB)
median(Mex_Lowland$sum.KB)
median(Gua_Highland$sum.KB)
median(Mex_Highland$sum.KB)
median(SW_US$sum.KB)

wilcox.test(Andes$sum.KB, Mex_Lowland$sum.KB, alternative="greater")
wilcox.test(Andes$sum.KB, Mex_Highland$sum.KB, alternative="greater")
wilcox.test(Andes$sum.KB, SA_Lowland$sum.KB, alternative="greater")
wilcox.test(Andes$sum.KB, SW_US$sum.KB, alternative="greater")
wilcox.test(Andes$sum.KB, Gua_Highland$sum.KB, alternative="greater")

##ROHs less than 1mb
df.less1mb <- subset(df, df$KB<=1000)
df.transform <- ddply(df.less1mb, "IID", summarize, sum.KB=sum(KB))
df.transform
df.transform
df.transform <- df.transform[-17, ]
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0383")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0384")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0385")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0387")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0415")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA1012")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0670")] <- "Gua_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA1007")] <- "Gua_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA1008")] <- "Gua_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0421")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0438")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0623")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0626")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0672")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0677")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0409")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0703")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0720")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0733")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA1010")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0390")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0392")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0393")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0395")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0398")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0399")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0466")] <- "Andes"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0468")] <- "Andes"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0662")] <- "Andes"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0665")] <- "Andes"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0625")] <- "Andes"
df.transform
names(df.transform)[1] <- "pop"
df.transform <- df.transform[order(df.transform$pop), ]
colorder <- c("Andes", "SA_Lowland", "Mex_Highland", "Mex_Lowland", "SW_US", "Gua_Highland")

df.transform
ggplot(df.transform, aes(x=pop, y=sum.KB)) + geom_boxplot(aes(fill=pop)) + xlab("") +scale_x_discrete(limits=colorder,labels=c("Andes","SA_Low","MexHigh","MexLow", "SW_US", "GuaHigh")) + theme_bw() + ylab("sum length of ROH(kb)")
ggsave("ROH300kb.20SNP.1het.sum.rm1mb.pdf")

Andes <- subset(df.transform, df.transform$pop == "Andes")
SA_Lowland <- subset(df.transform, df.transform$pop == "SA_Lowland")
Mex_Lowland <- subset(df.transform, df.transform$pop == "Mex_Lowland")
Gua_Highland <- subset(df.transform, df.transform$pop == "Gua_Highland")
Mex_Highland <- subset(df.transform, df.transform$pop == "Mex_Highland")
SW_US <- subset(df.transform, df.transform$pop == "SW_US")
wilcox.test(Andes$sum.KB, Mex_Lowland$sum.KB, alternative="greater")
wilcox.test(Andes$sum.KB, Mex_Highland$sum.KB, alternative="greater")
wilcox.test(Andes$sum.KB, SA_Lowland$sum.KB, alternative="greater")
wilcox.test(Andes$sum.KB, SW_US$sum.KB, alternative="greater")
wilcox.test(Andes$sum.KB, Gua_Highland$sum.KB, alternative="greater")

ggplot(df.less1mb, aes(x=KB, fill=pop)) + geom_histogram(binwidth=100, alpha=0.5, position="dodge") + theme_bw()+ coord_cartesian(xlim=c(300, 1000))
ggsave("ROH300kb.histogram.rm1Mb.pdf")



#bigger than 1mb
df.more1mb <- subset(df, df$KB > 1000)
df.transform <- ddply(df.more1mb, "IID", summarize, sum.KB=sum(KB))
df.transform
df.transform
df.transform <- df.transform[-17, ]
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0383")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0384")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0385")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0387")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0415")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA1012")] <- "SW_US"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0670")] <- "Gua_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA1007")] <- "Gua_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA1008")] <- "Gua_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0421")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0438")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0623")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0626")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0672")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0677")] <- "Mex_Highland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0409")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0703")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0720")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0733")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA1010")] <- "Mex_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0390")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0392")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0393")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0395")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0398")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0399")] <- "SA_Lowland"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0466")] <- "Andes"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0468")] <- "Andes"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0662")] <- "Andes"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0665")] <- "Andes"
levels(df.transform$IID)[which(levels(df.transform$IID)=="RIMMA0625")] <- "Andes"
df.transform
names(df.transform)[1] <- "pop"
df.transform <- df.transform[order(df.transform$pop), ]
colorder <- c("Andes", "SA_Lowland", "Mex_Highland", "Mex_Lowland", "SW_US", "Gua_Highland")

df.transform
ggplot(df.transform, aes(x=pop, y=sum.KB)) + geom_boxplot(aes(fill=pop)) + xlab("") +scale_x_discrete(limits=colorder,labels=c("Andes","SA_Low","MexHigh","MexLow", "SW_US", "GuaHigh")) + theme_bw() + ylab("sum length of ROH(kb)")
ggsave("ROH300kb.20SNP.1het.sum.rm1mb.pdf")


savehistory("ROH.boxplot.wilcox.test.R")
