function J = calcJacobian(optProb)

[ABC_xi, ABC_eta] = slv.getAbcsPDiffXiEta(optProb);
[f_pDiff, ~] = slv.getFuns("formfun_pdiff", optProb);

J = @(xe, ye, xi, eta) ...
    [f_pDiff(xi, eta, ABC_xi)  * xe,  f_pDiff(xi, eta, ABC_xi)  * ye;
     f_pDiff(xi, eta, ABC_eta) * xe,  f_pDiff(xi, eta, ABC_eta) * ye]; 
end

