function [abc_xi, abc_eta] = getAbcsPDiffXiEta(optProb)
% \brief Get the abc-matrix for partial derivatives of first- and 
%        second-order triangle formfunctions in 
%        isoparameteric (xi/eta)-domain 
%          
%        
% \details To evaluate the xi-derivative of k-th formfunction at a cetain 
%          point xi_k, eta_k evaluate:
%               
%            [abc_xi, abc_eta] = getAbcsPDiffXiEta(optProb)
%            f = getFunc("formfun_pdiff", optProb)
%            val = f(xi_k, eta_k, abc_xi(k, :))
%
%         abs_xi(k, :) selects the xi-partial derivative of the k-th
%         formfunction.

if (optProb.elementOrder == 1)
               
    abc_xi = [ -1;     % N1
                1;     % N2
                0;     % N3
             ];
         
    abc_eta = [ -1;     % N1
                 0;     % N2
                 1;     % N3
              ];
elseif (optProb.elementOrder == 2)
          
              % 1      xi      eta     
    abc_xi = [ -3,     4,      4;     % N1
               -1,     4,      0;     % N3
                0,     0,      0;     % N5
                4,    -8,     -4;     % N2
                0,     0,      4;     % N4
                0,     0,     -4;     % N6
             ];
         
               % 1      xi      eta     
    abc_eta = [ -3,     4,      4;     % N1
                 0,     0,      0;     % N3
                -1,     0,      4;     % N5
                 0,    -4,      0;     % N2
                 0,     4,      0;     % N4
                 4,    -4,     -8;     % N6
              ];
end
    

end

