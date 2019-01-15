% parsing the input file
clear all
clc

tags = {'$MeshFormat', '$PhysicalNames', '$Nodes', ...
    '$Elements', '$EndElements'};

mesh_format = '';
phy_names = {};
nodes = {};
elements = {};


input_file = 'coil_fine.msh';
fid = fopen(input_file);

is_parsing = 1;

while(is_parsing)
    line = fgetl(fid);
    
    disp('Parsing...')
    if(strcmp(line, tags{1}))
        mesh_format = fgetl(fid);
        while(~strcmp(fgetl(fid), strrep(tags{1}, '$', '$End')))
        end
        line = fgetl(fid);
    end
    disp(' - Names - ')
    if(strcmp(line, tags{2}))
        n_names = str2double(fgetl(fid));
        phy_names = cell(n_names, 1);
        for i=1:n_names
            phy_names(i) = {fgetl(fid)};
        end
        while(~strcmp(fgetl(fid), strrep(tags{2}, '$', '$End')))
        end
        line = fgetl(fid);
    end
    disp(' - Nodes - ')
    if(strcmp(line, tags{3}))
        n_nodes = str2double(fgetl(fid));
        nodes = cell(n_nodes, 1);
        for i=1:n_nodes
            nodes(i) = {fgetl(fid)};
        end
        while(~strcmp(fgetl(fid), strrep(tags{3}, '$', '$End')))
        end
        line = fgetl(fid);
    end
    disp(' - Elements - ')
    if(strcmp(line, tags{4}))
        n_elements = str2double(fgetl(fid));
        elements = cell(n_elements, 1);
        for i=1:n_elements
            elements(i) = {fgetl(fid)};
        end
        while(~strcmp(fgetl(fid), strrep(tags{4}, '$', '$End')))
        end
        is_parsing = 0;
    end
    
end

nodes_mat = cell2mat(nodes);
elements_mat = cell2mat(elements);


