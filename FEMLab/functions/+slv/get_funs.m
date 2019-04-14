function [f1, f2, f3] = get_funs(type, prob_opt)

if(nargin < 2 || isempty(prob_opt))
    prob_opt = struct('class', {''}, 'type', {''}, ...
        'int', {0});
end

switch lower(type)
    
    case {'formfun'}
        f1 = @(x,y,ABC) ABC*[x, y, 1]';
        f2 = 0; f3 = 0;
    case {'quadrature'}
        [f1, f2] = slv.get_integral_fun(prob_opt);
        f3 = 0;
    case {'element'}
        [f1, f2] = slv.get_element_fun(prob_opt);
        f3 = 0;
    case {'efield', 'e'}
        [f1, f2] = slv.get_E_fun(prob_opt);
        f3 = 0;
    case {'bfield', 'b'}
        [f1, f2] = slv.get_B_fun(prob_opt);
        f3 = 0;
    case {'abc'}
        [f1, f2, f3] = slv.get_abc_fun();
    otherwise
        error('Unsupported function!?')
end