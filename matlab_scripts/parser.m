% parsing the input file
clearvars
clc

regions = struct('dim', {}, 'tag', {}, 'name', {});
nodes = struct('x', {}, 'y', {}, 'z', {});
elements = struct('type', {}, 'n_tags',...
             {}, 'tags', {}, 'nodes', {});

tags = {'$MeshFormat', '$PhysicalNames', ...
    '$Nodes', '$Elements'};

mesh_format = '';
phy_names = {};
nodes_cell = {};
elements_cell = {};

[file_name, file_path] = uigetfile('*.msh', 'Select mesh file');
input_file = [file_path,file_name];
fid = fopen(input_file);
is_parsing = 1;

while(is_parsing)
    
    [line, err] = get_line(fid);
    
    disp('Parsing...')
    if(strcmp(line, tags{1}) && err == 0)
        mesh_format = get_line(fid);
        while(~strcmp(get_line(fid), strrep(tags{1}, '$', '$End')))
        end
        line = get_line(fid);
    end
    disp(' - Names - ')
    if(strcmp(line, tags{2}))
        n_regions = str2double(get_line(fid));
        phy_names = cell(n_regions, 1);
        for i=1:n_regions
            phy_names(i) = {get_line(fid)};
        end
        while(~strcmp(get_line(fid), strrep(tags{2}, '$', '$End')))
        end
        line = get_line(fid);
    end
    disp(' - Nodes - ')
    if(strcmp(line, tags{3}))
        n_nodes = str2double(get_line(fid));
        nodes_cell = cell(n_nodes, 1);
        for i=1:n_nodes
            nodes_cell(i) = {get_line(fid)};
        end
        while(~strcmp(get_line(fid), strrep(tags{3}, '$', '$End')))
        end
        line = fgetl(fid);
    end
    disp(' - Elements - ')
    if(strcmp(line, tags{4}))
        n_elements = str2double(get_line(fid));
        elements_cell = cell(n_elements, 1);
        for i=1:n_elements
            elements_cell(i) = {get_line(fid)};
        end
        while(~strcmp(get_line(fid), strrep(tags{4}, '$', '$End')))
        end
        is_parsing = 0;
    end
end

nodes_mat = cell2mat(nodes_cell);
elements_mat = cell2mat(elements_cell);

for i_region = n_regions:-1:1
    line = strsplit(phy_names{i_region}, ' ');
    regions(i_region).dim = str2double(line{1});
    regions(i_region).tag = str2double(line{2});
    regions(i_region).name = strrep(line{3}, '"', '');
end

for i_node = n_nodes:-1:1
    nodes(i_node).x = nodes_mat(i_node, 2);
    nodes(i_node).y = nodes_mat(i_node, 3);
    nodes(i_node).z = nodes_mat(i_node, 4);
end

for i_elem = n_elements:-1:1
    elements(i_elem).type = elements_mat(i_elem, 2);
    elements(i_elem).n_tags = elements_mat(i_elem, 3);
    i_tags = 3+elements(i_elem).n_tags;
    elements(i_elem).tags = elements_mat(i_elem,...
        4:3+elements(i_elem).n_tags);
    i_end = size(elements_mat, 2) - 2 + elements(i_elem).type;
    elements(i_elem).nodes = elements_mat(i_elem, i_tags+1:i_end);
end

if(exist('results', 'dir') ~= 7), mkdir('results'); end
respth = './results/';
save([respth, 'mesh_data'], 'regions', 'nodes', 'elements',...
    'n_regions', 'n_nodes', 'n_elements')
clearvars
disp('Finished parsing')