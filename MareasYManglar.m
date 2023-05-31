%importamo nuestros datos 
manglares=readtable("./Datos/Manglares.csv");

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
t2018=datetime(2018,01,01,0,0,0)
t2019=datetime(2019,01,01,0,0,0)
T2018=isbetween(manglares.fecha,t2018,t2019);
manglares=manglares(T2018,:);


%AHORA PARA CADA TIPO DE MANGLAT%%%%%%%}
%vamos a generar una tabla para cada tipo de manglar y vamos a hacer un
%smooth a los datos por tipo 


%hacmeos lo mismo para otros manglares 
Avicenia= strcmp(manglares.tipo,"Avicenia"); 
manglares_Avicenia= manglares(Avicenia,:); 
manglares_Avicenia.presionMbarCorregido=smooth(manglares_Avicenia.presionMbarCorregido)


%ahora chaparro 
chaparro=strcmp(manglares.tipo,"Chaparro");
manglares_chaparro=manglares(chaparro,:);
manglares_chaparro.presionMbarCorregido=smooth(manglares_chaparro.presionMbarCorregido)



%ahora para los manglares de franja 
franja=strcmp(manglares.tipo,"franja"); 
manglares_franja=manglares(franja,:);
manglares_franja.presionMbarCorregido=smooth(manglares_franja.presionMbarCorregido)

%ahora cuenca adentro 
Cuenca_adentro=strcmp(manglares.tipo,"Cuenca-Adentro");
manglares_Cuenca_Adentro=manglares(Cuenca_adentro,:);
manglares_Cuenca_Adentro.presionMbarCorregido=smooth(manglares_Cuenca_Adentro.presionMbarCorregido)

%ahora para Cuenca afuera  
Cuenca_Afuera= strcmp(manglares.tipo,"cuenca-afuera"); 
manglares_Cuenca_Afuera= manglares(Cuenca_Afuera,:);
manglares_Cuenca_Afuera.presionMbarCorregido=smooth(manglares_Cuenca_Afuera.presionMbarCorregido)

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


%podemos ir calculando lo promedios de las señales

PromAvicenas=mean(manglares_Avicenia.presionMbarCorregido)

PromChaparro=mean(manglares_chaparro.presionMbarCorregido)

PromCuencaAdentro=mean(manglares_Cuenca_Adentro.presionMbarCorregido)

PromCuencaAfuera=mean(manglares_Cuenca_Afuera.presionMbarCorregido)




%%%%%%%%%%%%%%%%%%%%% AHORA PARA LA SEÑAL DE MAREA%%%%%%%%%%%%%%%%%%%%%

mareas=readtable("./Datos/datosHoraMareaCelestunRadar.csv")
mareas.Fecha=datetime(mareas.Fecha); 

%Hacemos un plot para ver como estÃ¡n los datos


%figure(3)
%plot(mareas.Fecha,mareas.presion)
%title('Mareas')
%xlabel('fecha')
%ylabel('nivel (?)')


%vemos que tienen un hueco a finales del 2018 


%Vemos si tiene datos daltantes 
NAT=isnat(mareas.Fecha)
mareasNAT=mareas(NAT,:);

%Si tiene datos faltantes entonces los interpolamos 

%rellenamos aquellos valores que son NAT 
%ahora los podríamos  interpolar para esas horas que faltan. 
mareasInter= fillmissing(mareas.Fecha,'linear');
%Ahora que ya lo tenemos sustituimos los valores 
mareas.Fecha=mareasInter;

%podemos cortar los datos para el mismo periodo que la señales de manglares
%

t2018=datetime(2018,01,01,0,0,0)
t2019=datetime(2018,08,25,0,0,0)
T2018=isbetween(mareas.Fecha,t2018,t2019);
mareas=mareas(T2018,:);

%Parece que no hay datos faltantes 

%ordenamos los datos 
mareas = sortrows(mareas,'Fecha','ascend');

%Hacemos un plot para ver como estÃ¡n los datos 
figure(4)
plot(mareas.Fecha,mareas.presion)
title('Mareas')
xlabel('fecha')
ylabel('nivel (?)')




%Ahora podríamos ir obteniedo los valores necesarios par ahcer furier 
%primero obtenermos los valores de frecuencia de muestreo. si tenemos datos
%cada hora, la frecuencua en hz sería 1/t(s). donde t=3600 s

t=3600 %intervalo entre muestreos
Nq=1/2.*t
Fs=1/t  %Frecuencia de muestreo 
L=length(mareas.Fecha) %longitud de los datos que tenemos
t=mareas.Fecha  %vector de tiempo 

%Se puede hacer un fft a los datos de nivel de la marea 
Y=fft(mareas.presion)

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;

figure(5)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of X(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")
ylim([0,2])
xlim([-1,100])









