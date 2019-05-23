function disp_flines(files, prob_opt)

load(files.respth, 'A', 'X', 'Y')
[~, ch] = contour(X, Y, A, prob_opt.ncont, '-');
ch.LineColor = 'k';
ch.LineWidth = 0.5;

xlabel(prob_opt.labels.x)
ylabel(prob_opt.labels.y)
title('Field lines')
grid on
xlim([min(X(:)), max(X(:))])
ylim([min(Y(:)), max(Y(:))])

if(~prob_opt.axes_on)
    ax = gca;
    ax.XTick = [];
    ax.YTick = [];
end
if(prob_opt.do_print)
    plotpath = eval(['files.pltpth_flines', prob_opt.plots]);
    print(plotpath, prob_opt.print_format, ['-r' num2str(prob_opt.res)])
end