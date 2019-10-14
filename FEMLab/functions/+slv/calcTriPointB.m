function calcTriPointB(files)

load(files.respth, 'triangles', 'nodes', 'nNodes', ...
    'Bc', 'Bcx', 'Bcy', 'nodesBc', 'areaTri')

matConnect = msh.matConn(triangles, nNodes);

Bpx = zeros(1, nNodes);
Bpy = zeros(1, nNodes);

areaSum = zeros(1, nNodes);
for iNode = 1:nNodes
areaSum(iNode) = 1/sum(areaTri(matConnect(iNode,:)));
end

for iNode = 1:nNodes
    Bpx(iNode) = Bcx(matConnect(iNode,:))*areaTri(matConnect(iNode,:));
    Bpy(iNode) = Bcy(matConnect(iNode,:))*areaTri(matConnect(iNode,:));
end

Bpx = Bpx.*areaSum;
Bpy = Bpy.*areaSum;
Bp = sqrt(Bpx.^2 + Bpy.^2);

save(files.respth, 'Bp', 'Bpx', 'Bpy', '-append')
