library(cowplot)
###
library(cowplot)
library(viridis)
library(data.table)
df <- fread("fd_combine_skinny.txt")
chr3 <- subset(df, df$scaffold==3)
chr4 <- subset(df, df$scaffold==4)
chr6 <- subset(df, df$scaffold==6)

bob1 <- ggplot(data=chr3, aes(x=position/1000000, y=fd, group=population, color=population, alpha=population, size=population)) + geom_smooth(method="loess", formula = y ~ x, se=FALSE, span=0.1)  + ylab("fd")  +  xlab("") +
theme(legend.position="none") + 
ggtitle("chromosome 3") + 
coord_cartesian(ylim = c(0, 0.43)) +
scale_color_manual(values=c("grey", viridis(3)[1], "grey", "grey", "grey")) +
scale_alpha_manual(values=c(0.3, 1, 0.3, 0.3, 0.3)) +
scale_size_manual(values=c(0.3, 1, 0.3, 0.3, 0.3))

bob2 <- ggplot(data=chr3, aes(x=position/1000000, y=fd, group=population, color=population, alpha=population, size=population)) + geom_smooth(method="loess", formula = y ~ x, se=FALSE, span=0.1)  + ylab("fd")  + xlab("") +
theme(legend.position="none") + 
coord_cartesian(ylim = c(0, 0.43)) +
scale_color_manual(values=c("grey", "grey", viridis(3)[2], "grey", "grey")) +
scale_alpha_manual(values=c(0.3, 0.3, 1, 0.3, 0.3)) +
scale_size_manual(values=c(0.3, 0.3, 1, 0.3, 0.3))

bob3 <- ggplot(data=chr3, aes(x=position/1000000, y=fd, group=population, color=population, alpha=population, size=population)) + geom_smooth(method="loess", formula = y ~ x, se=FALSE, span=0.1) + xlab("physical position (Mb)") + ylab("fd")  + 
theme(legend.position="none") + 
coord_cartesian(ylim = c(0, 0.43)) +
scale_color_manual(values=c("grey", "grey", "grey", "grey", viridis(3)[3])) +
scale_alpha_manual(values=c(0.3, 0.3, 0.3, 0.3, 1)) +
scale_size_manual(values=c(0.3, 0.3, 0.3, 0.3, 1))

bob4 <- ggplot(data=chr4, aes(x=position/1000000, y=fd, group=population, color=population, alpha=population, size=population)) + geom_smooth(method="loess", formula = y ~ x, se=FALSE, span=0.1)  + xlab("") + ylab("") + 
theme(legend.position="none") + 
ggtitle("chromosome 4") + 
coord_cartesian(ylim = c(0, 0.43)) +
scale_color_manual(values=c("grey", viridis(3)[1], "grey", "grey", "grey")) +
scale_alpha_manual(values=c(0.3, 1, 0.3, 0.3, 0.3)) +
scale_size_manual(values=c(0.3, 1, 0.3, 0.3, 0.3))

bob5 <- ggplot(data=chr4, aes(x=position/1000000, y=fd, group=population, color=population, alpha=population, size=population)) + geom_smooth(method="loess", formula = y ~ x, se=FALSE, span=0.1)  + xlab("") + ylab("") + 
theme(legend.position="none") + 
coord_cartesian(ylim = c(0, 0.43)) +
scale_color_manual(values=c("grey", "grey", viridis(3)[2], "grey", "grey")) +
scale_alpha_manual(values=c(0.3, 0.3, 1, 0.3, 0.3)) +
scale_size_manual(values=c(0.3, 0.3, 1, 0.3, 0.3))

bob6 <- ggplot(data=chr4, aes(x=position/1000000, y=fd, group=population, color=population, alpha=population, size=population)) + geom_smooth(method="loess", formula = y ~ x, se=FALSE, span=0.1) + xlab("physical position (Mb)") + ylab("") + 
theme(legend.position="none") + 
coord_cartesian(ylim = c(0, 0.43)) +
scale_color_manual(values=c("grey", "grey", "grey", "grey", viridis(3)[3])) +
scale_alpha_manual(values=c(0.3, 0.3, 0.3, 0.3, 1)) +
scale_size_manual(values=c(0.3, 0.3, 0.3, 0.3, 1))

bob7 <- ggplot(data=chr6, aes(x=position/1000000, y=fd, group=population, color=population, alpha=population, size=population)) + geom_smooth(method="loess", formula = y ~ x, se=FALSE, span=0.1)  + ylab("fd")  +  xlab("") +
theme(legend.position="none") + 
ggtitle("chromosome 6") + 
coord_cartesian(ylim = c(0, 0.43)) +
scale_color_manual(values=c("grey", viridis(3)[1], "grey", "grey", "grey")) +
scale_alpha_manual(values=c(0.3, 1, 0.3, 0.3, 0.3)) +
scale_size_manual(values=c(0.3, 1, 0.3, 0.3, 0.3))

bob8 <- ggplot(data=chr6, aes(x=position/1000000, y=fd, group=population, color=population, alpha=population, size=population)) + geom_smooth(method="loess", formula = y ~ x, se=FALSE, span=0.1)  + ylab("fd")  + xlab("") +
theme(legend.position="none") + 
coord_cartesian(ylim = c(0, 0.43)) +
scale_color_manual(values=c("grey", "grey", viridis(3)[2], "grey", "grey")) +
scale_alpha_manual(values=c(0.3, 0.3, 1, 0.3, 0.3)) +
scale_size_manual(values=c(0.3, 0.3, 1, 0.3, 0.3))

bob9 <- ggplot(data=chr6, aes(x=position/1000000, y=fd, group=population, color=population, alpha=population, size=population)) + geom_smooth(method="loess", formula = y ~ x, se=FALSE, span=0.1) + xlab("physical position (Mb)") + ylab("fd")  + 
theme(legend.position="none") + 
coord_cartesian(ylim = c(0, 0.43)) +
scale_color_manual(values=c("grey", "grey", "grey", "grey", viridis(3)[3])) +
scale_alpha_manual(values=c(0.3, 0.3, 0.3, 0.3, 1)) +
scale_size_manual(values=c(0.3, 0.3, 0.3, 0.3, 1))


plot_grid(bob1, bob4, bob2, bob5, bob3, bob6, ncol=2, align="hv", labels=c("A", "D", "B", "E", "C", "F"))
ggsave("chr3.chr4.fd.track.pdf", dpi=300)

plot_grid(bob7, bob8, bob9, ncol=1, align="v")
ggsave("chr6.fd.track.pdf")

bob1 <- ggplot(data=chr3, aes(x=position/1000000, y=fd, group=population, color=population, alpha=population, size=population)) + geom_smooth(method="loess", formula = y ~ x, se=FALSE, span=0.1)  + ylab("fd")  +  xlab("") +
theme(legend.position="none", plot.margin=unit(c(0.5,-0.5,-0.5,0.5), "cm")) + 
ggtitle("chromosome 3") + 
coord_cartesian(ylim = c(0, 0.43)) +
scale_color_manual(values=c("grey", viridis(3)[1], "grey", "grey", "grey")) +
scale_alpha_manual(values=c(0.3, 1, 0.3, 0.3, 0.3)) +
scale_size_manual(values=c(0.3, 1, 0.3, 0.3, 0.3))


