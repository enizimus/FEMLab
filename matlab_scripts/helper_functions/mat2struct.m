function [regions, nodes, elements] = mat2struct(phy_names, n_regions, nodes_cell, n_nodes, elements_cell, n_elements)

regions = struct('dim', {}, 'tag', {}, 'name', {});
nodes = struct('x', {}, 'y', {}, 'z', {});
elements = struct('type', {}, 'n_tags',...
    {}, 'tags', {}, 'nodes', {}, 'K', {}, 'R', {}, 'n', {});

nodes_mat = cell2mat(nodes_cell);
elements_mat = cell2mat(elements_cell);

for i_region = n_regions:-1:1
    line = strsplit(phy_names{i_region}, ' ');
    regions(i_region).dim = str2double(line{1});
    regions(i_region).tag = str2double(line{2});
    regions(i_region).name = strrep(line{3}, '"', '');
end

for i_node = n_nodes:-1:1
    nodes(i_node).x = nodes_mat(i_node, 2);
    nodes(i_node).y = nodes_mat(i_node, 3);
    nodes(i_node).z = nodes_mat(i_node, 4);
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