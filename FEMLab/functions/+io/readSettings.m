function [settings, nIt] = readSettings(filePath)
% settings.txt format :
%       %Faces (id = 2)
%           [name] [id] [material mu_0] [J]
%       %Edges (id = 1)
%           [name] [id] [DRB/NRB/SRC] [VAL]
%
%       where : - J   : Current density
%               - DRB : Dirichlet boundary condition
%               - NRB : Neumann boundary condition
%               - SRC : Source
%               - VAL : Value of selected DRB/NRB/SRC


inputFile = [filePath, 'settings.txt'];

if(exist(inputFile, 'file')==2)
    fid = fopen(inputFile);
else
    error(['Setting file not found at : ', inputFile])
end

settings = struct();
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
        settings(iReg).name = parts{1};
        settings(iReg).id = str2double(parts{2});
        settings(iReg).reg = parts{3};
        settings(iReg).sour = str2double(parts{4});
        iReg = iReg + 1;
    end
end

fclose(fid);



