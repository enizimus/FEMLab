function disp_sliceB(files, labels, do_print, print_format)

if(nargin < 4 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 3 || isempty(do_print)), do_print = 0; end

load(files.respth, 'B', 'nodes', 'Bx', 'By');
% n_p = length(B);
% n_s = 10;
% x = [nodes.x];
% y = [nodes.y];
% rlin = linspace(0,1,n_p);
% philin = linspace(0,2*pi,n_p);
% 
% [R, Phi] = meshgrid(rlin, philin);
% X = R.*cos(Phi);
% Y = R.*sin(Phi);
% 
% fBx = scatteredInterpolant(x',y',Bx');
% fBy = scatteredInterpolant(x',y',By');
% 
% BX = fBx(X,Y);
% BY = fBy(X,Y);
% 
% hf = figure;
% hf.Name = sprintf('%s: even stream arrow', mfilename);
% dspl.even_stream_arrow(X, Y, BX, BY, 1, 2, ...
%     'LineStyle', '-', 'LineWidth', 0.5, 'Color', 'b', 'ArrowLength', 4, ...
%     'ArrowTipAngle', 30, 'ArrowBaseAngle', 10, 'ArrowDensity', 2);
% title('even\_stream\_arrow');
% ax = gca;
% ax.XTick = [];
% ax.YTick = [];

% n_points = length(B);
% 
% xlin = linspace(min(x),max(x), n_points);
% ylin = linspace(min(y),max(y), n_points);
% [X,Y] = meshgrid(xlin,ylin);
% f = scatteredInterpolant(x',y',B');
% Z = f(X,Y);
% 
% 
% figure
% surf(X,Y,Z)
% colorbar
% shading interp
% view(2)
% xlabel('x')
% ylabel('y')
% title('|B|')

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


x = [nodes.x];
y = [nodes.y];

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
