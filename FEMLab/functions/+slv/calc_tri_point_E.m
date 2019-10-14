function calc_tri_point_E(files)

load(files.respth, 'triangles', 'nodes', 'nNodes', ...
    'Ec', 'Ecx', 'Ecy', 'nodes_Ec', 'tri_area')

c_mat = msh.matConn(triangles, nNodes);

%Bp = zeros(1, nNodes);
Epx = zeros(1, nNodes);
Epy = zeros(1, nNodes);

area_sum = zeros(1, nNodes);
for i_node = 1:nNodes
area_sum(i_node) = 1/sum(tri_area(c_mat(i_node,:)));
end

for i_node = 1:nNodes
    Epx(i_node) = Ecx(c_mat(i_node,:))*tri_area(c_mat(i_node,:));
    Epy(i_node) = Ecy(c_mat(i_node,:))*tri_area(c_mat(i_node,:));
end

Epx = Epx.*area_sum;
Epy = Epy.*area_sum;
Ep = sqrt(Epx.^2 + Epy.^2);

save(files.respth, 'Ep', 'Epx', 'Epy', '-append')
