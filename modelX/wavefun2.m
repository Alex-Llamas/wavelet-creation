function [phi, psi] = wavefun2(Hi_R, Lo_R, iter)
% WAVEFUN Wavelet and scaling functions 1-D.
% WAVEFUN returns approximations of the wavelet and scaling function
% given the Lo_R and Hi_R coeffients

coef = (sqrt(2)^iter);
pas  = 1/(2^iter);
long  = length(Lo_R);
nbpts = (long-1)/pas+1;
phi   = coef*upcoef('a',1,Lo_R,'dummy',iter);
psi   = coef*upcoef('d',1,Lo_R,Hi_R,iter);
[~,nb,dn] = getNBpts(nbpts,iter,long);
phi = [0 wkeep1(phi,nb) zeros(1,1+dn)];
psi = [0 wkeep1(psi,nb) zeros(1,1+dn)];
psi = fliplr(psi);

%----------------------%
% Internal Function(s) %
%----------------------%
function [nbpts,nb,dn] = getNBpts(nbpts,iter,long)

    lplus = long-2;
    nb = 1; for kk = 1:iter, nb = 2*nb+lplus; end
    dn = nbpts-nb-2;
    if dn<0 , nbpts = nbpts-dn; dn = 0; end    % HAAR 