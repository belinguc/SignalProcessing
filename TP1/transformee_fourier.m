function FFT = transformee_fourier(x,Fe,t)
mesF=(-Fe/2:Fe/(numel(x)-1):Fe/2); %ensemble des fréquences pour lesquelles on va calculer la transformée de Fourier
% autre façon de faire : mesF=linspace(-Fe/2,Fe/2,numel(x));
indice=1;
FFT=zeros(size(mesF)); %on crée un vecteur de la taille de l'ensemble des fréquences, initialisé à zéro
while(indice<numel(x)) %on fait une boucle pour se ramener à un cas discret qui sera exécutée le nombre d'élements de x
    FFT(indice)=sum( x.*exp(-2i*pi*mesF(indice).*t ) ); %calcul de la transformée de Fourier
    indice=indice+1;
end
figure;
plot(mesF,subplus(real(FFT))); %affichage de la representation fréquentielle
grid on;
end