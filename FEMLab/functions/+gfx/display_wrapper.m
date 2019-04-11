function display_wrapper(files, prob_opt)

prob_opt.labels = def.get_labels(prob_opt);
n_opt = length(prob_opt.fieldplt);

for i_opt = 1:n_opt
    option = prob_opt.fieldplt{i_opt};
    switch(option)
        case('abs')
            gfx.disp_abs(files, prob_opt)
        case('quiv')
            gfx.disp_quiv(files, prob_opt)
        case('slice')
            gfx.disp_slice(files, prob_opt)
        case('cont')
            gfx.disp_cont(files, prob_opt)
    end
end