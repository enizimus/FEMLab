function disp_abstri(files, prob_opt)

var = [prob_opt.plots, 'p'];
load(files.respth, var, 'triangles', 'x', 'y')
val = reshape(eval(var), [length(eval(var)), 1]);
tri = triangulation(triangles, x, y, val);

figure
trisurf(tri)
colorbar
title(['|', prob_opt.plots,'|'])
xlabel('x')
ylabel('y')
zlabel(prob_opt.plots)
view(2)
xlim([min(x(:)), max(x(:))])
ylim([min(y(:)), max(y(:))])

if(~prob_opt.axes_on)
    ax = gca;
    ax.XTick = [];
    ax.YTick = [];
end

if(prob_opt.do_print)
    plotpath = eval(['files.pltpth_abstri', prob_opt.plots]);
    print(plotpath, prob_opt.print_format, ['-r' num2str(prob_opt.res)])
end

end