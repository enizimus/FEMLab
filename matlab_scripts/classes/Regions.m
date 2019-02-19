classdef Regions
    
    properties
        regs = containers.Map('KeyType', 'char', 'ValueType', 'double');
        reg_map = containers.Map('KeyType', 'double', 'ValueType', 'char');
        reg_map_inv = containers.Map('KeyType', 'char', 'ValueType', 'double');
        predef_keys = {'dirichlet', 'neumann', 'source'};
        predef_colors =  {[255, 250, 10], [22, 95, 229], [237, 33, 60]};
        colors = containers.Map('KeyType', 'char', 'ValueType', 'any');
        dir_codes = [];
    end
    
    methods
        
        function obj = Regions(keys, vals)
            obj.regs = containers.Map(keys, vals);
            obj = fill_color_map(obj);
        end
        
        function obj = get_dirichlet_codes(obj)
            codes = [];
            i_codes = 1;
            keys_c = keys(obj.regs);
            n_keys = length(keys_c);
            for i_key = 1:n_keys
                if(contains(keys_c{i_key}, 'dirichlet'))
                    codes(i_codes) = obj.reg_map_inv(keys_c{i_key});
                    i_codes = i_codes + 1;
                end
            end
            
            obj.dir_codes = codes;
            
        end
        
        function obj = set_reg_map(obj, keys, vals)
            obj.reg_map = containers.Map(keys, vals);
            obj.reg_map_inv = containers.Map(vals, keys);
            obj = get_dirichlet_codes(obj);
        end
        
        function code = get_reg_code(obj, region)
            code = obj.reg_map_inv(region);
        end
        
        function obj = fill_color_map(obj)
            n_keys = length(obj.regs);
            keys_c = keys(obj.regs);
            for i_key = 1:n_keys
                clr_set = 0;
                for i_pred = 1:3
                    if(contains(keys_c(i_key), obj.predef_keys(i_pred)))
                        obj.colors(keys_c{i_key}) = obj.predef_colors{i_pred}/255;
                        clr_set = 1;
                    end
                end
                if(~clr_set)
                    obj.colors(keys_c{i_key}) = clr()/255;
                end
            end
        end
        
        function color = get_color(obj, key)
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
        
        function param = get_param(obj, key)
            if(isnumeric(key) && isKey(obj.reg_map, key))
                param = obj.regs(obj.reg_map(key));
            elseif(isstring(key) && isKey(obj.regs, key))
                param = obj.regs(key);
            end
        end
        
        
    end
    
end