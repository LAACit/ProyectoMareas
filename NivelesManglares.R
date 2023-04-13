library(ggplot2)
library(lubridate)
library(viridis)


Avicenias <- read.csv("../DatosMAnglar/Avicenias.csv")

Avicenias$Fecha.Tiempo..GMT.05.00 <- as.POSIXct(strptime(Avicenias$Fecha.Tiempo..GMT.05.00, format = "%m/%d/%Y %I:%M:%S %p"))
str(Avicenias)

Chaparro <- read.csv("../DatosMAnglar/Chaparro.csv")
Chaparro$Tiempo <- paste(Chaparro$Fecha,Chaparro$Hora,Chaparro$PM)
Chaparro$Tiempo <- as.POSIXct((strptime(Chaparro$Tiempo, format = "%m/%d/%Y %I:%M:%S %p")))

Franja <- read.csv("../DatosMAnglar/Franja_Cel.csv")
Franja$Fecha.Tiempo..GMT.05.00 <- as.POSIXct(strptime(Franja$Fecha.Tiempo..GMT.05.00, format = "%m/%d/%Y %I:%M:%S %p"))


#Viendo los datos de manglar vemos que tienen diferentes horarios de inicio de mediciones. Hacemos el corte a una hora similar para todos los manglares y para los nuivles de marea 

Chaparro <- Chaparro[-1:-2,]
Avicenias <- Avicenias[-1:-3,]
dfMAreas <- dfMAreas[-1:-16,]

r

#Explorando los datos vemos que estan en mbar y que estos incluyen la presión atmosferica. Entonces lo que se hace es restar la presión 

### Ahora hacemos una resta de la presión atm en mBar a los datos de presión de los manglares (1 aTM a nivel del mar = 1013 mbar) 

Avicenias$Pres.abs..mbar..LGR.S.N..20158088..SEN.S.N..20158088.<- Avicenias$Pres.abs..mbar..LGR.S.N..20158088..SEN.S.N..20158088.- PresionPromedioDiciembreValla

Chaparro$Presión <- Chaparro$Presión - PresionPromedioDiciembreValla

Franja$Pres.abs..mbar..LGR.S.N..20081790..SEN.S.N..20081790. <- Franja$Pres.abs..mbar..LGR.S.N..20081790..SEN.S.N..20081790.- PresionPromedioDiciembreValla


GraficaChaparro <- ggplot(Chaparro, aes(x=Chaparro$Tiempo, y= Chaparro$Presión))+
  geom_line()+
  xlab("")+
  ylab("Presión (mbar)")+
  ggtitle("Chaparro")+
  theme_bw()

GraficaAvicenias <- ggplot(Avicenias, aes(x=Avicenias$Fecha.Tiempo..GMT.05.00, y=Avicenias$Pres.abs..mbar..LGR.S.N..20158088..SEN.S.N..20158088.))+
  geom_line()+
  xlab("")+
  ylab("Presión (mbar)")+
  ggtitle("Avicenias")+
  theme_bw()

GraficaFranja <- ggplot(Franja, aes(x=Franja$Fecha.Tiempo..GMT.05.00, y=Franja$Pres.abs..mbar..LGR.S.N..20081790..SEN.S.N..20081790.))+
  geom_line()+
  xlab("")+
  ylab("Presión (mbar)")+
  ggtitle("Franja")+
  theme_bw()

grid.arrange(GraficaChaparro, GraficaAvicenias, GraficaFranja,GraficaMareaCelestun, nrow = 4)



#######################33

ggplot(Franja, aes(x=Franja$Fecha.Tiempo..GMT.05.00, y=Franja$Pres.abs..mbar..LGR.S.N..20081790..SEN.S.N..20081790.))+
  geom_line()+
  xlab("")+
  ylab("Presión (mbar)")+
  
  ggtitle("Franja")+
  theme_bw()+
  geom_line(dfMAreas , aes(x= dfMAreas$MareaTiempoCelestun, y= dfMAreas$MareaCelestunVector))+
  geom_line()+
  xlab("")+
  ylab("Presión (mbar)")+
  ggtitle("Marea Celestún")+
  theme_bw()


