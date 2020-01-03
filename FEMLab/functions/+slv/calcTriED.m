function calcTriED(files, optProb)

load(files.respth, 'Ap', 'triangles', 'nodes', 'nNodes', ...
                   'regsTris', 'regSet', 'const', 'ABCs')

nTris = length(triangles);
Ec = zeros(1,nTris);
Ecx = zeros(1,nTris);
Ecy = zeros(1,nTris);
nodes_Ec = zeros(nTris, 2);

[hFunEx, hFunEy] = slv.getFuns('Efield', optProb);
c = 0.333333333333333;

% parameters according to region
eps_r = [regSet(regsTris).matProp];
eps = eps_r.*const.eps_0;

eps(eps == 0) = 1;
% ---------------------------- %

for iTri = 1:nTris
    
    x = nodes(triangles(iTri,:),1);
    y = nodes(triangles(iTri,:),2);
    ABC = slv.solveAbc(x,y);
    nodes_Ec(iTri, :) = [sum(x)*c, sum(y)*c];
    
    cEy = hFunEy(Ap(triangles(iTri,:)), ABC, nodes_Ec(iTri, 1), nodes_Ec(iTri, 2));
    cEx = hFunEx(Ap(triangles(iTri,:)), ABC);
    
    Ecx(iTri) = cEx;
    Ecy(iTri) = cEy;
    Ec(iTri) = sqrt(cEx^2 + cEy^2);
    
end

Dc = Ec.*eps;
Dcx = Ecx.*eps;
Dcy = Ecy.*eps;

save(files.respth, 'Ec', 'Ecx', 'Ecy', ...
                   'Dc', 'Dcx', 'Dcy', ...
                   'nodes_Ec', '-append')

end