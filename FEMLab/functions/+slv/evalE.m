function [E, Ex, Ey] = evalE(files, optProb, X, Y)

load(files.respth, 'triangles', 'x', 'y',...
                    'Ep', 'Epx', 'Epy', ...
                    'ABCs', 'areaTri')
                
if(nargin < 3 || (isempty(X) && isempty(Y)))
    load(files.respth, 'X', 'Y')
end

nPts = size(X,1)*size(X,2);

E = zeros(size(X));
Ex = zeros(size(X));
Ey = zeros(size(X));

TRI = triangulation(triangles(:,1:3), x, y);
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
end


