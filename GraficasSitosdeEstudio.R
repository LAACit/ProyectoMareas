library(lubridate)
library(tidyverse)
library(gridExtra)
library(ggplot2)


#Importamos los datos en este caso los csv del 2018 
#setwd("./Datos_Hobboq/Datos_Hobbo/Datos_Acomodados_CelCop/2018/")

temp = list.files(pattern="*.csv")
for (i in 1:length(temp)) assign(temp[i], read.csv(temp[i]))

#Removemos los que nos ayudo a abrir el archvio 
rm(i)
rm(temp)

#Ahora lo que hacemos es tener las columnas de fecha en un formato de tiempo que se pueda leer. En este caso para avicenias 

Avicenias_11junio18.csv$Fecha..GMT.06.00<- as.POSIXct(strptime(Avicenias_11junio18.csv$Fecha..GMT.06.00, format = "%m/%d/%Y %I:%M:%S %p"))

Avicenias_20JunJul18.csv$Fecha..GMT.06.00 <- as.POSIXct(strptime(Avicenias_20JunJul18.csv$Fecha..GMT.06.00, format="%m/%d/%Y %I:%M:%S %p" ))

Avicenias_24AgoSep18.csv$Fecha..GMT.06.00<-as.POSIXct(strptime(Avicenias_24AgoSep18.csv$Fecha..GMT.06.00, format="%m/%d/%Y %I:%M:%S %p"))

Avicenias_24May18.csv$Fecha..GMT.06.00 <- as.POSIXct(strptime(Avicenias_24May18.csv$Fecha..GMT.06.00, format="%m/%d/%Y %I:%M:%S %p"))

Avicenias_abril18.csv$Fecha..GMT.06.00 <- as.POSIXct(strptime(Avicenias_abril18.csv$Fecha..GMT.06.00, format="%m/%d/%Y %I:%M:%S %p"))


#Graficamos avicenias 

GAvi18<- ggplot()+
  geom_line(data= Avicenias_11junio18.csv, aes(x=Avicenias_11junio18.csv$Fecha..GMT.06.00, y=Avicenias_11junio18.csv$X.mbar..LGR.S.N..20158088.S.N..20158088., color="Avicenias_11junio18.csv" ))+
  geom_line(data=Avicenias_20JunJul18.csv, aes(x=Avicenias_20JunJul18.csv$Fecha..GMT.06.00, y=Avicenias_20JunJul18.csv$X.mbar..LGR.S.N..20158088.S.N..20158088., color="Avicenias_20JunJul18.csv"))+
  geom_line(data=Avicenias_24AgoSep18.csv, aes(x=Avicenias_24AgoSep18.csv$Fecha..GMT.06.00, y=Avicenias_24AgoSep18.csv$X.mbar..LGR.S.N..20158088.S.N..20158088., color="Avicenias_24AgoSep18.csv"))+
  geom_line(data=Avicenias_24May18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20158088.S.N..20158088., color="Avicenias_24May18.csv"))+
  geom_line(data=Avicenias_abril18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20158088.S.N..20158088., color="Avicenias_abril18.csv"))+
  xlab("Fecha")+
  ylab( "presión (mbar)")+
  theme_minimal()+
  ggtitle("Niveles Sitio Avicenias 2018 ")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_x_datetime(limits = c(as.POSIXct("2018-03-18"), as.POSIXct("2018-08-25")))


#Cambiamos los formato de fecha para mangle chaparro 

Chaparro_11junio18.csv$Fecha..GMT.06.00<- as.POSIXct(strptime(Chaparro_11junio18.csv$Fecha..GMT.06.00, format ="%m/%d/%Y %I:%M:%S %p"))

Chaparro_20JunJul18.csv$Fecha..GMT.06.00<- as.POSIXct(strptime(Chaparro_20JunJul18.csv$Fecha..GMT.06.00, format = "%m/%d/%Y %I:%M:%S %p"))

