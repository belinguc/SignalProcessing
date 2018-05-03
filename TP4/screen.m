
Fe = 1000; % frequence d'echantillonage

m1=[zeros(3000,1);hanning(2000);-hanning(2000);zeros(3000,1)];
m2=[zeros(3000,1);-triang(2000);triang(2000);zeros(3000,1)];

t=0:1/Fe:(numel(m1)-1)/Fe;
f = (-Fe/2:Fe/(numel(m1)-1):Fe/2);

%-------------------------- MODULATION ------------------------------------
f0=10;
x1=m1'.*cos(2*pi*f0*t); %transposé de m1
x2=m2'.*sin(2*pi*f0*t); %transposé de m2
y=x1+x2;

%-------------------------- Q1: TF de x1 et x2 ----------------------------
TFx1=tfourier(x1); % transformé de fourrier du signal x1
TFx2=tfourier(x2); % transformé de fourrier du signal x2
TFy=tfourier(y); % transformé de fourrier du signal y

%------------------- Q2: Densité spectrale --------------------------------
Sx=TFx1.*conj(TFx2);

%------------------- Q3: Fonction intercorrélation ------------------------
Rx=ifft(Sx);
figure
plot(t,Rx)

%-------------------------- Q3: Energie intercorrélation ------------------
% Ex=Rx(0)=0

% ------------------------- Q4: DEMODULATION ------------------------------
fd0=10;
z1=y.*cos(2*pi*fd0*t); % module par cos(2*pi*fd0*t)
z2=y.*sin(2*pi*fd0*t); % module par sin(2*pi*fd0*t)

%------------------- FILTRAGE PASSE-BAS z1 --------------------------------
[vB,vA] = butter(8,5/(Fe/2)); % fc=5, 4 correspond à l'odre du filtre
z1filtre = filter(vB,vA,z1); % filtrage passe bas avec fmax < fc

%------------------- FILTRAGE PASSE-BAS z2 --------------------------------
[vB,vA] = butter(8,5/(Fe/2)); % fc=5, 4 correspond à l'odre du filtre
z2filtre = filter(vB,vA,z2); % filtrage passe bas avec fmax < fc


