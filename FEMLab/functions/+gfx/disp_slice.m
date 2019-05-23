function disp_slice(files, prob_opt)

field = prob_opt.plots;
load(files.respth, [field 'x'], [field 'y'], 'X', 'Y');

figure
gfx.ext.even_stream_arrow(X, Y, ...
    eval([field 'x']), eval([field 'y']),1, 3, ...
    'LineStyle', '-', 'LineWidth', 0.2, 'Color', 'k', 'ArrowLength', 3, ...
    'ArrowTipAngle', 30, 'ArrowBaseAngle', 10, 'ArrowDensity', 1);
title('Stream lines : B');
xlabel(prob_opt.labels.x)
ylabel(prob_opt.labels.y)
title(field)
grid on
xlim([min(X(:)), max(X(:))])
ylim([min(Y(:)), max(Y(:))])



% figure
% gfx.ext.even_stream_line(X, Y, Bx, By, 1, 3, 'Color', 'b', 'LineWidth', 0.2);

if(prob_opt.do_print)
    plotpath = eval(['files.pltpth_slice', prob_opt.plots]);
    print(plotpath, prob_opt.print_format, ['-r' num2str(prob_opt.res)])
end
end
