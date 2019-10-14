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

i_elem = 1;
while(elements(i_elem).type ~= 2), i_elem = i_elem + 1; end
elemOffset = i_elem;

nLines = elemOffset-1;
lines = [elements(1:nLines).nodes];
lines = reshape(lines, [2, nLines])';
arr = elemsRegion(1:nLines);
[tagOrderLines, I] = sort(arr);
lines = lines(I,:);

nTris = nElems-i_elem+1;
arr = elemsRegion(i_elem:nElems);
[tagOrderTris, I] = sort(arr);
triangles = [elements(i_elem:nElems).nodes];
triangles = reshape(triangles, [3, nTris])';
ptriangles = triangles(I,:);
