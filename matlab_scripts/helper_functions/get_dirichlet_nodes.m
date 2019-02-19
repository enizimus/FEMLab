function [dir_nodes, n_sys] = get_dirichlet_nodes(elements, element_r, n_nodes, regions_c)
dir_nodes = zeros(1,n_nodes);
code = regions_c.get_reg_code('dirichlet');
indices = find( element_r == code );
for i_el=indices
        dir_nodes([elements(i_el).nodes]) = code;
end
n_sys = sum(dir_nodes == 0);
end