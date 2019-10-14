function dispCont(files, optProb)

load(files.respth, optProb.plots, 'X', 'Y');

figure
contourf(X, Y, eval(optProb.plots), optProb.nCont);
colorbar
xlabel(optProb.labels.x)
ylabel(optProb.labels.y)
title(['|' optProb.plots '|'])

xlim([min(X(:)), max(X(:))])
ylim([min(Y(:)), max(Y(:))])

if(~optProb.axesOn)
    ax = gca;
    ax.XTick = [];
    ax.YTick = [];
end

if(optProb.doPrint)
    plotpath = eval(['files.pltpth_quiv', optProb.plots]);
    print(plotpath, optProb.printFormat, ['-r' num2str(optProb.res)])
end

end
