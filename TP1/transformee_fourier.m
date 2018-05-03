function FFT = transformee_fourier(x,Fe,t)
mesF=(-Fe/2:Fe/(numel(x)-1):Fe/2); %ensemble des fr�quences pour lesquelles on va calculer la transform�e de Fourier
% autre fa�on de faire : mesF=linspace(-Fe/2,Fe/2,numel(x));
indice=1;
FFT=zeros(size(mesF)); %on cr�e un vecteur de la taille de l'ensemble des fr�quences, initialis� � z�ro
while(indice<numel(x)) %on fait une boucle pour se ramener � un cas discret qui sera ex�cut�e le nombre d'�lements de x
    FFT(indice)=sum( x.*exp(-2i*pi*mesF(indice).*t ) ); %calcul de la transform�e de Fourier
    indice=indice+1;
end
figure;
plot(mesF,subplus(real(FFT))); %affichage de la representation fr�quentielle
grid on;
end