function edge_type = assign_edge_opts(msh_opt)

def_type = def.get_edge_opts();
switch lower(msh_opt)
    case {'circ', 'circular', 'round', 'o'}
        edge_type = def_type(1);
    case {'rect', 'rectangular', 'r', 'square'}
        edge_type = def_type(2);        
end