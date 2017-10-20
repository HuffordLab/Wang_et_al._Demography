library(data.table)
library(tidyr)
library(dplyr)
library(cowplot)

#functions

sgerp<-function(gerp){ return((1.422761e-02+5.994283e-03*gerp)/171.187889848485)}


#Data

mbig<-fread("TeoMaize.mbig.txt",header=T)


#GERP>0

loadit<-function(countonly,homozygous){
if(countonly==FALSE){
  all$"0"=all$"0"*sgerp(0)
  all$"1"=all$"1"*sgerp(1)
  all$"2"=all$"2"*sgerp(2)
  all$"3"=all$"3"*sgerp(3)
  all$"4"=all$"4"*sgerp(4)
  all$"5"=all$"5"*sgerp(5)
  all$"6"=all$"6"*sgerp(6)
  all$GERP=sgerp(all$GERP)
}


all<-mutate(all,del.score=`0`*0+`1`*1+`2`*2+`3`*3+`4`*4+`5`*5+`6`*6)
colnames(all)[7]="der.alleles" #change from 7 to 8 because of different column id
all<-filter(all,(( GERP >=0 & REF != derived.allele) | REF == derived.allele))
all<-mutate(all, del.score=ifelse(REF!=derived.allele,ifelse(countonly,1,GERP),del.score))
all<-select(all,1:8,del.score)
all<-mutate(all,taxa=ifelse(substr(ind,1,3)=="RIM","maize","teosinte")) #define the pop when deal with maize data

if(homozygous){
  if(countonly){
    filter(all,der.alleles!="NA",der.alleles==2) %>% 
      group_by(taxa,ind) %>%   
      summarize(tot=sum(del.score*der.alleles/2))
  } else{
    filter(all,der.alleles!="NA",der.alleles==2) %>% 
      group_by(taxa,ind) %>%   
      summarize(load=-exp(-1*sum(del.score*der.alleles/2)))
  }
} else{
  if(countonly){
    filter(all,der.alleles!="NA") %>% 
      group_by(taxa,ind) %>%   
      summarize(tot=sum(del.score*der.alleles/2))
  } else{
    filter(all,der.alleles!="NA") %>% 
      group_by(taxa,ind) %>%   
      summarize(load=-exp(-1*sum(del.score*der.alleles/2)))
  }
}
}

all=mbig
lind=loadit(countonly=FALSE,homozygous=FALSE)
lind
group_by(lind,taxa) %>% summarize(wbar=mean(load))
write.table(lind, file="additive.GERP0.load.txt", quote=F, sep="\t", row.names=F)


all=mbig
lind=loadit(countonly=FALSE,homozygous=TRUE)
lind
group_by(lind,taxa) %>% summarize(wbar=mean(load))
write.table(lind, file="homo.GERP0.load.txt", quote=F, sep="\t", row.names=F)


all=mbig
temp=loadit(countonly=TRUE,homozygous=TRUE)
maxtot=mean(subset(temp$tot,temp$taxa=="teosinte"))
ggplot(temp)+
  geom_jitter(aes(y=tot/maxtot,x=taxa,color=taxa),size=4,width=0.25)+theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=18),axis.title.y = element_text(size=18))+
  xlab("")+
  ylab("relative load")+ylim(0.95,1.45)+
  ggtitle("homozygous GERP>0")
ggsave("countHomoDelteriousSites_GERP0.pdf")
write.table(temp, file="homo.GERP0.count.txt", sep="\t", quote=F, row.names=F)



all=mbig
temp=loadit(countonly=TRUE,homozygous=FALSE)
maxtot=mean(subset(temp$tot,temp$taxa=="teosinte"))
ggplot(temp)+
  geom_jitter(aes(y=tot/maxtot,x=taxa,color=taxa),size=4,width=0.25)+theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=18),axis.title.y = element_text(size=18))+
  xlab("")+
  ylab("relative load")+ylim(0.95,1.45)+
  ggtitle("total GERP>0")
ggsave("countHomoHeteroDelteriousSites_GERP0.pdf")
write.table(temp, file="additive.GERP0.count.txt", sep="\t", quote=F, row.names=F)


#GERP 0 to 2

