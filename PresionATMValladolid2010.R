#install.packages("lubridate")
##install.packages("gridExtra")
library(gridExtra)
library(tidyverse)
library(readxl)
library(ggplot2)
library(lubridate)


source("../../../GraficasSitosdeEstudio.R")

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
PO1718_1 <- PO1718_1[,c(2,11)]



#OJO tienen diferentes tasas de muestreo? 
#PO18_1 es cada 10 min 
#PO18_2 10 min 
#PO17_1 10 min

#Cambiamos los ejes

colnames(PO1718_1)<- c("Tiempo","PresionATM")


ggplot() +
  geom_line(data = PO1718_1, aes(x=Tiempo, y=PresionATM))+
 #geom_line(data=PO18_1, aes(x = Fecha.Tiempo, y = BP.mbar.))+
  #geom_line(data=PO18_2, aes(x = Fecha.Tiempo, y = BP.mbar.))+
  #geom_line(data=PO17_1, aes(x = Fecha.Tiempo, y = BP.mbar.))+
 geom_line(data=Manglares, aes(x=fecha, y=presion, color=tipo))+
  xlab("Fecha")+
  labs(color = "Archivo y Fecha ")+
  ylab("Presión (mbar) ")+
  ggtitle("Presión Atmosferica Progreso 2017-2018 y niveles de manglar ")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_x_datetime(limits = c(as.POSIXct("2018-03-18"), as.POSIXct("2018-08-25")))


PO1718_1<-rename(PO1718_1,Fecha=Tiempo)
Manglares<-rename(Manglares,Fecha=fecha)

#Para iniciar unir presiones con manglaresseleccionar el tipo de manglar PRIMERO AVICENIAS 

#Selcccion tipo de manglar 


tipo<-distinct(Manglares,tipo)

tipo
view(tipo)
entrada<- readline(prompt="Tipo de manglar; ")


NivelesAvicenias<-Manglares[Manglares$tipo==entrada,]%>%drop_na()


NivelesAvicenias<-left_join(NivelesAvicenias,PO1718_1)%>%drop_na()

#Se restan los nieles 
NivelesAvicenias$corregido<-NivelesAvicenias$presion-NivelesAvicenias$PresionATM


d<-ggplot()+
  geom_line(data=NivelesAvicenias,aes(x=Fecha,y=presion, color="presion sensor"))+
  geom_line(data=NivelesAvicenias,aes(x=Fecha,y=PresionATM, color="presion atmosferica"))
s<-ggplot()+
  geom_line(data=NivelesAvicenias,aes(x=Fecha,y=corregido, color="nivel orregido"))
 
grid.arrange(d,s,nrow=2) 




