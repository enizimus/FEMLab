function plt_opts = get_plt_opts()

load('./functions/+def/const_defs', 'defs')
c_opts = defs('plt_defs');
plt_opts = cellfun(@(str) str2double(str), strsplit(c_opts, ' '));
