function [U, I] = setKnownPot(triangles, nTris, nodeProps, regSet)

I = reshape(nodeProps(triangles(:)), [nTris, 3]);
U = zeros(size(I));
keys_U = unique(I);
keys_U(keys_U == 0) = [];

for iKey = 1:numel(keys_U)
    ind = I == keys_U(iKey);
    U(ind) = regSet(iKey).srcProp;
end
