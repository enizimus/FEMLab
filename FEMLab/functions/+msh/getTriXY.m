function [xTri, yTri]  = getTriXY(triangles, x, y, nTris, nPts)

xTri = reshape(x(triangles(:)), [nTris, nPts]);
yTri = reshape(y(triangles(:)), [nTris, nPts]);