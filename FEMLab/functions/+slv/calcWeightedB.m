function calcWeightedB(files)

load(files.respth, 'U', 'triangles', 'nodes', 'nNodes', ...
    'nodesBc', 'Bp', 'Bpx', 'Bpy')

N = slv.getFuns('formarr');
x = [nodes.x];
y = [nodes.y];
%clear nodes
xc = nodesBc(:,1);
yc = nodesBc(:,2);
clear nodesBc
nTris = size(triangles,1);
B = zeros(nTris,1);
Bx = zeros(nTris,1);
By = zeros(nTris,1);

for iTri = 1:nTris
    I = triangles(iTri,:);
    ABC = slv.solveAbc(x(I),y(I));
    %[ABC, ~] = slv.calcAbc(nodes, I);
    hNForm = N(xc(iTri), yc(iTri), ABC');
    B(iTri) = Bp(I)*hNForm;
    Bx(iTri) = Bpx(I)*hNForm;
    By(iTri) = Bpy(I)*hNForm;
end

save(files.respth, 'B', 'Bx', 'By', '-append')