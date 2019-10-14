function [triangles, ptriangles, lines, elem_offset,...
    tag_order_lines, tag_order, nTris, nLines] = extract_lines_tris(elements, n_elements, elemsRegion)
% EXTRACT_LINES_TRIS - extracts the triangles and line elements
% from the elements structure for easier indexing and usage later
% appends them to the resulting .mat file
%
% Syntax:  extract_lines_tris(files)
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
elem_offset = i_elem;

nLines = elem_offset-1;
lines = [elements(1:nLines).nodes];
lines = reshape(lines, [2, nLines])';
arr = elemsRegion(1:nLines);
[tag_order_lines, I] = sort(arr);
lines = lines(I,:);

nTris = n_elements-i_elem+1;
arr = elemsRegion(i_elem:n_elements);
[tag_order, I] = sort(arr);
triangles = [elements(i_elem:n_elements).nodes];
triangles = reshape(triangles, [3, nTris])';
ptriangles = triangles(I,:);
