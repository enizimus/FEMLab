function [regions, replace_tags] = separate_regions(regions)

dirichlet_dim = 1;
neumann_dim = 2;
source_dim = 3;
others_dim = 4;

replace_tags = zeros(4, size(regions,2));

ind = contains({regions.name}, 'dirichlet');
[regions(ind).dim] = deal(dirichlet_dim);
replace_tags(dirichlet_dim, ind) = [regions(ind).tag];
oth_ind = ind;
ind = contains({regions.name}, 'neumann');
[regions(ind).dim] = deal(neumann_dim);
replace_tags(neumann_dim, ind) = [regions(ind).tag];
oth_ind = oth_ind | ind;
ind = contains({regions.name}, 'source');
[regions(ind).dim] = deal(source_dim);
replace_tags(source_dim, ind) = [regions(ind).tag];
oth_ind = ~(oth_ind | ind);
[regions(oth_ind).dim] = deal(others_dim);
replace_tags(others_dim, oth_ind) = [regions(oth_ind).tag];