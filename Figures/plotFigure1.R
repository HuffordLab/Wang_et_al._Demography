library(raster)
library(dismo)
library(rgdal)
library(cowplot)
files <- list.files(path="./rasterTIF", pattern="tif", full.names=T)
files
vars <- seq(1, 19, 1)
grids <- sapply(vars, function(x) {
  patt <- paste('bio', x, '_', sep='')
  tiles <- files[grep(patt, files)]
  merged <- eval(parse(text=paste('merge(', toString(paste('raster(', tiles, ')', 
                sep='"')), ')', sep='')))
})
names(grids) <- paste('bio', vars, sep='')
names(grids)
s <- stack(grids)
ext <- extent(-120, -70, -15, 38)
s.crop <- crop(s, ext)
distri <- read.delim("Genome_Passport_firstVersion_Li.txt", header=T)
distri <- distri[, 3:5]
distri
s.points <- rasterToPoints(s.crop)
s.df <- as.data.frame(s.points)
head(s.df)
length(s.df$x)
s.df["tmp"] <- s.df$bio1/10
#bio1.gradient <- seq(min(s.df$bio1), max(s.df$bio1), length.out=100)
names(distri)[1] <- "population"
p1 <- ggplot(data=s.df, aes(y=latitude, x=longitude)) +
geom_raster(aes(fill=tmp)) +
geom_point(data=distri, aes(x=Long, y=Lat, color=population), size=2) +
coord_equal() +
scale_fill_gradient(limits=c(-8,46), low="blue", high="orange", breaks=c(0, 16, 32)) +
theme(legend.position = c(0.15, 0.3)) +
ggtitle("Annual Mean Temperature")
p1
ggsave("Fig1A_test2.pdf")


