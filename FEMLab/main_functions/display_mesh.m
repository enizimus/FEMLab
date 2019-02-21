function display_mesh(files, do_print, print_format)

if(nargin < 3 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 2 || isempty(do_print)), do_print = 0; end

load(files.respth, 'elements', 'nodes', 'n_elements', 'n_nodes', ...
    'regions_c', 'n_regions', 'element_r');
lgnd = cell(n_regions, 1);
legend_pick = gobjects(size(lgnd));

i_elem = 1;
while(elements(i_elem).type ~= 2), i_elem = i_elem + 1; end
elem_offset = i_elem;

n_lines = elem_offset-1;
lines = [elements(1:n_lines).nodes];
lines = reshape(lines, [2, n_lines])';
arr = element_r(1:n_lines);
[tag_order_lines, I] = sort(arr);
lines = lines(I,:);

n_tri = n_elements-i_elem+1;
arr = element_r(i_elem:n_elements);
[tag_order, I] = sort(arr);
triangles = [elements(i_elem:n_elements).nodes];
triangles = reshape(triangles, [3, n_tri])';
triangles = triangles(I,:);

f_color = [-1,0,0];
i_lgnd = 1;
figure, hold on
for i_tri = 1:n_tri
    colr = regions_c.get_color(tag_order(i_tri));
    hp = triplot(triangles(i_tri, :), [nodes.x], [nodes.y], ...
        'color', colr, ...
        'linewidth', 1.1);
    
    if( sum(f_color - colr) ~= 0)
        legend_pick(i_lgnd) = hp;
        f_color = colr;
        lgnd(i_lgnd) = {regions_c.get_name(tag_order(i_tri))};
        i_lgnd = i_lgnd + 1;
    end
end
for i_lines = 1:n_lines
    colr = regions_c.get_color(tag_order_lines(i_lines));
    hp = plot([nodes(lines(i_lines,1)).x, nodes(lines(i_lines,2)).x],...
              [nodes(lines(i_lines,1)).y, nodes(lines(i_lines,2)).y],...
              'linewidth', 1.2, 'color', colr);
    if( sum(f_color - colr) ~= 0)
        legend_pick(i_lgnd) = hp;
        f_color = colr;
        lgnd(i_lgnd) = {regions_c.get_name(tag_order_lines(i_lines))}; 
        i_lgnd = i_lgnd + 1;
    end
end
hold off
title([files.file_name, '.msh'], 'interpreter', 'none')
lgd = legend(legend_pick(1:i_lgnd-1), lgnd(1:i_lgnd-1),...
    'location', 'eastoutside', 'interpreter', 'none');
title(lgd, 'Regions : ')
set(gca,'YTick',[], 'XTick',[]);

if(do_print)
    print(files.pltpth_mesh, print_format)
end

save(files.respth, 'triangles', 'lines', '-append')


