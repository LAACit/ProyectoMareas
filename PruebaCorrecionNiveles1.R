#se me ocurre que pueda tomar las columanas de fechas y hacer un left_join() con las que son de presion 

#iportamos presiones
PO18_1<-read.csv("../../../../DatosMAnglar/PresionesYuctán/CGSMN-B00.8.-23-0000154/P_18_1c.csv")
#Cortamos y ponemos nombres
PO18_1<-rename(PO18_1,Fecha=Fecha.Tiempo)%>%.[,c(2,11)]
str(PO18_1)

#importamos avicenias 
Avicenias_11junio18.csv<-read.csv("../2018/Avicenias_11junio18.csv")

Avicenias_11junio18.csv<-rename(Avicenias_11junio18.csv,Fecha=Fecha..GMT.06.00)%>%.[,c(2,3)]

#pero tienen diferentes formatos de fechas, deberiamos poder unirlos y sitienne el mimso formato 

#Para avicenias 

Avicenias_11junio18.csv$Fecha<- as.POSIXct(strptime(Avicenias_11junio18.csv$Fecha, format = "%m/%d/%Y %I:%M:%S %p"))

#Para presiones 
PO18_1$Fecha<-as.POSIXct(strptime(PO18_1$Fecha, format="%d/%m/%Y %I:%M:%S %p"))

pru1<-left_join(Avicenias_11junio18.csv, PO18_1, by="Fecha")%>%na.exclude()

colnames(pru1)<-c("Fecha","mbaratm","mbaragua")

pru1$mbarcorregido<-pru1$mbaragua-pru1$mbaratm

p<-ggplot()+
  geom_line(data=pru1,aes(x=Fecha,y=mbaratm, color="Presion atm "))+
  geom_line(data=pru1,aes(x=Fecha,y=mbaragua,color="Nivel medido"))
  
n<-ggplot()+
  geom_line(data=pru1, aes(x=Fecha,y=mbarcorregido, colour="nivel corregido"))

grid.arrange(p,n,nrow=2)
