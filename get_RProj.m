function [RProj] = get_RProj (pc,lc)
RProj=pc*diag(lc.^(-1/2));
end