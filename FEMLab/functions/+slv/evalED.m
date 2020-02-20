function [E, Ex, Ey, D, Dx, Dy] = evalED(files, optProb, X, Y)

load(files.respth, 'triangles', 'x', 'y',...
                    'Ep', 'Epx', 'Epy', ...
                    'Dp', 'Dpx', 'Dpy', ...
                    'ABCs', 'areaTri')
                
if(nargin < 3 || (isempty(X) && isempty(Y)))
    load(files.respth, 'X', 'Y')
end

nPts = size(X,1)*size(X,2);

E = zeros(size(X));
Ex = zeros(size(X));
Ey = zeros(size(X));

D = zeros(size(X));
Dx = zeros(size(X));
Dy = zeros(size(X));

TRI = triangulation(triangles, x, y);
parentTri = pointLocation(TRI, X(:), Y(:));

N = slv.getFuns('formfun', optProb);

for iPt = 1:nPts
    
    iTri = parentTri(iPt);
    I = triangles(iTri, :);
    ABC = ABCs(:,:,iTri)/(2*areaTri(iTri));
    
    hNForm = N(X(iPt), Y(iPt), ABC);
    
    E(iPt) = hNForm*Ep(I)';
    Ex(iPt) = hNForm*Epx(I)';
    Ey(iPt) = hNForm*Epy(I)';
    
    D(iPt) = hNForm*Dp(I)';
    Dx(iPt) = hNForm*Dpx(I)';
    Dy(iPt) = hNForm*Dpy(I)';
end

