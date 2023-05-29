
#Importamos los datos en este caso los csv del 2018 

setwd("../../Prueba/P2018/")

temp = list.files(pattern="*.csv")

for (i in 1:length(temp)){
  assign(temp[i], read.csv(temp[i]))
}

#los que podemos hacer es unir todos los df por tipo de manglar

Avicenias<-rbind(Avicenias_11junio18.csv,Avicenias_20JunJul18.csv,Avicenias_24AgoSep18.csv,Avicenias_24May18.csv,Avicenias_abril18.csv)
Avicenias<-Avicenias[,2:4]
colnames(Avicenias)<-c("fecha","presion mbar","temperatura C")
Avicenias$tipo<-c("Avicenia")

Cuenca_afuera<-rbind(Cuenca__Afuera_11junio18.csv,Cuenca__Afuera_20JunJul18.csv,Cuenca__Afuera_24AgoSep18.csv,Cuenca__Afuera_24May18.csv)
Cuenca_afuera<-Cuenca_afuera[,2:4]
colnames(Cuenca_afuera)<-c("fecha","presion mbar","temperatura C")
Cuenca_afuera$tipo<-c("cuenca-afuera")

Franja<-rbind(Franja_Cel_11junio18.csv,Franja_Cel_20JunJul18.csv,Franja_Cel_24AgoSep18.csv,Franja_Cel_24May18.csv,Franja_Cel_abril18.csv)
Franja<-Franja[,2:4]
colnames(Franja)<-c("fecha","presion mbar","temperatura C")
Franja$tipo<-c("franja")

#Unimos todos el df de manglar 
Manglares <- rbind(Avicenias,Franja,Cuenca_afuera)

rm(list=ls()[!ls() %in% c("Avicenias","Franja","Cuenca_afuera","Manglares")])

#Ahora al df de manglares le podemos hacer el cambio a formato de fecha 
Manglares$fecha<-as.POSIXct(strptime(Manglares$fecha, format ="%m/%d/%Y %I:%M:%S %p"))

#Eliminamos los NA 
Manglares<-drop_na(Manglares)

#Agregamos los datos de presión 
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

#cambniamos los nombres de las columnas de los datos de presión 
colnames(PO1718_1)<- c("fecha","presion mbar atm")

#Ahora podemos unir los df de presiones de manglares y presion atm 

Manglares<- left_join(Manglares,PO1718_1)%>%drop_na()

#ahora calculamos la presion del nivel del manglar corregido con la presion atm 
Manglares$presionMbarCorregido<-Manglares$`presion mbar`- Manglares$`presion mbar atm` 


library(ggplot2)

ggplot()+
  geom_line(data=Manglares,aes(x=fecha, y = Manglares$`temperatura C`, color=tipo))+
  ylim(20,27)+
  theme_light()+
  ylab("Presion atm")+
  xlab("fecha")+
  ggtitle("Nivel presion inundación manglares celestun")





#Por alguna razón fallo la importación de chaparro 18 abiril y esta en mmHg. HAcemos la conversión 

Chaparro_abril18.csv$X.mm.Hg..mbar.<-Chaparro_abril18.csv$X.mm.Hg..mbar.*1.33
rename(Chaparro_abril18.csv,X.mbar..mbar.=X.mm.Hg..mbar.)

head(Chaparro_20JunJul18.csv)


Chaparro<- rbind(Chaparro_11junio18.csv,Chaparro_20JunJul18.csv,Chaparro_24AgoSep18.csv,Chaparro_24May18.csv,Chaparro_abril18.csv)


Cuenca_Adentro<-rbind(Cuenca_Adentro_11junio18.csv,Cuenca_Adentro_20JunJul18.csv,Cuenca_Adentro_24AgoSep18.csv,Cuenca_Adentro_24May18.csv)


