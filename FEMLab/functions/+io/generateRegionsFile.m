function generateRegionsFile(files, regions)

inputFile = files.regfile;

fid = fopen(inputFile, 'wt');
nRegions = length(regions);

% selecting what needs to be written
tags = {'$Edges', '$Faces'};

indEdges = [];
indFaces = [];

for iReg = 1:nRegions
    switch regions(iReg).dim
        case 1
            indEdges = [indEdges, iReg];
        case 2
            indFaces = [indFaces, iReg];
    end
end

indices = {indEdges, indFaces};

isWriting = true;
iTag = 1;
while(isWriting)
    tag = tags{iTag};
    fprintf(fid, [tag, '\r']); % print region tag
    fprintf(fid, [num2str(length(indices{iTag})), '\r']); % print number of regions following
    for iReg = indices{iTag}
        % Constructing line to be written
        line = [num2str(regions(iReg).id), ' ', regions(iReg).name, ' ', ...
            regions(iReg).spec, ' ', num2str(regions(iReg).matProp), ' ', ...
            num2str(regions(iReg).srcProp), '\r'];
        fprintf(fid, line);
    end
    fprintf(fid, ['$End', tag(2:end), '\r']);
    iTag = iTag + 1;
    if(iTag > length(tags))
        isWriting = false;
    end
end

fclose(fid);