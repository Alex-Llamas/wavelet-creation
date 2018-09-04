function out = decomposition(h_1, h, signal)
    lev   = 1;  % define the number of levels for the wavalet decomposition
    nbcol = 64;
    
    [c,l] = wavedec(signal,lev,h,h_1);  % apply spike wavelet decomposition
    
    % Expand discrete wavelet coefficients for plot.
    len = length(signal);
    cfd = zeros(lev,len);
    for k = 1:lev
        d = detcoef(c,l,k);
        d = d(:)';
        d = d(ones(1,2^k),:);
        cfd(k,:) = wkeep1(d(:)',len);
    end
    cfd =  cfd(:);
    I = find(abs(cfd)<sqrt(eps));
    cfd(I) = zeros(size(I));
    cfd    = reshape(cfd,lev,len);
    cfd = wcodemat(cfd,nbcol,'row');
    out = cfd(1, :);
end