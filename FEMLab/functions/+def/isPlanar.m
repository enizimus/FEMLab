function is_pl = isPlanar(type)

cases = {'planar', 'Planar', 'Plane', 'Plane symmetric', ...
    'Plane symmetry'};
switch type
    case cases
        is_pl = 1;
    otherwise
        is_pl = 0;
end