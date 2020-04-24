function time = calcJ(files, optProb)
% CALC_J - Calculates the stationary current field from the previously calculated
% potentials. First the stationary current field defined in the middle of the
% triangle is calculated and from those the field in the triangle nodes.
%
% Syntax:  calcJ(files, optProb)
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


% disp('-Calculating stationary current field ...')
tic

slv.calcTriE(files, optProb)
slv.calcTriPointE(files)

% The calculation is the same and therefore J = gamma*E
[E, Ex, Ey] = slv.evalE(files, optProb);

load(files.respth, 'Ec', 'Ecx', 'Ecy', 'Ep', 'Epx', 'Epy')

% Placeholder :
gamma = 1;

Jc = gamma*Ec;
Jcx = gamma*Ecx;
Jcy = gamma*Ecy;
Jp = gamma*Ep;
Jpx = gamma*Epx;
Jpy = gamma*Epy;
J = gamma*E;
Jx = gamma*Ex;
Jy = gamma*Ey;

save(files.respth, 'J', 'Jx', 'Jy', ...
                   'Jc', 'Jcx', 'Jcy', ...
                   'Jp', 'Jpx', 'Jpy', '-append')
time = toc;
% disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])