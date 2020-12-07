function [pnact] = pn_activity(I,m_vect,sigma)
%Computes PN responses to OSN input from equation modified from 
%Luo et al. 2010 and Olsen et al. 2010
%INPUTS
    %I:       Matrix of OSN firing rate responses (Hz). Rows are PNs and columns
    %         are odors
    %m_vect:  vector of PN sensitivities to lateral inhibtion
    %sigma:   Half Max response parameter
%OUTPUTS
    %pnact    Matrix of PN activities on [0 1]. Rows are PNs and columans are
    %         odors
%% Preallocation and Parameters
[pnn,odornum] = size(I);
pnact = zeros(pnn,odornum);

%% Calculations
for j=1:odornum
    osn = I(:,j);
    for i = 1:pnn

        s = sum(osn);
        pnact(i,j) = (osn(i).^(1.5))./(osn(i).^(1.5)+sigma.^(1.5)+(m_vect(i).*s).^(1.5));
        
    end
end














end

