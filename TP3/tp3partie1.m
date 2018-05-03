clear ; clc ; close all

Fe = 3000; % frequence d'echantillonage
t = 0:1/Fe:1-(1/Fe);
T=0:1/Fe:(3*numel(t)-1)/Fe;

Fdo=554; Fre=587; Fmi=659; % frequence des notes de musique do, re, mi

xdo = sin(2*pi*Fdo*t); xre = sin(2*pi*Fre*t); xmi = sin(2*pi*Fmi*t); 
% signaux des notes de musique do, re, mi
y = [xdo xre xmi]; % vecteur constitué des 3 signaux do, re, mi à la suite

N =length(y); % taille du vecteur y (vecteur constitué des 3 signaux)
f = 0:Fe/N:Fe*(N-1)/N;
Nfen=200; % taille de la fenetre
h = hanning(Nfen); % fenetre de hanning de la taille Nfen
Nbfen = floor(N/Nfen); % nombre de fentre en fonction de la taille d'une 
% fentre et de l'echantillon. On prend la valeur par défaut de la division,
% on peut perdre une partie de la fin du signal

spectro = zeros (Nbfen,Nfen); % initialise à 0 la matrice du spectrogramme
% de la taille du nombre de fentre (Nbfen) par la taille d'une fenetre (Nfen)

ffy = fft(y); % calcul de la transformée de Fourrier du signal y 
figure(1);
plot(f, abs(ffy)); title('module de la tf de y');
figure(2);
plot(f, angle(ffy)); title('phase de la tf de y');

% calcul de la fentre glissante
for i = 1 : Nbfen
    indicedebut = (i-1)*Nfen+1; % indice du debut de la fenetre i
    indicefin = indicedebut + Nfen-1; % indice de fin de la fenetre i
    vectps(i) = (T(indicedebut) + T(indicefin))/2; % echelle du temps
    Fy = fftshift(fft((y(indicedebut:indicefin)'.*h))); 
    % tf d'un morceau du signal y multiplié par la fenetre de hanning
    spectro(i,:) = abs(Fy)';
end;
vecfreq = linspace(-Fe/2,Fe/2,size(spectro,2)); % echelle des frequences
figure
imagesc(vectps, vecfreq, abs(spectro'));%representation du spectrogramme 2D
title('spectrogramme'); xlabel('t'); ylabel('f');

figure
surf(vectps, vecfreq, abs(spectro'))%representation du spectrogramme 3D
