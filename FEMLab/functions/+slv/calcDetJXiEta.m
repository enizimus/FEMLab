function detJ = calcDetJXiEta(optProb, xi, eta, xe, ye)

[ABC_xi, ABC_eta] = slv.getAbcsPDiffXiEta(optProb);
[f_pDiff, ~] = slv.getFuns("formfun_pdiff", optProb);
 
detJ = zeros(length(xi), 1);                                    
                    
for l = 1 : length(xi)                                   
        dx_dXi =  f_pDiff(xi(l), eta(l), ABC_xi)  * xe;
        dx_dEta = f_pDiff(xi(l), eta(l), ABC_eta) * xe;
        dy_dXi =  f_pDiff(xi(l), eta(l), ABC_xi)  * ye;
        dy_dEta = f_pDiff(xi(l), eta(l), ABC_eta) * ye;
    
        detJ(l) = dx_dXi * dy_dEta - dx_dEta * dy_dXi;
end
end

