function disp_quiv(files, optProb)

field = optProb.plots;
load(files.respth, [field 'x'], [field 'y'], 'X', 'Y');

figure
if(optProb.flines_on)
    load(files.respth, 'A')
    [~, ch] = contour(X, Y, A, optProb.ncont, '-');
    ch.LineColor = 'k';
    ch.LineWidth = 0.5;
    hold on
end
quiver(X, Y, eval([field 'x']), eval([field 'y']), 'color', 'b', 'linewidth', 0.9)
xlabel(optProb.labels.x)
ylabel(optProb.labels.y)
title(field)
grid on
xlim([min(X(:)), max(X(:))])
ylim([min(Y(:)), max(Y(:))])

if(~optProb.axes_on)
    ax = gca;
    ax.XTick = [];
    ax.YTick = [];
end
% set(gca,'visible','off')
if(optProb.do_print)
    plotpath = eval(['files.pltpth_quiv', optProb.plots]);
    print(plotpath, optProb.print_format, ['-r' num2str(optProb.res)])
end
end