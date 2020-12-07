function [pnact_data,m_data] = pn_response_generator(I,sens_mean,sigma,trials)
%Generates the responses of PN OSN input as mediated by lateral inhibtion
%and LN sensivity as described by Olsen et al 2010 and Hong and Wilson 2015
%INPUTS
%I:            Matrix of OSN inputs. Rows are OSN, Columns are Odors
%m_vect:       vector of PN sensitivities to lateral inhibtion derived from
%              data with non-measured entries left out
%sigma:        Half Max response parameter
%trials:       number of runs
%OUTPUTS
%pnact_data:   cell of pn responses across trials
%% Preallocate and Parameters
pnact_data = cell(trials,1);
m_data =cell(trials,1);

%% Calculations

for i=1:trials
    
    m_vect = pn_sensitivity_generator(sens_mean);
    pnact = pn_activity(I,m_vect,sigma);
    pnact_data{i} = pnact;
    m_data{i} = m_vect;

end

end

