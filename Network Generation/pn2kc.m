function [c,kc_gvect] = pn2kc(kcn,gvect,bvect,dog,con)
%Assigns connections from projection neurons to kenyon cells
%INPUTS
%   kcn:      number of kenyon cells, typically 2000
%   gvect:    vector describing the group assignments of PNs
%   bvect:    vector describing the biases of PNs
%   dog:      degree of grouping: probability that KC are placed into a group
%   con:      mean numbere of PN connections per KC
%OUTPUTS
%   c:        adjacency matrix of PN to KC connectivity (typically 2000 x 50)
%   kc_gvect: vector of which groups KC were assigned 

%% parameters
sig0=1.77; %standard deviation of PN connections per KC maybe 2.4
pnn = numel(gvect); %number of PNs

%% Preallocate adjacency matrix and define incoming kc connection numbers
c = zeros(kcn,numel(gvect));
kc_inc = round(normrnd(con,sig0,kcn,1));

%% Assign Groups to KC
kc_gvect = rand(kcn,1);
kc_gvect(kc_gvect>dog) = 0;
kc_gvect(kc_gvect~=0) = 1;
kc_gvect(kc_gvect==1) = randi(5,length(find(kc_gvect)),1);

%% Assign PN to KC Connections
for i = 1:kcn
    
    %Find which PNs are available to send conns to each KC based on
    %grouping
    if kc_gvect(i) ==0
        avail=1:pnn;
    elseif kc_gvect(i)~=0
        avail = find(gvect==kc_gvect(i));
    end
    
    %Create probability vector given grouping/bias
    prob = zeros(1,pnn);
    prob(avail) = bvect(avail)./sum(bvect(avail));
    prob = cumsum(prob);
    
    %Assign Connections
    for j = 1:kc_inc(i)
        a =rand;
        ind =  sum(prob<a)+1;
        c(i,ind) = c(i,ind)+1;
    end
      
end

end

