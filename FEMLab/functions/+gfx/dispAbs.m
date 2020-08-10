function dispAbs(files, optProb)

if(optProb.plots == 'V')
    optProb.plots = 'A';
end

load(files.respth, optProb.plots, 'X', 'Y');

f = figure;
surf(X,Y,eval(optProb.plots))
colorbar
shading interp
view(2)
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
    plotpath = eval(['files.pltpthAbs', optProb.plots]);
    %print(plotpath, optProb.printFormat, ['-r' num2str(optProb.res)])
    savefig(f, plotpath);
end

end
