function disp_quivB(files, labels, do_print, print_format)

if(nargin < 4 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 3 || isempty(do_print)), do_print = 0; end

n_p = 300;
n_s = 10;

load(files.respth, 'B', 'nodes', 'Bx', 'By');

n_points = length(B);
x = [nodes.x];
y = [nodes.y];

xlin = linspace(min(x),max(x), n_p);
ylin = linspace(min(y),max(y), n_p);
[X,Y] = meshgrid(xlin,ylin);
f = scatteredInterpolant(x',y',B');
Z = f(X,Y);

figure
surf(X,Y,Z)
colorbar
shading interp
view(2)
xlabel('x')
ylabel('y')
title('|B|')
axis off

% hold on
% I = 1:n_s:n_points;
% quiver3(nodes_B(I,1), nodes_B(I,2), B(I)', Bx(I)', By(I)', zeros(size(Bx(I)))', 'linewidth', 0.6, 'color', 'b')

% figure
% contour(X,Y,Z)
% hold on
% quiver(nodes_B(I,1), nodes_B(I,2), Bx(I)', By(I)', 'linewidth', 0.6, 'color', 'b')
% xlabel('x')
% ylabel('y')
% title('B')

figure
quiver(x, y, Bx, By, 'linewidth', 0.6, 'color', 'b')
xlabel(labels.x)
ylabel(labels.y)
title('B')
grid on
xlim([min(x), max(x)])
ylim([min(y), max(y)])
axis off

if(do_print)
    print(files.pltpth_B, print_format)
end
end