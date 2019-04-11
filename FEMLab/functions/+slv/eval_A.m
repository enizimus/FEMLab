function eval_A(files)

load(files.respth, 'triangles', 'x', 'y', 'U',...
    'X', 'Y')

n_points = size(X,1)*size(X,2);
A = zeros(size(X));

TRI = triangulation(triangles, x, y);
surr_tri = pointLocation(TRI, X(:), Y(:));

N = slv.get_funs('formarr');

for i_p = 1:n_points
    
    I = triangles(surr_tri(i_p), :);
    xtri = x(I);
    ytri = y(I);
    ABC = slv.solve_abc(xtri', ytri');
    
    N_form = N(X(i_p), Y(i_p), ABC');
    A(i_p) = U(I)'*N_form;
end

save(files.respth, 'A', '-append')

