#hacemos el df para todo los manglares

PO18_1<-read.csv("../../../../DatosMAnglar/PresionesYuctán/CGSMN-B00.8.-23-0000154/P_18_1c.csv")
PO18_2 <- read.csv("../../../../DatosMAnglar/PresionesYuctán/CGSMN-B00.8.-23-0000154/PROGRESO_2018_02.csv")
PO17_1<- read.csv("../../../../DatosMAnglar/PresionesYuctán/CGSMN-B00.8.-23-0000154/P_17_1c.csv")

#Cambiamos los formatos de dehcas 

PO18_1$Fecha.Tiempo<-as.POSIXct(strptime(PO18_1$Fecha.Tiempo, format="%d/%m/%Y %I:%M:%S %p"))
str(PO18_1)
PO18_2$Fecha.Tiempo<- as.POSIXct(strptime(PO18_2$Fecha.Tiempo, format="%d/%m/%Y %H:%M"))
str(PO18_2)
PO17_1$Fecha.Tiempo<-as.POSIXct(strptime(PO17_1$Fecha.Tiempo, format = "%d/%m/%Y %I:%M:%S %p"))
str(PO17_1)


PO1718_1<- rbind(PO17_1,PO18_1,PO18_2) %>% drop_na()
PO1718_1 <- PO1718_1[,c(2,11)]%>%rename(.,Fecha=Fecha.Tiempo)

Manglares<-rename(Manglares,fecha=Fecha)

Avicenias<-Manglares[Manglares$tipo=="Avicenias",]%>%rename(.,Fecha=fecha)%>%drop_na()
#Ahora le restamos los niveles de presión 
NivelesAvicenias<-left_join(Avicenias,PO1718_1)
#Se restan los nieles 
NivelesAvicenias$corregido<-NivelesAvicenias$presion-NivelesAvicenias$BP.mbar


NivelesAvicenias<-drop_na(NivelesAvicenias)


d<-ggplot()+
  geom_line(data=NivelesAvicenias,aes(x=Fecha,y=presion, color="presion sensor"))+
  geom_line(data=NivelesAvicenias,aes(x=Fecha,y=BP.mbar., color="presion atmosferica"))+
  scale_x_datetime(limits = c(as.POSIXct("2018-02-18"), as.POSIXct("2018-09-25")))

s<-ggplot()+
  geom_line(data=NivelesAvicenias,aes(x=Fecha,y=corregido, color="nivel orregido"))+
  scale_x_datetime(limits = c(as.POSIXct("2018-02-18"), as.POSIXct("2018-09-25")))
grid.arrange(d,s,nrow=2) 
