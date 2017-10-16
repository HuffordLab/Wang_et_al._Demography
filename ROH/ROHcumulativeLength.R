library("data.table")
library("cowplot")
library(dplyr)
#Physical Length
df <- fread("ROH300kb.20snpWindow.1het.hom.withCM")
head(df)
names(df) <- c("FID", "chr", "pos1", "pos2", "KB", "start.cM", "end.cM", "cM")
head(df)

df <- as.data.frame(df)
df <- subset(df, df$FID != "RIMMA0623")
df <- subset(df, df$FID != "RIMMA0623" & df$FID != "RIMMA0677")
summary(df$cM)
breaks <- seq(0, 2.3, 0.1)
length(breaks)
df["cm.cut"] <- cut(df$cM, breaks, labels=breaks[-1])
head(df)
#df.new <- df2 %>% group_by(FID, cm.cut) %>% summarize(value=sum(KB)) %>% mutate(csum = cumsum(value))
df.new <- df %>% group_by(FID, cm.cut) %>% summarize(value=sum(KB)) %>% mutate(csum = cumsum(value))
df.new["population"] <- ifelse(df.new$FID %in% c("RIMMA0383", "RIMMA0384", "RIMMA0385", "RIMMA0387", "RIMMA0415", "RIMMA1012"), "SW_US", "unknown")
df.new["population"] <- ifelse(df.new$FID %in% c("RIMMA0670", "RIMMA1007", "RIMMA1008"), "GuaHigh", df.new$population)
df.new["population"] <- ifelse(df.new$FID %in% c("RIMMA0421", "RIMMA0438", "RIMMA0623", "RIMMA0626", "RIMMA0672", "RIMMA0677"), "MexHigh", df.new$population)
df.new["population"] <- ifelse(df.new$FID %in% c("RIMMA0409", "RIMMA0703", "RIMMA0720", "RIMMA0733", "RIMMA1010"), "MexLow", df.new$population)
df.new["population"] <- ifelse(df.new$FID %in% c("RIMMA0390", "RIMMA0392", "RIMMA0393", "RIMMA0395", "RIMMA0398", "RIMMA0399"), "SA_Low", df.new$population)
df.new["population"] <- ifelse(df.new$FID %in% c("RIMMA0466", "RIMMA0468", "RIMMA0662", "RIMMA0665", "RIMMA0625"), "Andes", df.new$population)
df.new$cm.cut <- as.numeric(as.character(df.new$cm.cut))
head(df.new)
df.new2 <- df.new %>% group_by(cm.cut, population) %>% summarize(median.value=median(value)) %>% group_by(population) %>% mutate(csum.new = cumsum(median.value))
ggplot(df.new, aes(x=cm.cut, y=csum/1000, color = population)) + geom_point() + xlab("bins of ROHs length (cM)") + ylab("cumulative length of ROHs (Mb)") + theme(legend.position=c(0.9, 0.15)) +
#geom_smooth(data=df.new, aes(x=cm.cut, y=csum/1000, group=population, color=population), se=FALSE) +
geom_line(data=df.new2, aes(x=cm.cut, y=csum.new/1000, color=population)) +
scale_x_continuous(breaks=c(0, 0.5, 1, 1.5, 2))
ggsave("ROHnewCM.pdf")

##CHANGE y axis also to cM 
df.new <- df %>% group_by(FID, cm.cut) %>% summarize(value=sum(cM)) %>% mutate(csum = cumsum(value))
df.new["population"] <- ifelse(df.new$FID %in% c("RIMMA0383", "RIMMA0384", "RIMMA0385", "RIMMA0387", "RIMMA0415", "RIMMA1012"), "SW_US", "unknown")
df.new["population"] <- ifelse(df.new$FID %in% c("RIMMA0670", "RIMMA1007", "RIMMA1008"), "GuaHigh", df.new$population)
df.new["population"] <- ifelse(df.new$FID %in% c("RIMMA0421", "RIMMA0438", "RIMMA0623", "RIMMA0626", "RIMMA0672", "RIMMA0677"), "MexHigh", df.new$population)
df.new["population"] <- ifelse(df.new$FID %in% c("RIMMA0409", "RIMMA0703", "RIMMA0720", "RIMMA0733", "RIMMA1010"), "MexLow", df.new$population)
df.new["population"] <- ifelse(df.new$FID %in% c("RIMMA0390", "RIMMA0392", "RIMMA0393", "RIMMA0395", "RIMMA0398", "RIMMA0399"), "SA_Low", df.new$population)
df.new["population"] <- ifelse(df.new$FID %in% c("RIMMA0466", "RIMMA0468", "RIMMA0662", "RIMMA0665", "RIMMA0625"), "Andes", df.new$population)
df.new$cm.cut <- as.numeric(as.character(df.new$cm.cut))
head(df.new)
df.new2 <- df.new %>% group_by(cm.cut, population) %>% summarize(median.value=median(value)) %>% group_by(population) %>% mutate(csum.new = cumsum(median.value))
ggplot(df.new, aes(x=cm.cut, y=csum, color = population)) + geom_point() + xlab("bins of ROHs length (cM)") + ylab("cumulative length of ROHs (cM)") + theme(legend.position=c(0.9, 0.15)) +
geom_line(data=df.new2, aes(x=cm.cut, y=csum.new, color=population)) +
scale_x_continuous(breaks=c(0, 0.5, 1, 1.5, 2))
ggsave("ROHnewCM2.pdf")
