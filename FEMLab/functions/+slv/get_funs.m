function [f1, f2, f3] = get_funs(type, optProb)

if(nargin < 2 || isempty(optProb))
    optProb = struct('class', {''}, 'type', {''}, ...
        'int', {0});
end

switch lower(type)
    
    case {'formfun'}
        f1 = @(x,y,ABC) ABC*[x, y, 1]';
        f2 = 0; f3 = 0;
    case {'quadrature'}
        [f1, f2] = slv.get_integral_fun(optProb);
        f3 = 0;
    case {'wint', 'wquadrature'}
        f1 = @slv.int_W_as;
        f2 = 0; f3 = 0;
    case {'element'}
        [f1, f2] = slv.get_element_fun(optProb);
        f3 = 0;
    case {'efield', 'e'}
        [f1, f2] = slv.get_E_fun(optProb);
        f3 = 0;
    case {'bfield', 'b'}
        [f1, f2] = slv.get_B_fun(optProb);
        f3 = 0;
    case {'abc'}
        [f1, f2, f3] = slv.get_abc_fun();
    case {'w', 'energy'}
        f1 = @(B, A, mu, r) 0.5*B^2*mu*r;%get_energy_fun(optProb);
        f2 = 0; f3 = 0;
    otherwise
        error('Unsupported function!?')
end