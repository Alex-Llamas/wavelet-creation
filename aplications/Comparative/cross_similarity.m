function out = cross_similarity(signals, type, wavelet, wav_type)
% calculates the average similarity associated with the same stimuli 
    [~, N]=size(signals);
    v = 1:1:N;
    b = nchoosek(v,2);
    sum = 0;
    for i = 1:length(b)
        sum = sum + similarity(signals(:,b(i,1)), signals(:,b(i,2)), type, wavelet, wav_type);
    end
    out = sum / length(b);
end