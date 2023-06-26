#Vamos a hacerlo por manglar 
setwd("./DatosManglarGMT6/Avicenias/")

library(tidyverse)
library(ggplot2)
library(lubridate)



setwd("../Avicenias/")

temp = list.files(pattern="*.csv")

for (i in 1:length(temp)){
  assign(temp[i], read.csv(temp[i]))
}

colnames(Avicenias_11Junio18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Avicenias_20JunJul18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Avicenias_24AgosSep18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Avicenias_24Mayo18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Avicenias_9Abril18.csv)<-c("n","fecha","presionMbar", "tempC")

Avicenias<-rbind(Avicenias_11Junio18.csv,Avicenias_20JunJul18.csv,Avicenias_24AgosSep18.csv,Avicenias_24Mayo18.csv,Avicenias_9Abril18.csv)

rm(list=ls()[! ls() %in% c("Avicenias")])

Avicenias<-Avicenias[,2:4]%>%na.omit()

Avicenias$fecha<-as.POSIXct(strptime(Avicenias$fecha, format = "%m/%d/%Y %I:%M:%S %p" ))
Avicenias$tempC<-Avicenias$tempC/1000
Avicenias$Tipo<-c("Avicenias")


#write.csv(Avicenias,"./AviceniasCorregido.csv")

#Ahora por los chaparros 

setwd("../Chaparro/")

temp = list.files(pattern="*.csv")

for (i in 1:length(temp)){
  assign(temp[i], read.csv(temp[i]))
}

colnames(Chaparro_10JunJul18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Chaparro_11Junio18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Chaparro_24AgosSep18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Chaparro_24Mayo18.csv)<-c("n","fecha","presionMbar", "tempC")

#corregimos el valor del Chaparrro de mmHg a mmbar 

colnames(Chaparro_9Abril18.csv)<-c("n","fecha","presionMmHg", "tempC")
Chaparro_9Abril18.csv$presionMmHg<-Chaparro_9Abril18.csv$presionMmHg*1.33
colnames(Chaparro_9Abril18.csv)<-c("n","fecha","presionMbar", "tempC")
str(Chaparro_9Abril18.csv)


Chaparro<-rbind(Chaparro_10JunJul18.csv,Chaparro_11Junio18.csv,Chaparro_24AgosSep18.csv,Chaparro_24Mayo18.csv,Chaparro_9Abril18.csv)

Chaparro<-Chaparro[,2:4]

Chaparro$Tipo<-c("Chaparro")

Chaparro$fecha<-as.POSIXct(strptime(Chaparro$fecha, format ="%m/%d/%Y %I:%M:%S %p" ))

rm(list=ls()[! ls() %in% c("Chaparro","Avicenias")])

setwd("../Cuenca_Adentro/")

temp = list.files(pattern="*.csv")

for (i in 1:length(temp)){
  assign(temp[i], read.csv(temp[i]))
}

colnames(Cuenca_Adentro_11Junio18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Cuenca_Adentro_20JunJul18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Cuenca_Adentro_24AgosSep18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Cuenca_Adentro_24Mayo18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Cuenca_Adentro_9Abril18.csv)<-c("n","fecha","presionMbar", "tempC")

Cuenca_Adentro<-rbind(Cuenca_Adentro_11Junio18.csv,Cuenca_Adentro_20JunJul18.csv,Cuenca_Adentro_24AgosSep18.csv,Cuenca_Adentro_24Mayo18.csv,Cuenca_Adentro_9Abril18.csv)

Cuenca_Adentro<-Cuenca_Adentro[,2:4]%>%na.omit()
Cuenca_Adentro$Tipo<-c("Cuenca_Adentro")

Cuenca_Adentro$fecha<-as.POSIXct(strptime(Cuenca_Adentro$fecha, format = "%m/%d/%Y %I:%M:%S %p"))




rm(list=ls()[! ls() %in% c("Chaparro","Avicenias", "Cuenca_Adentro")])


setwd("../Cuenca_Afuera/")

temp = list.files(pattern="*.csv")

for (i in 1:length(temp)){
  assign(temp[i], read.csv(temp[i]))
}

colnames(Cuenca__Afuera_11Junio18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Cuenca__Afuera_20JunJul18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Cuenca__Afuera_24AgosSep18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Cuenca__Afuera_24MAyo18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Cuenca__Afuera_9Abril18.csv)<-c("n","fecha","presionMbar", "tempC")


Cuenca_Afuera<-rbind(Cuenca__Afuera_11Junio18.csv,Cuenca__Afuera_20JunJul18.csv,
                     Cuenca__Afuera_24AgosSep18.csv,Cuenca__Afuera_24MAyo18.csv,
                     Cuenca__Afuera_9Abril18.csv)

Cuenca_Afuera<-Cuenca_Afuera[,2:4]%>%na.omit()
Cuenca_Afuera$Tipo<-c("Cuenca_Afuera")

Cuenca_Afuera$fecha<-as.POSIXct(strptime(Cuenca_Afuera$fecha, format = "%m/%d/%Y %I:%M:%S %p"))


rm(list=ls()[! ls() %in% c("Chaparro","Avicenias", "Cuenca_Adentro",
                           "Cuenca_Afuera")])


setwd("../Franja/")

temp = list.files(pattern="*.csv")

for (i in 1:length(temp)){
  assign(temp[i], read.csv(temp[i]))
}

colnames(Franja_Cel_11Junio18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Franja_Cel_20JunJul18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Franja_Cel_24AgosSep18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Franja_Cel_24Mayo18.csv)<-c("n","fecha","presionMbar", "tempC")
colnames(Franja_Cel_9Abril18.csv)<-c("n","fecha","presionMbar", "tempC")

