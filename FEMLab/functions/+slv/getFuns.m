function [f1, f2, f3] = getFuns(type, optProb)

f1=0; f2=0; f3 = 0;

if(nargin < 2 || isempty(optProb))
    optProb = struct('class', {''}, 'type', {''}, ...
        'int', {0});
end

switch lower(type)
    
    case {'formfun'}
        f1 = slv.getFormFun(optProb);
    case {'quadrature'}
        [f1, f2] = slv.getIntegralFun(optProb);
    case {'wint', 'wquadrature'}
        f1 = @slv.integrateWas;
    case {'element'}
        [f1, f2] = slv.getElementFun(optProb);
    case {'efield', 'e'}
        [f1, f2] = slv.getEFun(optProb);
    case {'bfield', 'b'}
        [f1, f2] = slv.getBFun(optProb);
    case {'coefs'}
        if(optProb.elementOrder == 1)
            f1 = @slv.calcAbcFirstOrder;
        elseif(optProb.elementOrder == 2)
            f1 = @slv.calcAbcSecondOrder;
        end
    case {'w', 'energy'}
        f1 = @(B, A, mu, r) 0.5*B^2*mu*r;%get_energy_fun(optProb);
    case {'neumann'}
        [f1, f2, f3] = slv.getNeumannFun(optProb);
    case {'neumann quadrature'}
        f1 = @slv.integrateNeumann;
    otherwise
        error('Unsupported function!?')
end