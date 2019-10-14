function [elem_params, sour_params] = get_elem_params(optProb, element_r, regions_c)

elem_params = zeros(size(element_r));
sour_params = zeros(size(element_r));
is_source = false(size(element_r));
is_dir = false(size(element_r));

dir_keys = regions_c.dir_codes;
sour_keys = regions_c.get_source_keys();
key_arr = regions_c.get_regions_keys('num');
key_param = regions_c.get_regions_params(key_arr);
n_reg = length(key_arr);
n_sour = length(sour_keys);
n_dir = length(dir_keys);

for i_sour = 1:n_sour
    is_source(element_r == sour_keys(i_sour)) = true;
end
for i_dir = 1:n_dir
    is_dir(element_r == dir_keys(i_dir)) = true;
end
for i_reg = 1:n_reg
    I = element_r == key_arr(i_reg);
    elem_params(I) = key_param(i_reg);
end

sour_params(is_source) = elem_params(is_source);
elem_params(is_source) = 1;
I = ~(is_dir);

switch(lower(optProb.class))
    case {'estatic'}
        k_0 = regions_c.eps_0;
        elem_params(I) = elem_params(I)*k_0; % = eps
    case {'mstatic'}
        k_0 = regions_c.mu_0;
        elem_params(I) = 1./(elem_params(I)*k_0); % = 1/mu
end



