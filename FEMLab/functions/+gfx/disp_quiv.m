function disp_quiv(files, prob_opt)

load(files.respth, 'Bx', 'By', 'X', 'Y');

figure
if(prob_opt.flines_on)
    load(files.respth, 'A')
    [~, ch] = contour(X, Y, A, prob_opt.ncont, ':');
    ch.LineColor = 'k';
    ch.LineWidth = 1.1;
    hold on
end
quiver(X, Y, Bx, By, 'linewidth', 0.9, 'color', 'b')
xlabel(prob_opt.labels.x)
ylabel(prob_opt.labels.y)
title('B')
grid on
xlim([min(X(:)), max(X(:))])
ylim([min(Y(:)), max(Y(:))])

if(~prob_opt.axes_on)
    ax = gca;
    ax.XTick = [];
    ax.YTick = [];
end

if(prob_opt.do_print)
    print(files.pltpth_quivB, prob_opt.print_format)
end
end