function prep_field_data(files, mshType)

load(files.respth, 'x', 'y')

npoints = 25;
[xlims,ylims] = msh.get_xy_lims(files);
[X,Y] = msh.get_xy_mesh(mshType, xlims, ylims, npoints);

save(files.respth, 'X', 'Y', 'xlims', 'ylims', '-append')