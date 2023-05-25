ggplot()+
  geom_line(data=Cuenca__Afuera_11junio18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081788.S.N..20081788., color="Cuenca__Afuera"))+
  geom_line(data=Cuenca__Afuera_20JunJul18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081788.S.N..20081788., color="Cuenca__Afuera"))+
  geom_line(data=Cuenca__Afuera_24AgoSep18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081788.S.N..20081788., color="Cuenca__Afuera"))+
  geom_line(data=Cuenca__Afuera_24May18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081788.S.N..20081788., color="Cuenca__Afuera"))+
  geom_line(data=Cuenca__Afuera_abril18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081788.S.N..20081788., color="Cuenca__Afuera"))+
  geom_line(data=Cuenca_Adentro_11junio18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081791.S.N..20081791., color="Cuenca_Adentro"))+
  geom_line(data=Cuenca_Adentro_20JunJul18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081791.S.N..20081791., color="Cuenca_Adentro"))+
  geom_line(data=Cuenca_Adentro_24AgoSep18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081791.S.N..20081791., color="Cuenca_Adentro"))+
  geom_line(data=Cuenca_Adentro_24May18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081791.S.N..20081791., color="Cuenca_Adentro"))+
  geom_line(data=Cuenca_Adentro_abril18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..LGR.S.N..20081791.S.N..20081791., color="Cuenca_Adentro"))+
  xlab("Fecha")+
  ylab( "presión (mbar)")+
  theme_minimal()+
  ggtitle("Niveles Sitio Cuenca Adentro 2018 ")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_x_datetime(limits = c(as.POSIXct("2018-03-18"), as.POSIXct("2018-08-25")))+
  geom_line(data=Franja_Cel_11junio18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..presion.mbar., color="Franja_Cel"))+
  geom_line(data=Franja_Cel_20JunJul18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..presion.mbar. ,color="Franja_Cel"))+
  geom_line(data=Franja_Cel_24AgoSep18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..presion.mbar., color="Franja_Cel"))+
  geom_line(data=Franja_Cel_24May18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..presion.mbar. ,color="Franja_Cel"))+
  geom_line(data=Franja_Cel_abril18.csv, aes(x=Fecha..GMT.06.00, y=X.mbar..presion.mbar.,color="Franja_Cel"))