Franja_Cel<-rbind(Franja_Cel_11Junio18.csv,Franja_Cel_20JunJul18.csv,
                  Franja_Cel_24AgosSep18.csv,Franja_Cel_24Mayo18.csv,
                  Franja_Cel_9Abril18.csv)

Franja_Cel<-Franja_Cel[,2:4]%>%na.omit()
Franja_Cel$Tipo<-c("Franja_cel")

Franja_Cel$fecha<-as.POSIXct(strptime(Franja_Cel$fecha, format ="%m/%d/%Y %I:%M:%S %p"))


rm(list=ls()[! ls() %in% c("Chaparro","Avicenias", "Cuenca_Adentro",
                           "Cuenca_Afuera","Franja_Cel")])



#Ahora hacemos la correción de datos de presión 

#Agregamos los datos de presión 
PO18_1<-read.csv("../../DatosATMPresion/Progreso18/PO18_1_1.csv")
PO18_2 <- read.csv("../../DatosATMPresion/Progreso18/PO18_2_1.csv")

PO18_1<-PO18_1[,c(2,4,11)]%>%na.omit()
PO18_2<-PO18_2[,c(2,4,11)]%>%na.omit()

colnames(PO18_1)<-c("fecha","PrecipitacionMm","atmPresionMbar")
colnames(PO18_2)<-c("fecha","PrecipitacionMm","atmPresionMbar")

PO18_1$fecha<-as.POSIXct(strptime(PO18_1$fecha, format="%d/%m/%Y %I:%M:%S %p"))
PO18_2$fecha<-as.POSIXct(strptime(PO18_2$fecha, format = "%d/%m/%Y %H:%M"))

PO18_1$ArchivoPresion<-c("PO18_1")
PO18_2$ArchivoPresion<-c("PO18_2")

PresionATM<-rbind(PO18_1,PO18_2)

PresionATM$FechaChar<-as.character(PresionATM$fecha)

PresionATMChr<-PresionATM[!duplicated(PresionATM$FechaChar),]
PresionATMSr<-PresionATM[!duplicated.POSIXlt(PresionATM$fecha),]


ggplot()+
   geom_line(data=PresionATMChr,aes(x=fecha,y=atmPresionMbar, color=ArchivoPresion))+
   scale_x_datetime(limits = c(as.POSIXct("2018-01-01"), as.POSIXct("2018-12-03")))

#hacemos un df por hora del intervalo de tiempo que necesitamos 

FechaInicio<-as.POSIXct("2018-01-01 00:00:00")
FechaFinal<-as.POSIXct("2018-10-13 07:20:00")
Tiempo<-as.data.frame(seq(FechaInicio,FechaFinal, by="hours"))
colnames(Tiempo)<-c("FechaChar")

Tiempo$FechaChar<-as.character(Tiempo$FechaChar)

PresionATMc<-left_join(Tiempo,PresionATMChr)%>%na.omit()

#vemos que tenemos 6847 datos pero hay algunos que son NA, descartamos los NA y quedan 6758 datos 

ggplot()+
  geom_line(data=PresionATMc,aes(x=fecha,y=atmPresionMbar,color=ArchivoPresion))+
  scale_x_datetime(limits = c(as.POSIXct("2018-01-01"), as.POSIXct("2018-10-13")))

#Ahora que ya tenemos los valores de presión atm y los de manglares, podemos poner una columa dentro de cada df de manglares que indique la presión de la atm en ese momento de tiempo. Eliminamos aquellos que son NA 

AviceniasATM<-left_join(Avicenias,PresionATMc)%>%na.omit()

(3727*100)/3783

ChaparroATM<-left_join(Chaparro,PresionATMc)%>%na.omit()


Cuenca_AdentroATM<-left_join(Cuenca_Adentro,PresionATMc)%>%na.omit()

Cuenca_AfueraATM<-left_join(Cuenca_Afuera,PresionATMc)%>%na.omit()

Franja_CelATM<-left_join(Franja_Cel,PresionATMc)%>%na.omit()

f<-ggplot()+
  geom_line(data=AviceniasATM,aes(x=fecha,y=presionMbar, color=Tipo))+
  geom_line(data=Cuenca_AdentroATM,aes(x=fecha,y=presionMbar, color=Tipo))+
  geom_line(data=Cuenca_AfueraATM,aes(x=fecha,y=presionMbar, color=Tipo))+
  geom_line(data=ChaparroATM,aes(x=fecha,y=presionMbar, color=Tipo))+
  geom_line(data=Franja_CelATM,aes(x=fecha,y=presionMbar, color=Tipo))+
  scale_x_datetime(limits = c(as.POSIXct("2018-04-01"),as.POSIXct("2018-08-03")))
d<-ggplot()+
  geom_line(data=AviceniasATM,aes(x=fecha,y=presionMbar, color=Tipo))+
  geom_line(data=Cuenca_AdentroATM,aes(x=fecha,y=presionMbar, color=Tipo))+
  geom_line(data=Cuenca_AfueraATM,aes(x=fecha,y=presionMbar, color=Tipo))+
  geom_line(data=ChaparroATM,aes(x=fecha,y=presionMbar, color=Tipo))+
  geom_line(data=Franja_CelATM,aes(x=fecha,y=presionMbar, color=Tipo))+
  scale_x_datetime(limits = c(as.POSIXct("2018-04-01"),as.POSIXct("2018-05-03")))

gridExtra::grid.arrange(f,d)
