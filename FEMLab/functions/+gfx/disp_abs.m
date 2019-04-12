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

if(~prob_opt.axes_on)
    ax = gca;
    ax.XTick = [];
    ax.YTick = [];
end

if(prob_opt.do_print)
    print(files.pltpth_pot, prob_opt.print_format)
end

end
