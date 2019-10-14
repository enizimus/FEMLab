function calc_tri_B(files, optProb)

load(files.respth, 'Ap', 'triangles', 'nodes', 'n_nodes', 'ABCs')

nTris = length(triangles);
Bc = zeros(1,nTris);
Bcx = zeros(1,nTris);
Bcy = zeros(1,nTris);
nodes_Bc = zeros(nTris, 2);

[f_Bx, f_By] = slv.get_funs('Bfield', optProb);
c = 0.333333333333333;

for i_tri = 1:nTris
    
    x = [nodes(triangles(i_tri,:)).x];
    y = [nodes(triangles(i_tri,:)).y];
    ABC = slv.solve_abc(x,y);
    nodes_Bc(i_tri, :) = [sum(x)*c, sum(y)*c];
    
    cBy = f_By(Ap(triangles(i_tri,:)), ABC, nodes_Bc(i_tri, 1), nodes_Bc(i_tri, 2));
    cBx = f_Bx(Ap(triangles(i_tri,:)), ABC);
    
    Bcx(i_tri) = cBx;
    Bcy(i_tri) = cBy;
    Bc(i_tri) = sqrt(cBx^2 + cBy^2);
    
end

save(files.respth, 'Bc', 'Bcx', 'Bcy', 'nodes_Bc', '-append')

end