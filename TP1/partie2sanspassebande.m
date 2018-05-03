clear ; clc ; close all

Fe = 2000;
t = (0:(1/Fe):1-(1/Fe));
%----------------------- LE SIGNAL ----------------------------------------
f1 = 20;
f2 = 40;
f3 = 60;
x1 = sin(2*pi*f1*t)+sin(2*pi*f2*t); %signal 1 compos� de 2 fr�quences � 20 et 40 Hz
x2 = cos(2*pi*f3*t); %signal 2 avec une fr�quence de 60 Hz
x = x1 + x2; %signal compos� des deux signaux
figure
plot(t,x)

f = (-Fe/2:Fe/(numel(x)-1):Fe/2); %ensemble des fr�quences = abscisse des repr�sentations fr�quentielles
FFT = transformee_fourier(x,Fe,t);

%---------------------- MODULATION ----------------------------------------
a = 1/2; %indice de modulation 
f01 = 400; %frequence de porteuse du signal 1
f02 = 800; %frequence de porteuse du signal 2
y1=(1+a.*x1).*sin(2*pi*f01*t); % signal x1 modul� = y1
y2=(1+a.*x2).*sin(2*pi*f02*t); % signal x2 modul� = y2
y = y1 + y2; % signal x modul� = y
figure
plot(t,y)

FFT = transformee_fourier(y,Fe,t);

%---------------------- DEMODULATION --------------------------------------
%Pas de filtrage passe bande
%---------------------- REDRESSAGE ----------------------------------------
ypp1=subplus(y); %r�cup�ration de la partie positive du signal modul� 1
%figure
%plot(t,ypp1)
%FFT = transformee_fourier(ypp1,Fe,t);

%ypp2=subplus(y2filtre); %r�cup�ration de la partie positive du signal modul� 2
%figure
%plot(t,ypp2)
%FFT = transformee_fourier(ypp2,Fe,t);

%---------------------- FILTRAGE PASSE-BAS --------------------------------
[vB,vA] = butter(4,100/(2000/2));
yppfiltre1 = filter(vB,vA,ypp1); %filtrage passe bas de la partie positive du signal modul�
figure
plot(t,yppfiltre1)
FFT = transformee_fourier(yppfiltre1,Fe,t);
