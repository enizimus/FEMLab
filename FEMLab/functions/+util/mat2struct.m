function [regions, nodes, elements] = mat2struct(reg_names, reg_id, n_regions, nodes_mat, n_nodes, elements_mat, n_elements)

regions = struct('dim', {}, 'tag', {}, 'name', {});
nodes = struct('x', {}, 'y', {}, 'z', {});
elements = struct('type', {}, 'n_tags',...
    {}, 'tags', {}, 'nodes', {}, 'K', {}, 'R', {}, 'U', {}, 'n', {});

for i_region = n_regions:-1:1
    regions(i_region).dim = reg_id(i_region, 1);
    regions(i_region).tag = reg_id(i_region, 2);
    regions(i_region).name = reg_names{i_region};
end

for i_node = n_nodes:-1:1
    nodes(i_node).x = nodes_mat(i_node, 2);
    nodes(i_node).y = nodes_mat(i_node, 3);
    %nodes(i_node).z = nodes_mat(i_node, 4);
end

for i_elem = n_elements:-1:1
    elements(i_elem).type = elements_mat(i_elem, 2);
    elements(i_elem).n_tags = elements_mat(i_elem, 3);
    i_tags = 3+elements(i_elem).n_tags;
    elements(i_elem).tags = elements_mat(i_elem,...
        4:3+elements(i_elem).n_tags);
    i_end = size(elements_mat, 2) - 2 + elements(i_elem).type;
    elements(i_elem).nodes = elements_mat(i_elem, i_tags+1:i_end);
end