function [I_l, I_t] = sep_lines_tris(n_items, element_r, rkeys, n_tri, n_lines)

I_l = false(n_lines, n_items(1));
I_t = false(n_tri, n_items(2));

for i_r = 1:n_items(1)
    I_l(:, i_r) = element_r(1:n_lines) == rkeys(i_r);
end

for i_r = n_items(1)+1:sum(n_items)
    I_t(:, i_r) = element_r(n_lines+1:n_lines+n_tri) == rkeys(i_r);
end
    