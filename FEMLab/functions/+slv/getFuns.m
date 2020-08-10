function [f1, f2] = getFuns(type, optProb)

if(nargin < 2 || isempty(optProb))
    optProb = struct('class', {''}, 'type', {''}, ...
        'int', {0});
end

switch lower(type)
    
    case {'formfun'}
        f1 = slv.getFormFun(optProb);
        %f1 = @(x,y,ABC) ABC*[x, y, 1]';
        f2 = 0; 
    case {'formfun_pdiff'}
        f1 = slv.getFormFunPDiff(optProb);
        f2 = 0; 
    case {'quadrature'}
        [f1, f2] = slv.getIntegralFun(optProb);
    case {'wint', 'wquadrature'}
        f1 = @slv.integrateWas;
        f2 = 0;
    case {'element'}
        [f1, f2] = slv.getElementFun(optProb);
    case {'efield', 'e'}
        [f1, f2] = slv.getEFun(optProb);
    case {'bfield', 'b'}
        [f1, f2] = slv.getBFun(optProb);
    case {'coefs'}
        if(optProb.elementOrder == 1)
            f1 = @slv.calcAbcFirstOrder;
            f2 = 0;
        elseif(optProb.elementOrder == 2)
            f1 = @slv.calcAbcSecondOrder;
            f2 = 0;
        end
    case {'w', 'energy'}
        f1 = @(B, A, mu, r) 0.5*B^2*mu*r;%get_energy_fun(optProb);
        f2 = 0;
    otherwise
        error('Unsupported function!?')
end