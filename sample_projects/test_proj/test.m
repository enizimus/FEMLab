inputFile = ['regions.txt'];

if(exist(inputFile, 'file')==2)
    fid = fopen(inputFile);
else
    error(['Setting file not found at : ', inputFile])
end

regions = struct();
dataParsed = struct();
tags = {'$Edges', '$Faces'};
nIt = zeros(size(tags));
isParsing = 1;
iTag = 1;
nTags = length(tags);

while(isParsing)
    line = io.get_line(fid);
    if(strcmp(line, tags{iTag}))
        nItems = str2double(io.get_line(fid));
        nIt(iTag) = nItems;
        cValues = cell(nItems, 1);
        for i=1:nItems
            cValues(i) = {io.get_line(fid)};
        end
        dataParsed(iTag).cValues = cValues;
        dataParsed(iTag).nItems = nItems;
        
        endTag = strrep(tags{iTag}, '$', '$End');
        while(~strcmp(io.get_line(fid), endTag))
        end
    end
    
    iTag = iTag + 1;
    if(iTag > nTags), isParsing = 0; end
end

iReg = 1;
for iTag = 1:nTags
    for iItem = 1:dataParsed(iTag).nItems
        parts = strsplit(dataParsed(iTag).cValues{iItem});
        regions(iReg).name = parts{1};
        regions(iReg).spec = parts{2};
        regions(iReg).matProp = parts{3};
        regions(iReg).sourProp = str2double(parts{4});
        iReg = iReg + 1;
    end
end

fclose(fid);