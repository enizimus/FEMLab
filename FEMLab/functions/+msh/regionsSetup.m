function regionsSetup(files)

load(files.respth, 'regions', 'nElems', 'elements', 'nNodes', 'nodes')

% For update button: 
% If new project started with no region setup file this function will
% create a new one and read it, if a file already exists it will just read
% the file and give it back.
[regSet, nRegSets] = io.readRegions(files);

% Nova funkcija da odradi ekstrakciju
[elemsRegion, elemsTag] = msh.getElemRegions(elements, nElems, regSet);

[prescNodes, nSys] = msh.getPrescribedNodes(elements, elemsTag, nNodes);

[triangles, ptriangles, lines, elemOffset,...
    regsLines, regsTris, nTris, nLines] = msh.extractLT(elements, nElems, elemsRegion);

x = [nodes.x]';
y = [nodes.y]';

save(files.respth, 'elemsRegion', 'regSet', 'bRegions', 'elemsTag', ...
    'prescNodes', 'nSys', 'triangles', 'lines', 'elemOffset',...
    'regsLines', 'regsTris', 'nTris', 'nLines', 'x', 'y', 'ptriangles', '-append');