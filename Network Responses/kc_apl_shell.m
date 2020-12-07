function [kcact,aplact,fvals] = kc_apl_shell(kc_input,alpha,eps,beta,b,c1,v,q)
%Solves the KC/APL system efficently. Only solves the equations of KC that
%are activated with no APL feedback
%INPUTS
    %kc_input:  Input of PNs to KC for each odor. Input includes multiple
    %               connections etc. mediated by the PN to KC network
    %alpha:     KC to APL connection strength
    %eps:       PN to KC connection strength
    %beta:      APL to KC connection strength
    %b,c1,v,q:  Constants controlling KC response sigmoid

%OUTPUTS
    %kcact:     The responses of KCs to an odor panel
    %aplact:    The responses of the APL to an odor panel
    %fvals:     Numerical algebra residuals
%% Preallocation and Parameters

thresh = 0.001;
[kcn,odornum] = size(kc_input);

kcact_noapl = zeros(kcn,odornum);
kcact = zeros(kcn,odornum);
aplact = zeros(odornum,1);
kcact_temp = cell(odornum,1);
ind_list = cell(odornum,1);
fvals = cell(odornum,1);
%% Calculations
%Determine the response of KCs to each odor without APL inhibition
for h = 1:odornum
    kcact_noapl(:,h) =  kc_sigmoid(eps.*kc_input(:,h),b,c1,v,q);
end

%Compute the response of select KC with APL inhibtion
parfor h=1:odornum
    
    ind = find(kcact_noapl(:,h)>=thresh);
    ind_list{h} = ind;
    if isempty(ind)==0
        nonzero_input = kc_input(ind,h);
        [output,aplact(h),fvals_temp] = kc_apl_feedback(nonzero_input,alpha,eps,beta,b,c1,v,q);
        kcact_temp{h} = output;
        fvals{h} = fvals_temp;
    end
    
end

for h=1:odornum
    ind = ind_list{h};
    kcact(ind,h) = kcact_temp{h};
end


end

