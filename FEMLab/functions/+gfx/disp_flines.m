function disp_flines(files, optProb)

load(files.respth, 'A', 'X', 'Y')
[~, ch] = contour(X, Y, A, optProb.ncont, '-');
ch.LineColor = 'k';
ch.LineWidth = 0.5;

xlabel(optProb.labels.x)
ylabel(optProb.labels.y)
title('Field lines')
grid on
xlim([min(X(:)), max(X(:))])
ylim([min(Y(:)), max(Y(:))])

if(~optProb.axes_on)
    ax = gca;
    ax.XTick = [];
    ax.YTick = [];
end
if(optProb.do_print)
    plotpath = eval(['files.pltpth_flines', optProb.plots]);
    print(plotpath, optProb.print_format, ['-r' num2str(optProb.res)])
end