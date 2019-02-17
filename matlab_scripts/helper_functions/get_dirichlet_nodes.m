function dir_nodes = get_dirichlet_nodes(elements, element_r, n_nodes)
dir_nodes = zeros(1,n_nodes);
indices = find( element_r == Regions.DIRICHLET );
for i_el=indices
        dir_nodes([elements(i_el).nodes]) = Regions.DIRICHLET;
end
end