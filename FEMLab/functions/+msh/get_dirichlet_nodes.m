function [dir_nodes, nSys] = getDirNodes(elements, elemsRegion, nNodes, sRegions)
dir_nodes = zeros(1,nNodes);
codes = sRegions.dir_codes;
for i=1:length(codes)
    indices = find( elemsRegion == codes(i) );
    for i_el=indices
        dir_nodes([elements(i_el).nodes]) = codes(i);
    end
end
nSys = sum(dir_nodes == 0);
end