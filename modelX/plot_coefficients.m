function plot_coefficients(h_1, h, cascade_level)
% plot the coefficients and the functions associated 
    L = length(h_1); % number of coefficients
    %generate the functions
    [phi, psi] = wavefun2(h_1, h, cascade_level);
    %--- generate base wavelet 
    base_psi = target(length(psi));
    % ploting the results
    figure(1);
    
    subplot(221)
    stem(h)
    title(sprintf('Scaling coefficients--cascade level-%d-coeff-%d',cascade_level,L))
    subplot(222)
    stem(h_1)
    title('Wavelet coefficients')

    subplot(223)
    plot(phi, 'b')
    title('Calculated scaling function (blue)')

    subplot(224)
    plot(psi, 'b')
    hold on
    plot(base_psi, 'r')
    hold off
    title('Calculated wavelet (blue)/ base psi (red)')
end
