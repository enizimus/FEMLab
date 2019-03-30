function calc_B(files, prob_opt)
% CALC_B - Calculates the magnetic field from the previously calculated
% potentials. First the magnetic field defined in the middle of the
% triangle is calculated and from those the field in the triangle nodes.
%
% Syntax:  calc_B(files, prob_opt)
%
% Inputs:
%    files - struct containing file and result paths
%    prob_opt - struct containing information about the problem ( the
%    problem can be 'planar' or 'axissymetric')
%
% Outputs:
%    none
%
% Other m-files required: calc_tri_B.m, calc_weighted_B.m 
%
% Subfunctions: none
% MAT-files required: None
%
% Author: Eniz Museljic
% email: eniz.m@outlook.com
% Mar 2019


disp('-Calculating magnetic field ...')
tic

n_p = 10;

[xlims,ylims] = msh.get_xy_lims(files);
slv.calc_tri_B(files, prob_opt)
slv.calc_tri_point_B(files)
x = linspace(xlims(1),xlims(2),n_p);
y = linspace(ylims(1),ylims(2),n_p);
[X,Y] = meshgrid(x,y);
[B, Bx, By] = slv.eval_B(files, X, Y);
save(files.respth, 'B', 'Bx', 'By', 'X', 'Y', '-append')


disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])