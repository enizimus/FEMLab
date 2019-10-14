function disp_abs(files, optProb)

load(files.respth, optProb.plots, 'X', 'Y');

figure
surf(X,Y,eval(optProb.plots))
colorbar
shading interp
view(2)
xlabel(optProb.labels.x)
ylabel(optProb.labels.y)
title(['|' optProb.plots '|'])
xlim([min(X(:)), max(X(:))])
ylim([min(Y(:)), max(Y(:))])

if(~optProb.axes_on)
    ax = gca;
    ax.XTick = [];
    ax.YTick = [];
end

if(optProb.do_print)
    plotpath = eval(['files.pltpth_abs', optProb.plots]);
    print(plotpath, optProb.print_format, ['-r' num2str(optProb.res)])
end

end
