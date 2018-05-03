clear ; clc ; close all

Fe = 2000;
t = (0:(1/Fe):1-(1/Fe));


%----------------------- LE SIGNAL ----------------------------------------
f1 = 20;
f2 = 40;
x = sin(2*pi*f1*t)+sin(2*pi*f2*t); %signal compos� de 2 fr�quences � 20 et 40 Hz
figure
plot(t,x)

f = (-Fe/2:Fe/(numel(x)-1):Fe/2); %ensemble des fr�quences = abscisse des repr�sentations fr�quentielles

FFT = transformee_fourier(x,Fe,t);

%---------------------- MODULATION ----------------------------------------
a = 1/2; %indice de modulation 
f0 = 500; %frequence de porteuse
y=(1+a.*x).*sin(2*pi*f0*t); % signal x modul� = y
figure
plot(t,y)

FFT = transformee_fourier(y,Fe,t);

%---------------------- DEMODULATION --------------------------------------
%---------------------- REDRESSAGE ----------------------------------------
ypp=subplus(y); %r�cup�ration de la partie positive du signal modul�
figure
plot(t,ypp)

FFT = transformee_fourier(ypp,Fe,t);

%---------------------- FILTRAGE PASSE-BAS --------------------------------
[vB,vA] = butter(4,100/(2000/2));
yppfiltre = filter(vB,vA,ypp); %filtrage passe bas de la partie positive du signal modul�

figure
plot(t,yppfiltre)

FFT = transformee_fourier(yppfiltre,Fe,t);

