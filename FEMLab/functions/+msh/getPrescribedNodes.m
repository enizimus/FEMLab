function [prescNodes, nSys] = getPrescribedNodes(elemNodes, elemsRegion, elemsTag, prescRegions, nNodes)
% Returns an array containing the id of the boundary condition prescribed
% onto the node, the conditions can be (DRB = 1, NRB = 2);
%
% nSys gives the size of the resulting system of equations when boundary
% conditions are plugged in 
%

prescNodes = zeros(1,nNodes); 
for i=1:length(prescRegions)
    indices = find( elemsRegion == prescRegions(i) );
    for iElem = indices
        I = elemNodes(iElem, :);
        I = I( I ~= 0 );
        prescNodes(I) = prescRegions(i);
    end
end
nSys = sum(prescNodes == 0);
end