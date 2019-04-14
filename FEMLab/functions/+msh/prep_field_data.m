function prep_field_data(files, msh_opt)

load(files.respth, 'x', 'y')

npoints = 50;
[xlims,ylims] = msh.get_xy_lims(files);
[X,Y] = msh.get_xy_mesh(msh_opt, xlims, ylims, npoints);

save(files.respth, 'X', 'Y', 'xlims', 'ylims', '-append')