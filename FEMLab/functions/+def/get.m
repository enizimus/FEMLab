function params = get(keys)

if(~iscell(keys))
    keys = {keys};
end
load('./functions/+def/const_defs', 'defs')
nKeys = numel(keys);
for iKey = 1:nKeys
    switch lower(keys{iKey})
        case {'triangle_area_eps'}
            params = str2double(defs('triangle_area_eps'));
        case {'msh_edge_types'}
            cOpts = defs('msh_edge_types');
            params = cellfun(@(str) str2double(str), strsplit(cOpts, ' '));
        case {'plt_defs'}
            cOpts = defs('plt_defs');
            params = cellfun(@(str) str2double(str), strsplit(cOpts, ' '));
    end
end