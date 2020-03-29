function [D, Dx, Dy] = evalD(files, X, Y)

load(files.respth, 'triangles', 'x', 'y',...
                    'Ep', 'Epx', 'Epy')
                
if(nargin < 2 || (isempty(X) && isempty(Y)))
    load(files.respth, 'X', 'Y')
end

nPts = size(X,1)*size(X,2);
D = zeros(size(X));
Dx = zeros(size(X));
Dy = zeros(size(X));

TRI = triangulation(triangles(:,1:3), x, y);
parentTri = pointLocation(TRI, X(:), Y(:));

N = slv.getFuns('formfun');

for iPt = 1:nPts
    
    I = triangles(parentTri(iPt), :);
    xtri = x(I);
    ytri = y(I);
    ABC = slv.solveAbc(xtri, ytri);
    
    hNForm = N(X(iPt), Y(iPt), ABC');
    D(iPt) = Dp(I)*hNForm;
    Dx(iPt) = Dpx(I)*hNForm;
    Dy(iPt) = Dpy(I)*hNForm;
end

