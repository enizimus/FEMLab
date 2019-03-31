function params = get(keys)

if(~iscell(keys))
    keys = {keys};
end
load('./functions/+def/const_defs', 'defs')
n_keys = numel(keys);
for i_key = 1:n_keys
    switch lower(keys{i_key})
        case {'triangle_area_eps'}
            params = str2double(defs('triangle_area_eps'));
        case {'msh_edge_types'}
            c_opts = defs('msh_edge_types');
            params = cellfun(@(str) str2double(str), strsplit(c_opts, ' '));
        case {'plt_defs'}
            c_opts = defs('plt_defs');
            params = cellfun(@(str) str2double(str), strsplit(c_opts, ' '));
    end
end