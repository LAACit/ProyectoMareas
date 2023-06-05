%importamo nuestros datos 
manglares=readtable("./Manglares.csv", 'VariableNamingRule','preserve');

%datos formato de fecha 
manglares.fecha=datetime(manglares.fecha);

%vemos los tipos de manglar que tenemos 
tipos_Manglar=unique(manglares.tipo)

%Graficamos los datos originales 

%figure (1)
%plot(manglares.fecha,manglares.presionMbarCorregido)
%title("Nivel corregido de manglar ")
%xlabel('fecha')
%ylabel('presion (mbar)')


%vemos que tiene unos NaT los identificamos
nat=isnat(manglares.fecha);
nat=manglares(nat,:);

%rellenamos aquellos valores que son NAT 
%ahora los podríamos  interpolar para esas horas que faltan. 
manglaresInter= fillmissing(manglares.fecha,'linear');

%Ahora que ya lo tenemos sustituimos los valores 
manglares.fecha=manglaresInter;

%ordenamos los datos 
manglares = sortrows(manglares,'fecha','ascend');

%como tiene datos muy distantes del 2017, los descartamos y dejamo sólo los
%del 2108 

t2018=datetime(2018,04,11,4,0,0);
t2019=datetime(2018,08,21,4,0,0);

T2018=isbetween(manglares.fecha,t2018,t2019);
manglares=manglares(T2018,:);

clear T2018 t2019 t2018 nat 


%AHORA PARA CADA TIPO DE MANGLAR%%%%%%%}
%vamos a generar una tabla para cada tipo de manglar y vamos a hacer un
%smooth a los datos por tipo 

%hacmeos lo mismo para otros manglares 
Avicenia= strcmp(manglares.tipo,"Avicenia"); 
manglares_Avicenia= manglares(Avicenia,:); 
clear Avicenia

%ahora chaparro 
chaparro=strcmp(manglares.tipo,"Chaparro");
manglares_chaparro=manglares(chaparro,:);
clear chaparro

%ahora para los manglares de franja 
franja=strcmp(manglares.tipo,"franja"); 
manglares_franja=manglares(franja,:);
clear franja

%ahora cuenca adentro 
Cuenca_adentro=strcmp(manglares.tipo,"Cuenca-Adentro");
manglares_Cuenca_Adentro=manglares(Cuenca_adentro,:);
clear Cuenca_adentro

%ahora para Cuenca afuera  
Cuenca_Afuera= strcmp(manglares.tipo,"cuenca-afuera"); 
manglares_Cuenca_Afuera= manglares(Cuenca_Afuera,:);
clear Cuenca_Afuera


%graficamos los resultados 
figure(2)
plot(manglares_Avicenia.fecha,manglares_Avicenia.presionMbarCorregido)
hold on 
plot(manglares_Cuenca_Adentro .fecha,manglares_Cuenca_Adentro.presionMbarCorregido)
hold on 
plot(manglares_chaparro.fecha,manglares_chaparro.presionMbarCorregido)
hold on
plot(manglares_franja.fecha,manglares_franja.presionMbarCorregido)
hold on 
plot(manglares_Cuenca_Afuera.fecha,manglares_Cuenca_Afuera.presionMbarCorregido)
ylim([0,100])
legend('avicenia','cuenca adentro','chaparro','franja', 'cuenca afuera')
title("niveles manglar")
ylabel("presion (mbar)")
xlabel("fecha")

%%%%%%%%%%%%%%%%%%%%%%%%%

%vemos qu existe una desface en los datos de la presion atm. extraemos los datos de presion atm por tipo 

PresionATM=manglares_Avicenia.("presion mbar atm");
PresionATMFecha=datenum(manglares_Avicenia.fecha);

%entonces 1 hora es en datenum 
h1=datenum(hours(1));
%Ahora eso multiplicado 6 veces que sería el desface
h6=h1*6;

%podemos hacer que el vector de tiempo de la señal de presión se ajuste a
%las 7 horas pasandolo a datenum y sumando los valores numericos de la
%fecha 
PresionATMFecha =PresionATMFecha-h6;
PresionATMFecha=datetime(PresionATMFecha,'ConvertFrom','datenum');

PresionATMFecha = sortrows(PresionATMFecha,1);

%ahora ya tenemos los datos corregidos, podemos hacer una grafica de estos
%datos y los de datos de manglares de Avicenias 

figure(8)
plot(manglares_Avicenia.fecha,manglares_Avicenia.("presion mbar"),'r.-')
hold on 
plot(PresionATMFecha,PresionATM,'b.-')
legend("Sensor","Presion ATM Correcion hora")

%Ahora vemos que no tiene mucho sentido que existan presiones medidas por
%el sensor que sean menores a las presiones atms xk en teoria la presion
%minima del sensor tiene que ser la presion de la atm 

%vemos que la diferencia maxima entre estos valores es de 6 mbar. Podemos
%agregar esta valor a los datos de presion de manglar 

PresionATM=PresionATM-7;

figure(9)
plot(manglares_Avicenia.fecha,manglares_Avicenia.("presion mbar"),'r.-')
hold on 
plot(PresionATMFecha,PresionATM,'b.-')
legend("Sensor","Presion ATM Correcion hora y correcion presión ")
grid on 

clear h1 h6 manglares 


PresionATM=table(PresionATM,PresionATMFecha);


%Vemos que ahora los datos de manglar tienen las primeras 6 horas como extras, las eliminamos 

%cortamos los datos de fechas en un intervalo de interes
tinicio=datetime(2018,04,11,4,0,0);
tfinal=datetime(2018,08,21,4,0,0);

TAv=isbetween(manglares_Avicenia.fecha,tinicio,tfinal);
Avicenias=manglares_Avicenia(TAv,:);
clear manglares_Avicenia 

Tfran=isbetween(manglares_franja.fecha,tinicio,tfinal);
Franja=manglares_franja(Tfran,:);
clear manglares_franja Tfran

TChap=isbetween(manglares_chaparro.fecha,tinicio,tfinal);
Chaparro=manglares_chaparro(TChap,:);
clear manglares_chaparro  TChap

TCAf=isbetween(manglares_Cuenca_Afuera.fecha,tinicio,tfinal);
CuencaAf=manglares_Cuenca_Afuera(TCAf,:);
clear manglares_Cuenca_Afuera TCAf

TCAd=isbetween(manglares_Cuenca_Adentro.fecha,tinicio,tfinal);
CuencaAd=manglares_Cuenca_Adentro(TCAd,:);
clear manglares_Cuenca_Adentro TCAd


PresionATM = sortrows(PresionATM,'PresionATMFecha','ascend');
TPres=isbetween(PresionATM.PresionATMFecha,tinicio,tfinal);
PresionATM=PresionATM(TPres,:);
