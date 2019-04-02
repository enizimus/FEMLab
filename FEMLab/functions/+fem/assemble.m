function assemble(files)
% ASSEMBLE - Loads the previously calculated element matrices, assembles
% the whole equation system and solves it to get the node potentials.
% After calling this function elements.K and elements.R have the right
% dimension. Not done previously to have easier indexing.
%
% Syntax:  assemble(files)
%
% Inputs:
%    files - struct containing file and result paths
%
% Outputs:
%    none
%
% Other m-files required: get_known_U.m, bluewhitered.m
%
% Subfunctions: none
% MAT-files required: Results.mat
%
% Author: Eniz Museljic
% email: eniz.m@outlook.com
% Feb 2019



disp('-Assembling solution matrix and calculating solution ...')
tic

load(files.respth, 'elements', 'regions_c', 'n_nodes', 'n_elements')

K = spalloc(n_nodes, n_nodes, 6*n_nodes);
R = zeros(n_nodes,1);

i_elem = 1;
while(elements(i_elem).type == 1)
    i_elem = i_elem + 1;
end

for i_el=i_elem:n_elements
    
    i_n = elements(i_el).n;
    i_N = elements(i_el).nodes(i_n);
    
    K(i_N, i_N) = K(i_N, i_N) + elements(i_el).K(i_n, i_n);
    R(i_N) = R(i_N) + elements(i_el).R(i_n);
    
    elements(i_el).K = elements(i_el).K(i_n, i_n);
    elements(i_el).R = elements(i_el).R(i_n);
    
end

U = zeros(n_nodes, 1);

I = any(K,2);
u_unknown = I;
u_known = ~I;
K = K(I,:);
R = R(I);
I = any(K,1);
K = K(:,I);

U_known = slv.get_known_U(u_known, regions_c);
U_unknown = K\R;
U(u_unknown) = U_unknown;
U(u_known) = U_known;

% figure;surface(1:size(K,1),size(K,1):-1:1,K,K);colormap(util.bluewhitered);shading flat 
% eigenvals = eig(full(K)); % to be fixed
% condition_number = max(abs(eigenvals))/min(abs(eigenvals));
% disp(['Condition Number: ',num2str(condition_number)]);

save(files.respth, 'elements', 'U', 'K', 'R', '-append'); 

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])
end