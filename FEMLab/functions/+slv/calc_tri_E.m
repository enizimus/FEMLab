function calc_tri_E(files, optProb)

load(files.respth, 'Ap', 'triangles', 'nodes', 'n_nodes', 'ABCs')

nTris = length(triangles);
Ec = zeros(1,nTris);
Ecx = zeros(1,nTris);
Ecy = zeros(1,nTris);
nodes_Ec = zeros(nTris, 2);

[f_Ex, f_Ey] = slv.get_funs('Efield', optProb);
c = 0.333333333333333;

for i_tri = 1:nTris
    
    x = [nodes(triangles(i_tri,:)).x];
    y = [nodes(triangles(i_tri,:)).y];
    ABC = slv.solve_abc(x,y);
    nodes_Ec(i_tri, :) = [sum(x)*c, sum(y)*c];
    
    cEy = f_Ey(Ap(triangles(i_tri,:)), ABC, nodes_Ec(i_tri, 1), nodes_Ec(i_tri, 2));
    cEx = f_Ex(Ap(triangles(i_tri,:)), ABC);
    
    Ecx(i_tri) = cEx;
    Ecy(i_tri) = cEy;
    Ec(i_tri) = sqrt(cEx^2 + cEy^2);
    
end

save(files.respth, 'Ec', 'Ecx', 'Ecy', 'nodes_Ec', '-append')

end