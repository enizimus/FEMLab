function display_wrapper(files, optProb)

optProb.labels = def.getLabels(optProb);
n_opt = length(optProb.fieldplt);

for iOpt = 1:n_opt
    option = optProb.fieldplt{iOpt};
    
    switch(option)
        case('abs')
            gfx.disp_abs(files, optProb)
        case('abstri')
            gfx.disp_abstri(files, optProb)
        case('quiv')
            gfx.disp_quiv(files, optProb)
        case('slice')
            gfx.disp_slice(files, optProb)
        case('cont')
            gfx.disp_cont(files, optProb)
        case{'flines'}
            gfx.disp_flines(files, optProb)
    end
end