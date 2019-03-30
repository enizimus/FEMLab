function options = assign_plt_opts(opts_cell)

options = zeros(numel(opts_cell),1);
def_opts = def.get_plt_opts();
for i_opt = 1:numel(opts_cell)
    switch lower(opts_cell{i_opt})
        case {'abs', 'absolute', '1'}
            options(i_opt) = def_opts(1);
        case {'quiv', 'quiver', '2'}
            options(i_opt) = def_opts(2);
        case {'slice', 'streamslice', '3'}
            options(i_opt) = def_opts(3);
        case {'cont', 'contour', '4'}
            options(i_opt) = def_opts(4);
    end
end