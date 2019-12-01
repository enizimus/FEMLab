function type = getProbType(typeStr)

type2 = {'axissymetric', 'rotationsymetric', 'axssym', 'rotsym', '2', 'as',...
    'axis symmetric'};
type1 = {'planar', 'plane', 'pl', 'p', '1', 'plane symmetric'};

switch(lower(typeStr))
    case(type1)
        type = 1;
    case(type2)
        type = 2;
    otherwise
        error('[ERR] Unsupported problem type')
end