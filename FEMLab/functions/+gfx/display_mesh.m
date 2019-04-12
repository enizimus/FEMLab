function display_mesh(files, prob_opt)
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

load(files.respth, 'regions_c', 'element_r', 'x', 'y', ...
    'n_tri', 'ptriangles', 'lines', 'n_lines');

warning('off','all')
n_items = regions_c.n_items;
rkeys = regions_c.get_regions_keys('num');
lgnd = regions_c.get_regions_keys('str');

figure
hold on;

elements_tri = element_r(n_lines+1:end);
elements_line = element_r(1:n_lines);
tris_h = gobjects(1, n_items(2));
lines_h = gobjects(1, n_items(1));

ih = 1;
for i_r = n_items(1)+1:sum(n_items)
    
    colr = regions_c.get_color(rkeys(i_r));
    
    tris = ptriangles(elements_tri == rkeys(i_r),:);
    TRI = triangulation(tris,x,y);
    
    tris_h(ih) = triplot(TRI, 'color', colr);
    ih = ih + 1;
    
end

ih = 1;
for i_l = 1:n_items(1)
    
    colr = regions_c.get_color(rkeys(i_l));
    I = lines(elements_line == rkeys(i_l), :);
    xl = x(I);
    yl = y(I);
    
    [xl,yl] = util.get_non_rep(xl,yl);
    lines_h(ih) = plot(xl, yl, 'linewidth', 1.2, 'color', colr);
    ih = ih + 1;
    
end

title([files.file_name, '.msh'], 'interpreter', 'none')
lgd = legend([lines_h, tris_h], lgnd, 'location', 'eastoutside',...
    'interpreter', 'none');
title(lgd, 'Regions : ')
warning('on','all')

if(prob_opt.do_print)
    print(files.pltpth_pot, prob_opt.print_format)
end


