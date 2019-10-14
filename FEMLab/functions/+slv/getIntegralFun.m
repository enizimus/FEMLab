function [hFunQuadK, hFunQuadR] = getIntegralFun(optProb)

[type1, type2] = def.getProbTypeVals();
type = def.getProbType(optProb.type);

if(type == type1)
    if(optProb.int == 1)
        hFunQuadK = @slv.integrateK;
        hFunQuadR = @slv.integrateR;
    else
        hFunQuadK = @slv.preintK;
        hFunQuadR = @slv.preintR;
    end
elseif(type == type2)
    if(strcmp(optProb.class, 'mstatic'))
        hFunQuadK = @slv.integrateKas;
        hFunQuadR = @slv.integrateR;
    else
        hFunQuadK = @slv.integrateKas;
        hFunQuadR = @slv.integrateR;
    end
end