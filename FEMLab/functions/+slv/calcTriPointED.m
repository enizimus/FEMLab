function calcTriPointED(files)

load(files.respth, 'triangles', 'nodes', 'nNodes', ...
                   'Ec', 'Ecx', 'Ecy', 'nodes_Ec', ...
                   'Dc', 'Dcx', 'Dcy', 'areaTri')

matConnect = msh.matConn(triangles, nNodes);

Epx = zeros(1, nNodes);
Epy = zeros(1, nNodes);

Dpx = zeros(1, nNodes);
Dpy = zeros(1, nNodes);

areaSum = zeros(1, nNodes);
for iNode = 1:nNodes
areaSum(iNode) = 1/sum(areaTri(matConnect(iNode,:)));
end

for iNode = 1:nNodes
    
    Epx(iNode) = Ecx(matConnect(iNode,:))*areaTri(matConnect(iNode,:));
    Epy(iNode) = Ecy(matConnect(iNode,:))*areaTri(matConnect(iNode,:));
    
    Dpx(iNode) = Dcx(matConnect(iNode,:))*areaTri(matConnect(iNode,:));
    Dpy(iNode) = Dcy(matConnect(iNode,:))*areaTri(matConnect(iNode,:));
    
end

Epx = Epx.*areaSum;
Epy = Epy.*areaSum;
Ep = sqrt(Epx.^2 + Epy.^2);

Dpx = Dpx.*areaSum;
Dpy = Dpy.*areaSum;
Dp = sqrt(Dpx.^2 + Dpy.^2);

save(files.respth, 'Ep', 'Epx', 'Epy', ...
                   'Dp', 'Dpx', 'Dpy', '-append')
