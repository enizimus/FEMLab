function edgeType = getEdgeOpts()

load('./functions/+def/const_defs', 'defs')
cOpts = defs('msh_edge_types');
edgeType = cellfun(@(str) str2double(str), strsplit(cOpts, ' '));