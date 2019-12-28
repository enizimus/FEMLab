function calcTriBH(files, optProb)

load(files.respth, 'Ap', 'triangles', 'nodes', 'nNodes', ...
    'ABCs', 'regsTris', 'regSet', 'const')

nTris = length(triangles);
Bc = zeros(1,nTris);
Bcx = zeros(1,nTris);
Bcy = zeros(1,nTris);
nodesBc = zeros(nTris, 2);

[hFunBx, hFunBy] = slv.getFuns('Bfield', optProb);
c = 0.333333333333333;

% parameters according to region
mu_r = [regSet(regsTris).matProp];
mu = mu_r.*const.mu_0;

mu(mu == 0) = 1;
% ---------------------------- %

for iTri = 1:nTris
    
    x = [nodes(triangles(iTri,:)).x];
    y = [nodes(triangles(iTri,:)).y];
    ABC = slv.solveAbc(x,y);
    nodesBc(iTri, :) = [sum(x)*c, sum(y)*c];
    
    cBy = hFunBy(Ap(triangles(iTri,:)), ABC, nodesBc(iTri, 1), nodesBc(iTri, 2));
    cBx = hFunBx(Ap(triangles(iTri,:)), ABC);
    
    Bcx(iTri) = cBx;
    Bcy(iTri) = cBy;
    Bc(iTri) = sqrt(cBx^2 + cBy^2);
    
end

Hc = Bc./mu;
Hcx = Bcx./mu;
Hcy = Bcy./mu;

save(files.respth, 'Bc', 'Bcx', 'Bcy', ...
                   'Hc', 'Hcx', 'Hcy', ...
                   'nodesBc', '-append')

end