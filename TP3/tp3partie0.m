clear ; clc ; close all

Fe = 3000; % frequence d'echantillonage
t = (0:(1/Fe):2-(1/Fe)); % echelle du temps
f1=100; % frequence du signal 1
f2=25; % frequence du signal 2

fenHan = hann(round(numel(t)/2))'; 
% fenetre de hanning de la moitie de la taille de notre échelle des temps 
hannGauche = [fenHan zeros(1,numel(t)-numel(fenHan) )]; 
% fentre de hanning sur la premiere moitié de notre échelle des temps
hannDroite = [zeros(1,numel(t)-numel(fenHan) )  fenHan ];
% fentre de hanning sur la deuxieme moitié de notre échelle des temps

x1=exp(2j*pi*f1*t).*hannGauche; 
% signal 1 multiplié par la 1ere fenetre de hanning
x2=exp(2j*pi*f2*t).*hannDroite; 
% signal 2 multiplié par la 2eme fenetre de hanning

y=x1+x2; % somme des signaux x1 et x2
figure
plot(t,y)
title('signal y'); xlabel('t');

f = (-Fe/2:Fe/(numel(y)-1):Fe/2); % echelle des frequences
TFy=fftshift(fft(y)); % transformé de fourrier du signal y
Sy=abs(TFy).^2; % spectre du signal 
figure
plot(f,Sy)
title('Transformée de Fourier du signal y'); xlabel('f');

