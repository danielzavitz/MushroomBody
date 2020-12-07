%Network Generator
%% Set Parameters and Preallocate
load('bias_data.mat')
load('group_data.mat')
dob = [0 0.5 1];
dog = [0 0.5 1];
cons = 7;
kcn = 2000;
trials = 50;
c_data = cell(3,3,trials);
kcgroups_data = cell(3,3,trials);
pngroups_data = cell(3,3,trials);

%% 
for i=1:numel(dob)
    bvect = bias_generator(biases,dob(i));
    for j=1:numel(dog)
        for k=1:trials
            gvect = group_generator(groups,5);
            [c,kcgroups] = pn2kc(kcn,gvect,bvect,dog(j),cons);
            c_data{i,j,k} = sparse(c);
            kcgroups_data{i,j,k} = kcgroups;
            pngroups_data{i,j,k} = gvect;
        end
    end
end
