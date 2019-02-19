classdef Regions
    
    properties
        regs = containers.Map('KeyType', 'char', 'ValueType', 'double');
        reg_map = containers.Map('KeyType', 'double', 'ValueType', 'char');
        reg_map_inv = containers.Map('KeyType', 'char', 'ValueType', 'double');
    end
    
    methods
       
        function obj = Regions(keys, vals)
           obj.regs = containers.Map(keys, vals); 
        end
        
        function obj = set_reg_map(obj, keys, vals)
            obj.reg_map = containers.Map(keys, vals);
            obj.reg_map_inv = containers.Map(vals, keys);
        end
        
        function code = get_reg_code(obj, region)
            code = obj.reg_map_inv(region);
        end
        
        function obj = add_region(obj, key, val)
            obj.regs(key) = val;
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