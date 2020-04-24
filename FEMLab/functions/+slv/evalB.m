function [B, Bx, By] = evalB(files, optProb, X, Y)

load(files.respth, 'triangles', 'x', 'y',...
                    'Bp', 'Bpx', 'Bpy', ...
                    'ABCs', 'areaTri')
                
if(nargin < 3 || (isempty(X) && isempty(Y)))
    load(files.respth, 'X', 'Y')
end

nPts = size(X,1)*size(X,2);

B = zeros(size(X));
Bx = zeros(size(X));
By = zeros(size(X));

TRI = triangulation(triangles(:,1:3), x, y);
parentTri = pointLocation(TRI, X(:), Y(:));

N = slv.getFuns('formfun', optProb);

for iPt = 1:nPts
    if isnan(parentTri(iPt))
        pointId = nearestNeighbor(TRI, X(iPt), Y(iPt));
        pointNear = [x(pointId),y(pointId)];
        point = [X(iPt), Y(iPt)];
        deltaDist = pdist([pointNear;point]);
        mindistance = min(pdist([x,y]));
        
        if deltaDist<mindistance
            [row,~]=find(triangles==pointId);
            parentTri(iPt)=row(1);
        else
            
            B(iPt) = nan;
            Bx(iPt) = nan;
            By(iPt) = nan;
            
            continue;
        end

    end
    
    iTri = parentTri(iPt);
    I = triangles(iTri, :);
    ABC = ABCs(:,:,iTri)/(2*areaTri(iTri));
    
    hNForm = N(X(iPt), Y(iPt), ABC)';
    
    B(iPt) = Bp(I)*hNForm;
    Bx(iPt) = Bpx(I)*hNForm;
    By(iPt) = Bpy(I)*hNForm;
    
end