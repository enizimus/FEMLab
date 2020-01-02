function regionsSetup(files)

load(files.respth, 'regions', 'nElems', 'elements', 'nNodes', 'nodes', 'form')

% If new project started with no region setup file this function will
% create a new one and read it, if a file already exists it will just read
% the file and give it back.
[regSet, nRegSets] = io.readRegions(files);

sElements = msh.structureElements(elements);

[elemsRegion, elemsTag] = msh.getElemRegions(sElements, nElems, regSet);

[triangles, ptriangles, lines, elemOffset,...
    regsLines, regsTris, nTris, nLines] = msh.extractLT(sElements, nElems, elemsRegion, form);

[prescNodes, nSys] = msh.getPrescribedNodes(sElements.nodes, elemsTag, nNodes);

x = nodes(:,1);
y = nodes(:,2);

save(files.respth, 'sElements', 'elemsRegion', 'regSet', 'elemsTag', ...
    'prescNodes', 'nSys', 'triangles', 'lines', 'elemOffset',...
    'regsLines', 'regsTris', 'nTris', 'nLines', 'x', 'y', 'ptriangles', '-append');