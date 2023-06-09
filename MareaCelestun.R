library(ggplot2)
library(lubridate)
library(viridis)
library(readr)

# Leer la tabla de datos
MareografoCelestun <- read_table("~/Documents/ENES/SS/DatosMAnglar/MareografoCelestun2010.csv")

# Seleccionar los datos de diciembre
MareaCelestunDiciembre <- MareografoCelestun[669:692, 3:15]

# Eliminar la primera columna
MareaCelestunDiciembre <- MareaCelestunDiciembre[, -1]

# Convertir la tabla en una matriz
MareaCelestunDiciembre <- as.matrix(MareaCelestunDiciembre)


# Crear un vector de tiempo para las mediciones de marea
t1 <- as.POSIXct("0010-12-01 00:00:00", format = "%Y-%m-%d %H:%M:%S")
t2 <- as.POSIXct("0010-12-12 23:00:00", format = "%Y-%m-%d %H:%M:%S")
MareaTiempoCelestun <- seq(from = t1, to = t2, by = "hour")
MareaTiempoCelestun


#Ahora para los datos de presión... pordemos medio intentar hacer un blucle para forzarlos a entrar a un solo sitio como vector 

y <- MareaCelestunDiciembre[1,]

# Agregar los datos de cada fila restante de la matriz "MareaCelestunDiciembre" a "y"
for (i in 1:23) {
  MareaCelestunVector <- c(y, MareaCelestunDiciembre[i+1,])
  y <- MareaCelestunVector
}

#aqui eliminamos el promedio de la presion ATMS de valladolid 1013 mbar

MareaCelestunVector <- MareaCelestunVector - 1013

dfMAreas <- data.frame(MareaCelestunVector,MareaTiempoCelestun)

#Se hace un corte a las 16 hrs ya que los niveles de manglares comienzan a 16:35 
dfMareasCelestun <- dfMAreas[-1:-16,]


#Graficamos 

GraficaMareaCelestun <- ggplot(dfMareasCelestun , aes(x= dfMareasCelestun$MareaTiempoCelestun, y= dfMareasCelestun$MareaCelestunVector, color = "Marea"))+
  geom_line()+
  xlab("")+
  ylab("Presión (mbar)")+
  ggtitle("Marea Celestún (sin presión atm)")+
  theme_bw()

##dfMareasCelestun es el df donde vamos a trabajar 

rm(MareografoCelestun)
rm(MareaCelestunDiciembre)
rm(t1)
rm(t2)
rm(MareaTiempoCelestun)
rm(MareaCelestunVector)
rm(dfMAreas)
rm(i)
rm(y)

# quedamos sólo con el df de la marea de celestun  :) 


