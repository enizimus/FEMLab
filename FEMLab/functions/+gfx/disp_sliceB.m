function disp_sliceB(files, labels, do_print, print_format)

if(nargin < 4 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 3 || isempty(do_print)), do_print = 0; end

load(files.respth, 'X', 'Y', 'Bx', 'By');

figure
gfx.ext.even_stream_arrow(X, Y, Bx, By, 1, 3, ...
    'LineStyle', '-', 'LineWidth', 0.2, 'Color', 'k', 'ArrowLength', 3, ...
    'ArrowTipAngle', 30, 'ArrowBaseAngle', 10, 'ArrowDensity', 1);
title('Stream lines : B');
xlabel(labels.x)
ylabel(labels.y)
ax = gca;
ax.XTick = [];
ax.YTick = [];

figure
gfx.ext.even_stream_line(X, Y, Bx, By, 1, 3, 'Color', 'b', 'LineWidth', 0.2);

if(do_print)
    print(files.pltpth_B, print_format)
end
end
