function [B1, B2, B] = evalBXiEta(files, optProb, elements, xi, eta)

N_elements = length(elements);
N_points_per_element = length(xi);

S = load(files.respth, ...
    "Ap", ...
    "mu_r", ...
    "triangles", ...
    "nodes", ...
    "isNonlinearMaterial", ...
    "regions");

B1 = zeros(N_elements, N_points_per_element);
B2 = zeros(N_elements, N_points_per_element);
B = zeros(N_elements, N_points_per_element);


% ABC-values for formfuncitons
ABC = slv.getAbcsXiEta(optProb);

% Formfunctions
f_form = slv.getFormFun(optProb);


% Get ABC-values for partial derivatives of formfunctions
[ABC_xi, ABC_eta] = slv.getAbcsPDiffXiEta(optProb);

% Get partial derivatives of formfunctions.
% Partial derivative for xi or eta is determined by passing the
% corresponding ABC
[f_pDiff, ~] = slv.getFuns("formfun_pdiff", optProb);

% Get inverse jacobian
J_inv = slv.calcJacobianInv(optProb);

if strcmp(optProb.symmetry, "Axis symmetric")
    problem_type = 2;
elseif strcmp(optProb.symmetry, "Plane symmetric")
    problem_type = 1;
else
    error("Unsupported problem type");
end


for k = 1 : N_elements
    triangle_nodes = S.triangles(elements(k), :);
    element_node_coordinates = S.nodes(triangle_nodes, :);
    node_potentials = S.Ap(triangle_nodes);
    
    if problem_type == 1
        [B1_k, B2_k, B_k] = evalBPlanar(element_node_coordinates, ...
            node_potentials, ...
            xi, ...
            eta, ...
            ABC_xi, ...
            ABC_eta, ...
            J_inv, ...
            f_pDiff ...
            );
    elseif problem_type == 2
        [B1_k, B2_k, B_k] = evalBRotSym(element_node_coordinates, ...
            node_potentials, ...
            xi, ...
            eta, ...
            ABC_xi, ...
            ABC_eta, ...
            J_inv, ...
            f_pDiff, ...
            ABC, ...
            f_form);
    end
    
    B1(k,:) = B1_k';
    B2(k,:) = B2_k';
    B(k,:)  = B_k';  
end
end

function [Bx, By, B] = evalBPlanar(element_node_coordinates, ...
    node_potentials, ...
    xi, ...
    eta, ...
    ABC_xi, ...
    ABC_eta, ...
    J_inv, ...
    f_pDiff)

N_points = length(xi);

Bx = zeros(N_points, 1);
By = zeros(N_points, 1);
B  = zeros(N_points, 1);


for k = 1 : N_points
    xi_k = xi(k);
    eta_k = eta(k);
    
    % Partial derivatives of form-function in xi/eta-domain
    dN_dXi =  f_pDiff(xi_k, eta_k, ABC_xi);
    dN_dEta = f_pDiff(xi_k, eta_k, ABC_eta);
    
    dN_vec = [dN_dXi ; dN_dEta];
    
    xe = element_node_coordinates(:,1);
    ye = element_node_coordinates(:,2);
    
    tmp = J_inv(xe, ye, xi_k, eta_k) * dN_vec * node_potentials(:);
    By(k) = -tmp(1);
    Bx(k) = tmp(2);
    B(k) = norm([Bx(k), By(k)]);
    
end

end

function [Br, Bz, B] = evalBRotSym(element_node_coordinates, ...
    node_potentials, ...
    xi, ...
    eta, ...
    ABC_xi, ...
    ABC_eta, ...
    J_inv, ...
    f_pDiff, ...
    ABC, ...
    f_form)

N_points = length(xi);

Br = zeros(N_points, 1);
Bz = zeros(N_points, 1);
B  = zeros(N_points, 1);


for k = 1 : N_points
    xi_k = xi(k);
    eta_k = eta(k);
    
    % Partial derivatives of form-function in xi/eta-domain
    dN_dXi =  f_pDiff(xi_k, eta_k, ABC_xi);
    dN_dEta = f_pDiff(xi_k, eta_k, ABC_eta);
    
    dN_vec = [dN_dXi ; dN_dEta];
    
    re = element_node_coordinates(:,1);
    ze = element_node_coordinates(:,2);
    
    dA_vec = J_inv(re, ze, xi_k, eta_k) * dN_vec * node_potentials(:);
    
    N = f_form(xi_k, eta_k, ABC');
    A_r = N * node_potentials;
    r = N * re;
    
    Br(k) = -dA_vec(2);
    Bz(k) = A_r / r + dA_vec(1);
    B(k) = norm([Br(k), Bz(k)]);
    
end


end

