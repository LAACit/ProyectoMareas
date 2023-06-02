%vamos a corregir los datos de la presion atm para que encaje con los datos
%de presion 


%vemos qu existe una desface en los datos de la presion atm. extraemos los
%datos de presion atm por tipo 

PresionATMAv=manglares_Avicenia.presionMbarAtm;
PresionATMFechaAv=datenum(manglares_Avicenia.fecha)

%entonces 1 hora es en datenum 
h1=datenum(hours(1))
%Ahora eso multiplicado 6 veces que sería el desface
h6=h1*6

%podemos hacer que el vector de tiempo de la señal de presión se ajuste a
%las 7 horas pasandolo a datenum y sumando los valores numericos de la
%fecha 

PresionATMFechaAv=PresionATMFechaAv-h6
PresionATMFechaAv=datetime(PresionATMFechaAv,'ConvertFrom','datenum')

%ahora ya tenemos los datos corregidos, podemos hacer una grafica de estos
%datos y los de datos de manglares de Avicenias 

figure(8)
plot(manglares_Avicenia.fecha,manglares_Avicenia.presionMbar,'r.-')
hold on 
plot(PresionATMFechaAv,PresionATMAv,'b.-')
legend("manglar","atm Correcion")

%Ahora vemos que no tiene mucho sentido que existan presiones medidas por
%el sensor que sean menores a las presiones atms xk en teoria la presion
%minima del sensor tiene que ser la presion de la atm 

%vemos que la diferencia maxima entre estos valores es de 6 mbar. Podemos
%agregar esta valor a los datos de presion de manglar 

PresionATMAv=PresionATMAv-7;

figure(9)
plot(manglares_Avicenia.fecha,manglares_Avicenia.presionMbar,'r.-')
hold on 
plot(PresionATMFechaAv,PresionATMAv,'b.-')
legend("manglar","atm Correcion")


%SE PUEDE HACER LO MISO SPARA EL RESTO DE MANGLARES 

figure(10)
plot(manglares_chaparro.fecha,manglares_chaparro.presionMbar,'r.-')
hold on 
plot(PresionATMFechaAv,PresionATMAv,'b.-')
legend("manglar","atm Correcion")
grid on 

figure(11)
plot(manglares_Cuenca_Adentro.fecha,manglares_Cuenca_Adentro.presionMbar,'r.-')
hold on 
plot(PresionATMFechaAv,PresionATMAv,'b.-')
legend("manglar","atm Correcion")
grid on 


figure(12)
plot(manglares_Cuenca_Afuera.fecha,manglares_Cuenca_Afuera.presionMbar,'r.-')
hold on 
plot(PresionATMFechaAv,PresionATMAv,'b.-')
legend("manglar","atm Correcion")
grid on 


%vemos que ya no hay  ningun dato random 

%MAAÑANA TENEMOS QUE HACER LA CORRECION DE LOS NIVELES EN BASE A LOS
%NIVELES DE LOS SENSORES 