loadit<-function(countonly,homozygous){
if(countonly==FALSE){
  all$"0"=all$"0"*sgerp(0)
  all$"1"=all$"1"*sgerp(1)
  all$"2"=all$"2"*sgerp(2)
  all$GERP=sgerp(all$GERP)
}


all<-mutate(all,del.score=`0`*0+`1`*1+`2`*2)
colnames(all)[7]="der.alleles" #change from 7 to 8 because of different column id
all<-filter(all,(( GERP >=0 & GERP<=2 & REF != derived.allele) | REF == derived.allele))
all<-mutate(all, del.score=ifelse(REF!=derived.allele,ifelse(countonly,1,GERP),del.score))
all<-select(all,1:8,del.score)
all<-mutate(all,taxa=ifelse(substr(ind,1,3)=="RIM","maize","teosinte")) #define the pop when deal with maize data

if(homozygous){
  if(countonly){
    filter(all,der.alleles!="NA",der.alleles==2) %>% 
      group_by(taxa,ind) %>%   
      summarize(tot=sum(del.score*der.alleles/2))
  } else{
    filter(all,der.alleles!="NA",der.alleles==2) %>% 
      group_by(taxa,ind) %>%   
      summarize(load=-exp(-1*sum(del.score*der.alleles/2)))
  }
} else{
  if(countonly){
    filter(all,der.alleles!="NA") %>% 
      group_by(taxa,ind) %>%   
      summarize(tot=sum(del.score*der.alleles/2))
  } else{
    filter(all,der.alleles!="NA") %>% 
      group_by(taxa,ind) %>%   
      summarize(load=-exp(-1*sum(del.score*der.alleles/2)))
  }
}
}





all=mbig
lind=loadit(countonly=FALSE,homozygous=FALSE)
lind
group_by(lind,taxa) %>% summarize(wbar=mean(load))
write.table(lind, file="additive.GERP02.load.txt", quote=F, sep="\t", row.names=F)


all=mbig
lind=loadit(countonly=FALSE,homozygous=TRUE)
lind
group_by(lind,taxa) %>% summarize(wbar=mean(load))
write.table(lind, file="homo.GERP02.load.txt", quote=F, sep="\t", row.names=F)



all=mbig
temp=loadit(countonly=TRUE,homozygous=TRUE)
maxtot=mean(subset(temp$tot,temp$taxa=="teosinte"))
ggplot(temp)+
  geom_jitter(aes(y=tot/maxtot,x=taxa,color=taxa),size=4,width=0.25)+theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=18),axis.title.y = element_text(size=18))+
  xlab("")+
  ylab("relative load")+ylim(0.95,1.45)+
  ggtitle("homozygous 0<GERP<2")
ggsave("countHomoDelteriousSites_GERP02.pdf")
write.table(temp, file="homo.GERP02.count.txt", sep="\t", quote=F, row.names=F)


all=mbig
temp=loadit(countonly=TRUE,homozygous=FALSE)
maxtot=mean(subset(temp$tot,temp$taxa=="teosinte"))
ggplot(temp)+
  geom_jitter(aes(y=tot/maxtot,x=taxa,color=taxa),size=4,width=0.25)+theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=18),axis.title.y = element_text(size=18))+
  xlab("")+
  ylab("relative load")+ylim(0.95,1.45)+
  ggtitle("total 0<GERP<2")
ggsave("countHomoHeteroDelteriousSites_GERP02.pdf")
write.table(temp, file="additive.GERP02.count.txt", sep="\t", quote=F, row.names=F)





# 2<=GERP<=4

loadit2<-function(countonly,homozygous){
if(countonly==FALSE){
  all$"2"=all$"2"*sgerp(2)
  all$"3"=all$"3"*sgerp(3)
  all$"4"=all$"4"*sgerp(4)
  all$GERP=sgerp(all$GERP)
}

all<-mutate(all,del.score=`2`*2+`3`*3+`4`*4)
colnames(all)[7]="der.alleles"
all<-filter(all,(( GERP >=2 & GERP <=4 & REF != derived.allele) | REF == derived.allele))
all<-mutate(all, del.score=ifelse(REF!=derived.allele,ifelse(countonly,1,GERP),del.score))
all<-select(all,1:8,del.score)
all<-mutate(all,taxa=ifelse(substr(ind,1,3)=="RIM","maize","teosinte"))

if(homozygous){
  if(countonly){
    filter(all,der.alleles!="NA",der.alleles==2) %>% 
      group_by(taxa,ind) %>%   
      summarize(tot=sum(del.score*der.alleles/2))
  } else{
    filter(all,der.alleles!="NA",der.alleles==2) %>% 
      group_by(taxa,ind) %>%   
      summarize(load=-exp(-1*sum(del.score*der.alleles/2)))
  }
} else{
  if(countonly){
    filter(all,der.alleles!="NA") %>% 
      group_by(taxa,ind) %>%   
      summarize(tot=sum(del.score*der.alleles/2))
  } else{
    filter(all,der.alleles!="NA") %>% 
      group_by(taxa,ind) %>%   
      summarize(load=-exp(-1*sum(del.score*der.alleles/2)))
  }
}

}



