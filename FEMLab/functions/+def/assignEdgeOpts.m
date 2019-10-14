function edgeType = assignEdgeOpts(mshType)

defType = def.getEdgeOpts();
switch lower(mshType)
    case {'circ', 'circular', 'round', 'o'}
        edgeType = defType(1);
    case {'rect', 'rectangular', 'r', 'square'}
        edgeType = defType(2);        
end