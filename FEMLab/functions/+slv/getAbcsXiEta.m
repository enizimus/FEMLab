function abc = getAbcsXiEta(optProb)
% \brief Get the formfuction abc-matrix for first- or second-order 
%        triangles in isoparameteric (xi/eta) -  domain.
%
% \details [N, ~] = getFunc("formfun", optProb) returns 
%          formfunction-handle taking arguments (x, y, abc). 
%          To calculate the value of formfunction k at a certain point in 
%          xi/eta-domain, evaluate
%          N(abc(k, :), <xi-value>, <eta-value>).
%          
%          abc(k, :) selects the abc-values for the k-th formfunction.
%
%
%

if (optProb.elementOrder == 1)
          % 1  xi  eta
    abc = [ 1, -1, -1;     % N1
            0,  1,  0;     % N2
            0,  0,  1      % N3
          ];
elseif (optProb.elementOrder == 2)
           % 1      xi      eta     xi^2   xi*eta   eta^2
    abc = [  1,     -3,     -3,      2,      4,      2;     % N1
             0,      4,      0,     -4,     -4,      0;     % N2
             0,     -1,      0,      2,      0,      0;     % N3
             0,      0,      0,      0,      4,      0;     % N4
             0,      0,     -1,      0,      0,      2;     % N5
             0,      0,     -4,      0,      4,      4;     % N6
        ];
end
    

end

