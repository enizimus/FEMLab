function [E, Ex, Ey] = eval_E(files, X, Y)

load(files.respth, 'triangles', 'x', 'y',...
                    'Ep', 'Epx', 'Epy')
                
if(nargin < 2 || (isempty(X) && isempty(Y)))
    load(files.respth, 'X', 'Y')
end

n_points = size(X,1)*size(X,2);
E = zeros(size(X));
Ex = zeros(size(X));
Ey = zeros(size(X));

TRI = triangulation(triangles, x, y);
surr_tri = pointLocation(TRI, X(:), Y(:));

N = slv.get_funs('formfun');

for i_p = 1:n_points
    
    I = triangles(surr_tri(i_p), :);
    xtri = x(I);
    ytri = y(I);
    ABC = slv.solve_abc(xtri', ytri');
    
    N_form = N(X(i_p), Y(i_p), ABC');
    E(i_p) = Ep(I)*N_form;
    Ex(i_p) = Epx(I)*N_form;
    Ey(i_p) = Epy(I)*N_form;
end

