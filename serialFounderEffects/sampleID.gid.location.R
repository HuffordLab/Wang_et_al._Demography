##read in the sample ID file
sample <- read.delim("samples.txt", header=F)
sampleID <- t(sample)
head(sampleID)
sampleID <- as.factor(sampleID)
head(sampleID)

##read in the file containing both sampleID in the SNP data and general_identifier in CIMMYT
gid <- read.delim("SampleID2GermplasmID.txt")
head(gid)
gid <- gid[, -(3:9)]
head(gid)
names(gid)[2] <- "GID"
head(gid)
length(gid$GID)

diff <- setdiff(sampleID, gid$Sample.ID)
diff
length(diff)
rownumber <- match(sampleID, gid$Sample.ID)
length(rownumber)
length(sampleID)

## found sampleID contain duplicates, redo the match and subsetting
length(unique(sampleID))
length(unique(gid$Sample.ID))
sampleID.unique <- unique(sampleID)
rownumber <- match(sampleID.unique, gid$Sample.ID)
length(rownumber)
gid.subset <- gid[rownumber, ]
length(gid.subset$Sample.ID)
head(gid.subset)

##read in the PASSPORT file, which contains the general_identifier (gid) and the location information
PASSPORT <- read.delim("SEEDS_Passport.txt")
names(PASSPORT)
diff <- setdiff(gid.subset$GID, PASSPORT$general_identifier)
diff
length(diff)
rownumbers <- match(gid.subset$GID, PASSPORT$general_identifier)
PASSPORT.subset <- PASSPORT[rownumbers, c(3,35:43,49)]
names(PASSPORT.subset)
df <- as.data.frame(cbind(sampleID.unique, PASSPORT.subset[, 1:11]))
length(df$state)
names(df)
df.new <- df[, c(1:2, 10:12, 5:7, 9)]
head(df.new)
df.new <- df.new[complete.cases(df.new[, 3:4]), ]
length(df.new$latitude)

write.table(df.new, file="sampleID.gid.location.txt", sep="\t", quote=F, row.names=F)

savehistory("sampleID.gid.location.R")
