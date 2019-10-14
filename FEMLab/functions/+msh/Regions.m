classdef Regions
    
    properties
        
        % constants :
        mu_0 = 1.2566e-06;
        eps_0 = 8.854187e-12;
        
        % containers :
        regs = containers.Map('KeyType', 'char', 'ValueType', 'double');
        def = containers.Map('KeyType', 'char', 'ValueType', 'double');
        rMap = containers.Map('KeyType', 'double', 'ValueType', 'char');
        rMapInv = containers.Map('KeyType', 'char', 'ValueType', 'double');
        predefKeys = {'dirichlet', 'neumann', 'source'};
        predefColors =  {[255, 250, 10], [22, 95, 229], [237, 33, 60]};
        colors = containers.Map('KeyType', 'char', 'ValueType', 'any');
        codesDir = [];
        colrs = [61, 210, 1, 32];
        nEdges = 0;
        nFaces = 0;
        nItems = [0 0];
        
    end
    
    methods
        
        function obj = Regions(keys, vals, id, nItems)
            obj.regs = containers.Map(keys, vals);
            obj.def = containers.Map(keys, id);
            obj.nEdges = nItems(1);
            obj.nFaces = nItems(2);
            obj.nItems = nItems;
            obj = fillColorMap(obj);
        end
        
        function obj = getDirCodes(obj)
            codes = [];
            iCodes = 1;
            cKeys = keys(obj.regs);
            nKeys = length(cKeys);
            for iKey = 1:nKeys
                if(contains(cKeys{iKey}, 'dirichlet'))
                    codes(iCodes) = obj.rMapInv(cKeys{iKey});
                    iCodes = iCodes + 1;
                end
            end
            
            obj.codesDir = codes;
            
        end
        
        function keysArr = getKeysReg(obj, type)
            % getKeysReg(obj, type) - returns an array containing the
            % regions keys, if type == 'num' then it returns the numeric
            % keys, else it returns the string keys
            %
            if(strcmp(type, 'num'))
                temp = keys(obj.rMap);
                keysArr = [temp{:}];
            else
                keysArr = values(obj.rMap);
            end
        end
        
        function params = getParamsReg(obj, regs)
            % getKeysReg(obj, type) - returns an array containing the
            % regions keys, if type == 'num' then it returns the numeric
            % keys, else it returns the string keys
            %
            params = zeros(size(regs));
            for iReg = 1:numel(regs)
                params(iReg) = obj.getParam(regs(iReg));
            end
            
        end
        
        function obj = setRegMap(obj, keys, vals)
            obj.rMap = containers.Map(keys, vals);
            obj.rMapInv = containers.Map(vals, keys);
            obj = getDirCodes(obj);
        end
        
        function code = getRegCode(obj, region)
            code = obj.rMapInv(region);
        end
        
        function obj = fillColorMap(obj)
            nKeys = length(obj.regs);
            cKeys = keys(obj.regs);
            iClr = 1;
            for iKey = 1:nKeys
                setClr = 0;
                for iPredef = 1:3
                    if(contains(cKeys(iKey), obj.predefKeys(iPredef)))
                        obj.colors(cKeys{iKey}) = obj.predefColors{iPredef}/255;
                        setClr = 1;
                        break;
                    end
                end
                if(~setClr)
                    obj.colors(cKeys{iKey}) = util.clr(obj.colrs(iClr))/255;
                    iClr = iClr + 1;
                end
            end
        end
        
        function color = getColor(obj, key)
            if(isnumeric(key) && isKey(obj.rMap, key))
                color = obj.colors(obj.rMap(key));
            elseif(~isnumeric(key) && isKey(obj.colors, key))
                color = obj.colors(key);
            end
        end
        
        function obj = addRegion(obj, key, val)
            obj.regs(key) = val;
        end
        
        function name = getName(obj, key)
            name = obj.rMap(key);
        end
        
        function isDir = isDirichlet(obj, key)
            isDir = 0;
            if(contains(obj.rMap(key), 'dirichlet'))
                isDir = 1;
            end
        end
        
        function is_sour = isSource(obj, key)
            is_sour = 0;
            if(contains(obj.rMap(key), 'source'))
                is_sour = 1;
            end
        end
        
        function regsSour = getKeysSour(obj)
            
            keysArr = obj.getKeysReg('num');
            
            regsSour = zeros(numel(keysArr),1);
            for iKey = 1:numel(keysArr)
                if(obj.isSource(keysArr(iKey)))
                    regsSour(iKey) = iKey;
                end
            end
            
            regsSour(regsSour == 0) = [];
        end
        
        function param = getParam(obj, key)
            if(isnumeric(key))
                param = zeros(size(key));
                for i = 1:numel(key)
                    if(isKey(obj.rMap, key(i)))
                        param(i) = obj.regs(obj.rMap(key(i)));
                    end
                end
            elseif(ischar(key) && isKey(obj.regs, key))
                param = obj.regs(key);
            end
            
            
        end
        
        function [nums, strs] = getRegionIds(obj)
            nums = keys(obj.rMap);
            strs = values(obj.rMap);
        end
        
        function show_regions(obj)
            [nums, strs] = getRegionIds(obj);
            disp('----- Regions and codes -----')
            cellfun(@(x,y) disp([x ' [ ' num2str(y) ' ] ']), strs, nums)
            disp('-----------------------------')
        end
        
        function comb = getComboKeys(obj)
            nItems = obj.nItems;
            [regKeys, comb] = getRegionIds(obj);
            
            for iItem = 1:sum(nItems)
                comb{iItem} = [comb{iItem} ' (' num2str(regKeys{iItem}) ')'];
            end
            
        end
        
    end
end