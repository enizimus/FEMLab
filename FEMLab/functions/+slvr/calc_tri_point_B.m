function calc_tri_point_B(files)

load(files.respth, 'U', 'triangles', 'nodes', 'n_nodes', ...
    'Bc', 'Bcx', 'Bcy', 'nodes_Bc', 'tri_area')

c_mat = hlp.make_connect_mat(triangles, n_nodes);
Utri = slvr.calc_tri_U(U, triangles);

Bp = zeros(1, n_nodes);
Bpx = zeros(1, n_nodes);
Bpy = zeros(1, n_nodes);

for i_node = 1:n_nodes
    Bpx(i_node) = Bcx(c_mat(i_node,:))*tri_area(c_mat(i_node,:))/sum(tri_area(c_mat(i_node,:)));
    Bpy(i_node) = Bcy(c_mat(i_node,:))*tri_area(c_mat(i_node,:))/sum(tri_area(c_mat(i_node,:)));
    Bp(i_node) = sqrt(Bpx(i_node)^2 + Bpy(i_node)^2);
end

save(files.respth, 'Bp', 'Bpx', 'Bpy', '-append')
