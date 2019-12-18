function regionsSetup(files)

load(files.respth, 'regions', 'nElems', 'elements', 'nNodes', 'nodes')

% For update button: 
% If new project started with no region setup file this function will
% create a new one and read it, if a file already exists it will just read
% the file and give it back.
[regSet, nRegSets] = io.readRegions(files);

% save(files.respth, 'regSet', 'nRegSets', '-append');

% Nova funkcija da odradi ekstrakciju
elemsRegion = msh.getElemRegions(elements, nElems, regSet);

[prescNodes, nSys] = msh.getPrescribedNodes(elements, elemsRegion, nNodes);

[triangles, ptriangles, lines, elemOffset,...
    tagOrderLines, tagOrderTris, nTris, nLines] = msh.extractLT(elements, nElems, elemsRegion);

x = [nodes.x]';
y = [nodes.y]';

save(files.respth, 'elemsRegion', 'regSet', ...
    'prescNodes', 'nSys', 'triangles', 'lines', 'elemOffset',...
    'tagOrderLines', 'tagOrderTris', 'nTris', 'nLines', 'x', 'y', 'ptriangles', '-append');