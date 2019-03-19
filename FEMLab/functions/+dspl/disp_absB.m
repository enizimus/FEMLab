function disp_absB(files, do_print, print_format)

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