setwd("/Users/lwang/demography/msmc/sixPop/msmc2/bootstrap")
library("plyr")
library("reshape2")
library("cowplot")
#read all par bootstrap result files
bootstrap.par <- lapply(Sys.glob("par_bootstrap*.m0017.result.txt"), function(x) read.delim(x, header=F))
length(bootstrap.par)
names(bootstrap.par) <- paste("par_bootstrap", seq(1, 10, 1), sep="")
names(bootstrap.par)
#convert list to data frame
bootstrap.par.df <- ldply(bootstrap.par, data.frame)
head(bootstrap.par.df)
bootstrap.par.df["population"] <- "parviglumis"
#read all Andes bootstrap result files
bootstrap.Andes <- lapply(Sys.glob("Andes_bootstrap*.result.txt"), function(x) read.delim(x, header=F))
length(bootstrap.Andes)
names(bootstrap.Andes) <- paste("Andes_bootstrap", seq(1, 10, 1), sep="")
bootstrap.Andes.df <- ldply(bootstrap.Andes, data.frame)
head(bootstrap.Andes.df)
bootstrap.Andes.df["population"] <- "Andes"
#read all SA_Low bootstrap result files
bootstrap.SA_Low <- lapply(Sys.glob("SA_Low_bootstrap*.result.txt"), function(x) read.delim(x, header=F))
length(bootstrap.SA_Low)
names(bootstrap.SA_Low) <- paste("SA_Low_bootstrap", seq(1, 10, 1), sep="")
bootstrap.SA_Low.df <- ldply(bootstrap.SA_Low, data.frame)
head(bootstrap.SA_Low.df)
bootstrap.SA_Low.df["population"] <- "SA_Low"
#read all GuaHigh bootstrap result files
bootstrap.GuaHigh <- lapply(Sys.glob("GuaHigh_bootstrap*.result.txt"), function(x) read.delim(x, header=F))
length(bootstrap.GuaHigh)
names(bootstrap.GuaHigh) <- paste("GuaHigh_bootstrap", seq(1, 10, 1), sep="")
bootstrap.GuaHigh.df <- ldply(bootstrap.GuaHigh, data.frame)
head(bootstrap.GuaHigh.df)
bootstrap.GuaHigh.df["population"] <- "GuaHigh"
#read all MexHigh bootstrap result files
bootstrap.MexHigh <- lapply(Sys.glob("MexHigh_bootstrap*.result.txt"), function(x) read.delim(x, header=F))
length(bootstrap.MexHigh)
names(bootstrap.MexHigh) <- paste("MexHigh_bootstrap", seq(1, 10, 1), sep="")
bootstrap.MexHigh.df <- ldply(bootstrap.MexHigh, data.frame)
head(bootstrap.MexHigh.df)
bootstrap.MexHigh.df["population"] <- "MexHigh"
#read all SW_US bootstrap result files
bootstrap.SW_US <- lapply(Sys.glob("SW_US_bootstrap*.result.txt"), function(x) read.delim(x, header=F))
length(bootstrap.SW_US)
names(bootstrap.SW_US) <- paste("SW_US_bootstrap", seq(1, 10, 1), sep="")
bootstrap.SW_US.df <- ldply(bootstrap.SW_US, data.frame)
head(bootstrap.SW_US.df)
bootstrap.SW_US.df["population"] <- "SW_US"
#read all MexLow bootstrap result files
bootstrap.MexLow <- lapply(Sys.glob("MexLow_bootstrap*.result.txt"), function(x) read.delim(x, header=F))
length(bootstrap.MexLow)
names(bootstrap.MexLow) <- paste("MexLow_bootstrap", seq(1, 9, 1), sep="")
bootstrap.MexLow.df <- ldply(bootstrap.MexLow, data.frame)
head(bootstrap.MexLow.df)
bootstrap.MexLow.df["population"] <- "MexLow"
bootstrap <- rbind(bootstrap.par.df, bootstrap.Andes.df, bootstrap.SA_Low.df, bootstrap.GuaHigh.df, bootstrap.MexHigh.df, bootstrap.SW_US.df, bootstrap.MexLow.df)
bootstrap["lineType"] <- "bootstrap"
names(bootstrap)[2:3] <- c("time", "Ne")
head(bootstrap)
setwd("../")
Andes <- read.delim("Andes.msmc2.m0017.result.txt", header=F)
head(Andes)
Andes["population"] <- "Andes"
Andes[".id"] <- "Andes.Direct"
SA_Low <- read.delim("SA_Low.msmc2.m0017.result.txt", header=F)
SA_Low["population"] <- "SA_Low"
SA_Low[".id"] <- "SA_Low.Direct"
MexLow <- read.delim("MexLow.msmc2.m0017.result.txt", header=F)
MexLow["population"] <- "MexLow"
MexLow[".id"] <- "MexLow.Direct"
MexHigh <- read.delim("MexHigh.msmc2.m0017.result.txt", header=F)
MexHigh["population"] <- "MexHigh"
MexHigh[".id"] <- "MexHigh.Direct"
GuaHigh <- read.delim("GuaHigh.msmc2.m0017.result.txt", header=F)
GuaHigh["population"] <- "GuaHigh"
GuaHigh[".id"] <- "GuaHigh.Direct"
SW_US <- read.delim("SW_US.msmc2.m0017.result.txt", header=F)
SW_US["population"] <- "SW_US"
SW_US[".id"] <- "SW_US.Direct"
par <- read.delim("par.msmc2.m0017.result.txt", header=F)
par["population"] <- "parviglumis"
par[".id"] <- "par.Direct"
direct <- rbind(Andes, SA_Low, MexLow, MexHigh, GuaHigh, SW_US, par)
direct["lineType"] <- "direct"
names(direct)[1:2] <- c("time", "Ne")
direct <- direct[, c(4,1,2,3,5)]
df <- rbind(bootstrap, direct)

