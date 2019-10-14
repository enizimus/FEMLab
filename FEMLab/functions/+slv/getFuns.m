function [f1, f2, f3] = getFuns(type, optProb)

if(nargin < 2 || isempty(optProb))
    optProb = struct('class', {''}, 'type', {''}, ...
        'int', {0});
end

switch lower(type)
    
    case {'formfun'}
        f1 = @(x,y,ABC) ABC*[x, y, 1]';
        f2 = 0; f3 = 0;
    case {'quadrature'}
        [f1, f2] = slv.getIntegralFun(optProb);
        f3 = 0;
    case {'wint', 'wquadrature'}
        f1 = @slv.integrateWas;
        f2 = 0; f3 = 0;
    case {'element'}
        [f1, f2] = slv.getElementFun(optProb);
        f3 = 0;
    case {'efield', 'e'}
        [f1, f2] = slv.getEFun(optProb);
        f3 = 0;
    case {'bfield', 'b'}
        [f1, f2] = slv.getBFun(optProb);
        f3 = 0;
    case {'abc'}
        [f1, f2, f3] = slv.getAbcFun();
    case {'w', 'energy'}
        f1 = @(B, A, mu, r) 0.5*B^2*mu*r;%get_energy_fun(optProb);
        f2 = 0; f3 = 0;
    otherwise
        error('Unsupported function!?')
end