function [U, I] = setup_known_U(triangles, n_tri, nodes_prop, regions_c)

I = reshape(nodes_prop(triangles(:)), [n_tri, 3]);
U = zeros(size(I));
keys_U = unique(I);
keys_U(keys_U == 0) = [];
params = regions_c.get_regions_params(keys_U);

for i_key = 1:numel(keys_U)
    ind = U == keys_U(i_key);
    U(ind) = params(i_key);
end
