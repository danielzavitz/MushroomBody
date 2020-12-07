function [y_apl] = apl_sigmoid(I)
%APL depolarization (based on data from GGN) from Papadopoulou et al. 2011. 
%INPUT
%I:     KC input. Summed later
%OUTPUT
%y_apl: depolarization of the APL
[n,m] = size(I);
%c = 0.9982;% these parameters were found by fitting a sigmoid to data from Papadopoulou et al. 2011 Fig. 2Ci
%q = 0.3605;
%b = 5.3047;
%v = 0.0884;

c = 1.0653;
q = 0.3847;
b = 0.0379;
v = 0.0884;
k = 37.5910;

I = sum(I);
% x = [1 8 20 40 60 80 100 120 140];
% y = [1 1 3 8 12 15 17 17.5 18];



y_apl =k./((c + q.*exp(-b.*I)).^(1/v));


% figure
% hold on
% plot(I,y_apl,'LineWidth',2);
% plot(x,y,'o','MarkerSize',7,'LineWidth',2)
% xlabel('Total Input')
% ylabel('APL Depolarization mV')
% title('APL Response Function')
end

