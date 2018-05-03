clear ; clc ; close all

Fe = 2000;
t = (0:(1/Fe):1-(1/Fe));


%----------------------- LE SIGNAL ----------------------------------------
f1 = 20;
f2 = 40;
x = sin(2*pi*f1*t)+sin(2*pi*f2*t);
figure (1)
plot(t,x)

f = (-Fe/2:Fe/(numel(x)-1):Fe/2);

TFx=fftshift(fft(x)); % transformé de fourrier du signal x
Sx=abs(TFx).^2; % spectre du signal x
figure (2)
plot(f,Sx)

%---------------------- MODULATION ----------------------------------------
a = 1/2;
f0 = 500;
y=(1+a.*x).*sin(2*pi*f0*t); % signal x modulé = y
figure (3)
plot(t,y)

TFy=fftshift(fft(y)); % transformé de fourrier du signal y
Sy=abs(TFy).^2; % spectre du signal y
figure (4)
plot(f,Sy)

%---------------------- DEMODULATION --------------------------------------
%---------------------- REDRESSAGE ----------------------------------------
ypp=subplus(y);
figure (5)
plot(t,ypp)

TFypp=fftshift(fft(ypp)); % transformé de fourrier du signal ypp
Sypp=abs(TFypp).^2; % spectre du signal ypp
figure (6)
plot(f,Sypp)

%---------------------- FILTRAGE PASSE-BAS --------------------------------
N=100;%filtrage a 100 hz, (rapport de reduction par rapport au nombre d'élément de x qui depend de t)
filtre=zeros(size(f)); % séquence de 2000 valeurs à '0'
filtre(1,1:N)=ones(1,N); % on met des '1' du début de la séquence jusqu'à 100

%----------------------- SIGNAL FILTRÉ ------------------------------------
TFypp=fft(ypp); % transformé de fourrier de ypp
TFyppfiltre=filtre.*TFypp; % filtrage de ypp dans le domaine fréquentiel
yppfiltre=ifft(TFyppfiltre); % signal ypp filtré dans le domaine temporel

figure (7)
plot(t,yppfiltre) % représentation temporelle du signal ypp filtré


TFyppfiltre2=fftshift(TFyppfiltre); % transformé de fourrier du signal ypp filtré
Syppfiltre2=abs(TFyppfiltre2).^2; % spectre du signal ypp filtré
figure (8)
plot(f,Syppfiltre2) % représentation du spectre du signal ypp filtré

