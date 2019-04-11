function [B, Bx, By] = eval_B(files, xp, yp)

load(files.respth, 'triangles', 'x', 'y',...
                    'Bp', 'Bpx', 'Bpy')

n_points = size(xp,1)*size(xp,2);
B = zeros(size(xp));
Bx = zeros(size(xp));
By = zeros(size(xp));

TRI = triangulation(triangles, x, y);
surr_tri = pointLocation(TRI, xp(:), yp(:));

N = slv.get_funs('formarr');

for i_p = 1:n_points
    
    I = triangles(surr_tri(i_p), :);
    xtri = x(I);
    ytri = y(I);
    ABC = slv.solve_abc(xtri', ytri');
    
    N_form = N(xp(i_p), yp(i_p), ABC');
    B(i_p) = Bp(I)*N_form;
    Bx(i_p) = Bpx(I)*N_form;
    By(i_p) = Bpy(I)*N_form;
end

