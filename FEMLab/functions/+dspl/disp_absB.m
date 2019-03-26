function disp_absB(files, labels, do_print, print_format)

if(nargin < 4 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 3 || isempty(do_print)), do_print = 0; end

load(files.respth, 'B', 'triangles', 'nodes')
tri = triangulation(triangles, [nodes.x]', [nodes.y]', B');

figure
trisurf(tri)
colorbar
title([files.file_name, ' |B|'], 'interpreter', 'none')
xlabel(labels.x)
ylabel(labels.y)
zlabel('|B|')
view(2)
axis off

if(do_print)
    print(files.pltpth_pot, print_format)
end

end



% n_p = 300;
% load(files.respth, 'B', 'nodes_B');
% 
% x = nodes_B(:,1);
% y = nodes_B(:,2);
% 
% xlin = linspace(min(x),max(x), n_p);
% ylin = linspace(min(y),max(y), n_p);
% [X,Y] = meshgrid(xlin,ylin);
% f = scatteredInterpolant(x,y,B');
% Z = f(X,Y);
% 
% figure
% surf(X,Y,Z)
% colorbar
% shading interp
% view(2)
% xlabel('x')
% ylabel('y')
% title('|B|')
% 
% if(do_print)
%     print(files.pltpth_B, print_format)
% end
% end