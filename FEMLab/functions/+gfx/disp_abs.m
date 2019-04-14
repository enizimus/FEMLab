function disp_abs(files, prob_opt)

load(files.respth, prob_opt.plots, 'X', 'Y');

figure
surf(X,Y,eval(prob_opt.plots))
% if(prob_opt.flines_on)
%     hold on
%     load(files.respth, 'A')
%     [~, ch] = contour3(X, Y, A, prob_opt.ncont);
%     ch.LineColor = 'k';
% end
colorbar
shading interp
view(2)
xlabel(prob_opt.labels.x)
ylabel(prob_opt.labels.y)
title(['|' prob_opt.plots '|'])
xlim([min(X(:)), max(X(:))])
ylim([min(Y(:)), max(Y(:))])

if(~prob_opt.axes_on)
    ax = gca;
    ax.XTick = [];
    ax.YTick = [];
end

if(prob_opt.do_print)
    plotpath = eval(['files.pltpth_abs', prob_opt.plots]);
    print(plotpath, prob_opt.print_format, ['-r' num2str(prob_opt.res)])
end

end
