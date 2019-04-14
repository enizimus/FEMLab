function calc_tri_point_E(files)

load(files.respth, 'U', 'triangles', 'nodes', 'n_nodes', ...
    'Ec', 'Ecx', 'Ecy', 'nodes_Ec', 'tri_area')

c_mat = msh.make_connect_mat(triangles, n_nodes);

%Bp = zeros(1, n_nodes);
Epx = zeros(1, n_nodes);
Epy = zeros(1, n_nodes);

area_sum = zeros(1, n_nodes);
for i_node = 1:n_nodes
area_sum(i_node) = 1/sum(tri_area(c_mat(i_node,:)));
end

for i_node = 1:n_nodes
    Epx(i_node) = Ecx(c_mat(i_node,:))*tri_area(c_mat(i_node,:));
    Epy(i_node) = Ecy(c_mat(i_node,:))*tri_area(c_mat(i_node,:));
end

Epx = Epx.*area_sum;
Epy = Epy.*area_sum;
Ep = sqrt(Epx.^2 + Epy.^2);

save(files.respth, 'Ep', 'Epx', 'Epy', '-append')
