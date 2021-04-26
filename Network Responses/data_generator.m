function [] = data_generator(I,c_data,sens_mean,eps,beta)
%Creates responses to Hallem and Carlson Data set +monoglomerular odors
%INPUTS
    %I:     	inputs from experimentally measured Hallem and Carlson dataset
    %c_data:    Adjacency matrices of all 9 types of networks
    %eps:       strength of PN excitation to KC
    %beta:      strenth of APL inhibtion to KC
%OUTPUT
%all data saved
%% Preallocate and set parameters
[row,col,trials] = size(c_data);
odornum = length(I)+5;
kcdata = cell(row,col,trials);
pndata = cell(row,col,trials);
osndata = cell(row,col,trials);
pnsensdata = cell(row,col,trials);
apldata = cell(row,col,trials);
fvaldata =cell(row,col,trials,odornum);


c = c_data{1};
[kcn,pnn] = size(c); %Number of Kenyon cells and projection neurons

%parameters determining the shape of the KC response sigmoid
alpha = 1;
b=32;
c1=1;
q=20;
v=1e-13;

%A parameter determining PNs' responses to OSN input (Olsen et al. 2010)
sigma = 12;
%% Calculations

for i=1:row
    for j=1:col
        for k=1:trials %Loop through all network types and trials
            c = c_data{i,j,k};%Loop through all network types and trials
            
            %Shuffle and expand OSN odor representations
            Ishuff = realistic_OSN_responses(I);
            
            %Determine PN responses to odors
            [pn_sens_vect] = pn_sensitivity_generator(sens_mean); %Determine PNs' sensitivity to inhibition (Hong and Wilson, 2015)
            pnsensdata{i,j,k} = pn_sens_vect;
            pnact = pn_activity(Ishuff,pn_sens_vect,sigma); %Compute the PNs' response to OSN input
            kcact_noapl = zeros(kcn,odornum);
            kc_input = c*pnact; %Compute PN input to KCs
            
            %Comput the KC and APL responses to PN input
            [kcact,aplact,fvals] = kc_apl_shell(kc_input,alpha,eps,beta,b,c1,v,q);
            
            
            kcdata{i,j,k} = sparse(kcact);
            pndata{i,j,k} = pnact;
            pnsensdata{i,j,k} = pn_sens_vect;
            apldata{i,j,k} = aplact;
            fvaldata{i,j,k} = fvals;
        end
    end
end


%% Save Data

eps =num2str(eps);
eps(eps=='.') = [];

beta =num2str(beta);
beta(beta=='.') = [];

filename1 = strcat('kcdata_cloud_inputs','_eps',eps,'_beta',beta,'.mat');
filename2 = strcat('pndata_cloud_inputs','_eps',eps,'_beta',beta,'.mat');
filename3 = strcat('osndata_cloud_inputs','_eps',eps,'_beta',beta,'.mat');
filename4 = strcat('pnsensdata_cloud_inputs','_eps',eps,'_beta',beta,'.mat');
filename5 = strcat('apldata_cloud_inputs','_eps',eps,'_beta',beta,'.mat');
filename6 = strcat('fvaldata_cloud_inputs','_eps',eps,'_beta',beta,'.mat');
    
save(filename1,'kcdata');
save(filename2,'pndata');
save(filename3,'osndata');
save(filename4,'pnsensdata');
save(filename5,'apldata');
save(filename6,'fvaldata');

end

