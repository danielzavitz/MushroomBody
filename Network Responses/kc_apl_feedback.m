function [kcact,aplact,fvals] = kc_apl_feedback(kc_input,alpha,eps,beta,b,c,v,q)
%Computes the responses of KC to feedforward PN excitation and feedback APL
%inhibtion
%INPUTS
    %I:        PN input to each KC mediated by the pn2kc network
    %eps:      The strength overall feedforward excitation from PN to KC
    %alpha:    The strength of exciation from PN to APL
    %beta:     The strength of divisive inhibtion from APL to KC
    %b,c1,v,q: Constants controlling KC response sigmoid
    
%OUTPUTS
    %kcact: KC representaion .

%%
[n,~] = size(kc_input);
    function F = activity(x)
        %The  first 1 to kcn entries in x are KC. The n+1 entry is the APL
        input1 = (eps.*kc_input)./(1+beta.*x(n+1,1));
        input2 = alpha.*x(1:n,1);
        
        F(1:n,1) = x(1:n,1) - kc_sigmoid(input1,b,c,v,q);
        F(n+1,1) = x(n+1,1) - apl_sigmoid(input2);
    end

initial = ones(n+1,1);
initial(n+1) = apl_sigmoid(initial(1:n));
[cells,fvals] = fsolve(@activity,initial);

kcact = cells(1:n);
aplact = cells(n+1);


end

