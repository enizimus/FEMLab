function id = mapSpec(specStr)

switch upper(specStr)
    case 'DRB'
        id  = 1;
    case 'NRB'
        id = 2;
    case 'SRC'
        id = 3;
    case 'MAT'
        id = 4;
    otherwise
        error('Bad spec in regions.txt')
end