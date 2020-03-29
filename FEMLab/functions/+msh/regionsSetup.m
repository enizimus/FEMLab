function regionsSetup(files)

load(files.respth, 'regSet', 'nElems', 'elements', 'nNodes', 'nodes', 'form')

sElements = msh.structureElements(elements);

prescRegions = msh.getPrescribedRegions(regSet);

[elemsRegion, elemsTag] = msh.getElemRegions(sElements, nElems, regSet);

[triangles, ptriangles, lines, elemOffset,...
    regsLines, regsTris, nTris, nLines] = msh.extractLT(sElements, nElems, elemsRegion, form);

[prescNodes, nSys] = msh.getPrescribedNodes(sElements.nodes, elemsRegion, elemsTag, prescRegions, nNodes);

x = nodes(:,1);
y = nodes(:,2);

save(files.respth, 'sElements', 'elemsRegion', 'elemsTag', ...
    'prescNodes', 'nSys', 'triangles', 'lines', 'elemOffset',...
    'regsLines', 'regsTris', 'nTris', 'nLines', 'x', 'y', 'ptriangles', '-append');