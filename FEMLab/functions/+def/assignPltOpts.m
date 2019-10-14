function options = assignPltOpts(cOptions)

options = zeros(numel(cOptions),1);
defOpts = def.getPltOpts();
for iOpt = 1:numel(cOptions)
    switch lower(cOptions{iOpt})
        case {'abs', 'absolute', '1'}
            options(iOpt) = defOpts(1);
        case {'quiv', 'quiver', '2'}
            options(iOpt) = defOpts(2);
        case {'slice', 'streamslice', '3'}
            options(iOpt) = defOpts(3);
        case {'cont', 'contour', '4'}
            options(iOpt) = defOpts(4);
    end
end