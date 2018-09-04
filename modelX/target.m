function base_psi = target(N)
% generate the base wavelet 
    t=linspace(-3, 3, N);
    % base spike function
    base_psi=(exp(-5*(t+0.5).^2)-(1/5*exp(-(t-0.5).^2)));
    % sum off the wavelet samples must be zero 
    base_psi = (base_psi-mean(base_psi));       
end