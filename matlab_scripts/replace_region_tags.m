function elements = replace_region_tags(elements, n_elements, replace_tags)

dirichlet_dim = 1;
neumann_dim = 2;
source_dim = 3;
others_dim = 4;

i_elem = 1;
while(i_elem <= n_elements)
    if(any(elements(i_elem).tags(1) == replace_tags(1,:)))
        [elements(i_elem).tags(1)] = deal(dirichlet_dim);
    elseif(any(elements(i_elem).tags(1) == replace_tags(2,:)))
        [elements(i_elem).tags(1)] = deal(neumann_dim);
    elseif(any(elements(i_elem).tags(1) == replace_tags(3,:)))
        [elements(i_elem).tags(1)] = deal(source_dim);
    elseif(any(elements(i_elem).tags(1) == replace_tags(4,:)))
        [elements(i_elem).tags(1)] = deal(others_dim);
    end
    
    i_elem = i_elem + 1;
end
