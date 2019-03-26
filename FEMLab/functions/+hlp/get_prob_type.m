function type = get_prob_type(type_str)

type_2 = {'axissymetric', 'rotationsymetric', 'axssym', 'rotsym', '2', 'as'};
type_1 = {'planar', 'plane', 'pl', 'p', '1'};

switch(lower(type_str))
    case(type_1)
        type = 1;
    case(type_2)
        type = 2;
    otherwise
        error('[ERR] Unsupported problem type')
end