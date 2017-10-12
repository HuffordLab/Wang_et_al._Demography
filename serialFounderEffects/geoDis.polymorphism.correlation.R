library(ggplot2)
polym <- read.delim("~/Projects/wang_paper/demography/analyses/serialFounderEffects/results/perSamplePolymorphism.txt", header=T)
head(polym)
length(polym$sample)

geodis <- read.delim("~/Projects/wang_paper/demography/analyses/serialFounderEffects/results/sampleID.location.geoDis.txt", header=T)
names(geodis) <- c("sample", "geoDis")
head(geodis)
setdiff(geodis$sample, polym$sample)
row <- match(geodis$sample, polym$sample)

location <- read.delim("~/Projects/wang_paper/demography/analyses/serialFounderEffects/results/sampleID.gid.location.txt")
head(location)
names(location)

polym.subset <- polym[row, c(2:5)]
df <- as.data.frame(cbind(geodis, location[, c(3:9)], polym.subset))
head(df)
length(df$sample)
lm_eqn = function(m) {
  l <- list(a = format(coef(m)[1], digits = 2),
      b = format(abs(coef(m)[2]), digits = 2),
      r2 = format(summary(m)$r.squared, digits = 3));
  if (coef(m)[2] >= 0)  {
    eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(r)^2~"="~r2,l)
  } else {
    eq <- substitute(italic(y) == a - b %.% italic(x)*","~~italic(r)^2~"="~r2,l)    
  }
  as.character(as.expression(eq));                 
}

p <- ggplot(data=df, aes(x=geoDis, y=percpoly)) + geom_smooth(method = "lm", se=FALSE, color="black", formula = y ~ x) + geom_point() + xlab("geographical distance to Balsas Valley (km)") + ylab("percentage of polymorphic sites")
summary(df$geoDis)
summary(df$percpoly)
p1 = p + geom_text(color="blue", aes(x = 5000, y = 0.067, label = lm_eqn(lm(percpoly ~ geoDis, df))), parse = TRUE)
p1
ggsave("geoDis.polymorphism.correlation.pdf")
write.table(df, file="sampleID.location.geoDis.txt", sep="\t", quote=F, row.names=F)
savehistory("geoDis.polymorphism.correlation.R")
