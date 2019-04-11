function [xlims, ylims] = get_xy_lims(files)

load(files.respth, 'x', 'y');
xlims = [min(x), max(x)];
ylims = [min(y), max(y)];