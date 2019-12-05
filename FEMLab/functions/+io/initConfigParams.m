function initConfigParams(files, projPath, projName)

load(files.respth, 'regions', 'nElems', 'elements', 'nNodes', 'nodes')

[~, filePath] = io.getMeshFile(projPath, projName);

regionVals = {regions.name};
regionKeys = [regions.tag];

[settings, nItems] = io.readSettings(filePath);
[regNames, regParams, ids] = msh.extractKvi(settings);
sRegions = msh.Regions(regNames, regParams, ids, nItems);
sRegions = sRegions.setRegMap(regionKeys, regionVals);

elemsRegion = reshape([elements.tags], [2, nElems])';
elemsRegion(:,2) = [];

[triangles, ptriangles, lines, elemOffset,...
    tagOrderLines, tagOrderTris, nTris, nLines] = msh.extractLT(elements, nElems, elemsRegion);
[nodeProps, nSys] = msh.getDirNodes(elements, elemsRegion, nNodes, sRegions);
x = [nodes.x]';
y = [nodes.y]';

save(files.respth, 'elemsRegion', 'sRegions', ...
    'regParams', 'nodeProps', 'nSys', 'triangles', 'lines', 'elemOffset',...
    'tagOrderLines', 'tagOrderTris', 'nTris', 'nLines', 'x', 'y', 'ptriangles', '-append');
end