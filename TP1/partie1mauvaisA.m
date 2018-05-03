clear ; clc ; close all

Fe = 2000;
t = (0:(1/Fe):1-(1/Fe));


%----------------------- LE SIGNAL ----------------------------------------
f1 = 20;
f2 = 40;
x = sin(2*pi*f1*t)+sin(2*pi*f2*t);
figure
plot(t,x)

f = (-Fe/2:Fe/(numel(x)-1):Fe/2);

FFT = transformee_fourier(x,Fe,t);

%---------------------- MODULATION ----------------------------------------
a = 2;
f0 = 500;
y=(1+a.*x).*sin(2*pi*f0*t); % signal x modulé = y
figure
plot(t,y)

FFT = transformee_fourier(y,Fe,t);

%---------------------- DEMODULATION --------------------------------------
%---------------------- REDRESSAGE ----------------------------------------
ypp=subplus(y);
figure
plot(t,ypp)

FFT = transformee_fourier(ypp,Fe,t);

%---------------------- FILTRAGE PASSE-BAS --------------------------------
[vB,vA] = butter(4,100/(2000/2));%ordre du filtre, fc, fe/2
yppfiltre = filter(vB,vA,ypp);

figure
plot(t,yppfiltre) % représentation temporelle du signal ypp filtré

FFT = transformee_fourier(yppfiltre,Fe,t);

