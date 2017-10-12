library(cowplot)
df <- read.delim("31genome.geoDis.perc.hetero.txt")
df <- df[-17, ]
colorder <- c("MexLow", "MexHigh", "GuaHigh", "SW_US", "SA_Low", "Andes")
ggplot(df, aes(x=POP, y=F)) + geom_boxplot(aes(fill=POP)) + scale_x_discrete(limits=colorder) + theme(legend.position=c(0.10, 0.87)) + xlab("") + ylab("inbreeding coefficients")
ggsave("inbreedingCoefficients.boxplot.pdf")

lm_eqn = function(m) {
  l <- list(a = format(coef(m)[1], digits = 2),
      b = format(abs(coef(m)[2]), digits = 2),
      r = format(sqrt(summary(m)$r.squared), digits = 3),
      p = format(summary(m)$coefficients[2,4], digits=3));
  if (coef(m)[2] >= 0)  {
    eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(R)~"="~r*","~~italic(P)~"="~p,l)
  } else {
    eq <- substitute(italic(y) == a - b %.% italic(x)*","~~italic(R)~"="~r*","~~italic(P)~"="~p,l)    
  }
  as.character(as.expression(eq));                 
}
		
names(df)[4] <- "population"

p <- ggplot(df, aes(x=distance.km., y=perc.het)) + geom_smooth(method = "lm", color="blue", formula = y ~ x) + geom_point(aes(color=population)) + xlab("geographical distance to Balsas Valley (km)") + ylab("percentage of heterozygous sites") + theme_bw()
summary(df$perc.het)
summary(df$distance.km.)
p1 = p + geom_text(color="black", aes(x = 3200, y = 0.165, label = lm_eqn(lm(perc.het ~ distance.km., df))), parse = TRUE) + theme(legend.position=c(0.9, 0.8), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p1
ggsave("31genomeDisHeteroRegression.pdf")



