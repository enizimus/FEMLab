function display_potentials(files, do_print, print_format)

if(nargin < 3 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 2 || isempty(do_print)), do_print = 0; end

load(files.respth, 'U', 'triangles', 'nodes')
tri = triangulation(triangles, [nodes.x]', [nodes.y]', U);

figure
trisurf(tri)
colorbar
title([files.file_name, ' potential'], 'interpreter', 'none')
xlabel('x')
ylabel('y')
zlabel('A')
view(2)

if(do_print)
    print(files.pltpth_pot, print_format)
end

end