function display_B(files, prob_opt, do_print, print_format)

if(nargin < 4 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 3 || isempty(do_print)), do_print = 0; end

labels = def.get_labels(prob_opt);
n_opt = length(prob_opt.fieldplt);

for i_opt = 1:n_opt
    option = prob_opt.fieldplt{i_opt};
    switch(option)
        case('abs')
            gfx.disp_absB(files, labels, do_print, print_format)
        case('quiv')
            gfx.disp_quivB(files, labels, do_print, print_format)
        case('slice')
            % under work
            gfx.disp_sliceB(files, labels, do_print, print_format)
        otherwise
            error('[ERR] Not supported plot type')
    end
end