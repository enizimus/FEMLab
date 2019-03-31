function files = parse_gmesh()
% PARSE_GMESH - reads the .msh file and extracts the data into a
% more suitable format for further calculations
%
% Syntax:  files = parse_gmesh()
%
% Inputs:
%    None
%
% Outputs:
%    files - struct containing file and result paths
%    [selected-msh-file].mat (contains the extracted data
%
% Example: 
%    files = parse_gmesh()
%
% Other m-files required: Regions.m, generate_files.m, read_finfo, 
%                         file_changed.m, generate_finfo.m, get_line.m,
%                         mat2struct.m, extract_lines_tris.m, 
%                         read_settings.m, extract_kvi.m, Regions.m,
%                         get_dirichlet_nodes.m 
% Subfunctions: none
% MAT-files required: None
%
% Author: Eniz Museljic
% email: eniz.m@outlook.com
% Feb 2019

tags = {'$MeshFormat', '$PhysicalNames', ...
    '$Nodes', '$Elements'};
parsed_data = struct();

def.read_defs();

[file_name, file_path] = uigetfile('*.msh', 'Select mesh file');
file_name = strrep(file_name, '.msh', '');
files = io.generate_files(file_path, file_name);
f_info = io.read_finfo(files);
files.f_changed = io.file_changed(files, f_info);

if(files.f_changed)
    
    disp('-Parsing gmesh file ...')
    tic
    
    io.generate_finfo(files);
    input_file = files.mesh_file;
    fid = fopen(input_file);
    
    is_parsing = 1;
    i_tag = 1;
    n_tags = numel(tags);
    
    [line, err] = io.get_line(fid);
    if(strcmp(line, tags{i_tag}) && err == 0)
        mesh_format = io.get_line(fid);
        end_tag = strrep(tags{i_tag}, '$', '$End');
        while(~strcmp(io.get_line(fid), end_tag))
        end
        i_tag = i_tag + 1;
    end
    
    while(is_parsing)
        line = io.get_line(fid);
        if(strcmp(line, tags{i_tag}))
            n_items = str2double(io.get_line(fid));
            val_cell = cell(n_items, 1);
            for i=1:n_items
                val_cell(i) = {io.get_line(fid)};
            end
            parsed_data(i_tag-1).val_cell = val_cell;
            parsed_data(i_tag-1).n_items = n_items;
            
            end_tag = strrep(tags{i_tag}, '$', '$End');
            while(~strcmp(io.get_line(fid), end_tag))
            end
        end
        
        i_tag = i_tag + 1;
        if(i_tag > n_tags), is_parsing = 0; end
        
    end
    
    phy_names = parsed_data(1).val_cell; n_regions = parsed_data(1).n_items;
    nodes_cell = parsed_data(2).val_cell; n_nodes = parsed_data(2).n_items;
    elements_cell = parsed_data(3).val_cell; n_elements = parsed_data(3).n_items;
    
    [regions, nodes, elements] = util.mat2struct(phy_names, n_regions,...
        nodes_cell, n_nodes, elements_cell, n_elements);
    
    reg_vals = {regions.name};
    reg_keys = [regions.tag];
    
    [settings, n_items] = io.read_settings(file_path);
    [regnames, regparams, ids] = msh.extract_kvi(settings);
    regions_c = msh.Regions(regnames, regparams, ids, n_items);
    regions_c = regions_c.set_reg_map(reg_keys, reg_vals);
    
    element_r = reshape([elements.tags], [2, n_elements])';
    element_r(:,2) = [];
    
    [nodes_prop, n_sys] = msh.get_dirichlet_nodes(elements, element_r, n_nodes, regions_c);
    
    fclose(fid);
    
    save(files.respth, 'regions', 'nodes', 'elements',...
        'n_regions', 'n_nodes', 'n_elements', 'element_r', 'regions_c', ...
        'regparams', 'nodes_prop', 'n_sys');
    
    msh.extract_lines_tris(files)
else
    disp('-Files not changed since last parse')
    tic
end

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])