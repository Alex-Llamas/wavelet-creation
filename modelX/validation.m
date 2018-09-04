function similarity = validation(h_1, h, h_1_prima, h_prima)
    % -------- calculate similarity ------------
    load('..\experiments\up_and_down_kaggel\Subject1_2D.mat');
    C3=LeftBackward1(:,5);
    C3_centrada= (C3-mean(C3))/std(C3);  % normalize the input signal 
    Hd=Filtro50Hz;  % generate a 50Hz filter to the signal
    C3_50=conv(C3_centrada,Hd.numerator,'same');  % apply the 50Hz filter to the signal
    signal = C3_50;        %Señal a analizar
    % spike wavelet validation
    lev   = 7;  % define the number of levels for the wavalet decomposition
    % [c,l] = wavedec(x,n,LoD,HiD)
    [c,l] = wavedec(signal, lev, h, h_1);  % apply the wavelet decomposition
    % X = waverec(c,l,Lo_R,Hi_R)
    a0 = waverec(c, l, h_prima, h_1_prima);

    signal_norm = (signal - mean(signal)) / std(signal);
    a0_norm = (a0 - mean(a0)) / std(a0);

    similarity = 1 - (sum(abs(signal_norm - a0_norm))/ (sum(abs(signal_norm)) + sum(abs(a0_norm))));
end