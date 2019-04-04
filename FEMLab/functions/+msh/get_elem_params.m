function [elem_params, is_source] = get_elem_params(element_r, regions_c)

elem_params = zeros(size(element_r));
is_source = false(size(element_r));

sour_keys = regions_c.get_source_keys();
key_arr = regions_c.get_regions_keys('num');
key_param = regions_c.get_regions_params(key_arr);
n_reg = length(key_arr);
n_sour = length(sour_keys);

for i_sour = 1:n_sour
    is_source(element_r == sour_keys(i_sour)) = true;
end

for i_reg = 1:n_reg
    I = element_r == key_arr(i_reg);
    elem_params(I) = key_param(i_reg);
end

