clear ; clc ; close all

%########################Initialisation########################

%paramètres généraux
Te = 0.1;
Fe = 1/Te;
N = 500;
t=(0:N-1)*Te;
f = linspace(0,Fe, N);
t0=1;

%paramètres de l'antenne
l = 0.4;
alpha = linspace(-pi/2,pi/2,N);
SinAlpha = linspace(-1,1,N);
alpha0 = pi/4;

%paramètres de l'onde
c = 340;
f0 = 400;
%l=c/f0; %test

%############################Traitement########################

% Fonction de sin(alpha)
y = zeros(1,length(alpha));
for j=1:N
    y(j) = exp(2*1i*pi*f0*j)*exp(1i*f0*pi*l*(N-1)*SinAlpha(j)/c)*( sin( pi*f0*N*l*SinAlpha(j)/c )/sin( pi*f0*l*SinAlpha(j)/c ) );
end

%Fonction de alpha
u = zeros(1,length(t));
for j=1:N
    u = u + ondeacoustique(t0,j,l,c,alpha,f0);
end

% Déphasage
yd = zeros(1,length(alpha));
for j=1:length(SinAlpha)
    yd(j) = abs(sin(pi*f0*N*l*( SinAlpha(j) - sin(alpha0) )/c )/sin(pi*f0*l*( SinAlpha(j) - sin(alpha0) )/c));
end

hanning= zeros(1,N);
% Pondération 
for j=1:N 
    hanning(j) = (1/2)*(1-cos(2*j*pi/N));
end

w = zeros(1,length(alpha));
for j =1:N
    w = w + exp( 2*1i*pi*f0*( t0 + j*l*( SinAlpha  - sin(alpha0) )/c) ) * hanning(j) ;
end


%###############################Affichage######################

figure;
plot(SinAlpha, abs(y));
title('Réponse de l''antenne suivant sin(alpha) ');
xlabel('sin(alpha)'); ylabel('|x(t)|');

figure;
polar(alpha, abs(u));
title('Réponse de l''antenne suivant l''angle alpha (l=0,4, c=340, f0=400, N=500)');
xlabel('alpha'); ylabel('|x(t)|');

figure;
plot(SinAlpha, abs(yd));
title('Réponse de l''antenne suivant un déphasage (l=0,4, c=340, f0=400, N=500)');
xlabel('sin(alpha)'); ylabel('|x(t)|');

figure;
plot(SinAlpha, abs(w));
title('Réponse de l''antenne suivant un déphasage et pondéré par une fenêtre de Hanning (l=0,4, c=340, f0=400, N=500)');
xlabel('sin(alpha)'); ylabel('|x(t)|');