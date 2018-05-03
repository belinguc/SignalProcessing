clear ; clc ; close all

Fe = 1000; % frequence d'echantillonage

m1=audioread('/Users/christopherbelinguier/Documents/MATLAB/TP4/son.wav');

t=0:1/Fe:(numel(m1)-1)/Fe;

figure
plot(t,m1)

f = (-Fe/2:Fe/(numel(m1)-1):Fe/2);
TFm1=fftshift(fft(m1)); % transformé de fourrier du signal x
Sm1=abs(TFm1).^2; % spectre du signal x
figure
plot(f,Sm1)

%-------------------------- MODULATION ------------------------------------
f0=10;
x1=m1'.*cos(2*pi*f0*t); %transposé de m1
y=x1;
 
figure
plot(t,x1)
figure
plot(t,y)

%-------------------------- Q1: TF de x1 et x2 ----------------------------
f = (-Fe/2:Fe/(numel(x1)-1):Fe/2);
TFx1=fftshift(fft(x1)); % transformé de fourrier du signal x
Sx1=abs(TFx1).^2; % spectre du signal x
figure
plot(f,Sx1)

TFx2=fftshift(fft(x2)); % transformé de fourrier du signal x
Sx2=abs(TFx2).^2; % spectre du signal x
figure
plot(f,Sx2)

TFy=fftshift(fft(y)); % transformé de fourrier du signal x
Sy=abs(TFy).^2; % spectre du signal x
figure
plot(f,Sy)

%-------------------------- Q2: Densité spectrale -------------------------
Sx=TFx1.*conj(TFx2);
Sxaff=abs(Sx).^2; % spectre du signal x
figure
plot(f,Sxaff)

%-------------------------- Q2: Fonction corrélation ----------------------
Rx=ifft(Sx);
figure
plot(t,Rx)

%-------------------------- Q3: Energie intercorrélation ------------------
% Ex=Rx(0)=0

% ------------------------- Q4: DEMODULATION ------------------------------
fd0=10;
z1=y.*cos(2*pi*fd0*t);
z2=y.*sin(2*pi*fd0*t);
 
figure
plot(t,z1)
figure
plot(t,z2)


f = (-Fe/2:Fe/(numel(z1)-1):Fe/2);
TFz1=fftshift(fft(z1)); % transformé de fourrier du signal x
Sz1=abs(TFz1).^2; % spectre du signal x
figure
plot(f,Sz1)

TFz2=fftshift(fft(z2)); % transformé de fourrier du signal x
Sz2=abs(TFz2).^2; % spectre du signal x
figure
plot(f,Sz2)

%---------------------------- FILTRAGE PASSE-BAS z1 -----------------------
[vB,vA] = butter(8,5/(Fe/2)); %fc=5, 4 correspond à l'odre du filtre
z1filtre = filter(vB,vA,z1); %filtrage passe bas de la partie positive du signal modulé

figure
plot(t,z1filtre)

TFz1f=fftshift(fft(z1filtre)); % transformé de fourrier du signal x
Sz1f=abs(TFz1f).^2; % spectre du signal x
figure
plot(f,Sz1f)

sound (Sz1f)

