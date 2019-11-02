ee = c(0,0.16,0.32,0.48,0.64,0.8,1.6,2.4,3.2,4,4.8,5.6,6.4,7.2,8)
uu = c(0,14863,16630,17231,17539,17681,17982,18037,18052,18085,18105,18084,18103,18105,18093)
ii = round(uu/18280,4)
data = as.data.frame(cbind(ee,uu,ii))

f <- nls(uu ~ -a/(ee+c) + b,start=list(a = 400, b = -49, c = 0.025), data=data, trace=T)

library(scales)
ggplot(data,aes(ee, uu))+
  geom_point(size=3)+geom_line(aes(ee,fitted(f)),col='red')+
  xlab("Data/G")+
  ylab("Gene number")+
  geom_text(aes(label = uu, vjust = 1.1 , hjust = -0.5, angle = -45),size = 3.5, show_guide = FALSE)


fp <- nls(ii ~ -a/(ee+c) + b,start=list(a = 400, b = -49, c = 0.025), data=data, trace=T)

library(scales)
ggplot(data,aes(ee, ii))+
  geom_point(size=3)+geom_line(aes(ee,fitted(fp)),col='red')+
  xlab("Data/G")+
  ylab("Gene number percent")+
  geom_text(aes(label = uu, vjust = 1.1 , hjust = -0.5,angle = -45),size = 3.5, show_guide = FALSE)+
  scale_y_continuous(labels = percent)
