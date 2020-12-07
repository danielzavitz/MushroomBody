function [gvect] = group_generator(groups,gnum)
%Randomly assigns groups to PNs to not given groups experimentally
%INPUTS
%groups:    A vector of experimentally determined PN group assignments. 0s
%           indicate PNs that were not assigned a group
%gnum:      Number of groups total (typically 5)
%OUTPUT
%gvect:     A vector of experimentally determined AND randomly assigned
%           PN groups
%% PARAMETERS/Preallocation
gvect = groups;
%% Begin Code
while sum(gvect==5)==0 %make sure that at least 1 PN is assigned to group 5
gvect=groups;
gvect(gvect==0) = randi(gnum,length(find(gvect==0)),1);
end


end

