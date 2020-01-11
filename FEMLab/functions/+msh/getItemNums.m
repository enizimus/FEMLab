function [nEdgeElems, nFaceElems] = getItemNums(regSet)

specs = [regSet.dim];
I = specs == 1 | specs == 2;
nEdgeElems = sum(I);
nFaceElems = sum(~I);