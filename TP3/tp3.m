clc;
clear;
close all;

Fdo = 554,37;
Fre = 587,33;
Fmi = 659,26;
Fe = 2000;
t = 0:1/Fe:1;

xdo = sin(2*pi*Fdo*t);
xre = sin(2*pi*Fre*t);
xmi = sin(2*pi*Fmi*t);
x = [xdo xre xmi];

Nfen = 256; % nb pair
h = hanning(Nfen);
N =length(x);
Nbfen = N - Nfen; % a calculer
nf = 128; % nb de points de calcul de la TF
spectro = zeros (Nbfen,nf);

ffx = fft(x);
f = 0:Fe/N:Fe*(N-1)/N;
figure(1);
plot(f, abs(ffx)); title('représentation abs de tf de x');
figure(2);
plot(f, angle(ffx)); title('représentation phase de tf de x');

for i = 1 : Nbfen
    indicedebut = i;
    indicefin = i + Nfen-1;
    Fx = fourier((x(indicedebut:indicefin)'.*h),Fe,nf);
    spectro(i,:) = abs(Fx);
end;

% mauvaise résolution fréquentielle pour fenetre tres courte mais
% transition précise
% bonne resolution fréquentielle pour fenetre tres grande mais transition
% plus large et "flou"
% Cela est du a tF en effet tf de temps tres court est sur frequence
% importante. Large en frequence et court en temps.

figure(3);
imagesc(spectro');
colormap(gray);

%-------------------------------------------------------------------------

%Avec signal chelou

N = 1024;
Fe = 2000;
x = sin(2*pi/8/N*[0:N-1].^2);
x = x.*hanning(N)';


Nfen = 64; % nb pair
h = hanning(Nfen);
Nbfen = N - Nfen; % a calculer
nf = 128; % nb de points de calcul de la TF
spectro = zeros (Nbfen,nf);

figure(4);
plot(0:N-1, x); title('représentation fonction temporelle');
ffx = fft(x);
f = 0:fe/N:fe*(N-1)/N;
figure(1);
plot(f, abs(ffx)); title('représentation abs de tf de x');
figure(2);
plot(f, angle(ffx)); title('représentation phase de tf de x');

for i = 1 : Nbfen
    indicedebut = i;
    indicefin = i + Nfen-1;
    Fx = Fourier((x(indicedebut:indicefin)'.*h),Fe,nf);
    spectro(i,:) = abs(Fx);
end;


figure(3);
imagesc(spectro');
