
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

FFT = transformee_fourier(s,Fe,t);
title('TF signal defaut')

%----------------------- DEFAUT BAGUE EXTERNE -----------------------------
Fdbe = 480;
xe = SommeSignal(l,f0,t,Fdbe,Fe);
title('signal defaut bague externe')

FFT = transformee_fourier(xe,Fe,t);
title('TF signal defaut bague externe')
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

FFT = transformee_fourier(xe,Fe,t);
title('TF signal defaut bague interne')
hold on
plot(f,Ss,'r');


