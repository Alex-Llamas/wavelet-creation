function out = similarity(a, b, type, wavelet, wav_type)
% Calculates the similarity of two signals (a, b) using point wise or
% Dinamic Time Warping (DTW). The library mex dtw_c.c; should be loaded.

    
    a_norm = (a - mean(a)) / std(a);
    b_norm = (b - mean(b)) / std(b);

    switch wav_type
        case 1  % proposal wavelet
            load(sprintf('coefficients/%s.mat',wavelet));
            a_norm = decomposition(g, h, a_norm);
            b_norm = decomposition(g, h, b_norm);
        case 2  % generic wavelet
            [h,g,~,~] = wfilters(wavelet);
            a_norm = decomposition(g, h, a_norm);
            b_norm = decomposition(g, h, b_norm);
        case 3  % original 
            % do nothing
        otherwise
            warning('Unexpected wavelet type. No decomposition calculated.')
    end


    switch type
        case 1
            out = (1 - (sum(abs(a_norm - b_norm))/ (sum(abs(a_norm)) + sum(abs(b_norm)))))*100;
        case 2
            out = dtw_c(a_norm, b_norm);
        otherwise
            warning('Unexpected similarity type. No similarity calculated.')
    end
end