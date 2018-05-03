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

TFx=fftshift(fft(x)); % transform� de fourrier du signal x
Sx=abs(TFx).^2; % spectre du signal x
figure (2)
plot(f,Sx)

%---------------------- MODULATION ----------------------------------------
a = 1/2;
f0 = 500;
y=(1+a.*x).*sin(2*pi*f0*t); % signal x modul� = y
figure (3)
plot(t,y)

TFy=fftshift(fft(y)); % transform� de fourrier du signal y
Sy=abs(TFy).^2; % spectre du signal y
figure (4)
plot(f,Sy)

%---------------------- DEMODULATION --------------------------------------
%---------------------- REDRESSAGE ----------------------------------------
ypp=subplus(y);
figure (5)
plot(t,ypp)

TFypp=fftshift(fft(ypp)); % transform� de fourrier du signal ypp
Sypp=abs(TFypp).^2; % spectre du signal ypp
figure (6)
plot(f,Sypp)

%---------------------- FILTRAGE PASSE-BAS --------------------------------
N=100;%filtrage a 100 hz, (rapport de reduction par rapport au nombre d'�l�ment de x qui depend de t)
filtre=zeros(size(f)); % s�quence de 2000 valeurs � '0'
filtre(1,1:N)=ones(1,N); % on met des '1' du d�but de la s�quence jusqu'� 100

%----------------------- SIGNAL FILTR� ------------------------------------
TFypp=fft(ypp); % transform� de fourrier de ypp
TFyppfiltre=filtre.*TFypp; % filtrage de ypp dans le domaine fr�quentiel
yppfiltre=ifft(TFyppfiltre); % signal ypp filtr� dans le domaine temporel

figure (7)
plot(t,yppfiltre) % repr�sentation temporelle du signal ypp filtr�


TFyppfiltre2=fftshift(TFyppfiltre); % transform� de fourrier du signal ypp filtr�
Syppfiltre2=abs(TFyppfiltre2).^2; % spectre du signal ypp filtr�
figure (8)
plot(f,Syppfiltre2) % repr�sentation du spectre du signal ypp filtr�

