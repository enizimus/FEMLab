function disp_quivB(files, labels, do_print, print_format)

if(nargin < 4 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 3 || isempty(do_print)), do_print = 0; end

load(files.respth, 'Bx', 'By', 'X', 'Y');

figure
quiver(X, Y, Bx, By, 'linewidth', 0.6, 'color', 'b')
xlabel(labels.x)
ylabel(labels.y)
title('B')
grid on
xlim([min(X(:)), max(X(:))])
ylim([min(Y(:)), max(Y(:))])
axis off

if(do_print)
    print(files.pltpth_B, print_format)
end
end