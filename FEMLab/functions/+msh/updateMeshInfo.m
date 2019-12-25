function meshInfo = updateMeshInfo(files, meshInfo)
load(files.respth, 'nNodes', 'nElems', 'nSys')

meshInfo.nNodes = nNodes;
meshInfo.nElements = nElems;
meshInfo.nSys = nSys;