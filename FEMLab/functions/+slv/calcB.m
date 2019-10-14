function calcB(files, optProb)
% CALC_B - Calculates the magnetic field from the previously calculated
% potentials. First the magnetic field defined in the middle of the
% triangle is calculated and from those the field in the triangle nodes.
%
% Syntax:  calcB(files, optProb)
%
% Inputs:
%    files - struct containing file and result paths
%    optProb - struct containing information about the problem ( the
%    problem can be 'planar' or 'axissymetric')
%
% Outputs:
%    none
%
% Other m-files required: calcTriB.m, calcWeightedB.m 
%
% Subfunctions: none
% MAT-files required: None
%
% Author: Eniz Museljic
% email: eniz.m@outlook.com
% Mar 2019


disp('-Calculating magnetic field ...')
tic

slv.calcTriB(files, optProb)
slv.calcTriPointB(files)

[B, Bx, By] = slv.evalB(files);
save(files.respth, 'B', 'Bx', 'By', '-append')

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])