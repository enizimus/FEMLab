function disp_quiv(files, prob_opt)

field = prob_opt.plots;
load(files.respth, [field 'x'], [field 'y'], 'X', 'Y');

figure
if(prob_opt.flines_on)
    load(files.respth, 'A')
    [~, ch] = contour(X, Y, A, prob_opt.ncont, '-');
    ch.LineColor = 'k';
    ch.LineWidth = 0.5;
    hold on
end
quiver(X, Y, eval([field 'x']), eval([field 'y']), 'color', 'b', 'linewidth', 0.9)
xlabel(prob_opt.labels.x)
ylabel(prob_opt.labels.y)
title(field)
grid on
xlim([min(X(:)), max(X(:))])
ylim([min(Y(:)), max(Y(:))])

if(~prob_opt.axes_on)
    ax = gca;
    ax.XTick = [];
    ax.YTick = [];
end

% set(gca,'visible','off')

if(prob_opt.do_print)
    plotpath = eval(['files.pltpth_quiv', prob_opt.plots]);
    print(plotpath, prob_opt.print_format, ['-r' num2str(prob_opt.res)])
end
end