Chaparro_24AgoSep18.csv$Fecha..GMT.06.00<- as.POSIXct(strptime(Chaparro_24AgoSep18.csv$Fecha..GMT.06.00, format = "%m/%d/%Y %I:%M:%S %p"))

Chaparro_24May18.csv$Fecha..GMT.06.00<-as.POSIXct(strptime(Chaparro_24May18.csv$Fecha..GMT.06.00, format="%m/%d/%Y %I:%M:%S %p"))

Chaparro_abril18.csv$Fecha..GMT.06.00<-as.POSIXct(strptime(Chaparro_abril18.csv$Fecha..GMT.06.00, format="%m/%d/%Y %I:%M:%S %p"))


#Los valores del Abril de Chaparro estan mal importandos, se deben pasar de mmHg a mbar :/

Chaparro_abril18.csv$X.mm.Hg..LGR.S.N..20081786.S.N..20081786.<- Chaparro_abril18.csv$X.mm.Hg..LGR.S.N..20081786.S.N..20081786.* 1.33322


GChap18<- ggplot()+
  geom_line(data = Chaparro_11junio18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081786.S.N..20081786., color="Chaparro_11junio18.csv"))+
  geom_line(data = Chaparro_20JunJul18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081786.S.N..20081786., color="Chaparro_20JunJul18.csv"))+
  geom_line(data = Chaparro_24AgoSep18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081786.S.N..20081786., color="Chaparro_24AgoSep18.csv"))+
  geom_line(data = Chaparro_24May18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081786.S.N..20081786., color="Chaparro_24May18.csv"))+
 geom_line(data=Chaparro_abril18.csv, aes(x=Fecha..GMT.06.00, y=X.mm.Hg..LGR.S.N..20081786.S.N..20081786., color="
Chaparro_abril18.csv"))+
  xlab("Fecha")+
  ylab( "presión (mbar)")+
  theme_minimal()+
  ggtitle("Niveles Sitio Chaparro 2018 ")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_x_datetime(limits = c(as.POSIXct("2018-03-18"), as.POSIXct("2018-08-25")))





#Ahora para los de franja 

str(Franja_Cel_11junio18.csv$Fecha..GMT.06.00)

Franja_Cel_11junio18.csv$Fecha..GMT.06.00<-as.POSIXct(strptime(Franja_Cel_11junio18.csv$Fecha..GMT.06.00, format = "%m/%d/%Y %I:%M:%S %p"))


Franja_Cel_20JunJul18.csv$Fecha..GMT.06.00<-as.POSIXct(strptime(Franja_Cel_20JunJul18.csv$Fecha..GMT.06.00, format = "%m/%d/%Y %I:%M:%S %p"))

Franja_Cel_24AgoSep18.csv$Fecha..GMT.06.00<- as.POSIXct(strptime(Franja_Cel_24AgoSep18.csv$Fecha..GMT.06.00, format = "%m/%d/%Y %I:%M:%S %p"))

Franja_Cel_24May18.csv$Fecha..GMT.06.00<- as.POSIXct(strptime(Franja_Cel_24May18.csv$Fecha..GMT.06.00, format = "%m/%d/%Y %I:%M:%S %p"))

Franja_Cel_abril18.csv$Fecha..GMT.06.00<-as.POSIXct(strptime(Franja_Cel_abril18.csv$Fecha..GMT.06.00, format = "%m/%d/%Y %I:%M:%S %p"))




GFranja18<- ggplot()+
  geom_line(data=Franja_Cel_11junio18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..presion.mbar., color="Franja_Cel_11junio18.csv"))+
geom_line(data=Franja_Cel_20JunJul18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..presion.mbar. ,color="Franja_Cel_20JunJul18.csv"))+
  geom_line(data=Franja_Cel_24AgoSep18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..presion.mbar., color="Franja_Cel_24AgoSep18.csv"))+
  geom_line(data=Franja_Cel_24May18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..presion.mbar. ,color="Franja_Cel_24May18.csv"))+
  geom_line(data=Franja_Cel_abril18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..presion.mbar.,color="Franja_Cel_abril18.csv"))+
   xlab("Fecha")+
   ylab( "presión (mbar)")+
   theme_minimal()+
   ggtitle("Niveles Sitio Franja 2018 ")+
   theme(plot.title = element_text(hjust = 0.5))+
   scale_x_datetime(limits = c(as.POSIXct("2018-03-18"), as.POSIXct("2018-08-25")))


