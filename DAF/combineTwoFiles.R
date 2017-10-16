library(optparse)
library(data.table)

option_list <- list(make_option(c('-i','--in_file'), action='store', type='character', default=NULL, help='input file'),
make_option(c('-o','--out_file'), action='store', type='character', default=NULL, help='Output file')
                    )
opt <- parse_args(OptionParser(option_list = option_list))

df <- fread(opt$in_file, skip=554)
names(df)[1] <- "CHROM"
df <- df[order(df$CHROM, df$POS), ]
df <- as.data.frame(df)
df["ids"] <- paste(df$CHROM, df$POS, sep="_")

load(file="AllChr.GERP0.zea.majorAllele.RData")

df.new <- merge(df, allele)


write.table(df.new, file=opt$out_file, sep="\t", quote=F, row.names=F)

