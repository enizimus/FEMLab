function dispMesh(files, optProb)
% dispMesh - plots the mesh and saves it in the specified format
%
% Syntax:  dispMesh(files, doPrint, printFormat)
%
% Inputs:
%    files - struct containing file and result paths
%    doPrint - logical (True or False) or numeric (1 or 0)
%    printFormat - string
%
% Outputs:
%    None
%
% Example:
%    dispMesh(files, 1, '-dpng')
%    dispMesh(files, 1, '-depsc')
%
% Other m-files required: Regions.m
% Subfunctions: none
% MAT-files required: [mesh-file-name].mat
%
% Author: Eniz Museljic
% email: eniz.m@outlook.com
% Mar 2019

load(files.respth, 'sRegions', 'elemsRegion', 'x', 'y', ...
    'nTris', 'ptriangles', 'lines', 'nLines');

warning('off','all')
nItems = sRegions.nItems;
regKeys = sRegions.getRegionKeys('num');
legnd = sRegions.getComboKeys;

figure
hold on;

elemTriangles = elemsRegion(nLines+1:end);
elemLines = elemsRegion(1:nLines);
hTris = gobjects(1, nItems(2));
hLines = gobjects(1, nItems(1));

ih = 1;
for iReg = nItems(1)+1:sum(nItems)
    
    colr = sRegions.getColor(regKeys(iReg));
    
    tris = ptriangles(elemTriangles == regKeys(iReg),:);
    TRI = triangulation(tris,x,y);
    
    hTris(ih) = triplot(TRI, 'color', colr);
    ih = ih + 1;
    
end

ih = 1;
for iLine = 1:nItems(1)
    
    colr = sRegions.getColor(regKeys(iLine));
    I = lines(elemLines == regKeys(iLine), :);
    xl = x(I);
    yl = y(I);
    
    [xl,yl] = util.getNonRepeating(xl,yl);
    hLines(ih) = plot(xl, yl, 'linewidth', 1.2, 'color', colr);
    ih = ih + 1;
    
end

title([files.fileName, '.msh'], 'interpreter', 'none')
lgd = legend([hLines, hTris], legnd, 'location', 'eastoutside',...
    'interpreter', 'none');
title(lgd, 'Regions : ')
warning('on','all')
xlim([min(x(:)), max(x(:))])
ylim([min(y(:)), max(y(:))])

if(optProb.doPrint)
    print(files.pltpth_mesh, optProb.printFormat, ['-r' num2str(optProb.res)])
end


