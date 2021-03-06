rm=list(ls())
#读取数据库
library("reshape")
setwd('D:/数据库/1 传染病历史数据库/total/province')
total<-read.csv('total2015.csv',header=T)

#获取各年前2位的病种
attach(total)
data1<-total[fips==0  & month==0 & did!=0 & total$year>=2006 & did!=300 & category %in% c(1,2,22),]
detach(total)
data1<-data1[c(3,5,6,9:12)]
data1<-data1[order(data1$year,-data1$incidence),]
data2<-cbind(data1, rank=ave(-data1$incidence, data1$year, FUN=rank))
dis2<-data2[data2$rank %in% c(1,2),]

#获取各年各病种前5位的省份
attach(total)
data1<-total[fips!=0 & total$year>=2006 & month==0 ,]
detach(total)
data1<-data1[c(2,3,5,6,9:12)]
data1<-data1[data1$did==302,] #乙肝
data1<-data1[order(data1$year,-data1$incidence),]
data2<-cbind(data1, rank=ave(-data1$incidence, data1$year, FUN=rank))
pro5<-data2[data2$rank %in% c(1:5),]





#另一种添加序号的方法
if(F){
n <- unique(data1$year)
for (i in n) {
  data1$no[data1$year == i] <- 1:sum(data1$year == i)
}
data1
data1$no1 =rank(data1$year)
}



