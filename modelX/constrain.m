function [c, ceq] = constrain(h_1)
% function used as non linear equality constrain for the 
% optimization method fmincon
    L = length(h_1); % number of coefficients
    H_1 = fft(h_1);
    Hg = circshift(H_1, [0 L/2]);
    % non linear equality restrictions
    ceq = H_1.* conj(H_1) + Hg.*conj(Hg) - 2;
    c = [];  % non linear inequality restrictions 
end