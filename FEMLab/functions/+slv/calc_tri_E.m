function calc_tri_E(files, prob_opt)

load(files.respth, 'U', 'triangles', 'nodes', 'n_nodes', 'ABCs')

n_tri = length(triangles);
Ec = zeros(1,n_tri);
Ecx = zeros(1,n_tri);
Ecy = zeros(1,n_tri);
nodes_Ec = zeros(n_tri, 2);

[f_Ex, f_Ey] = slv.get_funs('Efield', prob_opt);
c = 0.333333333333333;

for i_tri = 1:n_tri
    
    x = [nodes(triangles(i_tri,:)).x];
    y = [nodes(triangles(i_tri,:)).y];
    ABC = slv.solve_abc(x,y);
    nodes_Ec(i_tri, :) = [sum(x)*c, sum(y)*c];
    
    cEy = f_Ey(U(triangles(i_tri,:)), ABC, nodes_Ec(i_tri, 1), nodes_Ec(i_tri, 2));
    cEx = f_Ex(U(triangles(i_tri,:)), ABC);
    
    Ecx(i_tri) = cEx;
    Ecy(i_tri) = cEy;
    Ec(i_tri) = sqrt(cEx^2 + cEy^2);
    
end

save(files.respth, 'Ec', 'Ecx', 'Ecy', 'nodes_Ec', '-append')

end