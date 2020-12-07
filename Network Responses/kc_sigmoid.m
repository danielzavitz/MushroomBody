function [y] = kc_sigmoid(I,b,c,v,q)
%Response of KC to PN excitation/APL inhibtion. 
%INPUT
    %I: Net PN/APL input
    %b: sigmoid growth rate
    %v: affects where which asymptote the transition occurs near
    %q:     affects the vale near 0
%OUTPUT
    %y: Response of the KC 

%%
[n,~] = size(I);
y =ones(n,1)./((c.*ones(n,1) + q.*exp(-b.*I)).^(1/v));

end

