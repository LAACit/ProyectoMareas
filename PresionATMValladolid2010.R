#install.packages("lubridate")
#install.packages("gridExtra")
library(gridExtra)
library(tidyverse)
library(readxl)
library(ggplot2)
library(lubridate)

PresionValla= read.csv("../DatosMAnglar/PresionesYuctán/CGSMN-B00.8.-23-0000154/Valladolid2010Corregido2.csv")

PresionValla$Fecha.Tiempo <-as.POSIXct(strptime(PresionValla$Fecha.Tiempo, format="%d/%m/%Y %I:%M:%S %p"))

PresionDiciembre <- PresionValla[15600:16318, ]

PresionPromedioDiciembreValla <- mean(PresionDiciembre$BP.mbar.)

ggplot(PresionDiciembre, aes(x = PresionDiciembre$Fecha.Tiempo, y = PresionDiciembre$BP.mbar.)) + 
  geom_line()+
  xlab("")+
  ylab("Presión (mbar) ")+
  ggtitle("Presión Atmosferica Valladolid ")+
  theme_bw()

rm(PresionValla)
rm(PresionDiciembre)
