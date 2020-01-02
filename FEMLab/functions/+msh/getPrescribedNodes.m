function [prescNodes, nSys] = getPrescribedNodes(elemNodes, elemsTag, nNodes)
% Returns an array containing the id of the boundary condition prescribed
% onto the node, the conditions can be (DRB = 1, NRB = 2);
%
% nSys gives the size of the resulting system of equations when boundary
% conditions are plugged in 
%

prescNodes = zeros(1,nNodes);
ids = [1,2]; % these are the dirichlet and neuman id's
for i=1:length(ids)
    indices = find( elemsTag == ids(i) );
    for iElem = indices
        I = elemNodes(iElem, :);
        I = I( I ~= 0 );
        prescNodes(I) = ids(i);
    end
end
nSys = sum(prescNodes == 0);
end