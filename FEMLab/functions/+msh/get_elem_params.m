function [elem_params, sour_params] = get_elem_params(optProb, elemsRegion, sRegions)

elem_params = zeros(size(elemsRegion));
sour_params = zeros(size(elemsRegion));
is_source = false(size(elemsRegion));
is_dir = false(size(elemsRegion));

dir_keys = sRegions.dir_codes;
sour_keys = sRegions.get_source_keys();
key_arr = sRegions.getRegionKeys('num');
key_param = sRegions.get_regions_params(key_arr);
n_reg = length(key_arr);
n_sour = length(sour_keys);
n_dir = length(dir_keys);

for i_sour = 1:n_sour
    is_source(elemsRegion == sour_keys(i_sour)) = true;
end
for i_dir = 1:n_dir
    is_dir(elemsRegion == dir_keys(i_dir)) = true;
end
for iReg = 1:n_reg
    I = elemsRegion == key_arr(iReg);
    elem_params(I) = key_param(iReg);
end

sour_params(is_source) = elem_params(is_source);
elem_params(is_source) = 1;
I = ~(is_dir);

switch(lower(optProb.class))
    case {'estatic'}
        k_0 = sRegions.eps_0;
        elem_params(I) = elem_params(I)*k_0; % = eps
    case {'mstatic'}
        k_0 = sRegions.mu_0;
        elem_params(I) = 1./(elem_params(I)*k_0); % = 1/mu
end



