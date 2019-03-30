function [xlims, ylims] = get_xy_lims(files)

load(files.respth, 'nodes');
xlims = [min([nodes.x]), max([nodes.x])];
ylims = [min([nodes.y]), max([nodes.y])];