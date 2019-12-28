function [H, Hx, Hy] = evalH(files, X, Y)

load(files.respth, 'triangles', 'x', 'y',...
                    'Hp', 'Hpx', 'Hpy')
                
if(nargin < 2 || (isempty(X) && isempty(Y)))
    load(files.respth, 'X', 'Y')
end

nPts = size(X,1)*size(X,2);
H = zeros(size(X));
Hx = zeros(size(X));
Hy = zeros(size(X));

TRI = triangulation(triangles, x, y);
parentTri = pointLocation(TRI, X(:), Y(:));

N = slv.getFuns('formfun');

for iPt = 1:nPts
    if isnan(parentTri(iPt))
        pointId = nearestNeighbor(TRI, X(iPt), Y(iPt));
        pointNear = [x(pointId),y(pointId)];
        point = [X(iPt), Y(iPt)];
        deltaDist = pdist([pointNear;point]);
        mindistance = min(pdist([x,y]));
        
        if deltaDist < mindistance
            [row,~] = find(triangles == pointId);
            parentTri(iPt) = row(1);
        else
            H(iPt) = nan;
            Hx(iPt) = nan;
            Hy(iPt) = nan;
            continue;
        end

    end
    I = triangles(parentTri(iPt), :);
    xtri = x(I);
    ytri = y(I);
    ABC = slv.solveAbc(xtri', ytri');
    
    hNForm = N(X(iPt), Y(iPt), ABC');
    H(iPt) = Hp(I)*hNForm;
    Hx(iPt) = Hpx(I)*hNForm;
    Hy(iPt) = Hpy(I)*hNForm;
end