#grid.arrange(GAvi18, GChap18,GFranja18, nrow=3)

#grid.arrange(GAvi18, GChap18,GFranja18, nrow=3)
  

#Ahora cuencas 

Cuenca__Afuera_11junio18.csv$Fecha..GMT.06.00<-as.POSIXct(strptime(Cuenca__Afuera_11junio18.csv$Fecha..GMT.06.00, format = "%m/%d/%Y %I:%M:%S %p"))

Cuenca__Afuera_20JunJul18.csv$Fecha..GMT.06.00<-as.POSIXct(strptime(Cuenca__Afuera_20JunJul18.csv$Fecha..GMT.06.00, format = "%m/%d/%Y %I:%M:%S %p"))

Cuenca__Afuera_24AgoSep18.csv$Fecha..GMT.06.00<- as.POSIXct(strptime(Cuenca__Afuera_24AgoSep18.csv$Fecha..GMT.06.00,format = "%m/%d/%Y %I:%M:%S %p"))
Cuenca__Afuera_24May18.csv$Fecha..GMT.06.00<- as.POSIXct(strptime(Cuenca__Afuera_24May18.csv$Fecha..GMT.06.00,format = "%m/%d/%Y %I:%M:%S %p"))
Cuenca__Afuera_abril18.csv$Fecha..GMT.06.00<-as.POSIXct(strptime( Cuenca__Afuera_abril18.csv$Fecha..GMT.06.00, format = "%m/%d/%Y %I:%M:%S %p"))
Cuenca_Adentro_11junio18.csv$Fecha..GMT.06.00<-as.POSIXct(strptime(Cuenca_Adentro_11junio18.csv$Fecha..GMT.06.00,format = "%m/%d/%Y %I:%M:%S %p"))
Cuenca_Adentro_20JunJul18.csv$Fecha..GMT.06.00<-as.POSIXct(strptime(Cuenca_Adentro_20JunJul18.csv$Fecha..GMT.06.00, format = "%m/%d/%Y %I:%M:%S %p"))
Cuenca_Adentro_24AgoSep18.csv$Fecha..GMT.06.00<-as.POSIXct(strptime(Cuenca_Adentro_24AgoSep18.csv$Fecha..GMT.06.00,format = "%m/%d/%Y %I:%M:%S %p"))
Cuenca_Adentro_24May18.csv$Fecha..GMT.06.00<-as.POSIXct(strptime(Cuenca_Adentro_24May18.csv$Fecha..GMT.06.00,format = "%m/%d/%Y %I:%M:%S %p"))
Cuenca_Adentro_abril18.csv$Fecha..GMT.06.00<-as.POSIXct(strptime(Cuenca_Adentro_abril18.csv$Fecha..GMT.06.00,format = "%m/%d/%Y %I:%M:%S %p"))


