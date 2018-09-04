function out = similarity(a, b, type, lev, wavelet, wav_type)
% Calculates the similarity of two signals (a, b) using point wise or
% Dinamic Time Warping (DTW). The library mex dtw_c.c; should be loaded.
% lev 0 is the original signal.
    
    a_norm = (a - mean(a)) / std(a);
    b_norm = (b - mean(b)) / std(b);
    if (lev > 1)
        switch wav_type
            case 1  % proposal 
                load(sprintf('../../results/Best_results/%s',wavelet));
            case 2  % generic 
                [h,g,~,~] = wfilters(wavelet);
            otherwise
                warning('Unexpected wavelet type. No decomposition calculated.')
        end
        a_norm = decomposition(g, h, a_norm, lev-1);
        b_norm = decomposition(g, h, b_norm, lev-1);
    end
    switch type
        case 1
            out = 1 - (sum(abs(a_norm - b_norm))/ (sum(abs(a_norm)) + sum(abs(b_norm))));
        case 2
            out = dtw_c(a_norm, b_norm);
        otherwise
            warning('Unexpected similarity type. No similarity calculated.')
    end
end