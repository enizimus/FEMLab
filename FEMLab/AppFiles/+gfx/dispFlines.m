function dispFlines(files, optProb)

load(files.respth, 'A', 'X', 'Y')
[~, ch] = contour(X, Y, A, optProb.nCont, '-');
ch.LineColor = 'k';
ch.LineWidth = 0.5;

xlabel(optProb.labels.x)
ylabel(optProb.labels.y)
title('Field lines')
grid on
xlim([min(X(:)), max(X(:))])
ylim([min(Y(:)), max(Y(:))])

if(~optProb.axesOn)
    ax = gca;
    ax.XTick = [];
    ax.YTick = [];
end
if(optProb.doPrint)
    plotpath = eval(['files.pltpthFlines', optProb.plots]);
    print(plotpath, optProb.printFormat, ['-r' num2str(optProb.res)])
end