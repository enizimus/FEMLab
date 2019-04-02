function calc_tri_point_B(files)

load(files.respth, 'U', 'triangles', 'nodes', 'n_nodes', ...
    'Bc', 'Bcx', 'Bcy', 'nodes_Bc', 'tri_area')

c_mat = msh.make_connect_mat(triangles, n_nodes);

%Bp = zeros(1, n_nodes);
Bpx = zeros(1, n_nodes);
Bpy = zeros(1, n_nodes);

area_sum = zeros(1, n_nodes);
for i_node = 1:n_nodes
area_sum(i_node) = 1/sum(tri_area(c_mat(i_node,:)));
end

for i_node = 1:n_nodes
    Bpx(i_node) = Bcx(c_mat(i_node,:))*tri_area(c_mat(i_node,:));
    Bpy(i_node) = Bcy(c_mat(i_node,:))*tri_area(c_mat(i_node,:));
end

Bpx = Bpx.*area_sum;
Bpy = Bpy.*area_sum;
Bp = sqrt(Bpx.^2 + Bpy.^2);

save(files.respth, 'Bp', 'Bpx', 'Bpy', '-append')
