function [E, Ex, Ey] = evalE(files, X, Y)

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
parentTri = pointLocation(TRI, X(:), Y(:));

N = slv.getFuns('formfun');

for iPt = 1:nPts
    
    I = triangles(parentTri(iPt), :);
    xtri = x(I);
    ytri = y(I);
    ABC = slv.solveAbc(xtri', ytri');
    
    hNForm = N(X(iPt), Y(iPt), ABC');
    E(iPt) = Ep(I)*hNForm;
    Ex(iPt) = Epx(I)*hNForm;
    Ey(iPt) = Epy(I)*hNForm;
end

