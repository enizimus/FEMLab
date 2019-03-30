function display_B(files, prob_opt, do_print, print_format)

if(nargin < 4 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 3 || isempty(do_print)), do_print = 0; end

labels = def.get_labels(prob_opt);
options = def.assign_plt_opts(prob_opt.fieldplt); % to be changed with gui
def_opts = def.get_plt_opts();
n_opt = length(prob_opt.fieldplt);

for i_opt = 1:n_opt
    option = options(i_opt);
    switch(option)
        case(def_opts(1))
            gfx.disp_absB(files, labels, do_print, print_format)
        case(def_opts(2))
            gfx.disp_quivB(files, labels, do_print, print_format)
        case(def_opts(3))
            gfx.disp_sliceB(files, labels, do_print, print_format)
        case(def_opts(4))
            gfx.disp_contourB(files, labels, do_print, print_format)
        otherwise
            error('[ERR] Not supported plot type')
    end
end