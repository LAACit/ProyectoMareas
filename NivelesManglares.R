library(viridis)
library(gridExtra)
library(tidyverse)
library(readxl)
library(ggplot2)
library(lubridate)

##Corremos el scrip de Marea de celestun para tener el dfMareasCelestun 
source("MareaCelestun.R")
source("PresionATMValladolid2010.R")

#EXPLORACIÓN DE DATOS ####

#Abrimos los datos y los hacemos en una señal de tiempo. 

Avicenias <- read.csv("../../../../Desktop/Acomodados/11_JUNIO 2018GMT6/Chaparro_11junio18.csv")
str(Avicenias)
colnames(Avicenias)<- c("n", "date","Presion mbar","Temp °C")
Avicenias$date <- as.POSIXct(strptime(Avicenias$date, format = "%m/%d/%Y %I:%M:%S %p"))

#str(Avicenias)

Chaparro <- read.csv("../DatosMAnglar/Chaparro.csv")
Chaparro$Tiempo <- paste(Chaparro$Fecha,Chaparro$Hora,Chaparro$PM)
Chaparro$Tiempo <- as.POSIXct((strptime(Chaparro$Tiempo, format = "%m/%d/%Y %I:%M:%S %p")))

#str(Chaparro)

Franja <- read.csv("../DatosMAnglar/Franja_Cel.csv")
Franja$Fecha.Tiempo..GMT.05.00 <- as.POSIXct(strptime(Franja$Fecha.Tiempo..GMT.05.00, format = "%m/%d/%Y %I:%M:%S %p"))

#str(Franja)


#Viendo los datos de manglar vemos que tienen diferentes horarios de inicio de mediciones. Hacemos el corte a una hora similar para todos los manglares


Chaparro <- Chaparro[-1:-2,]
Avicenias <- Avicenias[-1:-3,]
#Franaj fue referencia a 16:65 hrs 

#Explorando los datos vemos que estan en mbar y que estos incluyen la presión atmosferica. Entonces lo que se hace es restar la presión promedio de Valladolid que se obtiene del scrip PresionATMValladolid2010.R Promedio=1012 mbar 


Avicenias$Pres.abs..mbar..LGR.S.N..20158088..SEN.S.N..20158088.<- Avicenias$Pres.abs..mbar..LGR.S.N..20158088..SEN.S.N..20158088.- PresionPromedioDiciembreValla

Chaparro$Presión <- Chaparro$Presión - PresionPromedioDiciembreValla

Franja$Pres.abs..mbar..LGR.S.N..20081790..SEN.S.N..20081790. <- Franja$Pres.abs..mbar..LGR.S.N..20081790..SEN.S.N..20081790.- PresionPromedioDiciembreValla


#Se hace una grafica para cada manglar dentro de una misma 

Manglares <-ggplot() +
  geom_line(data= Franja, aes(x=Franja$Fecha.Tiempo..GMT.05.00, y=Franja$Pres.abs..mbar..LGR.S.N..20081790..SEN.S.N..20081790.,color='Franja')) +
  geom_line(data= Avicenias, aes(x=Avicenias$Fecha.Tiempo..GMT.05.00, y=Avicenias$Pres.abs..mbar..LGR.S.N..20158088..SEN.S.N..20158088., color='Avicenias')) + 
  geom_line(data= Chaparro, aes(x=Chaparro$Tiempo, y= Chaparro$Presión, color='Chaparro'))+
  xlab('Fecha')+
  ylab('Presión (mbar)')+
  theme_bw()+
  ggtitle("Nivel de inundación manglares") +
  theme(plot.title = element_text(hjust = 0.5))

grid.arrange(Manglares, GraficaMareaCelestun, nrow=2)



