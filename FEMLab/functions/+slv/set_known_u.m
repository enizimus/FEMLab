function [I, i_k, i_n] = set_known_u(nodes, nodes_prop, regions_c)
I = nodes_prop(nodes);
U = zeros(3,1);
i_k = find(I ~= 0);
i_n = 1:3;
i_n(i_k) = [];
U(i_k) = regions_c.get_param(I(i_k));

if(isempty(i_k)), i_k = 1; end


