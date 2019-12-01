function prepFieldData(files, options)

load(files.respth, 'x', 'y')

npoints = 25;
[xlims,ylims] = msh.getLimsXY(files);
[X,Y] = msh.getMeshXY(options, xlims, ylims, npoints);

save(files.respth, 'X', 'Y', 'xlims', 'ylims', '-append')