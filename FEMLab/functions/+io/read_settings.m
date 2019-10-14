function [settings, n_it] = read_settings(file_path)
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


input_file = [file_path, 'settings.txt'];

if(exist(input_file, 'file')==2)
    fid = fopen(input_file);
else
    error(['Setting file not found at : ', input_file])
end

settings = struct();
parsed_data = struct();
tags = {'$Edges', '$Faces'};
n_it = zeros(size(tags));
is_parsing = 1;
i_tag = 1;
n_tags = length(tags);

while(is_parsing)
    line = io.get_line(fid);
    if(strcmp(line, tags{i_tag}))
        nItems = str2double(io.get_line(fid));
        n_it(i_tag) = nItems;
        val_cell = cell(nItems, 1);
        for i=1:nItems
            val_cell(i) = {io.get_line(fid)};
        end
        parsed_data(i_tag).val_cell = val_cell;
        parsed_data(i_tag).nItems = nItems;
        
        end_tag = strrep(tags{i_tag}, '$', '$End');
        while(~strcmp(io.get_line(fid), end_tag))
        end
    end
    
    i_tag = i_tag + 1;
    if(i_tag > n_tags), is_parsing = 0; end
end

i_reg = 1;
for i_tag = 1:n_tags
    for i_item = 1:parsed_data(i_tag).nItems
        parts = strsplit(parsed_data(i_tag).val_cell{i_item});
        settings(i_reg).name = parts{1};
        settings(i_reg).id = str2double(parts{2});
        settings(i_reg).reg = parts{3};
        settings(i_reg).sour = str2double(parts{4});
        i_reg = i_reg + 1;
    end
end

fclose(fid);



