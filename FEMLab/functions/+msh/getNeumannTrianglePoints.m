function I = getNeumannTrianglePoints(nodeProps, triangles, nTris, nTriNodes)

isNeumann = nodeProps == 2;
nodeProps(~isNeumann) = 0;
I = reshape(nodeProps(triangles(:)), [nTris, nTriNodes]);