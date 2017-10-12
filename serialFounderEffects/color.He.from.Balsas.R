library(ggplot2)

##new version after group country name into Mexico, central America, South America
library(ggplot2)
df <- read.delim("sampleID.location.geoDis.txt")
levels(df$country_name)
lm_eqn = function(m) {
  l <- list(a = format(coef(m)[1], digits = 2),
      b = format(abs(coef(m)[2]), digits = 2),
      r = format(sqrt(summary(m)$r.squared), digits = 3));
  if (coef(m)[2] >= 0)  {
    eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(R)~"="~r,l)
  } else {
    eq <- substitute(italic(y) == a - b %.% italic(x)*","~~italic(R)~"="~r,l)    
  }
  as.character(as.expression(eq));                 
}
names(df)[5] <- "region"
p <- ggplot(data=df, aes(x=geoDis, y=percpoly)) + geom_smooth(method = "lm", se=FALSE, color="black", formula = y ~ x) + geom_point(aes(color=region, alpha=elevation))+ xlab("geographical distance to Balsas Valley (km)") + ylab("percentage of polymorphic sites") + theme_bw()
p1 = p + geom_text(color="blue", aes(x = 4500, y = 0.067, label = lm_eqn(lm(percpoly ~ geoDis, df))), parse = TRUE)
p1
ggsave("geoDis.polymorphism.correlation.colorCountry.pdf")

savehistory("color.He.from.Balsas.R")

