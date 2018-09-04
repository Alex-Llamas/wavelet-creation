function [h_1_prima, h_prima] = reconstruction_coefficients(h_1, h)
    L = length(h_1); 
    % h1_prima is the reconstruction low pass filter
    h_prima= zeros(1,L);
    for l=1:L
        h_prima(l) = ((-1)^(l))*h_1(l);  
    end
    % h_prima is the reconstruction high pass filter
    h_1_prima = zeros(1,L);
    for l=1:L
        h_1_prima(l) = -((-1)^(l))*h(l); 
    end
end