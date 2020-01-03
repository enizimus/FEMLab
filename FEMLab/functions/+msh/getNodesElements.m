function [nodes, elements] = getNodesElements(matNodes, matElements)

nodes = matNodes(:,[2,3]);

elements = matElements(:, 2:end);
isNan = isnan(elements);
elements(isNan) = 0;
