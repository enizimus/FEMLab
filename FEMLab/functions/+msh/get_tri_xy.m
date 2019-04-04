function [tri_x,tri_y]  = get_tri_xy(triangles, x, y, n_tri)

tri_x = reshape(x(triangles(:)), [n_tri, 3]);
tri_y = reshape(y(triangles(:)), [n_tri, 3]);