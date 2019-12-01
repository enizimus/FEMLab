function isrot = isRotsym(type)

cases = {'axis', 'Axis', 'ASym', 'Axis symmetric', ...
    'Axis symmetry'};
switch type
    case cases
        isrot = 1;
    otherwise
        isrot = 0;
end