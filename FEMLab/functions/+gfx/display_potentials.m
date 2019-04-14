function display_potentials(files, do_print, print_format)

if(nargin < 3 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 2 || isempty(do_print)), do_print = 0; end

load(files.respth, 'U', 'triangles', 'x', 'y')
tri = triangulation(triangles, x, y, U);

figure
trisurf(tri)
colorbar
title([files.file_name, ' potential'], 'interpreter', 'none')
xlabel('x')
ylabel('y')
zlabel('A')
view(2)
xlim([min(x(:)), max(x(:))])
ylim([min(y(:)), max(y(:))])
if(do_print)
    print(files.pltpth_pot, print_format)
end

end