function [xTri,yTri]  = getTriXY(triangles, x, y, nTris)

xTri = reshape(x(triangles(:)), [nTris, 3]);
yTri = reshape(y(triangles(:)), [nTris, 3]);