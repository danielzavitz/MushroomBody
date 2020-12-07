function [bvect] = bias_generator(biases,dob)
%Creates a bias vector from experimentally measured bias and degree of bias
%INPUTS
%   biases:    probability of recieving connections from each PN
%           (experimentally measured)
%   dob:       degree of bias
%OUTPUTS
%   bvect:     vector of biases

%% PARAMETERS
pn_num = numel(biases);

%%
bvect = (biases -ones(1,pn_num)./pn_num).*dob+ones(1,pn_num)./pn_num;

end

