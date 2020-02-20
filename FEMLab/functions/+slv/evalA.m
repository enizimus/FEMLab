function evalA(files, optProb)

load(files.respth, 'triangles', 'x', 'y', 'Ap',...
    'X', 'Y', 'ABCs', 'areaTri')

nPts = size(X,1)*size(X,2);
A = zeros(size(X));

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
            A(iPt)=nan;
            continue;
        end
    end
    
    iTri = parentTri(iPt);
    I = triangles(iTri, :);
    ABC = ABCs(:,:,iTri)/(2*areaTri(iTri));
    hNForm = N(X(iPt), Y(iPt), ABC);
    
    A(iPt) = hNForm*Ap(I);
end

save(files.respth, 'A', '-append')

