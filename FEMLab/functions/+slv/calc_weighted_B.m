function calc_weighted_B(files)

load(files.respth, 'U', 'triangles', 'nodes', 'n_nodes', ...
    'nodes_Bc', 'Bp', 'Bpx', 'Bpy')

N = slv.get_funs('formarr');
x = [nodes.x];
y = [nodes.y];
%clear nodes
xc = nodes_Bc(:,1);
yc = nodes_Bc(:,2);
clear nodes_Bc
n_tri = size(triangles,1);
B = zeros(n_tri,1);
Bx = zeros(n_tri,1);
By = zeros(n_tri,1);

for i_tri = 1:n_tri
    I = triangles(i_tri,:);
    ABC = slv.solve_abc(x(I),y(I));
    %[ABC, ~] = slv.calc_abc(nodes, I);
    N_form = N(xc(i_tri), yc(i_tri), ABC');
    B(i_tri) = Bp(I)*N_form;
    Bx(i_tri) = Bpx(I)*N_form;
    By(i_tri) = Bpy(I)*N_form;
end

save(files.respth, 'B', 'Bx', 'By', '-append')