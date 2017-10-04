library(data.table)
library(plyr)
library(tidyr)
library(reshape2)

df <- fread("gerpSkinny_derAlleleFreq.txt")
head(df)
df <- as.data.frame(df)
df["gerp"] <- round(df$V17)

#convert number of ALT alleles to number of derived alleles
for (i in 7:15)
{
df[, i] <- ifelse(df$V3==df$V6, df[, i], 2-df[, i])
}

##exclude sorghum N or non-biallelic sites
df.new <- subset(df, df$V16==df$V5 | df$V16==df$V6)

#bin the derived allele frequency into 1% bin
df.new$bin <- cut(df.new$V4, breaks=seq(0, 1, 0.01), labels=seq(0, 0.99, 0.01))

#subtract the data to those B73==Sorghum
df.B73anc <- subset(df.new, df.new$V5==df.new$V16)

##cross tabulate frequency based on drived frequency bin and gerp scores
t <- count(df.B73anc, c('bin', 'gerp'))

##convert long format to wide format
t_wide <- spread(t, gerp, freq)

##calculate the proportion
t_wide_prop <- cbind(t_wide[1], prop.table(as.matrix(t_wide[-1]), margin=1))

##merge the distribution of SNPs in GERP categories with the df.new data based on the same column "bin" (derived allele frequency)
df.big <- merge(df.new, t_wide_prop, all.x=T, all.y=T)

names(df.big)[2:18] <- c("chr", "pos", "derivedAllele", "derivedAlleleFreq", "REF", "ALT", "2A", "2B", "2C", "2D", "RIMMA0409", "RIMMA0703", "RIMMA0720", "RIMMA0733", "RIMMA1010", "sorghum", "gerpRaw")
names(df.big)
df.big2 <- df.big[, c(1,2,3,6,19,4,8:16)]
df.big.melt <- melt(df.big2, id.vars=c("bin", "chr", "pos", "REF", "gerp", "derivedAllele"))
names(df.big.melt)[7:8] <- c("ind", "del.alleles")
head(df.big.melt)
mbig <- merge(df.big.melt, t_wide_prop, all.x=T, all.y=T)

#editing the format to be fully accordant with Jeff's
names(mbig)[1] <- "derived.freq"

mbig["chrompos"] <- paste(mbig$chr, mbig$pos, sep="_")
names(mbig)[5] <- "GERP"
names(mbig)[6] <- "derived.allele"
mbig["gerpcat"] <- 1
names(mbig)
mbig2 <- mbig[, c(1,28,4:8,29,9:27)]

write.table(mbig2, file="TeoMaize.mbig.txt", row.names=F, sep="\t", quote=F)


