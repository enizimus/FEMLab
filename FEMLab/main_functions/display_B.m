function display_B(files, do_print, print_format)

if(nargin < 3 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 2 || isempty(do_print)), do_print = 0; end

n_p = 300;
load(files.respth, 'B', 'nodes_B');

x = nodes_B(:,1);
y = nodes_B(:,2);

xlin = linspace(min(x),max(x), n_p);
ylin = linspace(min(y),max(y), n_p);
[X,Y] = meshgrid(xlin,ylin);
f = scatteredInterpolant(x,y,B');
Z = f(X,Y);

figure
surf(X,Y,Z)
colorbar
shading interp
view(2)
xlabel('x')
ylabel('y')
title('|B|')

if(do_print)
    print(files.pltpth_B, print_format)
end
end