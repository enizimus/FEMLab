function calc_weighted_B(files)

load(files.respth, 'U', 'triangles', 'nodes', 'n_nodes', ...
    'Bc', 'Bcx', 'Bcy', 'nodes_Bc')

c_mat = hlp.make_connect_mat(triangles, n_nodes);
Utri = slvr.calc_tri_U(U, triangles);

B = zeros(1, n_nodes);
Bx = zeros(1, n_nodes);
By = zeros(1, n_nodes);

for i_node = 1:n_nodes
    Bx(i_node) = Bcx(c_mat(i_node,:))*Utri(c_mat(i_node,:))'/sum(Utri(c_mat(i_node,:)));
    By(i_node) = Bcy(c_mat(i_node,:))*Utri(c_mat(i_node,:))'/sum(Utri(c_mat(i_node,:)));
    B(i_node) = sqrt(Bx(i_node)^2 + By(i_node)^2);
end

save(files.respth, 'B', 'Bx', 'By', '-append')
