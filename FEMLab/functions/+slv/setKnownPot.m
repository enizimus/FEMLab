function [U, I, A] = setKnownPot(triangles, nTris, nodeProps, regSet, nTriNodes)

%isDirichlet = nodeProps == 1;
%nodeProps(~isDirichlet) = 0;

Aknown = nan(size(nodeProps));
I = reshape(nodeProps(triangles(:)), [nTris, nTriNodes]);
U = zeros(size(I));
keys_U = unique(I);
keys_U(keys_U == 0) = [];

for iKey = 1:numel(keys_U)
    ind = I == keys_U(iKey);
    U(ind) = regSet(keys_U(iKey)).srcProp;
    
    indA = nodeProps == keys_U(iKey);
    Aknown(indA) = regSet(keys_U(iKey)).srcProp;
end

A = Aknown(~isnan(Aknown));
