% Data Generator Shell
load('HC_supp2.mat') %Load OSN odor panel data from Hallem and Carlson, 2006
load('c_data') %Load previously created PN-KC network data

eps = 0.8;
beta = 0.03;
trials = 50;
small_input_data_generator(I,c_data,sens_mean,eps,beta,trials);
