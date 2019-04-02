function [max_len, n] = max_vec_len(cell_arr)
max_len = 0;
n = numel(cell_arr);
for i = 1:n
    c_len = numel(cell_arr{i});
    if(c_len > max_len)
        max_len = c_len;
    end
end
end

