library(stringr)

df <- read.delim("All_SeeD_2.7_biallelic.unimputed.hmp.txt", row.names=1)
df <- df[, -c(1:4)]
save(df, file="All_SeeD_2.7_biallelic.RData")

colnames(df) <- str_extract(colnames(df), "SEEDGWAS[0-9]+")


useful_stats<-function(x){
  countN<-sum(x=='N')
  known<-sum(x!='N')
  hetero<-sum(x %in% c("R", "Y", "M", "K", "S", "W"))
  percpoly<-as.numeric(hetero)/as.numeric(known)
  df <- as.data.frame(rbind(countN, known, hetero, percpoly))
  return(df)
}

## as there is a memory issue to deal with all samples in R, the samples were divided into five groups 
statistics <- apply(df[, c(1:1000)], 2, useful_stats)
statistics.df <- as.data.frame(sapply(statistics, function(x)x))
save(statistics.df, file="intermediate.RData")
rownames(statistics.df) <- c("countN", "known", "hetero", "percpoly")
colnames(statistics.df) <- str_extract(colnames(statistics.df), "SEEDGWAS[0-9]+")
statistics.df.transpose1 <- as.data.frame(t(statistics.df))

statistics <- apply(df[, c(1001:2000)], 2, useful_stats)
statistics.df <- as.data.frame(sapply(statistics, function(x)x))
save(statistics.df, file="intermediate.RData")
rownames(statistics.df) <- c("countN", "known", "hetero", "percpoly")
colnames(statistics.df) <- str_extract(colnames(statistics.df), "SEEDGWAS[0-9]+")
statistics.df.transpose1 <- as.data.frame(t(statistics.df))

statistics <- apply(df[, c(2001:3000)], 2, useful_stats)
statistics.df <- as.data.frame(sapply(statistics, function(x)x))
save(statistics.df, file="intermediate.RData")
rownames(statistics.df) <- c("countN", "known", "hetero", "percpoly")
colnames(statistics.df) <- str_extract(colnames(statistics.df), "SEEDGWAS[0-9]+")
statistics.df.transpose3 <- as.data.frame(t(statistics.df))

statistics <- apply(df[, c(3001:4000)], 2, useful_stats)
statistics.df <- as.data.frame(sapply(statistics, function(x)x))
save(statistics.df, file="intermediate.RData")
rownames(statistics.df) <- c("countN", "known", "hetero", "percpoly")
colnames(statistics.df) <- str_extract(colnames(statistics.df), "SEEDGWAS[0-9]+")
statistics.df.transpose4 <- as.data.frame(t(statistics.df))

statistics <- apply(df[, c(4001:4841)], 2, useful_stats)
statistics.df <- as.data.frame(sapply(statistics, function(x)x))
save(statistics.df, file="intermediate.RData")
rownames(statistics.df) <- c("countN", "known", "hetero", "percpoly")
colnames(statistics.df) <- str_extract(colnames(statistics.df), "SEEDGWAS[0-9]+")
statistics.df.transpose5 <- as.data.frame(t(statistics.df))

df <- as.data.frame(rbind(statistics.df.transpose1, statistics.df.transpose2, statistics.df.transpose3, statistics.df.transpose4, statistics.df.transpose5))
write.table(df, file="perSamplePolymorphism.txt", sep="\t", quote=F, row.names=T)


