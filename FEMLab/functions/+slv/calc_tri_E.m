function calc_tri_E(files, optProb)

load(files.respth, 'Ap', 'triangles', 'nodes', 'nNodes', 'ABCs')

nTris = length(triangles);
Ec = zeros(1,nTris);
Ecx = zeros(1,nTris);
Ecy = zeros(1,nTris);
nodes_Ec = zeros(nTris, 2);

[f_Ex, f_Ey] = slv.get_funs('Efield', optProb);
c = 0.333333333333333;

for iTri = 1:nTris
    
    x = [nodes(triangles(iTri,:)).x];
    y = [nodes(triangles(iTri,:)).y];
    ABC = slv.solve_abc(x,y);
    nodes_Ec(iTri, :) = [sum(x)*c, sum(y)*c];
    
    cEy = f_Ey(Ap(triangles(iTri,:)), ABC, nodes_Ec(iTri, 1), nodes_Ec(iTri, 2));
    cEx = f_Ex(Ap(triangles(iTri,:)), ABC);
    
    Ecx(iTri) = cEx;
    Ecy(iTri) = cEy;
    Ec(iTri) = sqrt(cEx^2 + cEy^2);
    
end

save(files.respth, 'Ec', 'Ecx', 'Ecy', 'nodes_Ec', '-append')

end