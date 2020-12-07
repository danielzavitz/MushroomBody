%% Group Assignment

for i =1:50;
    
    text = groups{i};
    
    if strcmp(text,'A')
        gvect(i) = 1;
    elseif strcmp(text,'B')
        gvect(i) = 2;
    elseif strcmp(text,'C')
        gvect(i) = 3;
    elseif strcmp(text,'D')
        gvect(i) = 4;
    else 
        gvect(i) = 0;
    end
    
end

% 0 are unassigned  glomeruli