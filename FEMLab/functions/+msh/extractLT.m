function [triangles, ptriangles, lines, elemOffset,...
    tagOrderLines, tagOrderTris, nTris, nLines] = extractLT(sElements, nElems, elemsRegion, form)
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

nLines = sum(sElements.dim == form.lineCode);
elemOffset = nLines + 1;

lines = sElements.nodes(1:nLines, [1 : form.nLineNodes]);

arr = elemsRegion(1:nLines);
[tagOrderLines, I] = sort(arr);
lines = lines(I,:);

nTris = nElems-nLines;
triangles = sElements.nodes(elemOffset:end, [1 : form.nTriNodes]);

arr = elemsRegion(elemOffset:nElems);
[tagOrderTris, I] = sort(arr);
ptriangles = triangles(I,:); % used for plotting! -> ptriangles
