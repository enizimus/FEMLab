function dispAbstri(files, optProb)

var = [optProb.plots, 'p'];
load(files.respth, var, 'triangles', 'x', 'y')
val = reshape(eval(var), [length(eval(var)), 1]);
tri = triangulation(triangles, x, y, val);

figure
trisurf(tri)
colorbar
title(['|', optProb.plots,'|'])
xlabel('x')
ylabel('y')
zlabel(optProb.plots)
view(2)
xlim([min(x(:)), max(x(:))])
ylim([min(y(:)), max(y(:))])

if(~optProb.axesOn)
    ax = gca;
    ax.XTick = [];
    ax.YTick = [];
end

if(optProb.doPrint)
    plotpath = eval(['files.pltpth_abstri', optProb.plots]);
    print(plotpath, optProb.printFormat, ['-r' num2str(optProb.res)])
end

end