df1 <- subset(df, df$time<=10000)
df2 <- subset(df, df$time>10000)
p2_log <- ggplot(data=df1, aes(x=time, y=Ne, group=.id, color=population)) + geom_line(aes(linetype=lineType, size=lineType)) + scale_x_log10(limits=c(60, 10000), breaks=c(100, 1000, 10000)) + scale_y_log10(limits=c(1000, 30000000), breaks=c(3000, 10000, 100000, 1000000, 10000000)) + xlab("years before present") + ylab("effective population size") +  scale_linetype_manual(values=c(3, 1)) + scale_size_manual(values=c(0.5, 1)) + background_grid(minor="x", size.minor = 0.2, colour.minor = "grey98") + theme(legend.position="none")
p2_linear <-  ggplot(data=df2, aes(x=time, y=Ne, group=.id, color=population)) + geom_line(aes(linetype=lineType, size=lineType)) + scale_x_continuous(limits=c(10000, 100000), breaks=c(10000, 50000, 100000)) + scale_y_log10(limits=c(1000, 30000000), breaks=c(3000, 10000, 100000, 1000000, 10000000)) + xlab("years before present") + ylab("effective population size") +  theme(legend.position=c(0.9, 0.78)) + scale_linetype_manual(values=c(3, 1)) + scale_size_manual(values=c(0.5, 1))+ background_grid(minor = "x", size.minor = 0.2, colour.minor = "grey98")

plot_grid(p2_log, p2_linear)
ggsave("msmc2.new.pdf", width=14, height=7)

#background_grid(major = c("xy", "x", "y", "only_minor", "none"), minor = c("xy", "x", "y", "none"), size.major = 0.2, size.minor = 0.5, colour.major = "grey90", colour.minor = "grey98")
#background_grid(minor = "x", size.minor = 0.2, colour.minor = "grey98")


setwd("/Users/lwang/Wang_Private/demography/analyses/serialFounderEffects")
library(cowplot)
df <- read.delim("31genome.geoDis.perc.hetero.txt")
df <- df[-c(17,24), ]
lm_eqn = function(m) {
  l <- list(a = format(coef(m)[1], digits = 2),
      b = format(abs(coef(m)[2]), digits = 2),
      r = format(sqrt(summary(m)$r.squared), digits = 3),
      p = format(summary(m)$coefficients[2,4], digits=3));
  if (coef(m)[2] >= 0)  {
    eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(R)~"="~r*","~~
italic(P)~"="~p,l)
  } else {
    eq <- substitute(italic(y) == a - b %.% italic(x)*","~~italic(R)~"="~r*","~~italic(P)~"="~p,l)    
  }
  as.character(as.expression(eq));                 
}
                
names(df)[4] <- "populations"
p <- ggplot(df, aes(x=distance.km., y=perc.het)) + geom_smooth(method = "lm", color="black", formula = y ~ x) + geom_point(aes(color=populations), size=4) + xlab("geographical distance to Balsas Valley (km)") + ylab("percentage of heterozygous sites") 
summary(df$distance.km.)
p3 = p + geom_text(color="black", aes(x = 3200, y = 0.165, label = lm_eqn(lm(perc.het ~ distance.km., df))), parse = TRUE) + theme(legend.position=c(0.9, 0.8))

setwd("~/raster/")
ggdraw()
ggdraw() + 
draw_plot(p1, 0, 0, 0.5, 1) +
draw_plot(p2, 0.5, 0.5, 0.5, 0.5) +
draw_plot(p3, 0.5, 0, 0.5, 0.5) + 
draw_plot_label(c("A","B","C"), c(0, 0.5, 0.5), c(1, 1, 0.5))
savehistory("plotFigure1.R")
names(s.df)[1:2] <- c("longitude", "latitude")
ggdraw() + 
draw_plot(p1, 0, 0, 0.5, 1) +
draw_plot(p2, 0.5, 0.5, 0.5, 0.5) +
draw_plot(p3, 0.5, 0, 0.5, 0.5) + 
draw_plot_label(c("A","B","C"), c(0, 0.5, 0.5), c(1, 1, 0.5))
head(d.df)
head(s.df)
savehistory("plotFigure1.R")

ggdraw() + 
draw_plot(p2, 0, 1, 1, 0.5) +
draw_plot(p1, 0, 0, 0.5, 0.5) +
draw_plot(p3, 0.5, 0, 0.5, 0.5) + 
draw_plot_label(c("A","B","C"), c(0, 0, 0.5), c(0.5, 1, 0.5))

