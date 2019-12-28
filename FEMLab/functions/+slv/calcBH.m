function calcBH(files, optProb)
% CALC_B - Calculates the magnetic field from the previously calculated
% potentials. First the magnetic field defined in the middle of the
% triangle is calculated and from those the field in the triangle nodes.
% Additionaly the eval function calculates the field in the points passed
% to it as a weighted sum of the field in the element points.
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

slv.calcTriBH(files, optProb)
slv.calcTriPointBH(files)

[B, Bx, By, H, Hx, Hy] = slv.evalBH(files);
save(files.respth, 'B', 'Bx', 'By', 'H', 'Hx', 'Hy', '-append')

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])