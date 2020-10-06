function [x,y] = getXYFromXiEta(files, optProb, elements, xi, eta)

N_elements = length(elements);
N_points = length(xi);

S = load(files.respth, ...
    "triangles", ...
    "nodes");

x = zeros(N_elements, N_points);
y = zeros(N_elements, N_points);

ABC = slv.getAbcsXiEta(optProb)';
formfun = slv.getFormFun(optProb);

for k = 1 : N_elements
    element_node_coordinates = S.nodes(S.triangles(elements(k), :), :);
    
     formfun_matrix = formfun(xi(:),eta(:),ABC);
     xk = (formfun_matrix * element_node_coordinates(:,1))';
     yk = (formfun_matrix * element_node_coordinates(:,2))';
     x(k,:) = xk;
     y(k,:) = yk;
     
     if any(xk < 0)
         keyboard
     end
end
end
