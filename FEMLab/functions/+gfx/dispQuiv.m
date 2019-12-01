function dispQuiv(files, optProb)

field = optProb.plots;
load(files.respth, [field 'x'], [field 'y'], 'X', 'Y');

figure
if(optProb.flinesOn)
    load(files.respth, 'A')
    [~, ch] = contour(X, Y, A, optProb.nCont, '-');
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

if(~optProb.axesOn)
    ax = gca;
    ax.XTick = [];
    ax.YTick = [];
end
% set(gca,'visible','off')
if(optProb.doPrint)
    plotpath = eval(['files.pltpthQuiv', optProb.plots]);
    print(plotpath, optProb.printFormat, ['-r' num2str(optProb.res)])
end
end