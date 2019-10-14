function [triangles, ptriangles, lines, elemOffset,...
    tagOrderLines, tagOrderTris, nTris, nLines] = extractLT(elements, nElems, elemsRegion)
% EXTRACT_LINES_TRIS - extracts the triangles and line elements
% from the elements structure for easier indexing and usage later
% appends them to the resulting .mat file
%
% Syntax:  extractLT(files)
%
% Inputs:
%    files - struct containing file and result paths
%
% Outputs:
%    None
%
% Example: 
%    None
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: [mesh-file-name].mat
%
% Author: Eniz Museljic
% email: eniz.m@outlook.com
% Mar 2019

iElem = 1;
while(elements(iElem).type ~= 2), iElem = iElem + 1; end
elemOffset = iElem;

nLines = elemOffset-1;
lines = [elements(1:nLines).nodes];
lines = reshape(lines, [2, nLines])';
arr = elemsRegion(1:nLines);
[tagOrderLines, I] = sort(arr);
lines = lines(I,:);

nTris = nElems-iElem+1;
arr = elemsRegion(iElem:nElems);
[tagOrderTris, I] = sort(arr);
triangles = [elements(iElem:nElems).nodes];
triangles = reshape(triangles, [3, nTris])';
ptriangles = triangles(I,:);
