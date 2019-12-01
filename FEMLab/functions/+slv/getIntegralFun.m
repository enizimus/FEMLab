function [hFunQuadK, hFunQuadR] = getIntegralFun(optProb)

if(def.isPlanar(optProb.symmetry))
    if(def.isInt(optProb.computation))
        hFunQuadK = @slv.integrateK;
        hFunQuadR = @slv.integrateR;
    else
        hFunQuadK = @slv.preintK;
        hFunQuadR = @slv.preintR;
    end
elseif(def.isRotsym(optProb.symmetry))
    if(def.isMstatic(optProb.problemClass))   %strcmp(optProb.problemClass, 'mstatic'))
        hFunQuadK = @slv.integrateKas;
        hFunQuadR = @slv.integrateR;
    elseif(def.isEstatic(optProb.problemClass))
        hFunQuadK = @slv.integrateKas;
        hFunQuadR = @slv.integrateR;
    end
end