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

load(files.respth, 'regSet', 'elemsRegion', 'x', 'y', ...
    'nTris', 'ptriangles', 'lines', 'nLines', ...
    'nEdgeElems', 'nFaceElems');

warning('off','all')
[legnd, regKeys] = msh.getComboKeys(regSet);

f = figure;
if(optProb.hideFig)
    set(f, 'visible', 'off')
end
hold on;

elemTriangles = elemsRegion(nLines+1:end);
elemLines = elemsRegion(1:nLines);
hTris = gobjects(1, nFaceElems);
hLines = gobjects(1, nEdgeElems);

ih = 1;
for iReg = nEdgeElems + 1:(nEdgeElems + nFaceElems)
    
    clr = msh.getColor(files, regSet(iReg));
    
    tris = ptriangles(elemTriangles == regKeys(iReg),:);
    TRI = triangulation(tris(:,1:3),x,y);
    
    hTris(ih) = triplot(TRI, 'color', clr);
    ih = ih + 1;
    
end

ih = 1;
for iLine = 1:nEdgeElems
    
    clr = msh.getColor(files, regSet(iLine));
    I = lines(elemLines == regKeys(iLine), :);
    xl = x(I);
    yl = y(I);
    
    [xl,yl] = util.getNonRepeating(xl,yl);
    hLines(ih) = plot(xl, yl, 'linewidth', 1.2, 'color', clr);
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
    saveas(f,files.pltpthMesh,'png')
    %print(files.pltpthMesh, optProb.printFormat, ['-r' num2str(optProb.res)])
end


