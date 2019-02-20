function display_potentials(file_name)
disp('-Assembling solution matrix and calculating solution ...')
respth = ['.\results\', file_name];
load(respth, 'U', 'triangles', 'nodes')
tri = triangulation(triangles, [nodes.x]', [nodes.y]', U);

figure
trisurf(tri)
colorbar
title([file_name, '.msh Potential'])
xlabel('x')
ylabel('y')
zlabel('A')

end