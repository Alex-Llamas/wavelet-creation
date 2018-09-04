clear
clc
mex dtw_c.c;
load('..\..\data\spelling_experiment\S1.mat');
[electrodes, samples, stimuli, blocks] = size(data);
N = electrodes*stimuli;
x = zeros(N, (3+1)); % 3 levels plus the original
similarity_type = 1;  % 1 uses point wise, 2 uses DTW
wavelets = {
    'variable-spike_4-cascade_1-sim_1.000000e+00.mat',
    'variable-spike_4-cascade_2-sim_1.000000e+00.mat',
    'variable-spike_4-cascade_3-sim_1.000000e+00.mat',
    'variable-spike_4-cascade_6-sim_1.000000e+00.mat',
    'variable-spike_4-cascade_9-sim_1.000000e+00.mat',
    'variable-spike_6-cascade_4-sim_9.827359e-01.mat',
    'variable-spike_6-cascade_6-sim_9.958483e-01.mat'};
for i = 1: length(wavelets)
    wavelet = wavelets{i}
    for lev = 1:(3+1)  % 3 levels plus the original
        lev
        for electrode = 1:electrodes
            for stimulus = 1:stimuli
                x((electrode-1)*stimuli + stimulus, lev) = cross_similarity(reshape(data(electrode,:,stimulus,:), 1500, 6), similarity_type, lev, wavelet, 1);
            end
        end
    end
    figure(1)
    labels = {'original', 'level_1', 'level_2', 'level_3'};
    boxplot(x,'Labels', labels, 'MedianStyle','line','Widths',0.15,'LabelOrientation','inline')
    title(sprintf('wavelet-%s',wavelet))
    savefig(sprintf('wavelet-%s.fig',wavelet))

end

wavelets = {'haar','db3','db5', 'db10', 'db20', 'db45', 'coif1', 'coif2', 'coif3', 'coif5', 'bior1.5', 'bior2.8', 'bior3.7', 'bior6.8', 'rbior1.5', 'rbior2.8', 'rbior3.7', 'rbior6.8'};
for i = 1: length(wavelets)
    wavelet = wavelets{i}
    for lev = 1:(3+1)  % 3 levels plus the original
        lev
        for electrode = 1:electrodes
            for stimulus = 1:stimuli
                x((electrode-1)*stimuli + stimulus, lev) = cross_similarity(reshape(data(electrode,:,stimulus,:), 1500, 6), similarity_type, lev, wavelet, 2);
            end
        end
    end
    figure(1)
    labels = {'original', 'level_1', 'level_2', 'level_3'};
    boxplot(x,'Labels', labels, 'MedianStyle','line','Widths',0.15,'LabelOrientation','inline')
    title(sprintf('wavelet-%s',wavelet))
    savefig(sprintf('wavelet-%s.fig',wavelet))

end