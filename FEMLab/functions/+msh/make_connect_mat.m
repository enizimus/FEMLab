function connect_mat = make_connect_mat(triangles, n_nodes)

n_tri = size(triangles,1);
connect_mat = false(n_nodes, n_tri);
for i_tri = 1:n_tri
    connect_mat(triangles(i_tri,:), i_tri) = true;
end