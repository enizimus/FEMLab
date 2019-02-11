function element_regions = replace_region_tags(elements, n_elements, replace_tags)

dirichlet_dim = 1;
neumann_dim = 2;
source_dim = 3;
others_dim = 4;

element_regions = zeros(1, n_elements);
i_elem = 1;
while(i_elem <= n_elements)
    if(any(elements(i_elem).tags(1) == replace_tags(1,:)))
        element_regions(i_elem) = dirichlet_dim;
    elseif(any(elements(i_elem).tags(1) == replace_tags(2,:)))
        element_regions(i_elem) = neumann_dim;
    elseif(any(elements(i_elem).tags(1) == replace_tags(3,:)))
        element_regions(i_elem) = source_dim;
    elseif(any(elements(i_elem).tags(1) == replace_tags(4,:)))
        element_regions(i_elem) = others_dim;
    end
    i_elem = i_elem + 1;
end