ggplot()+
  geom_line(data=Cuenca__Afuera_11junio18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081788.S.N..20081788., color="Cuenca__Afuera_11junio18.csv "))+
  geom_line(data=Cuenca__Afuera_20JunJul18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081788.S.N..20081788., color="Cuenca__Afuera_20JunJul18.csv"))+
  geom_line(data=Cuenca__Afuera_24AgoSep18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081788.S.N..20081788., color="Cuenca__Afuera_24AgoSep18.csv"))+
  geom_line(data=Cuenca__Afuera_24May18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081788.S.N..20081788., color="Cuenca__Afuera_24May18.csv "))+
  geom_line(data=Cuenca__Afuera_abril18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081788.S.N..20081788., color="Cuenca__Afuera_abril18.csv "))+
  xlab("Fecha")+
  ylab( "presión (mbar)")+
  theme_minimal()+
  ggtitle("Niveles Sitio Cuenca Afuera 2018 ")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_x_datetime(limits = c(as.POSIXct("2018-03-18"), as.POSIXct("2018-08-25")))+geom_line(data=Cuenca_Adentro_11junio18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081791.S.N..20081791., color=" Cuenca_Adentro_11junio18.csv"))+
  geom_line(data=Cuenca_Adentro_20JunJul18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081791.S.N..20081791., color="Cuenca_Adentro_20JunJul18.csv"))+
  geom_line(data=Cuenca_Adentro_24AgoSep18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081791.S.N..20081791., color="Cuenca_Adentro_24AgoSep18.csv"))+
  geom_line(data=Cuenca_Adentro_24May18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081791.S.N..20081791., color="Cuenca__Adentro_24May18.csv "))+
  geom_line(data=Cuenca_Adentro_abril18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081791.S.N..20081791., color="Cuenca__Adentro_abril18.csv "))+
  xlab("Fecha")+
  ylab( "presión (mbar)")+
  theme_minimal()+
  ggtitle("Niveles Sitio Cuenca Adentro 2018 ")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_x_datetime(limits = c(as.POSIXct("2018-03-18"), as.POSIXct("2018-08-25")))


#grid.arrange(GCuenAden18,GCuenAfuera18, nrow=2)



#Podemos hacer un df donde se incluyan todos los valores 


Avicenias_11junio18.csv<- Avicenias_11junio18.csv[,2:4]
Avicenias_11junio18.csv$Tipo <- c("Avicenias")
Avicenias_11junio18.csv$archivo<- c("Avicenias_11junio18")


Avicenias_20JunJul18.csv<-Avicenias_20JunJul18.csv[,2:4]
Avicenias_20JunJul18.csv$Tipo <- c("Avicenias")
Avicenias_20JunJul18.csv$archivo <- c("Avicenias_20JunJul18")

Avicenias_24AgoSep18.csv<-Avicenias_24AgoSep18.csv[,2:4]
Avicenias_24AgoSep18.csv$Tipo <- c("Avicenias")
Avicenias_24AgoSep18.csv$archivo<-c("Avicenias_24AgoSep18")

Avicenias_24May18.csv<-Avicenias_24May18.csv[,2:4]
Avicenias_24May18.csv$Tipo <- c("Avicenias")
Avicenias_24May18.csv$archivo <- c("Avicenias_24May18")

Avicenias_abril18.csv<-Avicenias_abril18.csv[,2:4]
Avicenias_abril18.csv$Tipo <- c("Avicenias")
Avicenias_abril18.csv$archivo <- c("Avicenias_abril18")

Avicenias <- rbind(Avicenias_11junio18.csv,Avicenias_20JunJul18.csv, Avicenias_24AgoSep18.csv,Avicenias_24May18.csv,Avicenias_abril18.csv) 

colnames(Avicenias) <- c("fecha","presion","temp", "tipo","archivo")
str(Avicenias)


Chaparro_11junio18.csv<-Chaparro_11junio18.csv[,2:4]
Chaparro_11junio18.csv$tipo<-c("Chaparro")
Chaparro_11junio18.csv$archivo<- c("Chaparro_11junio18.csv")

Chaparro_20JunJul18.csv<-Chaparro_20JunJul18.csv[,2:4]
Chaparro_20JunJul18.csv$tipo <- c("Chaparro")
Chaparro_20JunJul18.csv$archivo <- c("Chaparro_20JunJul18.csv")

Chaparro_24AgoSep18.csv<- Chaparro_24AgoSep18.csv[,2:4]
Chaparro_24AgoSep18.csv$tipo <-c("Chaparro")
Chaparro_24AgoSep18.csv$archivo <-c("Chaparro_24AgoSep18.csv")

