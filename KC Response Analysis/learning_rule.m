function [correct,pref,valence,w1,w2,r1,r2] =learning_rule(kcact,thresh,alpha_minus,alpha_plus,g0,gmin,gmax)
%Implements learning on KC to MBON synapes.
%INPUTS
%       kcact: KC activity matrix with rows corresponding to KC and columns
%              corresponding to odors
%       thresh: threshold of activity in KC. Usually 0.5;
%       alpha1: learning rate of synapses to positive EN
%       alpha2: learning ratte of synapes to negative EN
%       g0:     initial synapse value
%       gmin:   minimum synapse value
%       gmax:   maximum synapse value
%OUTPUT
%       correct: the fraction of odor/valence pairs recalled correctly
%                after training on n odors
%       pref: MBON+ - MBON- after training on n odors
%       valence: the valences associated with each odor
%       w1: the weights vector to MBON+
%       w2: the weights vector to MBON-
%       r1: response of MBON+ to each odor
%       r2: response of MBON- to each odor 

%% Load Data Set Parameters, and Preallocate
[kcn,odornum] = size(kcact);

%Threshold KC responses
kcact(kcact<thresh) = 0;
kcact(kcact>=thresh) = 1;

w1 = ones(1,kcn)*g0;
w2 = ones(1,kcn)*g0;

correct = zeros(1,odornum);


%% Alter KC-MBON connection weights

valence = randi([0 1],odornum,1);
valence(valence==0) = -1;

for i=1:odornum
    
    %Odor is paired with a positive valence stimulus
    if valence(i) == 1
        
        % Lower the efficacy of active KC to negative EN2
        inds = find(kcact(:,i));
        w2(inds) = w2(inds) - alpha_minus;
        w2(w2<gmin) = gmin;
        
        %Increase the efficacy of inactive KC to negative EN2
        inds = find(kcact(:,i)==0);
        w2(inds) = w2(inds) + alpha_plus;
        w2(w2>gmax) = gmax;
        
    
    %Odor is paired with a negative valence stimulus
    elseif valence(i)==-1
        % Lower the efficacy of active KC to positive EN1
        inds = find(kcact(:,i));
        w1(inds) = w1(inds)-alpha_minus;
        w1(w1<gmin) = gmin;
        
        %Increase the efficacy of inactive KC to positive EN1
        inds = find(kcact(:,i)==0);
        w1(inds) = w1(inds)+alpha_plus;
        w1(w1>gmax) = gmax;
        
    end
    
    
end


%% Test Preference vs Valence
pref = zeros(odornum,1);
r1 = zeros(odornum,1);
r2 = zeros(odornum,1);

for i=1:odornum
    
    %Find the responses of the MBONs
    r1(i) = w1*kcact(:,i);
    r2(i) = w2*kcact(:,i);
    
    
    pref(i)= r1(i)-r2(i);
    
    %If no activity is evoked, assign the "correct" value 0.5
    if isnan(pref(i)) 
        correct(i) = 0.5;
    else
        if sign(pref(i)) == sign(valence(i))
            correct(i) = 1;
        end
    end
    
end



