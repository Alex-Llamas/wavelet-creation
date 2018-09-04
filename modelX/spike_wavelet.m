function [h_1, h, h_1_prima, h_prima] = spike_wavelet(L)
% L is the number of coefficient for the aproximation, even number
% This code takes a base function and calculate the wavelet coefficients
% that best aproximate the base function using the dilation equation
% calculates the wavelet filter coeficients the high filter "h_1" and
% calculates the scaling filter coeficients the low filter "h".
% the cascade level should be defined before use this function 
    global cascade_level;
    x0 = target(L);
    
    % inequality linear restrictions, empty for the model
    A = [];  % Ax <= b matrix 
    b = [];  % Ax <= b vector

    % equality linear restrictions (Aeq * x = beq), the system have one
    Aeq = ones(1,L);  % matrix -- restriction sum to zero (Eq. 39) 
    beq = 0;          % vector
    
    % lb and ub are domain limits on x
    lb = [];
    ub = [];
    
    nonlcon = @constrain;  % non linear restrictions
    
    fun = @objective;  % function to optimize 
    
    options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
    options.MaxFunEvals = 1000000;
    options.MaxIter = 2000;
    options.TolCon = 1e-2;
    % if f(x) is lower than TolFun then stop, f(x) is the value of the 
    % objetive function with the current values of x
    options.TolFun = 1e-9;
    % if Steplength is lower than TolX then stop
    options.TolX = 8e-18;    

    % calculation of the wavelet coefficients usign de optimization method
    % h_1 is the decomposition high pass filter
    [h_1,fval,exitflag,~] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
    
    % Calculation of scaling coefficients from h_1
    r = L+1;
    h=zeros(1,L);
    for l=1:L
        h(l) = ((-1)^(l-r))*h_1(r-l); 
    end
    
    [h_1_prima, h_prima] = reconstruction_coefficients(h_1, h);

    % plot the coefficients and the functions associated 
    plot_coefficients(h_1, h, cascade_level)
    
    % validate the resulting coefficients
    similarity = validation(h_1, h, h_1_prima, h_prima);
    
    % save only results with a good recostruction factor (similarity)
    if ( (exitflag >= 0) && (similarity > 0.98))
        savefig(sprintf('figure-spike_%d-cascade_%d-sim_%d',L,cascade_level,similarity))
        save(sprintf('variable-spike_%d-cascade_%d-sim_%d',L,cascade_level,similarity), 'h_1', 'h', 'h_1_prima', 'h_prima')
    end
end


