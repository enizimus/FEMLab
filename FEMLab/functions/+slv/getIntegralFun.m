function [hFunQuadK, hFunQuadR] = getIntegralFun(optProb)

if(def.isPlanar(optProb.symmetry))
    if(optProb.elementOrder == 1)
        
        if(def.isInt(optProb.computation))
            hFunQuadK = @slv.integrateK;
            hFunQuadR = @slv.integrateR;
        else
            hFunQuadK = @slv.preintK;
            hFunQuadR = @slv.preintR;
        end
        
    elseif(optProb.elementOrder == 2)
        hFunQuadK = @slv.integrateKsecOrd;
        hFunQuadR = @slv.integrateRsecOrd;
    end
    
elseif(def.isRotsym(optProb.symmetry))
    if(optProb.elementOrder == 1)
        
        % for order 1 elements same integration for EStatic and MStatic
        hFunQuadK = @slv.integrateKas;
        hFunQuadR = @slv.integrateR;
        
    elseif(optProb.elementOrder == 2)
        
        if(def.isMstatic(optProb.problemClass))
            hFunQuadK = @slv.integrateKas;
            hFunQuadR = @slv.integrateR;
            
        elseif(def.isEstatic(optProb.problemClass))
            hFunQuadK = @slv.integrateKas;
            hFunQuadR = @slv.integrateR;
        end
        
    end
end