Chaparro_24May18.csv<-Chaparro_24May18.csv[,2:4]
Chaparro_24May18.csv$tipo <- c("Chaparro")
Chaparro_24May18.csv$archivo <- c("Chaparro_24May18.csv")

Chaparro_abril18.csv<-Chaparro_abril18.csv[,2:4]
Chaparro_abril18.csv$tipo <- c("Chaparro")
Chaparro_abril18.csv$archivo <- c("Chaparro_abril18.csv")



Chaparros<- rbind(Chaparro_11junio18.csv,Chaparro_20JunJul18.csv,Chaparro_24AgoSep18.csv,Chaparro_24May18.csv,Chaparro_abril18.csv)



Cuenca__Afuera_11junio18.csv<- Cuenca__Afuera_11junio18.csv[,2:4]
Cuenca__Afuera_11junio18.csv$tipo <-c("Cuenca_Afuera")

Cuenca__Afuera_20JunJul18.csv<-Cuenca__Afuera_20JunJul18.csv[,2:4]
Cuenca__Afuera_20JunJul18.csv$tipo <-c("Cuenca_Afuera")

Cuenca__Afuera_24AgoSep18.csv<-Cuenca__Afuera_24AgoSep18.csv[,2:4]
Cuenca__Afuera_24AgoSep18.csv$tipo<- c("Cuenca_Afuera")

Cuenca__Afuera_24May18.csv<-Cuenca__Afuera_24May18.csv[,2:4]
Cuenca__Afuera_24May18.csv$tipo<-c("Cuenca_Afuera")

Cuenca__Afuera_abril18.csv<-Cuenca__Afuera_abril18.csv[,2:4]
Cuenca__Afuera_abril18.csv$tipo<-c("Cuenca_Afuera")


Cuenca_Afuera <- rbind(Cuenca__Afuera_11junio18.csv,Cuenca__Afuera_20JunJul18.csv,Cuenca__Afuera_24AgoSep18.csv,Cuenca__Afuera_24May18.csv,Cuenca__Afuera_abril18.csv)

Cuenca_Adentro_11junio18.csv<-Cuenca_Adentro_11junio18.csv[,2:4]
Cuenca_Adentro_11junio18.csv$tipo<-c("Cuenca_adentro")

Cuenca_Adentro_20JunJul18.csv<-Cuenca_Adentro_20JunJul18.csv[,2:4]
Cuenca_Adentro_20JunJul18.csv$tipo<-c("Cuenca_adentro")

Cuenca_Adentro_24AgoSep18.csv<-Cuenca_Adentro_24AgoSep18.csv[,2:4]
Cuenca_Adentro_24AgoSep18.csv$tipo<-c("Cuenca_adentro")

Cuenca_Adentro_24May18.csv<-Cuenca_Adentro_24May18.csv[,2:4]
Cuenca_Adentro_24May18.csv$tipo<-c("Cuenca_adentro")

Cuenca_Adentro_abril18.csv<-Cuenca_Adentro_abril18.csv[,2:4]
Cuenca_Adentro_abril18.csv$tipo<-c("Cuenca_adentro")

Cuenca_Andentro <- rbind(Cuenca_Adentro_11junio18.csv,Cuenca_Adentro_20JunJul18.csv,Cuenca_Adentro_24AgoSep18.csv,Cuenca_Adentro_24May18.csv,Cuenca_Adentro_abril18.csv)
str(Cuenca_Andentro)
colnames(Cuenca_Andentro)<- c("fecha","presion","temp", "tipo")
colnames(Cuenca_Afuera) <-  c("fecha","presion","temp", "tipo")

Avicenias<-Avicenias[1:4]

Manglares <- rbind(Avicenias,Cuenca_Afuera,Cuenca_Andentro)



ggplot()+
  geom_line(data=Manglares, aes(x=fecha, y=presion, color=tipo))+
  theme_light()
  










