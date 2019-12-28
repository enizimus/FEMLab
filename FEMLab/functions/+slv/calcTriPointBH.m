function calcTriPointBH(files)

load(files.respth, 'triangles', 'nodes', 'nNodes', ...
                   'Bc', 'Bcx', 'Bcy', 'nodesBc', ...
                   'Hc', 'Hcx', 'Hcy', 'areaTri')

matConnect = msh.matConn(triangles, nNodes);

Bpx = zeros(1, nNodes);
Bpy = zeros(1, nNodes);

Hpx = zeros(1, nNodes);
Hpy = zeros(1, nNodes);

areaSum = zeros(1, nNodes);
for iNode = 1:nNodes
areaSum(iNode) = 1/sum(areaTri(matConnect(iNode,:)));
end

for iNode = 1:nNodes
    Bpx(iNode) = Bcx(matConnect(iNode,:))*areaTri(matConnect(iNode,:));
    Bpy(iNode) = Bcy(matConnect(iNode,:))*areaTri(matConnect(iNode,:));
    
    Hpx(iNode) = Hcx(matConnect(iNode,:))*areaTri(matConnect(iNode,:));
    Hpy(iNode) = Hcy(matConnect(iNode,:))*areaTri(matConnect(iNode,:));
end

Bpx = Bpx.*areaSum;
Bpy = Bpy.*areaSum;
Bp = sqrt(Bpx.^2 + Bpy.^2);

Hpx = Hpx.*areaSum;
Hpy = Hpy.*areaSum;
Hp = sqrt(Hpx.^2 + Hpy.^2);

save(files.respth, 'Bp', 'Bpx', 'Bpy', ...
                   'Hp', 'Hpx', 'Hpy', '-append')
