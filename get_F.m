function [pc, lc, F,RProj] = get_F(compromise)
[pc,lc]=eigen(compromise); %may return a matrix smaller than the original. This is fine.
F=pc*diag(sqrt(lc));%this will give us our centroid for the plot
RProj=pc*diag(lc.^(-1/2));
end