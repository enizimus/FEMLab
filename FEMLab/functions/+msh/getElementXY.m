function [xe, ye] = getElementXY(nodes, eNodes)
xe = [nodes(eNodes).x];
ye = [nodes(eNodes).y];