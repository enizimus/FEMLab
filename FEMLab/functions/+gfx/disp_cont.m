function disp_cont(files, prob_opt)

load(files.respth, prob_opt.plots, 'X', 'Y');

figure
contour(X, Y, eval(prob_opt.plots), prob_opt.ncont);
colorbar
xlabel(prob_opt.labels.x)
ylabel(prob_opt.labels.y)
title(['|' prob_opt.plots '|'])
ax = gca;
ax.XTick = [];
ax.YTick = [];

if(prob_opt.do_print)
    print(files.pltpth_pot, prob_opt.print_format)
end

end
