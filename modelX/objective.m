function fun = objective(h_1)
% function used as objective for the optimization method fmincon
% the cascade level should be defined before use this function
    global cascade_level;
    L = length(h_1); % number of coefficients even number
    % calculate scaling coefficients from wavelet coefficients
    r = L+1;
    h=zeros(1,L);
    for l=1:L
        h(l) = ((-1)^(l-r))*h_1(r-l); 
    end
    % ---- generate wavelet function assosiated to the coefficients
    [~, psi] = wavefun2(h_1, h, cascade_level);
    % --- generate base wavelet 
    base_psi = target(length(psi));
    %---- compare both signals
    fun = sum((base_psi - psi).^2);
end