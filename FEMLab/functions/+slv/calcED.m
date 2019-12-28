function calcED(files, optProb)
% CALC_E - Calculates the electric field from the previously calculated
% potentials. First the electric field defined in the middle of the
% triangle is calculated and from those the field in the triangle nodes.
%
% Syntax:  calcE(files, optProb)
%
% Inputs:
%    files - struct containing file and result paths
%    optProb - struct containing information about the problem ( the
%    problem can be 'planar' or 'axissymetric')
%
% Outputs:
%    none
%
% Other m-files required: calcTriE.m, calc_weighted_E.m 
%
% Subfunctions: none
% MAT-files required: None
%
% Author: Eniz Museljic
% email: eniz.m@outlook.com
% Mar 2019


disp('-Calculating electric field ...')
tic

slv.calcTriED(files, optProb)
slv.calcTriPointED(files)

[E, Ex, Ey, D, Dx, Dy] = slv.evalED(files);
save(files.respth, 'E', 'Ex', 'Ey', ...
                   'D', 'Dx', 'Dy', '-append')

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])