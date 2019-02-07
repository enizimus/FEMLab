function display_mesh(file_name)

load(['.\results\', file_name])
tags = [3 2 1];
lgnd = {'Air', 'Source'};
lgnd_pick = zeros(size(lgnd));


i_elem = 1;
while(elements(i_elem).type ~= 2), i_elem = i_elem + 1; end

triangles = [elements(i_elem:end).nodes];
triangles = reshape(triangles, [3, length(triangles)/3])';
color_mat = zeros(size(triangles));

i_tag = i_elem;
i_col = 1;
while(i_tag <= n_elements)
    if(elements(i_tag).tags(1) == tags(1))
        color_mat(i_col, :) = [35, 255, 105]; %green
        lgnd_pick(1) = i_col;
    elseif(elements(i_tag).tags(1) == tags(2))
        color_mat(i_col, :) = [237, 33, 60]; %red
        lgnd_pick(2) = i_col;
    elseif(elements(i_tag).tags(1) == tags(3))
        color_mat(i_col, :) = [255, 250, 10]; %yellow
    end
    i_col = i_col + 1;
    i_tag = i_tag + 1;
end

color_mat = color_mat./255;

figure
hold on
for i_tri = 1:size(triangles,1)
triplot(triangles(i_tri, :), [nodes.x], [nodes.y], 'color', color_mat(i_tri,:))
pause(0.01)
end
hold off
title(['Plotted : ', file_name, '.msh'], 'interpreter', 'none')
legend(lgnd, 'location', 'eastoutside')



