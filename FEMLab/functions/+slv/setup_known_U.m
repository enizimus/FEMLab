function [U, I] = setup_known_U(triangles, nTris, nodes_prop, sRegions)

I = reshape(nodes_prop(triangles(:)), [nTris, 3]);
U = zeros(size(I));
keys_U = unique(I);
keys_U(keys_U == 0) = [];
params = sRegions.get_regions_params(keys_U);

for iKey = 1:numel(keys_U)
    ind = U == keys_U(iKey);
    U(ind) = params(iKey);
end
