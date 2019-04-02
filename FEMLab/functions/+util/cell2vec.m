function vec = cell2vec(cell_arr, n)
% vec = zeros(1, n);
% for i = 1:length(cell_arr)
%     vec(i) = str2double(cell_arr{i});
% end
vec = zeros(1,n);
vec(1:numel(cell_arr)) = arrayfun(@(x) str2double(x), cell_arr)';

end

