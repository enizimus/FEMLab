function [regions, nodes, elements] = mat2struct(regionNames, regionIds, nRegions, matNodes, nNodes, matElements, nElems)

regions = struct('dim', {}, 'tag', {}, 'name', {});
nodes = struct('x', {}, 'y', {}, 'z', {});
elements = struct('type', {}, 'nTags',...
    {}, 'tags', {}, 'nodes', {}, 'K', {}, 'R', {}, 'U', {}, 'n', {});

for i_region = nRegions:-1:1
    regions(i_region).dim = regionIds(i_region, 1);
    regions(i_region).tag = regionIds(i_region, 2);
    regions(i_region).name = regionNames{i_region};
end

for i_node = nNodes:-1:1
    nodes(i_node).x = matNodes(i_node, 2);
    nodes(i_node).y = matNodes(i_node, 3);
    %nodes(i_node).z = matNodes(i_node, 4);
end

for i_elem = nElems:-1:1
    elements(i_elem).type = matElements(i_elem, 2);
    elements(i_elem).nTags = matElements(i_elem, 3);
    i_tags = 3+elements(i_elem).nTags;
    elements(i_elem).tags = matElements(i_elem,...
        4:3+elements(i_elem).nTags);
    i_end = size(matElements, 2) - 2 + elements(i_elem).type;
    elements(i_elem).nodes = matElements(i_elem, i_tags+1:i_end);
end