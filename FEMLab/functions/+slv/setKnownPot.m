function [U, I] = setBoolKnownPot(triangles, nTris, nodeProps, sRegions)

I = reshape(nodeProps(triangles(:)), [nTris, 3]);
U = zeros(size(I));
keys_U = unique(I);
keys_U(keys_U == 0) = [];
params = sRegions.getParamsReg(keys_U);

for iKey = 1:numel(keys_U)
    ind = U == keys_U(iKey);
    U(ind) = params(iKey);
end
