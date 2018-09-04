global cascade_level;
for i = 1 : 3
    for j = 1:10
        cascade_level = j;
        [g, h, g_prima, h_prima] = spike_wavelet(i*2);
    end
end