all=mbig
temp=loadit2(countonly=TRUE,homozygous=TRUE)
maxtot=mean(subset(temp$tot,temp$taxa=="teosinte"))
ggplot(temp)+
  geom_jitter(aes(y=tot/maxtot,x=taxa,color=taxa),size=4,width=0.25)+theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=18),axis.title.y = element_text(size=18))+
  xlab("")+
  ylab("relative load")+ylim(0.95,1.45)+
  ggtitle("homozygous 2<=GERP<=4")
ggsave("countHomoDelteriousSites_GERP24.pdf")
write.table(temp, file="homo.GERP24.count.txt", sep="\t", quote=F, row.names=F)



all=mbig
temp=loadit2(countonly=TRUE,homozygous=FALSE)
maxtot=mean(subset(temp$tot,temp$taxa=="teosinte"))
ggplot(temp)+
  geom_jitter(aes(y=tot/maxtot,x=taxa,color=taxa),size=4,width=0.25)+theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=18),axis.title.y = element_text(size=18))+
  xlab("")+
  ylab("relative load")+ylim(0.95,1.45)+
  ggtitle("total 2<=GERP<=4")
ggsave("countHomoHeteroDelteriousSites_GERP24.pdf")
write.table(temp, file="additive.GERP24.count.txt", sep="\t", quote=F, row.names=F)




all=mbig
lind=loadit2(countonly=FALSE,homozygous=TRUE)
lind
group_by(lind,taxa) %>% summarize(wbar=mean(load))
write.table(lind, file="homo.GERP24.load.txt", quote=F, sep="\t", row.names=F)



all=mbig
lind=loadit2(countonly=FALSE,homozygous=FALSE)
lind
group_by(lind,taxa) %>% summarize(wbar=mean(load))
write.table(lind, file="additive.GERP24.load.txt", quote=F, sep="\t", row.names=F)



#GERP -2 to 0

loaditneg2<-function(countonly,homozygous){
if(countonly==FALSE){
  all$"-2"=all$"-2"*sgerp(-2)
  all$"-1"=all$"-1"*sgerp(-1)
  all$"0"=all$"0"*sgerp(0)
  all$GERP=sgerp(all$GERP)
}

all<-mutate(all,del.score=`-2`*(-2)+`-1`*(-1)+`0`*0)
colnames(all)[7]="der.alleles"
all<-filter(all,(( GERP >=-2 & GERP <=0 & REF != derived.allele) | REF == derived.allele))
all<-mutate(all, del.score=ifelse(REF!=derived.allele,ifelse(countonly,1,GERP),del.score))
all<-select(all,1:8,del.score)
all<-mutate(all,taxa=ifelse(substr(ind,1,3)=="RIM","maize","teosinte"))

if(homozygous){
  if(countonly){
    filter(all,der.alleles!="NA",der.alleles==2) %>% 
      group_by(taxa,ind) %>%   
      summarize(tot=sum(del.score*der.alleles/2))
  } else{
    filter(all,der.alleles!="NA",der.alleles==2) %>% 
      group_by(taxa,ind) %>%   
      summarize(load=-exp(-1*sum(del.score*der.alleles/2)))
  }
} else{
  if(countonly){
    filter(all,der.alleles!="NA") %>% 
      group_by(taxa,ind) %>%   
      summarize(tot=sum(del.score*der.alleles/2))
  } else{
    filter(all,der.alleles!="NA") %>% 
      group_by(taxa,ind) %>%   
      summarize(load=-exp(-1*sum(del.score*der.alleles/2)))
  }
}
}




all=mbig
temp=loaditneg2(countonly=TRUE,homozygous=FALSE)
maxtot=mean(subset(temp$tot,temp$taxa=="teosinte"))
ggplot(temp)+
  geom_jitter(aes(y=tot/maxtot,x=taxa,color=taxa),size=4,width=0.25)+theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=18),axis.title.y = element_text(size=18))+
  xlab("")+
  ylab("relative load")+ylim(0.95,1.45)+
  ggtitle("total -2<GERP<0")
