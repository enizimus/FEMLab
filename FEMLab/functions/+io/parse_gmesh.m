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

def.read_defs();

[file_name, file_path] = uigetfile('*.msh', 'Select mesh file');
file_name = strrep(file_name, '.msh', '');
files = io.generate_files(file_path, file_name);
f_info = io.read_finfo(files);
files.f_changed = io.file_changed(files, f_info);

if(1)%files.f_changed)
    
    disp('-Parsing gmesh file ...')
    tic
    
    io.generate_finfo(files);
    input_file = files.mesh_file;
    fid = fopen(input_file);
    
    reading = true;
    n_line = 0;
    while(reading)
        line = fgetl(fid);
        n_line = n_line + 1;
        if(strcmp(line, '$MeshFormat'))
            mesh_format = fgetl(fid);
            n_line = n_line + 2;
            line = fgetl(fid);
            reading = false;
        end
    end
    
    reading = true;
    read_elements = false;
    while(reading)
        line = fgetl(fid);
        switch line
            case {'$PhysicalNames'}
                n_regions = sscanf(fgetl(fid), '%f');
                form_spec = '%f %f %s';
                dat = textscan(fid, form_spec, n_regions);
                reg_names = cellfun(@(x) strrep(x ,'"', ''), dat{3}, ...
                    'UniformOutput', false);
                reg_id = [dat{1} dat{2}];
            case {'$Nodes'}
                n_nodes = sscanf(fgetl(fid), '%f');
                form_spec = '%f %f %f %f';
                dat_size = [4 n_nodes];
                nodes_mat = fscanf(fid, form_spec, dat_size)';
            case {'$Elements'}
                n_elements = sscanf(fgetl(fid), '%f');
                form_spec = '%f %f %f %f %f %f %f %f';
                cdat = textscan(fid, form_spec, n_elements)';
                elements_mat = [cdat{1} cdat{2} cdat{3} cdat{4} cdat{5} cdat{6} cdat{7} cdat{8}];
                read_elements = true;
        end
        
        if(read_elements)
            reading = false;
        end
    end
    
    [regions, nodes, elements] = util.mat2struct(reg_names, reg_id, n_regions,...
        nodes_mat, n_nodes, elements_mat, n_elements);
    
    reg_vals = {regions.name};
    reg_keys = [regions.tag];
    
    [settings, n_items] = io.read_settings(file_path);
    [regnames, regparams, ids] = msh.extract_kvi(settings);
    regions_c = msh.Regions(regnames, regparams, ids, n_items);
    regions_c = regions_c.set_reg_map(reg_keys, reg_vals);
    
    element_r = reshape([elements.tags], [2, n_elements])';
    element_r(:,2) = [];
    
    [triangles, ptriangles, lines, elem_offset,...
        tag_order_lines, tag_order, n_tri, n_lines] = msh.extract_lines_tris(elements, n_elements, element_r);
    [nodes_prop, n_sys] = msh.get_dirichlet_nodes(elements, element_r, n_nodes, regions_c);
    x = [nodes.x]';
    y = [nodes.y]';
    
    fclose(fid);
    
    save(files.respth, 'regions', 'nodes', 'elements',...
        'n_regions', 'n_nodes', 'n_elements', 'element_r', 'regions_c', ...
        'regparams', 'nodes_prop', 'n_sys', 'triangles', 'lines', 'elem_offset',...
        'tag_order_lines', 'tag_order', 'n_tri', 'n_lines', 'x', 'y', 'ptriangles');
    
else
    disp('-Files not changed since last parse')
    tic
end

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])