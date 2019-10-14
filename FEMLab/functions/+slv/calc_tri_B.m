function calc_tri_B(files, optProb)

load(files.respth, 'Ap', 'triangles', 'nodes', 'nNodes', 'ABCs')

nTris = length(triangles);
Bc = zeros(1,nTris);
Bcx = zeros(1,nTris);
Bcy = zeros(1,nTris);
nodes_Bc = zeros(nTris, 2);

[f_Bx, f_By] = slv.get_funs('Bfield', optProb);
c = 0.333333333333333;

for iTri = 1:nTris
    
    x = [nodes(triangles(iTri,:)).x];
    y = [nodes(triangles(iTri,:)).y];
    ABC = slv.solve_abc(x,y);
    nodes_Bc(iTri, :) = [sum(x)*c, sum(y)*c];
    
    cBy = f_By(Ap(triangles(iTri,:)), ABC, nodes_Bc(iTri, 1), nodes_Bc(iTri, 2));
    cBx = f_Bx(Ap(triangles(iTri,:)), ABC);
    
    Bcx(iTri) = cBx;
    Bcy(iTri) = cBy;
    Bc(iTri) = sqrt(cBx^2 + cBy^2);
    
end

save(files.respth, 'Bc', 'Bcx', 'Bcy', 'nodes_Bc', '-append')

end