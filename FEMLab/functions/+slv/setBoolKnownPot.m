function [I, iK, iN] = setBoolKnownPot(nodes, nodeProps, sRegions)
I = nodeProps(nodes);
U = zeros(3,1);
iK = find(I ~= 0);
iN = 1:3;
iN(iK) = [];
U(iK) = sRegions.getParam(I(iK));

if(isempty(iK)), iK = 1; end


