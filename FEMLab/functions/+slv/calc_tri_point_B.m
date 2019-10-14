function calc_tri_point_B(files)

load(files.respth, 'triangles', 'nodes', 'nNodes', ...
    'Bc', 'Bcx', 'Bcy', 'nodes_Bc', 'tri_area')

c_mat = msh.matConn(triangles, nNodes);

Bpx = zeros(1, nNodes);
Bpy = zeros(1, nNodes);

area_sum = zeros(1, nNodes);
for i_node = 1:nNodes
area_sum(i_node) = 1/sum(tri_area(c_mat(i_node,:)));
end

for i_node = 1:nNodes
    Bpx(i_node) = Bcx(c_mat(i_node,:))*tri_area(c_mat(i_node,:));
    Bpy(i_node) = Bcy(c_mat(i_node,:))*tri_area(c_mat(i_node,:));
end

Bpx = Bpx.*area_sum;
Bpy = Bpy.*area_sum;
Bp = sqrt(Bpx.^2 + Bpy.^2);

save(files.respth, 'Bp', 'Bpx', 'Bpy', '-append')
