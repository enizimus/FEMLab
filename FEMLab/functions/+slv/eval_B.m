function [B, Bx, By] = eval_B(files, x, y)

load(files.respth, 'triangles', 'nodes', 'n_nodes', 'nodes_Bc',...
                    'Bp', 'Bpx', 'Bpy', 'tri_area')

n_points = size(x,1)*size(x,2);
B = zeros(size(x));
Bx = zeros(size(x));
By = zeros(size(x));

surr_tri = msh.find_tris(triangles, nodes, x, y);
N = slv.get_funs('formarr');

for i_p = 1:n_points
    
    I = triangles(surr_tri(i_p), :);
    xtri = [nodes(I).x];
    ytri = [nodes(I).y];
    ABC = slv.solve_abc(xtri, ytri);
    
    N_form = N(x(i_p), y(i_p), ABC');
    B(i_p) = Bp(I)*N_form;
    Bx(i_p) = Bpx(I)*N_form;
    By(i_p) = Bpy(I)*N_form;
end

