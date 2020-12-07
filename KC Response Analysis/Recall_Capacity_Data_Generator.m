%% Recall  Capacity
%Determines how many odor/valence pairs each network can remember. For each
% model and trial, an increasing number of odor/valence pairs are presented
% and the accuracy is tracked

%% Load Data

%Loads KC representations of 4 networks per network model
load('kcdata_data_example.mat')


%% Set Parameters and preallocate
[row,col,trials] = size(kcdata);

alpha_minus = 0.25; % learning rate of active KC-MBON connections
alpha_plus = 0.01;  % learning rate of inactive KC-MBON connections

kcn = 2000; % Number of KCs
g0 = 1; % Initial KC-MBON connection weight
gmax = 1.5; % Max KC-MBON connection weight
gmin = 0; % Min KC-MBON connection weight
thresh = 0.5; % Threshold for KC activity

dn = 20; % Change in number of odors
odornums = dn:dn:800; % Number of odors to train on


w1data = cell(row,col,trials); % weight vector w1 data
w2data = cell(row,col,trials); % weight vector w2 data
valencedata = cell(row,col,trials,numel(odornums));  % odor valence data
prefdata = cell(row,col,trials,numel(odornums));    %MBON preference data
correctdata = cell(row,col,trials,numel(odornums)); % Correct odor/valence association data
acc = cell(row,col,trials);  % Overall accuracy data
%% Find the recall accuracy across models, trials, and odors trained on

parfor i=1:row
    for j=1:col
        for k=1:trials
            
            accvect = zeros(numel(odornums),1);
            w1temp = zeros(kcn,numel(odornums));
            w2temp = zeros(kcn,numel(odornums));
            kcact = kcdata{i,j,k};
            for h=1:numel(odornums)
                %Apply learning rule
                [correct,pref,valence,w1,w2] =learning_rule_2comp(kcact(:,1:odornums(h)),thresh,alpha_minus,alpha_plus,g0,gmin,gmax);
                correctdata{i,j,k,h} = correct;
                accvect(h)= sum(correct)/odornums(h);
                prefdata{i,j,k} = pref;
                valencedata{i,j,k,h} = valence;
                w1temp(:,h) = w1;
                w2temp(:,h) = w2;
                
            end
            acc{i,j,k} = accvect;
            w1data{i,j,k} = w1temp;
            w2data{i,j,k} = w2temp;
        end
    end
end


%% Save relevant data

save('recall_acc_example.mat','acc');






