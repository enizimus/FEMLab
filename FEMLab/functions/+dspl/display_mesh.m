function display_mesh(files, do_print, print_format)
% DISPLAY_MESH - plots the mesh and saves it in the specified format
%
% Syntax:  display_mesh(files, do_print, print_format)
%
% Inputs:
%    files - struct containing file and result paths
%    do_print - logical (True or False) or numeric (1 or 0)
%    print_format - string
%
% Outputs:
%    None
%
% Example: 
%    display_mesh(files, 1, '-dpng')
%    display_mesh(files, 1, '-depsc')
%
% Other m-files required: Regions.m
% Subfunctions: none
% MAT-files required: [mesh-file-name].mat
%
% Author: Eniz Museljic
% email: eniz.m@outlook.com
% Mar 2019

if(nargin < 3 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 2 || isempty(do_print)), do_print = 0; end

load(files.respth, 'elements', 'nodes', 'n_elements', 'n_nodes', ...
    'regions_c', 'n_regions', 'element_r', ...
    'tag_order_lines', 'tag_order', 'n_tri',...
    'triangles', 'lines', 'n_lines');

n_items = regions_c.n_items;
rkeys = regions_c.get_regions_keys('num');
lgnd = regions_c.get_regions_keys('str');

[I_l, I_t] = hlp.sep_lines_tris(n_items, element_r, rkeys, ...
    n_tri, n_lines);

figure
hold on
for i_r = 1:n_items(1)
    colr = regions_c.get_color(rkeys(i_r));
    plot([nodes(lines(I_l(:,i_r),1)).x, nodes(lines(I_l(:,i_r),2)).x],...
              [nodes(lines(I_l(:,i_r),1)).y, nodes(lines(I_l(:,i_r),2)).y],...
              'linewidth', 1.2, 'color', colr);
end

for i_r = n_items(1)+1:sum(n_items)
    colr = regions_c.get_color(rkeys(i_r));
    triplot(triangles(I_t(:,i_r), :), [nodes.x], [nodes.y], ...
        'color', colr, ...
        'linewidth', 1.1);
end
title([files.file_name, '.msh'], 'interpreter', 'none')
lgd = legend(lgnd, 'location', 'eastoutside', 'interpreter', 'none');
title(lgd, 'Regions : ')

if(do_print)
    print(files.pltpth_mesh, print_format)
end



