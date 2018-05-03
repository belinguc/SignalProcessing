
function y = SommeSignal(l,f0,t,Fdbe,Fe)
    nb_clac=numel(t)/Fe*(Fdbe-1);
    array = zeros(size(t));

    for i =0:nb_clac-1
        array = array + exp(-l*(t-(i/Fdbe))).*sin(2*pi*f0*(t-(i/Fdbe))).*((t-(i/Fdbe))>0);
    end
    
    y=array/nb_clac;%on divise par le nombre de clac pour normaliser l'energie à un clac
    figure
    plot(t,y);
end

