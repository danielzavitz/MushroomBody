function [I] = realistic_OSN_responses(I)
%Creates  realistic/special OSN inptus from Hallem and Carlson 2006 +others
%INPUT
%I:         OSN responses from Hallem and Carlson 2006
%OUTPUT
%Iout       Randomly Sampled outputs
%% Preallocation and Parameters
[n,odornum] = size(I);
maxfr = max(max(I));
%% Hallem and Carlson Odors
I(I<0) = 0; %remove negative values
for i=1:odornum
    
    vect =I(:,i);
    measured = I(isnan(vect)==0);
    ind = find(isnan(vect));
    sampind = randi(numel(measured),numel(ind),1);
    vect(ind) = measured(sampind);
    I(:,i) = vect;
    
    
end
%% Monoglomerular odors 
Imono = zeros(n,5);
%cVA
I(3,:) = zeros(1,odornum);
Imono(3,1) = 0.4*maxfr;

%geosmin
I(4,:) = zeros(1,odornum);
Imono(4,2) = 0.573*maxfr;

%valencene
I(8,:) = zeros(1,odornum);
Imono(8,3) = 0.775*maxfr;

%farnesol
I(10,:) = zeros(1,odornum);
Imono(10,4) = 0.922*maxfr;

%CO2
I(26,:) = zeros(1,odornum);
Imono(26,5) = 0.859*maxfr;

I = horzcat(Imono,I);



end

