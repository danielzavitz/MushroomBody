function [pn_sens_vect] = pn_sensitivity_generator(sens_mean)
%Creates a vector of PN sensitivities to lateral inhibtion from both data
%from Hong and Wilson 2015 as well as random values
%INPUTS
%sens_mean:      A vector of PN sensitvities to LN mediated lateral
%                inhibtion. Entries are averaged over both LN
%                sensitivity and GABA sensitivity measurements from Hong
%                and Wilson 2015. NaN entries are those PNs not measured
%OUTPUTS
%pn_sens_vect:   A vector of PN sensitivities whose unmeasured values are
%                drawn from a normal distribution with the same mean and
%                standard deviation as sens_mean
%Parameters
%alpha = 0.164, scaling factor that matches data from Hong and Wilson 2015
%with equations from Olsen et al 2010.

%% Preallocate and find parameters
pn_sens_vect = sens_mean;
ave = nanmean(sens_mean);
std_dev = nanstd(sens_mean);
alpha = 0.164;

%% Calculations
inds = find(isnan(sens_mean));
vals = normrnd(ave,std_dev,numel(inds),1);
while ~isempty(find(vals<0, 1))
    vals = normrnd(ave,std_dev,numel(inds),1);
end

pn_sens_vect(inds) = vals;
pn_sens_vect = alpha.*pn_sens_vect;


end

