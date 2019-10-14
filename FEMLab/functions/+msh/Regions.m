classdef Regions
    
    properties
        
        % constants :
        mu_0 = 1.2566e-06;
        eps_0 = 8.854187e-12;
        
        % containers :
        regs = containers.Map('KeyType', 'char', 'ValueType', 'double');
        def = containers.Map('KeyType', 'char', 'ValueType', 'double');
        reg_map = containers.Map('KeyType', 'double', 'ValueType', 'char');
        reg_map_inv = containers.Map('KeyType', 'char', 'ValueType', 'double');
        predef_keys = {'dirichlet', 'neumann', 'source'};
        predef_colors =  {[255, 250, 10], [22, 95, 229], [237, 33, 60]};
        colors = containers.Map('KeyType', 'char', 'ValueType', 'any');
        dir_codes = [];
        colrs = [61, 210, 1, 32];
        n_edges = 0;
        n_faces = 0;
        nItems = [0 0];
        
    end
    
    methods
        
        function obj = Regions(keys, vals, id, nItems)
            obj.regs = containers.Map(keys, vals);
            obj.def = containers.Map(keys, id);
            obj.n_edges = nItems(1);
            obj.n_faces = nItems(2);
            obj.nItems = nItems;
            obj = fill_color_map(obj);
        end
        
        function obj = get_dirichlet_codes(obj)
            codes = [];
            i_codes = 1;
            keys_c = keys(obj.regs);
            nKeys = length(keys_c);
            for iKey = 1:nKeys
                if(contains(keys_c{iKey}, 'dirichlet'))
                    codes(i_codes) = obj.reg_map_inv(keys_c{iKey});
                    i_codes = i_codes + 1;
                end
            end
            
            obj.dir_codes = codes;
            
        end
        
        function key_arr = getRegionKeys(obj, type)
            % getRegionKeys(obj, type) - returns an array containing the
            % regions keys, if type == 'num' then it returns the numeric
            % keys, else it returns the string keys
            %
            if(strcmp(type, 'num'))
                temp = keys(obj.reg_map);
                key_arr = [temp{:}];
            else
                key_arr = values(obj.reg_map);
            end
        end
        
        function params = get_regions_params(obj, regis)
            % getRegionKeys(obj, type) - returns an array containing the
            % regions keys, if type == 'num' then it returns the numeric
            % keys, else it returns the string keys
            %
            params = zeros(size(regis));
            for iReg = 1:numel(regis)
                params(iReg) = obj.get_param(regis(iReg));
            end
            
        end
        
        function obj = setRegMap(obj, keys, vals)
            obj.reg_map = containers.Map(keys, vals);
            obj.reg_map_inv = containers.Map(vals, keys);
            obj = get_dirichlet_codes(obj);
        end
        
        function code = get_reg_code(obj, region)
            code = obj.reg_map_inv(region);
        end
        
        function obj = fill_color_map(obj)
            nKeys = length(obj.regs);
            keys_c = keys(obj.regs);
            i_clr = 1;
            for iKey = 1:nKeys
                clr_set = 0;
                for i_pred = 1:3
                    if(contains(keys_c(iKey), obj.predef_keys(i_pred)))
                        obj.colors(keys_c{iKey}) = obj.predef_colors{i_pred}/255;
                        clr_set = 1;
                        break;
                    end
                end
                if(~clr_set)
                    obj.colors(keys_c{iKey}) = util.clr(obj.colrs(i_clr))/255;
                    i_clr = i_clr + 1;
                end
            end
        end
        
        function color = getColor(obj, key)
            if(isnumeric(key) && isKey(obj.reg_map, key))
                color = obj.colors(obj.reg_map(key));
            elseif(~isnumeric(key) && isKey(obj.colors, key))
                color = obj.colors(key);
            end
        end
        
        function obj = add_region(obj, key, val)
            obj.regs(key) = val;
        end
        
        function name = get_name(obj, key)
            name = obj.reg_map(key);
        end
        
        function is_dir = is_dirichlet(obj, key)
            is_dir = 0;
            if(contains(obj.reg_map(key), 'dirichlet'))
                is_dir = 1;
            end
        end
        
        function is_sour = is_source(obj, key)
            is_sour = 0;
            if(contains(obj.reg_map(key), 'source'))
                is_sour = 1;
            end
        end
        
        function sour_regs = get_source_keys(obj)
            
            key_arr = obj.getRegionKeys('num');
            
            sour_regs = zeros(numel(key_arr),1);
            for iKey = 1:numel(key_arr)
                if(obj.is_source(key_arr(iKey)))
                    sour_regs(iKey) = iKey;
                end
            end
            
            sour_regs(sour_regs == 0) = [];
        end
        
        function param = get_param(obj, key)
            if(isnumeric(key))
                param = zeros(size(key));
                for i = 1:numel(key)
                    if(isKey(obj.reg_map, key(i)))
                        param(i) = obj.regs(obj.reg_map(key(i)));
                    end
                end
            elseif(ischar(key) && isKey(obj.regs, key))
                param = obj.regs(key);
            end
            
            
        end
        
        function [nums, strs] = get_region_ids(obj)
            nums = keys(obj.reg_map);
            strs = values(obj.reg_map);
        end
        
        function show_regions(obj)
            [nums, strs] = get_region_ids(obj);
            disp('----- Regions and codes -----')
            cellfun(@(x,y) disp([x ' [ ' num2str(y) ' ] ']), strs, nums)
            disp('-----------------------------')
        end
        
        function comb = getComboKeys(obj)
            nItems = obj.nItems;
            [regKeys, comb] = get_region_ids(obj);
            
            for iItem = 1:sum(nItems)
                comb{iItem} = [comb{iItem} ' (' num2str(regKeys{iItem}) ')'];
            end
            
        end
        
    end
end