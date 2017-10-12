library(phangorn)

#contrast <- read.csv("contrast.txt", header=T)
#row.names(contrast) <- c("a", "c", "g", "t", "r", "y", "m", "k", "s", "w", "?")
#contrast <- as.matrix(contrast)
#contrast

data <- read.dna("chr4Inv.recode.fasta", format="fasta")
data <- phyDat(data)
data

#data <- read.phyDat(data, format="fasta", type="USER", contrast=contrast)
#data

#dm <- dist.dna(as.DNAbin(data), pairwise.deletion=TRUE)  
dm <- dist.ml(data)
treeNJ <- NJ(dm)


pdf("chr4Inv.NJtree.pdf")
root_name <- "Tripsacum"
plot(ladderize(root(treeNJ, match(root_name, treeNJ$tip.label))), type="phylogram", show.node.label=T, underscore=T, cex=0.8, no.margin=T)
dev.off()
write.tree(treeNJ, file="chr4Inv.NJ.tre")

#bs <- bootstrap.phyDat(data, FUN=function(x)NJ(dist.ml(x)), bs=100)
#pdf("chr4Inv.NJtree_bs.pdf")
#treeBS <- plotBS(treeNJ, bs, type="phylogram", bs.col="red", bs.adj=NULL)
#treeBS
#dev.off()

#write.tree(treeNJ, file="chr4Inv.NJ.tre")
#write.tree(treeBS, file="chr4Inv.NJ_BS.tre")



