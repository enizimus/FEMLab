function calcTriE(files, optProb)

load(files.respth, 'Ap', 'triangles', 'nodes', 'areaTri', ...
                   'ABCs')

nTris = length(triangles);
Ec = zeros(1,nTris);
Ecx = zeros(1,nTris);
Ecy = zeros(1,nTris);
nodes_Ec = zeros(nTris, 2);

[hFunEx, hFunEy] = slv.getFuns('Efield', optProb);

if(optProb.elementOrder == 1)
    c = 0.333333333333333;
elseif(optProb.elementOrder == 2)
    c = 0.166666666666667;
end

for iTri = 1:nTris
    
    x = nodes(triangles(iTri,:),1);
    y = nodes(triangles(iTri,:),2);
    ABC = ABCs(:,:,iTri)/(2*areaTri(iTri));
    
    nodes_Ec(iTri, :) = [sum(x)*c, sum(y)*c];
    
    cEy = hFunEy(Ap(triangles(iTri,:)), ABC, nodes_Ec(iTri, 1), nodes_Ec(iTri, 2));
    cEx = hFunEx(Ap(triangles(iTri,:)), ABC, nodes_Ec(iTri, 1), nodes_Ec(iTri, 2));
    
    Ecx(iTri) = cEx;
    Ecy(iTri) = cEy;
    Ec(iTri) = sqrt(cEx^2 + cEy^2);
    
end

save(files.respth, 'Ec', 'Ecx', 'Ecy', ...
                   'nodes_Ec', '-append')

end