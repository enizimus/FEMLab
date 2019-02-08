function display_mesh(file_name)

load(['.\results\', file_name])
tags = [regions.tag];
lgnd = {'Dirichlet', 'Neumann', 'Source', 'Material'};
legend_pick = gobjects(size(lgnd));
color_def = [22, 95, 229; 255, 250, 10;
             237, 33, 60; 35, 255, 105]/255;


i_elem = 1;
while(elements(i_elem).type ~= 2), i_elem = i_elem + 1; end
elem_offset = i_elem;

arr = reshape([elements(i_elem:n_elements).tags], [2, n_elements-i_elem+1])';
arr(:,2) = [];
[tag_order, I] = sort(arr);
triangles = [elements(i_elem:end).nodes];
triangles = reshape(triangles, [3, length(triangles)/3])';
triangles = triangles(I,:);
color_mat = zeros(size(triangles));

i_tag = i_elem;
i_col = 1;
end_cond = n_elements - elem_offset + 1;
while(i_col <= end_cond)
    color_mat(i_col, :) = color_def(tag_order(i_col), :);
    i_col = i_col + 1;
end

f_color = [-1,0,0];
i_lgnd = 1;
lgnd_ind = false(1,4);
figure
hold on
for i_tri = 1:end_cond
    hp = triplot(triangles(i_tri, :), [nodes.x], [nodes.y], 'color', color_mat(i_tri,:));
    %pause(0.01)
    if( sum(f_color - color_mat(i_tri,:)) ~= 0)
        legend_pick(i_lgnd) = hp;
        f_color = color_mat(i_tri,:);
        i_lgnd = i_lgnd + 1;
        lgnd_ind(tag_order(i_tri)) = true; 
    end
end
hold off
title(['Plotted : ', file_name, '.msh'], 'interpreter', 'none')
legend(legend_pick(1:i_lgnd-1), lgnd(lgnd_ind), 'location', 'eastoutside')



