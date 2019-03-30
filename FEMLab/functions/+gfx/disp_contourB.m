function disp_contourB(files, labels, do_print, print_format)

if(nargin < 4 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 3 || isempty(do_print)), do_print = 0; end

load(files.respth, 'B', 'X', 'Y');

nl = 30;
figure
contourf(X,Y,B,nl)
colorbar
xlabel(labels.x)
ylabel(labels.y)
title('|B|')
ax = gca;
ax.XTick = [];
ax.YTick = [];

if(do_print)
    print(files.pltpth_pot, print_format)
end

end
