function files = parseGmesh(files)
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
tic
def.defRead();
%[fileName, filePath] = io.getMeshFile(projPath, projName);
%fileName = strrep(fileName, '.msh', '');
fileInfo = io.readFInfo(files);
files.filesModified = io.isFileModified(files, fileInfo);

if(files.filesModified)
    
    disp('-Parsing gmesh file ...')
    tic
    
    io.generateFInfo(files);
    inputFile = files.mshFile;
    fid = fopen(inputFile);
    content = fileread(inputFile);
    
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
                formSpec = '%f %f %f %f %f %f %f %f';
                cData = textscan(fid, formSpec, nElems)';
                matElements = [cData{1} cData{2} cData{3} cData{4} cData{5} cData{6} cData{7} cData{8}];
                elemReadFinished = true;
        end
        
        if(elemReadFinished)
            reading = false;
        end
    end
    toc
    [regions, nodes, elements] = util.mat2struct(regionNames, regionIds, nRegions,...
        matNodes, nNodes, matElements, nElems);
    
    fclose(fid);
    
    save(files.respth, 'regions', 'nodes', 'elements', ...
        'nRegions', 'nNodes', 'nElems')
    
else
    disp('-Files not changed since last parse')
    tic
end

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])