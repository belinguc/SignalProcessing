clear ; clc ; close all

Fe = 30000;
t = (0:(1/Fe):0.1-(1/Fe));
l = 5000;

%----------------------- SIGNAL DEFAUT ------------------------------------
f0 = 5000;
s = exp(-l*t).*sin(2*pi*f0*t).*(t>0);
figure
plot(t,s);
title('signal defaut')

%FFT = transformee_fourier(s,Fe,t);
f = (-Fe/2:Fe/(numel(s)-1):Fe/2);
TFs=fftshift(fft(s)); % transformé de fourrier du signal x
Ss=abs(TFs).^2; % spectre du signal x
figure
plot(f,Ss)
title('TF signal defaut')

%----------------------- DEFAUT BAGUE EXTERNE -----------------------------
Fdbe = 480;
xe = SommeSignal(l,f0,t,Fdbe,Fe);
title('signal defaut bague externe')

%FFT = transformee_fourier(xe,Fe,t);
TFxe=fftshift(fft(xe)); % transformé de fourrier du signal x
Sxe=abs(TFxe).^2; % spectre du signal x
figure
plot(f,Sxe,'b'); xlabel('f'); ylabel('|TFxe(f)|');
title('TF signal defaut bague externe');
hold on
plot(f,Ss,'r');

%----------------------- DEFAUT BAGUE INTERNE -----------------------------
Fdbi = 520;
Fa = 100;
xi = SommeSignal(l,f0,t,Fdbi,Fe).*(1+cos(2*pi*Fa*t));
title('signal defaut bague interne')
figure
plot(t,xi);
title('signal defaut bague interne modulé')

%FFT = transformee_fourier(xe,Fe,t);
TFxi=fftshift(fft(xi)); % transformé de fourrier du signal x
Sxi=abs(TFxi).^2; % spectre du signal x
figure
plot(f,Sxi,'b'); xlabel('f'); ylabel('|TFxi(f)|');
title('TF signal defaut bague interne')
hold on
plot(f,Ss,'r');

