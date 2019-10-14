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

for iElem = nElems:-1:1
    elements(iElem).type = matElements(iElem, 2);
    elements(iElem).nTags = matElements(iElem, 3);
    i_tags = 3+elements(iElem).nTags;
    elements(iElem).tags = matElements(iElem,...
        4:3+elements(iElem).nTags);
    i_end = size(matElements, 2) - 2 + elements(iElem).type;
    elements(iElem).nodes = matElements(iElem, i_tags+1:i_end);
end