%Abrimos los datos y los ordenamos por fecha de forma ascendente 

Avicenias=readtable("./DatosManglarGMT6/AviceniaCorregido.csv");

Chaparro=readtable("./DatosManglarGMT6/ChaparroCorregio.csv");
CuencaAfuera=readtable("./DatosManglarGMT6/CuencaAfueraCorregido.csv");
CuencaAdentro=readtable("./DatosManglarGMT6/CuencaAdentroCorregido.csv");
FranjaCel=readtable("./DatosManglarGMT6/FranjaCelCorregido.csv")


%Vemos que ah NaT entonces hacemos que esos huecos sean rellenados por
%fecha 
%Chaparro
ChaparroF= fillmissing(Chaparro.fecha,'linear');
Chaparro.fecha=ChaparroF;
Chaparro=sortrows(Chaparro,'fecha','ascend');
figure(1)
plot(Chaparro.fecha,Chaparro.presionMbar)
hold on 
%Cuenca Afuera
CuencaAfF= fillmissing(CuencaAfuera.fecha,'linear');
CuencaAfuera.fecha=CuencaAfF;
CuencaAfuera=sortrows(CuencaAfuera,'fecha','ascend');
plot(CuencaAfuera.fecha,CuencaAfuera.presionMbar)
hold on 
%Cuenca Adentro
CuencaAF= fillmissing(CuencaAdentro.fecha,'linear');
CuencaAdentro.fecha=CuencaAF;
CuencaAdentro=sortrows(CuencaAdentro,'fecha','ascend');
plot(CuencaAdentro.fecha,CuencaAdentro.presionMbar)
hold on 
%Franja Cel
FranjaF= fillmissing(FranjaCel.fecha,'linear');
FranjaCel.fecha=FranjaF;
FranjaCel=sortrows(FranjaCel,'fecha','ascend');
plot(FranjaCel.fecha,FranjaCel.presionMbar)


%Extraemos la presión atm. Como todas tablas de nivel de manglar tienen un
%dato de presion atm en comun podemos utilizar el dato de una tabla para
%aplicarlo a todas 
PresionATM=table(Chaparro.fecha,Chaparro.atmPresionMbar);
figure(2)
plot(PresionATM.Var1,PresionATM.Var2)
hold on 

%Para correguir el deface pasamos a date num 
PresionATM.Var1=datenum(PresionATM.Var1);
% vemos que hay un desface de 6 horas. Entonces 1 hora es en datenum 
h1=datenum(hours(1));
%Ahora eso multiplicado 6 veces que sería el desface
h6=h1*6;
%Hacemos la correción 
PresionATM.Var1=PresionATM.Var1-h6;
PresionATM.Var1=datetime(PresionATM.Var1,'ConvertFrom','datenum')


%Ahora vemos que no tiene mucho sentido que existan presiones medidas por
%el sensor que sean menores a las presiones atms xk en teoria la presion
%minima del sensor tiene que ser la presion de la atm 

%vemos que la diferencia maxima entre estos valores es de 6 mbar. Podemos
%agregar esta valor a los datos de presion de manglar 

PresionATM.Var2=PresionATM.Var2-7;
plot(PresionATM.Var1,PresionATM.Var2)
legend("Presion ATM fecha presion SIN ajustado","Presion ATM fecha presion ajustado")

%Ahora vamos a cortar las tablas de manglares a los peridos de tiempo que
%hay en los datos corregido de presion ATM 

tinicio=datetime(2018,03,19,12,0,0);
tfinal=datetime(2018,08,24,3,0,0);

IT=isbetween(Chaparro.fecha,tinicio,tfinal);
ChaparroC=Chaparro(IT,:)

%Renombramos las variable de presion como fecha 
PresionATM.Properties.VariableNames=["fecha","atmPresionMbarX"]

%Ahora unimos Chaparro y Presion 
ChaparroC.fecha=datenum(ChaparroC.fecha)
PresionATM.fecha=datenum(PresionATM.fecha)
ChaparroU=innerjoin(ChaparroC,PresionATM)
ChaparroU.fecha=datetime(ChaparroU.fecha,'ConvertFrom','datenum')

PresionATM.fecha=datetime(PresionATM.fecha,'ConvertFrom','datenum')

plot(ChaparroU.fecha,ChaparroU.atmPresionMbar)
hold on 
plot(ChaparroU.fecha,ChaparroU.atmPresionMbarX)
hold on 
plot(PresionATM.fecha,PresionATM.atmPresionMbarX,'k*')
