function wrappDisp(files, optProb)

optProb.labels = def.getLabels(optProb);
nOpts = length(optProb.fieldplt);

for iOpt = 1:nOpts
    option = optProb.fieldplt{iOpt};
    
    switch(option)
        case('abs')
            gfx.dispAbs(files, optProb)
        case('abstri')
            gfx.dispAbstri(files, optProb)
        case('quiv')
            gfx.dispQuiv(files, optProb)
        case('slice')
            gfx.dispSlice(files, optProb)
        case('cont')
            gfx.dispCont(files, optProb)
        case{'flines'}
            gfx.dispFlines(files, optProb)
    end
end