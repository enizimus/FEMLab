function detJ = calcDetJXiEta(optProb, xi, eta, xe, ye)

[ABC_xi, ABC_eta] = slv.getAbcsPDiffXiEta(optProb);
[f_pDiff, ~] = slv.getFuns("formfun_pdiff", optProb);
 
dx_dXi = 0;
dx_dEta = 0;
dy_dXi = 0;
dy_dEta = 0;

N_nodes = optProb.elementOrder * 3; % 1st order: 3 nodes, 
                                    % 2nd-order 6 nodes, and so on
detJ = zeros(length(xi), 1);                                    
                    
for l = 1 : length(xi)                                   
    for k = 1 : N_nodes
        tmp1 = f_pDiff(xi(l), eta(l), ABC_xi(k,:)')  * xe(k);
        tmp2 = f_pDiff(xi(l), eta(l), ABC_eta(k,:)') * xe(k);
        tmp3 = f_pDiff(xi(l), eta(l), ABC_xi(k,:)')  * ye(k);
        tmp4 = f_pDiff(xi(l), eta(l), ABC_eta(k,:)') * ye(k);
        
        dx_dXi =  dx_dXi  + tmp1;
        dx_dEta = dx_dEta + tmp2;
        dy_dXi =  dy_dXi  + tmp3;
        dy_dEta = dy_dEta + tmp4;
    end
    
    detJ(l) = dx_dXi * dy_dEta - dx_dEta * dy_dXi;
end
end

