library(data.table)
library(tidyr)
library(dplyr)
library(cowplot)

df1 <- read.delim("TeoMaize.homo.GERP0.count.txt")
head(df1)
maxtot=mean(subset(df1$tot,df1$taxa=="teosinte"))
maxtot

p1 <- ggplot(df1) + geom_jitter(aes(y=tot/maxtot,x=taxa,color=taxa),size=4,width
=0.25)+theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size
=10),axis.title.y = element_text(size=12))+
  xlab("")+
  ylab("relative burden") +
ggtitle("")+
theme(legend.position="none")



df3 <- read.delim("MaizePop.homo.GERP0.count.txt")
head(df3)
maxtot=mean(subset(df3$tot,df3$pop=="MexLow"))
p2 <- ggplot(df3) + 
  geom_jitter(aes(y=tot/maxtot,x=pop,color=pop),size=4,width=0.25)+theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=10),axis.title.y = element_text(size=12))+
  xlab("")+
  ylab("relative burden")+
  ggtitle("")+
  theme(legend.position="none")

## fixed Seg TeoMaize
df.new2 <- read.delim("TeoMaize.fixedSeg.4Sample.100rep.txt")

df.fixedSeg <- melt(df.new2, id.vars="taxa") %>% group_by(taxa, variable) %>% summarize(mean=mean(value), se=sd(value)/sqrt(length(taxa)))

df.fixedSeg[3,4] <- 0
df.fixedSeg[4,4] <- 0

p3 <- ggplot(df.fixedSeg, aes(x=taxa,y=mean, fill=taxa, color=taxa))+
  geom_bar(stat = "identity", width = 0.5)+
  theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=10),axis.title.y = element_text(size=12))+
  xlab("")+
  ylab("no. of deleterious sites")+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), color="black", width=0.2) +
  facet_grid(variable ~ ., scales="free_y") + 
  theme(legend.position="none")
  
##fixed seg maize pop  
df.new <- read.delim("sixPop.fixedSeg.3Sample.simplified.txt")
df.new2 <- df.new[, 1:3]

df.fixedSeg <- melt(df.new2, id.vars="pop") %>% group_by(pop, variable) %>% summarize(mean=mean(value), se=sd(value)/sqrt(length(pop)))
df.fixedSeg
df.fixedSeg[3,4] <- 0
df.fixedSeg[4,4] <- 0


p4 <- ggplot(df.fixedSeg, aes(x=pop,y=mean, fill=pop, color=pop))+
  geom_bar(stat = "identity", width=0.8)+
  theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=10),axis.title.y = element_text(size=12))+
  xlab("")+
  ylab("no. of deleterious sites")+
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), color="black", width=0.2) +
  facet_grid(variable ~ ., scales="free_y") + 
  theme(legend.position="none")



plot_grid(p1, p2, p3, p4, labels=c("A", "B", "C", "D"), nrow=2)
ggsave("Figure3.pdf", width=10, height=10)

