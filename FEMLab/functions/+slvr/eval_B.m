function [B, Bx, By] = eval_B(files, x, y)

load(files.respth, 'triangles', 'nodes', 'n_nodes', 'nodes_Bc',...
                    'Bp', 'Bpx', 'Bpy')

n_points = length(x);
B = zeros(n_points, 1);
Bx = zeros(n_points, 1);
By = zeros(n_points, 1);

surr_tri = slvr.find_tris(triangles, nodes, x, y);
N = slvr.get_funs('formarr');

for i_p = 1:n_points
    
    I = triangles(surr_tri(i_p), :);
    xtri = [nodes(I).x];
    ytri = [nodes(I).y];
    ABC = slvr.solve_abc(xtri, ytri);
    
    N_form = N(x(i_p), y(i_p), ABC');
    B(i_p) = Bp(I)*N_form;
    Bx(i_p) = Bpx(I)*N_form;
    By(i_p) = Bpy(I)*N_form;
    
end

