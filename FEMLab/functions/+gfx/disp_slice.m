function disp_slice(files, optProb)

field = optProb.plots;
load(files.respth, [field 'x'], [field 'y'], 'X', 'Y');

figure
gfx.ext.even_stream_arrow(X, Y, ...
    eval([field 'x']), eval([field 'y']),1, 3, ...
    'LineStyle', '-', 'LineWidth', 0.2, 'Color', 'k', 'ArrowLength', 3, ...
    'ArrowTipAngle', 30, 'ArrowBaseAngle', 10, 'ArrowDensity', 1);
title('Stream lines : B');
xlabel(optProb.labels.x)
ylabel(optProb.labels.y)
title(field)
grid on
xlim([min(X(:)), max(X(:))])
ylim([min(Y(:)), max(Y(:))])



% figure
% gfx.ext.even_stream_line(X, Y, Bx, By, 1, 3, 'Color', 'b', 'LineWidth', 0.2);

if(optProb.do_print)
    plotpath = eval(['files.pltpth_slice', optProb.plots]);
    print(plotpath, optProb.print_format, ['-r' num2str(optProb.res)])
end
end
