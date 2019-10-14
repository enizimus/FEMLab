function [dir_nodes, nSys] = getDirNodes(elements, elemsRegion, nNodes, sRegions)
dir_nodes = zeros(1,nNodes);
codes = sRegions.codesDir;
for i=1:length(codes)
    indices = find( elemsRegion == codes(i) );
    for iElem=indices
        dir_nodes([elements(iElem).nodes]) = codes(i);
    end
end
nSys = sum(dir_nodes == 0);
end