write.table(temp, file="additive.GERP-20.count.txt", sep="\t", quote=F, row.names=F)


all=mbig
temp=loaditneg2(countonly=TRUE,homozygous=TRUE)
maxtot=mean(subset(temp$tot,temp$taxa=="teosinte"))
ggplot(temp)+
  geom_jitter(aes(y=tot/maxtot,x=taxa,color=taxa),size=4,width=0.25)+theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=18),axis.title.y = element_text(size=18))+
  xlab("")+
  ylab("relative load")+ylim(0.95,1.45)+
  ggtitle("homoygous -2<GERP<0")
write.table(temp, file="homo.GERP-20.count.txt", sep="\t", quote=F, row.names=F)



all=mbig
lind=loaditneg2(countonly=FALSE,homozygous=TRUE)
lind
group_by(lind,taxa) %>% summarize(wbar=mean(load))
write.table(lind, file="homo.GERP-20.load.txt", quote=F, sep="\t", row.names=F)



all=mbig
lind=loaditneg2(countonly=FALSE,homozygous=FALSE)
lind
group_by(lind,taxa) %>% summarize(wbar=mean(load))
write.table(lind, file="additive.GERP-20.load.txt", quote=F, sep="\t", row.names=F)


#GERP >4

loadit4<-function(countonly,homozygous){
if(countonly==FALSE){
  all$"4"=all$"4"*sgerp(4)
  all$"5"=all$"5"*sgerp(5)
  all$"6"=all$"6"*sgerp(6)
  all$GERP=sgerp(all$GERP)
}

all<-mutate(all,del.score=`4`*4+`5`*5+`6`*6)
colnames(all)[7]="der.alleles"
all<-filter(all,(( GERP >=4 & REF != derived.allele) | REF == derived.allele))
all<-mutate(all, del.score=ifelse(REF!=derived.allele,ifelse(countonly,1,GERP),del.score))
all<-select(all,1:8,del.score)
all<-mutate(all,taxa=ifelse(substr(ind,1,3)=="RIM","maize","teosinte"))

if(homozygous){
  if(countonly){
    filter(all,der.alleles!="NA",der.alleles==2) %>% 
      group_by(taxa,ind) %>%   
      summarize(tot=sum(del.score*der.alleles/2))
  } else{
    filter(all,der.alleles!="NA",der.alleles==2) %>% 
      group_by(taxa,ind) %>%   
      summarize(load=-exp(-1*sum(del.score*der.alleles/2)))
  }
} else{
  if(countonly){
    filter(all,der.alleles!="NA") %>% 
      group_by(taxa,ind) %>%   
      summarize(tot=sum(del.score*der.alleles/2))
  } else{
    filter(all,der.alleles!="NA") %>% 
      group_by(taxa,ind) %>%   
      summarize(load=-exp(-1*sum(del.score*der.alleles/2)))
  }
}

}

all=mbig
temp=loadit4(countonly=TRUE,homozygous=TRUE)
maxtot=mean(subset(temp$tot,temp$taxa=="teosinte"))
ggplot(temp)+
  geom_jitter(aes(y=tot/maxtot,x=taxa,color=taxa),size=4,width=0.25)+theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=18),axis.title.y = element_text(size=18))+
  xlab("")+
  ylab("relative load")+ylim(0.95,1.45)+
  ggtitle("homozygous GERP>4")
ggsave("countHomoDelteriousSites_GERP4.pdf")
write.table(temp, file="homo.GERP4.count.txt", sep="\t", quote=F, row.names=F)


all=mbig
temp=loadit4(countonly=TRUE,homozygous=FALSE)
maxtot=mean(subset(temp$tot,temp$taxa=="teosinte"))
ggplot(temp)+
  geom_jitter(aes(y=tot/maxtot,x=taxa,color=taxa),size=4,width=0.25)+theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=18),axis.title.y = element_text(size=18))+
  xlab("")+
  ylab("relative load")+ylim(0.95,1.45)+
  ggtitle("total GERP>4")
ggsave("countHomoHeteroDelteriousSites_GERP4.pdf")
write.table(temp, file="additive.GERP4.count.txt", sep="\t", quote=F, row.names=F)


all=mbig
lind=loadit4(countonly=FALSE,homozygous=TRUE)
lind
group_by(lind,taxa) %>% summarize(wbar=mean(load))
write.table(lind, file="homo.GERP4.load.txt", quote=F, sep="\t", row.names=F)

