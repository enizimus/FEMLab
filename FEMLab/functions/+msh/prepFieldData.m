function prepFieldData(files, options)

npoints = options.Npoints;

if(all(options.xlims == 0))
    [xlims, ylims] = msh.getLimsXY(files);
else
    xlims = options.xlims;
    ylims = options.ylims;
end

[X, Y] = msh.getMeshXY(options, xlims, ylims, npoints);

save(files.respth, 'X', 'Y', 'xlims', 'ylims', '-append')