clear
clc
mex dtw_c.c;
load('..\..\data\spelling_experiment\S1.mat');
[electrodes, samples, stimuli, blocks] = size(data);
N = electrodes*stimuli;

proposed_wavelets = {'spike_4-cascade_1', 'spike_4-cascade_2'};

generic_wavelets = {'db3', 'coif1'};

x = zeros(N, (length(proposed_wavelets) + length(generic_wavelets) + 1)); % plus original
similarity_type = 1;  % 1 uses point wise, 2 uses DTW
signal_count = 1
% calculate the original
fprintf('original signal');
for electrode = 1:electrodes
    for stimulus = 1:stimuli
        x((electrode-1)*stimuli + stimulus, signal_count) = cross_similarity(reshape(data(electrode,:,stimulus,:), 1500, 6), similarity_type, 'original', 3);
    end
end

for i = 1:length(proposed_wavelets) 
    signal_count = signal_count + 1
    wavelet = proposed_wavelets{i}
    for electrode = 1:electrodes
        for stimulus = 1:stimuli
            x((electrode-1)*stimuli + stimulus, signal_count) = cross_similarity(reshape(data(electrode,:,stimulus,:), 1500, 6), similarity_type, wavelet, 1);
        end
    end
end

for i = 1:length(generic_wavelets) 
    signal_count = signal_count + 1
    wavelet = generic_wavelets{i}
    for electrode = 1:electrodes
        for stimulus = 1:stimuli
            x((electrode-1)*stimuli + stimulus, signal_count) = cross_similarity(reshape(data(electrode,:,stimulus,:), 1500, 6), similarity_type, wavelet, 2);
        end
    end
end

figure(1)
labels = [{'original'}, proposed_wavelets, generic_wavelets];
boxplot(x,'Labels', labels, 'MedianStyle','line','Widths',0.15, 'Symbol' , '')
title(sprintf('Comparative'))
savefig(sprintf('comparative2.fig'))

