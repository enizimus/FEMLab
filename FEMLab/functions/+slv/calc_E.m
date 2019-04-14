function calc_E(files, prob_opt)
% CALC_E - Calculates the electric field from the previously calculated
% potentials. First the electric field defined in the middle of the
% triangle is calculated and from those the field in the triangle nodes.
%
% Syntax:  calc_E(files, prob_opt)
%
% Inputs:
%    files - struct containing file and result paths
%    prob_opt - struct containing information about the problem ( the
%    problem can be 'planar' or 'axissymetric')
%
% Outputs:
%    none
%
% Other m-files required: calc_tri_E.m, calc_weighted_E.m 
%
% Subfunctions: none
% MAT-files required: None
%
% Author: Eniz Museljic
% email: eniz.m@outlook.com
% Mar 2019


disp('-Calculating electric field ...')
tic

slv.calc_tri_E(files, prob_opt)
slv.calc_tri_point_E(files)

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])

% function calc_E(files, X, Y)
% 
% load(files.respth, 'A', 'X', 'Y')
% 
% dh = abs(X(1,1)-X(1,2));
% 
% [Ex, Ey] = gradient(A, dh);
% Ex = -Ex;
% Ey = -Ey;
% E = sqrt(Ex.^2 + Ey.^2);
% save(files.respth, 'E', 'Ex', 'Ey', '-append')