function calcTriPointE(files)

load(files.respth, 'triangles', 'nodes', 'nNodes', ...
    'Ec', 'Ecx', 'Ecy', 'nodes_Ec', 'areaTri')

matConnect = msh.matConn(triangles, nNodes);

Epx = zeros(1, nNodes);
Epy = zeros(1, nNodes);

areaSum = zeros(1, nNodes);
for iNode = 1:nNodes
areaSum(iNode) = 1/sum(areaTri(matConnect(iNode,:)));
end

for iNode = 1:nNodes
    Epx(iNode) = Ecx(matConnect(iNode,:))*areaTri(matConnect(iNode,:));
    Epy(iNode) = Ecy(matConnect(iNode,:))*areaTri(matConnect(iNode,:));
end

Epx = Epx.*areaSum;
Epy = Epy.*areaSum;
Ep = sqrt(Epx.^2 + Epy.^2);

save(files.respth, 'Ep', 'Epx', 'Epy', '-append')