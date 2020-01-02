function parseGmesh(files, form)
% PARSE_GMESH - reads the .msh file and extracts the data into a
% more suitable format for further calculations
%
% Syntax:  files = parseGmesh()
%
% Inputs:
%    None
%
% Outputs:
%    files - struct containing file and result paths
%    [selected-msh-file].mat (contains the extracted data
%
% Example:
%    files = parseGmesh()
%
% Other m-files required: Regions.m, generateFiles.m, readFInfo,
%                         isFileModified.m, generateFInfo.m, get_line.m,
%                         mat2struct.m, extractLT.m,
%                         readSettings.m, extractKvi.m, Regions.m,
%                         getDirNodes.m
% Subfunctions: none
% MAT-files required: None
%
% Author: Eniz Museljic
% email: eniz.m@outlook.com
% Feb 2019

inputFile = files.mshFile;
fid = fopen(inputFile);

reading = true;
nLine = 0;
while(reading)
    line = fgetl(fid);
    nLine = nLine + 1;
    if(strcmp(line, '$MeshFormat'))
        mshFormat = fgetl(fid);
        nLine = nLine + 2;
        line = fgetl(fid);
        reading = false;
    end
end

if(~strcmp(mshFormat, '2.2 0 8'))
    error('Not supported msh format')
end

reading = true;
elemReadFinished = false;
while(reading)
    line = fgetl(fid);
    switch line
        case {'$PhysicalNames'}
            nRegions = sscanf(fgetl(fid), '%f');
            formSpec = '%f %f %s';
            dat = textscan(fid, formSpec, nRegions);
            regionNames = cellfun(@(x) strrep(x ,'"', ''), dat{3}, ...
                'UniformOutput', false);
            regionIds = [dat{1} dat{2}];
        case {'$Nodes'}
            nNodes = sscanf(fgetl(fid), '%f');
            formSpec = '%f %f %f %f';
            dataSize = [4 nNodes];
            matNodes = fscanf(fid, formSpec, dataSize)';
        case {'$Elements'}
            
            nElems = sscanf(fgetl(fid), '%f');
            matElements = zeros(nElems, form.specLen);
            
            cData = textscan(fid, form.spec, nElems)';
            
            for iDat = 1:form.specLen
                matElements(:,iDat) = cData{iDat};
            end
            
            elemReadFinished = true;
    end
    
    if(elemReadFinished)
        reading = false;
    end
end

regions = msh.getRegionStruct(regionNames, regionIds, nRegions);

[nodes, elements] = msh.getNodesElements(matNodes, matElements);

fclose(fid);

save(files.respth, 'regions', 'nodes', 'elements', ...
                   'nRegions', 'nNodes', 'nElems', '-append')