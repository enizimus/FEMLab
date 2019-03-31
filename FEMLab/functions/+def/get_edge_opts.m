function edge_type = get_edge_opts()

load('./functions/+def/const_defs', 'defs')
c_opts = defs('msh_edge_types');
edge_type = cellfun(@(str) str2double(str), strsplit(c_opts, ' '));