all=mbig
lind=loadit4(countonly=FALSE,homozygous=FALSE)
lind
group_by(lind,taxa) %>% summarize(wbar=mean(load))
write.table(lind, file="additive.GERP4.load.txt", quote=F, sep="\t", row.names=F)





#fixed vs seg
### Gerp 0

all<-mbig
all<-mutate(all,del.score=`0`*0+`1`*1+`2`*2+`3`*3+`4`*4+`5`*5+`6`*6)
colnames(all)[7]="der.alleles"
all<-filter(all,(( GERP >=0 & REF != derived.allele) | REF == derived.allele))
all<-mutate(all, del.score=ifelse(REF!=derived.allele,1,del.score))
all<-select(all,1:8,del.score)
all<-mutate(all,taxa=ifelse(substr(ind,1,3)=="RIM","maize","teosinte"))
all <- filter(all, der.alleles!="NA")
fixseg<-group_by(all,chrompos,pop) %>%
  summarize(f=sum(der.alleles/2))
df.fixed <- filter(fixseg,((f==4 & taxa == "teosinte") | (f==5 & taxa=="maize"))) %>% group_by(taxa) %>% summarize(fixed=n())
df.seg <- filter(fixseg, (f>0 & ((f<4 & taxa == "teosinte") | (f<5 & taxa=="maize")))) %>% group_by(taxa) %>% summarize(seg=n())
df.fixed.seg <- merge(df.fixed, df.seg)
write.table(df.fixed.seg, file="GERP0.fixedSeg.txt", quote=F, sep="\t", row.names=F)
df.fixedSeg <- melt(df.fixed.seg, id.vars="taxa")
ggplot(df.fixedSeg, aes(x=taxa,y=value, fill=variable, color=variable))+
  stat_summary(fun.y=mean,position=position_dodge(),geom="bar")+
  theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=10),axis.title.y = element_text(size=14))+
  xlab("")+
  ylab("number of deleterious sites at population level")+
  ggtitle("GERP>0")
ggsave("GERP0.fixedSeg.pdf")


### Gerp -2 to 0
all<-mbig
all<-mutate(all,del.score=`-2`*(-2)+`-1`*(-1)+`0`*0)
colnames(all)[7]="der.alleles"
all<-filter(all,(( GERP >=-2 & GERP <=0 & REF != derived.allele) | REF == derived.allele))
all<-mutate(all, del.score=ifelse(REF!=derived.allele,1,del.score))
all<-select(all,1:8,del.score)
all<-mutate(all,taxa=ifelse(substr(ind,1,3)=="RIM","maize","teosinte"))
all <- filter(all, der.alleles!="NA")
fixseg<-group_by(all,chrompos,pop) %>%
  summarize(f=sum(der.alleles/2))
df.fixed <- filter(fixseg,((f==4 & taxa == "teosinte") | (f==5 & taxa=="maize"))) %>% group_by(taxa) %>% summarize(fixed=n())
df.seg <- filter(fixseg, (f>0 & ((f<4 & taxa == "teosinte") | (f<5 & taxa=="maize")))) %>% group_by(taxa) %>% summarize(seg=n())
df.fixed.seg <- merge(df.fixed, df.seg)
write.table(df.fixed.seg, file="GERP-20.fixedSeg.txt", quote=F, sep="\t", row.names=F)
df.fixedSeg <- melt(df.fixed.seg, id.vars="taxa")
ggplot(df.fixedSeg, aes(x=taxa,y=value, fill=variable, color=variable))+
  stat_summary(fun.y=mean,position=position_dodge(),geom="bar")+
  theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=10),axis.title.y = element_text(size=14))+
  xlab("")+
  ylab("number of deleterious sites at population level")+
  ggtitle("-2<GERP<=0")
ggsave("GERP-20.fixedSeg.pdf")


### Gerp 0 to 2

all<-mbig
all<-mutate(all,del.score=`0`*0+`1`*1+`2`*2)
colnames(all)[7]="der.alleles"
all<-filter(all,(( GERP >=0 & GERP <=2 & REF != derived.allele) | REF == derived.allele))
all<-mutate(all, del.score=ifelse(REF!=derived.allele,1,del.score))
all<-select(all,1:8,del.score)
all<-mutate(all,taxa=ifelse(substr(ind,1,3)=="RIM","maize","teosinte"))
all <- filter(all, der.alleles!="NA")
fixseg<-group_by(all,chrompos,pop) %>%
  summarize(f=sum(der.alleles/2))
