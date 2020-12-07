% Data Generator Shell
load('HC_supp2.mat') %Load OSN odor panel data from Hallem and Carlson, 2006
load('c_data') %Load previously created PN-KC network data
load('PN_sensitivity_vect.mat')% Load sensitivities of PNs to inhibition (Hong and Wilson, 2015)
eps = 0.8;
beta = 0.03;
trials = 50;
data_generator(I,c_data,sens_mean,eps,beta);
