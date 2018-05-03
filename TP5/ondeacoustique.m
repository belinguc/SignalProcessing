function y = ondeacoustique(t, n, l, c, alpha, f0)

    array = zeros(1, length(t));
    
    a = (n*l/c);
    b = sqrt(-1)*2*pi*f0;
    
    for k=1:length(alpha)
        array(k) = exp( b * ( t+ a*sin( alpha(k) ) ) );
    end
    
    y = array;
end

