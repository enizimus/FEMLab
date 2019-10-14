function [E, Ex, Ey] = eval_E(files, X, Y)

load(files.respth, 'triangles', 'x', 'y',...
                    'Ep', 'Epx', 'Epy')
                
if(nargin < 2 || (isempty(X) && isempty(Y)))
    load(files.respth, 'X', 'Y')
end

nPts = size(X,1)*size(X,2);
E = zeros(size(X));
Ex = zeros(size(X));
Ey = zeros(size(X));

TRI = triangulation(triangles, x, y);
surr_tri = pointLocation(TRI, X(:), Y(:));

N = slv.get_funs('formfun');

for iPt = 1:nPts
    
    I = triangles(surr_tri(iPt), :);
    xtri = x(I);
    ytri = y(I);
    ABC = slv.solve_abc(xtri', ytri');
    
    N_form = N(X(iPt), Y(iPt), ABC');
    E(iPt) = Ep(I)*N_form;
    Ex(iPt) = Epx(I)*N_form;
    Ey(iPt) = Epy(I)*N_form;
end

