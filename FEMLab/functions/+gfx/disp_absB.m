function disp_absB(files, labels, do_print, print_format)

if(nargin < 4 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 3 || isempty(do_print)), do_print = 0; end

load(files.respth, 'B', 'X', 'Y');

figure
surf(X,Y,B)
colorbar
shading interp
view(2)
xlabel('x')
ylabel('y')
title('|B|')
axis off

if(do_print)
    print(files.pltpth_pot, print_format)
end

end
