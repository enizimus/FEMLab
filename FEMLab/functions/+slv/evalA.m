function evalA(files)

load(files.respth, 'triangles', 'x', 'y', 'Ap',...
    'X', 'Y')

nPts = size(X,1)*size(X,2);
A = zeros(size(X));

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
        
        if deltaDist<mindistance
            [row,~]=find(triangles==pointId);
            parentTri(iPt)=row(1);
        else
            A(iPt)=nan;
            continue;
        end
    end
    I = triangles(parentTri(iPt), :);
    xtri = x(I);
    ytri = y(I);
    ABC = slv.solveAbc(xtri, ytri);
    
    hNForm = N(X(iPt), Y(iPt), ABC');
    A(iPt) = Ap(I)'*hNForm;
end

save(files.respth, 'A', '-append')

