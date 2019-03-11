function display_B(files, opt, do_print, print_format)

if(nargin < 4 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 3 || isempty(do_print)), do_print = 0; end

if(~iscell(opt))
    opt = {opt};
end

n_opt = length(opt);
for i_opt = 1:n_opt
    
    if(strcmp(opt{i_opt}, 'abs'))
        disp_absB(files, do_print, print_format)
    elseif(strcmp(opt{i_opt}, 'quiv'))
        disp_quivB(files, do_print, print_format)
    end
    
end