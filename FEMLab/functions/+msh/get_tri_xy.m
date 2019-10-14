function [tri_x,tri_y]  = get_tri_xy(triangles, x, y, nTris)

tri_x = reshape(x(triangles(:)), [nTris, 3]);
tri_y = reshape(y(triangles(:)), [nTris, 3]);