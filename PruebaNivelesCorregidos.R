#

Cuenca_Afuera<-Manglares[Manglares$tipo=="Cuenca_Afuera",]%>%rename(.,Fecha=fecha)

#Ahora le restamos los niveles de presión 
NivelesCuenca_Afuera<-left_join(Cuenca_Afuera,PO1718_1)
#Se restan los nieles 
NivelesCuenca_Afuera$corregido<-NivelesCuenca_Afuera$presion-NivelesCuenca_Afuera$BP.mbar.


d<-ggplot()+
  geom_line(data=NivelesCuenca_Afuera,aes(x=Fecha,y=presion, color="presion sensor"))+
  geom_line(data=NivelesCuenca_Afuera,aes(x=Fecha,y=BP.mbar., color="presion atmosferica"))


NivelesCuenca_Afuera<-NivelesCuenca_Afuera[NivelesCuenca_Afuera$corregido>=0,]%>%drop_na()

ggplot()+
  geom_line(data=NivelesCuenca_Afuera,aes(x=Fecha,y=corregido, color="nivel orregido"))+
  ggtitle("Presión corregida Niveles>=0 mbar")+
  scale_x_datetime(limits = c(as.POSIXct("2018-03-18"), as.POSIXct("2018-05-25")))+
  theme_linedraw()

grid.arrange(d,s,nrow=2) 


##########################################


Cuenca_Afuera<-Manglares[Manglares$tipo=="Cuenca_Afuera",]%>%rename(.,Fecha=fecha)

#Ahora le restamos los niveles de presión 
NivelesCuenca_Afuera<-left_join(Cuenca_Afuera,PO1718_1)
#Se restan los nieles 
NivelesCuenca_Afuera$corregido<-NivelesCuenca_Afuera$presion-NivelesCuenca_Afuera$BP.mbar.


d<-ggplot()+
  geom_line(data=NivelesCuenca_Afuera,aes(x=Fecha,y=presion, color="presion sensor"))+
  geom_line(data=NivelesCuenca_Afuera,aes(x=Fecha,y=BP.mbar., color="presion atmosferica"))+
  ggtitle(paste("Presion",NivelesAvicenias$tipo))+
  theme_linedraw()


NivelesCuenca_Afuera<-NivelesCuenca_Afuera[NivelesCuenca_Afuera$corregido>0,]%>%drop_na()

s<-ggplot()+
  geom_line(data=NivelesCuenca_Afuera,aes(x=Fecha,y=corregido, color="nivel orregido"))+
  ggtitle(paste("Presion",NivelesCuenca_Afuera$tipo))+
  theme_linedraw()
 
grid.arrange(d,s,nrow=2) 
