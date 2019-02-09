function display_mesh(file_name, do_print)

plt_pth = '.\plots\';
if(nargin < 2 || isempty(do_print)), do_print = 0; end

load(['.\results\', file_name])
%tags = [regions.tag];
lgnd = {'Dirichlet', 'Neumann', 'Source', 'Material'};
legend_pick = gobjects(size(lgnd));
%           [blue; yellow; red; green]
color_def = [22, 95, 229; 255, 250, 10;
             237, 33, 60; 35, 255, 105]/255;

i_elem = 1;
while(elements(i_elem).type ~= 2), i_elem = i_elem + 1; end
elem_offset = i_elem;

n_lines = elem_offset-1;
lines = [elements(1:n_lines).nodes];
lines = reshape(lines, [2, n_lines])';
color_mat_lines = zeros(n_lines, 3);
arr = reshape([elements(1:n_lines).tags], [2, n_lines])';
arr(:,2) = [];
[tag_order_lines, I] = sort(arr);
lines = lines(I,:);

n_tri = n_elements-i_elem+1;
arr = reshape([elements(i_elem:n_elements).tags], [2, n_tri])';
arr(:,2) = [];
[tag_order, I] = sort(arr);
triangles = [elements(i_elem:n_elements).nodes];
triangles = reshape(triangles, [3, n_tri])';
triangles = triangles(I,:);
color_mat_tri = zeros(n_tri, 3);

i_col = 1;
while(i_col <= n_lines)
    color_mat_lines(i_col, :) = color_def(tag_order_lines(i_col), :);
    i_col = i_col + 1;
end
i_col = 1;
while(i_col <= n_tri)
    color_mat_tri(i_col, :) = color_def(tag_order(i_col), :);
    i_col = i_col + 1;
end

lgnd_ind = [];
f_color = [-1,0,0];
i_lgnd = 1;
figure, hold on
for i_tri = 1:n_tri
    hp = triplot(triangles(i_tri, :), [nodes.x], [nodes.y], ...
        'color', color_mat_tri(i_tri,:),...
        'linewidth', 1.1);
    
    if( sum(f_color - color_mat_tri(i_tri,:)) ~= 0)
        legend_pick(i_lgnd) = hp;
        f_color = color_mat_tri(i_tri,:);
        lgnd_ind(i_lgnd) = tag_order(i_tri);
        i_lgnd = i_lgnd + 1;
    end
end
for i_lines = 1:n_lines
    hp = plot([nodes(lines(i_lines,1)).x, nodes(lines(i_lines,2)).x],...
              [nodes(lines(i_lines,1)).y, nodes(lines(i_lines,2)).y],...
              'linewidth', 1.2, 'color', color_mat_lines(i_lines, :));
    if( sum(f_color - color_mat_lines(i_lines,:)) ~= 0)
        legend_pick(i_lgnd) = hp;
        f_color = color_mat_lines(i_lines,:);
        lgnd_ind(i_lgnd) = tag_order_lines(i_lines); 
        i_lgnd = i_lgnd + 1;
    end
end
hold off
title([file_name, '.msh'], 'interpreter', 'none')
lgd = legend(legend_pick(1:i_lgnd-1), lgnd(lgnd_ind),...
    'location', 'eastoutside');
title(lgd, 'Regions : ')
if(do_print)
    if(exist(plt_pth, 'dir') ~= 7)
        mkdir(plt_pth)
    end
    print([plt_pth, file_name, '_mesh'], '-dpng')
end



