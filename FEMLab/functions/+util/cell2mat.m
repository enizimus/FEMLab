function res_mat = cell2mat(cell_mat)

cells_split = cellfun(@(x) strsplit(x, ' '), cell_mat(:), 'UniformOutput', false');
[n, n_elem] = util.max_vec_len(cells_split);
res_mat = zeros(n_elem, n);
for iNode = 1:n_elem
    res_mat(iNode, :) = util.cell2vec(cells_split{iNode}, n);
end
end

