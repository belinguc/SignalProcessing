clear ; clc ; close all

Fe = 1000; % frequence d'echantillonage

m1=[zeros(3000,1);hanning(2000);-hanning(2000);zeros(3000,1)];
m2=[zeros(3000,1);-triang(2000);triang(2000);zeros(3000,1)];

t=0:1/Fe:(numel(m1)-1)/Fe;

figure
plot(t,m1); title('m1'); xlabel('t'); ylabel('m1');
figure
plot(t,m2); title('m2'); xlabel('t'); ylabel('m1');

f = (-Fe/2:Fe/(numel(m1)-1):Fe/2);
TFm1=fftshift(fft(m1)); % transformé de fourrier du signal x
Sm1=abs(TFm1).^2; % spectre du signal x
figure
plot(f,Sm1,'b'); %title('module de la tf du signal m1'); xlabel('f');
TFm2=fftshift(fft(m2)); % transformé de fourrier du signal x
Sm2=abs(TFm2).^2; % spectre du signal x
hold on
plot(f,Sm2,'r'); title('module de la tf des signaux m1 et m2'); xlabel('f');
%UTILISER SUBPLOT(2,1,1) pour comparer
%-------------------------- MODULATION ------------------------------------
f0=10;
x1=m1'.*cos(2*pi*f0*t); %transposé de m1
x2=m2'.*sin(2*pi*f0*t); %transposé de m2
y=x1+x2;

% Calcul la phase mais des signaux modulés !
am1=angle(m1);
figure
plot(t,am1)
am2=angle(m2);
hold on
plot(t,am2); title('phase de x1 et x2');


figure
plot(t,x1); title('Signal x1'); xlabel('t'); ylabel('x1');
figure
plot(t,x2); title('Signal x2'); xlabel('t'); ylabel('x2');
figure
plot(t,y); title('Signal transmis y'); xlabel('t'); ylabel('y');

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
plot(f,Sy); title('module de la tf du signal transmis y'); xlabel('f');

%-------------------------- Q2: Densité spectrale -------------------------
Sx=TFx1.*conj(TFx2);
Sxaff=abs(Sx).^2; % spectre du signal x
figure
plot(f,Sxaff); title('Densité spectrale'); xlabel('f'); ylabel('Sx1x2');

%-------------------------- Q2: Fonction corrélation mutuelle ----------------------
Rx=ifft(Sx);
figure
plot(t,Rx); title('Fonction de corrélation mutuelle'); xlabel('f'); ylabel('Rx1x2');

%-------------------------- Q3: Energie d'interraction ------------------
% Ex=Rx(0)=0

% ------------------------- Q4: DEMODULATION ------------------------------
fd0=10;
z1=y.*cos(2*pi*fd0*t);
%z1=y.*cos(2*pi*fd0*t-(pi/4));
%z1=y.*cos(2*pi*fd0*t-(pi/2));
z2=y.*sin(2*pi*fd0*t);
 
figure
plot(t,z1); title('Signal z1'); xlabel('t'); ylabel('z1');
figure
plot(t,z2); title('Signal z2'); xlabel('t'); ylabel('z2');


f = (-Fe/2:Fe/(numel(z1)-1):Fe/2);
TFz1=fftshift(fft(z1)); % transformé de fourrier du signal x
Sz1=abs(TFz1).^2; % spectre du signal x
figure
plot(f,Sz1,'b'); xlabel('f');

TFz2=fftshift(fft(z2)); % transformé de fourrier du signal x
Sz2=abs(TFz2).^2; % spectre du signal x
hold on
plot(f,Sz2,'r'); title('module de la tf des signaux démodulé z1 et z2'); xlabel('f');

%------------------- FILTRAGE PASSE-BAS z1 --------------------------------
[vB,vA] = butter(8,5/(Fe/2)); %fc=5, 4 correspond à l'odre du filtre
z1filtre = filter(vB,vA,z1); %filtrage passe bas

figure
plot(t,z1filtre); title('Signal z1 filtré'); xlabel('t'); ylabel('z1');

TFz1f=fftshift(fft(z1filtre)); % transformé de fourrier du signal x
Sz1f=abs(TFz1f).^2; % spectre du signal x
figure
plot(f,Sz1f); title('module de la tf du signal demodulé, filtré z1'); xlabel('f');

%------------------- FILTRAGE PASSE-BAS z2 --------------------------------
[vB,vA] = butter(8,5/(Fe/2)); %fc=5, 4 correspond à l'odre du filtre
z2filtre = filter(vB,vA,z2); %filtrage passe bas 

figure
plot(t,z2filtre); title('Signal z2 filtré'); xlabel('t'); ylabel('z2');
%--
TFz1f=fftshift(fft(z1filtre)); % transformé de fourrier du signal x
Sz1f=abs(TFz1f).^2; % spectre du signal x
figure
plot(f,Sz1f,'b'); title('module de la tf du signal demodulé, filtré z1'); xlabel('f');
%--
TFz2f=fftshift(fft(z2filtre)); % transformé de fourrier du signal x
Sz2f=abs(TFz2f).^2; % spectre du signal x
hold on
plot(f,Sz2f,'r'); title('module de la tf des signaux demodulés, filtrés z1 et z2'); xlabel('f');
