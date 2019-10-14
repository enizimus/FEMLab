function optPlt = getPltOpts()

load('./functions/+def/const_defs', 'defs')
cOpts = defs('plt_defs');
optPlt = cellfun(@(str) str2double(str), strsplit(cOpts, ' '));