df.fixed <- filter(fixseg,((f==4 & taxa == "teosinte") | (f==5 & taxa=="maize"))) %>% group_by(taxa) %>% summarize(fixed=n())
df.seg <- filter(fixseg, (f>0 & ((f<4 & taxa == "teosinte") | (f<5 & taxa=="maize")))) %>% group_by(taxa) %>% summarize(seg=n())
df.fixed.seg <- merge(df.fixed, df.seg)
write.table(df.fixed.seg, file="GERP02.fixedSeg.txt", quote=F, sep="\t", row.names=F)
df.fixedSeg <- melt(df.fixed.seg, id.vars="taxa")
ggplot(df.fixedSeg, aes(x=taxa,y=value, fill=variable, color=variable))+
  stat_summary(fun.y=mean,position=position_dodge(),geom="bar")+
  theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=10),axis.title.y = element_text(size=14))+
  xlab("")+
  ylab("number of deleterious sites at population level")+
  ggtitle("0<GERP<=2")
ggsave("GERP02.fixedSeg.pdf")


### Gerp 2 to 4

all<-mbig
all<-mutate(all,del.score=`2`*2+`3`*3+`4`*4)
colnames(all)[7]="der.alleles"
all<-filter(all,(( GERP >=2 & GERP <=4 & REF != derived.allele) | REF == derived.allele))
all<-mutate(all, del.score=ifelse(REF!=derived.allele,1,del.score))
all<-select(all,1:8,del.score)
all<-mutate(all,taxa=ifelse(substr(ind,1,3)=="RIM","maize","teosinte"))
all <- filter(all, der.alleles!="NA")
fixseg<-group_by(all,chrompos,pop) %>%
  summarize(f=sum(der.alleles/2))
df.fixed <- filter(fixseg,((f==4 & taxa == "teosinte") | (f==5 & taxa=="maize"))) %>% group_by(taxa) %>% summarize(fixed=n())
df.seg <- filter(fixseg, (f>0 & ((f<4 & taxa == "teosinte") | (f<5 & taxa=="maize")))) %>% group_by(taxa) %>% summarize(seg=n())
df.fixed.seg <- merge(df.fixed, df.seg)
write.table(df.fixed.seg, file="GERP24.fixedSeg.txt", quote=F, sep="\t", row.names=F)
df.fixedSeg <- melt(df.fixed.seg, id.vars="taxa")
ggplot(df.fixedSeg, aes(x=taxa,y=value, fill=variable, color=variable))+
  stat_summary(fun.y=mean,position=position_dodge(),geom="bar")+
  theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=10),axis.title.y = element_text(size=14))+
  xlab("")+
  ylab("number of deleterious sites at population level")+
  ggtitle("2<GERP<=4")
ggsave("GERP24.fixedSeg.pdf")


### Gerp >4

all<-mbig
all<-mutate(all,del.score=`4`*4+`5`*5+`6`*6)
colnames(all)[7]="der.alleles"
all<-filter(all,(( GERP >=4 & REF != derived.allele) | REF == derived.allele))
all<-mutate(all, del.score=ifelse(REF!=derived.allele,1,del.score))
all<-select(all,1:8,del.score)
all<-mutate(all,taxa=ifelse(substr(ind,1,3)=="RIM","maize","teosinte"))
all <- filter(all, der.alleles!="NA")
fixseg<-group_by(all,chrompos,pop) %>%
  summarize(f=sum(der.alleles/2))
df.fixed <- filter(fixseg,((f==4 & taxa == "teosinte") | (f==5 & taxa=="maize"))) %>% group_by(taxa) %>% summarize(fixed=n())
df.seg <- filter(fixseg, (f>0 & ((f<4 & taxa == "teosinte") | (f<5 & taxa=="maize")))) %>% group_by(taxa) %>% summarize(seg=n())
df.fixed.seg <- merge(df.fixed, df.seg)
write.table(df.fixed.seg, file="GERP4.fixedSeg.txt", quote=F, sep="\t", row.names=F)
df.fixedSeg <- melt(df.fixed.seg, id.vars="taxa")
ggplot(df.fixedSeg, aes(x=taxa,y=value, fill=variable, color=variable))+
  stat_summary(fun.y=mean,position=position_dodge(),geom="bar")+
  theme(axis.text.y = element_text(size=10),axis.text.x = element_text(size=10),axis.title.y = element_text(size=14))+
  xlab("")+
  ylab("number of deleterious sites at population level")+
  ggtitle("GERP>4")
ggsave("GERP4.fixedSeg.pdf")
