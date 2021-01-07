function W = calcWmagNL(files, optProb)
% \brief Mail-function for nonlinear magnetic energy calculation
%
% \details 
%
% \param files Structure containing file-paths of the problems date- and
%              config-files.
% \param optProb Problem configuration
%
% \return Magnetic energy. Depending on the problem type, this is either
%         the total magnetic energy for axissymmetric problems, or the 
%         energy per unit length for planar problems.

S = load(files.respth, ...
    "Ap", ...
    "mu_r", ...
    "triangles", ...
    "nodes", ...
    "isNonlinearMaterial", ...
    "regsTris", ...  
    "regSet");

% Get hysteresis data
BHCurveData = jsondecode(fileread(fullfile("AppFiles", "nlSolverBHCurves", ...
    "muRCurves.json")));


[N_triangles, ~] = size(S.triangles);
surface_regions = S.regSet([S.regSet.dim] == 2);
N_surface_regions = length(surface_regions);
element_BH_curve_ids = zeros(N_triangles, 1);


if strcmp(optProb.symmetry, "Axis symmetric")
    problem_type = 2;
elseif strcmp(optProb.symmetry, "Plane symmetric")
    problem_type = 1;
else
    error("Unsupported problem type");
end

% Asslign B/H-curves to triangles
for k = 1 : N_surface_regions
    current_region_tag = surface_regions(k).id;
    current_material_curve = surface_regions(k).matProp;
    idx = S.regsTris == current_region_tag;
    element_BH_curve_ids(idx) = current_material_curve;
end

% Get Gauss-integration data
gauss_integration_data = slv.gaussIntData2();
gauss_weights = gauss_integration_data(:, 3);
gauss_xi = gauss_integration_data(:, 1);
gauss_eta = gauss_integration_data(:, 2);

% Flux-density at gauss-points
[~, ~, B] = slv.evalBXiEta(files, optProb, 1:N_triangles, ...
    gauss_xi, gauss_eta);

% Radius at Gauss-points. Required for axissymmetric-problems.
if problem_type == 2
    [r_gauss, ~] = slv.getXYFromXiEta(files, ...
        optProb, ...
        1:N_triangles, ...
        gauss_xi, ...
        gauss_eta);
end

% Magnetic energy value cummulatively summed over all finte-elements
W_omega = 0;

for k = 1 : N_triangles
    
    % Element-node coordinates.
    % For axissymmetric-problem: x -> r and y -> z
    xe = S.nodes(S.triangles(k,:),1);
    ye = S.nodes(S.triangles(k,:),2);
    
    % Jabobian determinan-values at Gauss-points
    det_J_gauss = slv.calcDetJXiEta(optProb, gauss_xi, gauss_eta, xe, ye);
    B_gauss = B(k,:);
    
    % Case-differentiation by problem-type and linear or nonlinear material
    % relation
    
    % ===== Nonlinear materials
    if S.isNonlinearMaterial(k) == 1
        
        % == Planar
        if problem_type == 1
            W_elem = W_elem_nl_planar( ...
                gauss_weights, ...
                B_gauss, ...
                BHCurveData.data(element_BH_curve_ids(k)), ...
                det_J_gauss);
            
            if W_elem < 0
                keyboard
            end
            
            W_omega = W_omega + W_elem;
         
        % == Axissymmetric    
        elseif problem_type == 2
            
            W_elem = W_elem_nl_rotsym( ...
                gauss_weights, ...
                B_gauss, ...
                BHCurveData.data(element_BH_curve_ids(k)), ...
                det_J_gauss, ...
                r_gauss(k,:));
            
            if W_elem < 0
                keyboard
            end
            W_omega = W_omega + W_elem;
        end
        
    % ===== Linear materials
    else
        
        % == Planar
        if problem_type == 1
            
            W_elem = W_elem_lin_planar(...
            gauss_weights, ...
            S.mu_r(k), ...
            B_gauss, ...
            det_J_gauss);
        
            if W_elem < 0
                keyboard
            end
            
            W_omega = W_omega + W_elem;
            
        % == Axissymmetric 
        elseif problem_type == 2
          W_elem = W_elem_lin_rotsym(...
            gauss_weights, ...
            S.mu_r(k), ...
            B_gauss, ...
            det_J_gauss, ...
            r_gauss(k,:));
        
          if W_elem < 0
              keyboard
          end
         W_omega = W_omega + W_elem;
        end
    end
end

W = W_omega; 
end



function W_elem = W_elem_nl_planar(...
    gauss_weights, ...
    B_gauss, ...
    BH_curve, ...
    det_J_gauss)

% \brief Calculates the magnetic energy within a finite element containing
%        a nonlinear material for a planar problem.
%
% \details See handwritten documentation for further details.
%
% \param gauss-weights Column-vector containing the Gauss-weights
% \param B_gauss Column-vector containing the B-field magnitudes at the
%        Gauss-points.
% \param BH_curve Structure containing the B/H-curve for the current
%        element.
% \param det_J_gauss Jacobian-determinant-values of current element at
%        Gauss-points.
%
% \return Magnetic energy per unit length within element.

    B = B_gauss(:);
    det_J = det_J_gauss(:);
    weights = gauss_weights(:);

    N_gauss_points = length(weights);
    w_mag_gauss_points = zeros(N_gauss_points, 1);
    
    
    for k = 1 : N_gauss_points
        w_mag_gauss_points(k) = w_mag_nl(B(k), BH_curve);
    end
    
    % Depending on the node-ordering, triangle-area can be negative due to
    % the projection between isoparametric- and problem domain. 
    % In this case, the energy has to be multiplied by (-1).
    triangle_area = 1/2 * det_J' * gauss_weights;
    
    % See hand-written documentation for further details.
    W_elem = 1/2 * (w_mag_gauss_points .* det_J)' * weights * ...
        sign(triangle_area);
end

function W_elem = W_elem_nl_rotsym(...
    gauss_weights, ...
    B_gauss, ...
    BH_curve, ...
    det_J_gauss, ...
    r_gauss)

% \brief Calculates the magnetic energy within a finite element containing
%        a nonlinear material for a axissymmetric problem.
%
% \details See handwritten documentation for further details.
%
% \param gauss-weights Column-vector containing the Gauss-weights
% \param B_gauss Column-vector containing the B-field magnitudes at the
%        Gauss-points.
% \param BH_curve Structure containing the B/H-curve for the current
%        element.
% \param det_J_gauss Jacobian-determinant-values of current element at
%        Gauss-points.
% \param r_gauss Radius at Gauss-points
%
% \return Total magnetic energy within element.

    B = B_gauss(:);
    r = r_gauss(:);
    det_J = det_J_gauss(:);
    weights = gauss_weights(:);

    N_gauss_points = length(weights);
    w_mag_gauss_points = zeros(N_gauss_points, 1);
    
    for k = 1 : N_gauss_points
        w_mag_gauss_points(k) = w_mag_nl(B(k), BH_curve);
    end
    
    triangle_area = 1/2 * det_J' * gauss_weights; 
    
    % Division by 2 from Gauss-integration already considered!
    W_elem = pi * (w_mag_gauss_points(k) .* det_J .* r)' * ...
        weights * sign(triangle_area);
end

function W_elem = W_elem_lin_planar(...
    gauss_weights, ...
    mu_r_element, ...
    B_gauss, ...
    det_J_gauss)

% \brief Calculates the magnetic energy within a finite element containing
%        a linear material for a planar problem.
%
% \details See handwritten documentation for further details.
%
% \param gauss-weights Column-vector containing the Gauss-weights.
% \param mu_r_element Relative permeability within element.
% \param B_gauss Flux-density magnitude values at Gauss-points.
% \param det_J_gauss Jacobian-determinant-values of current element at
%        Gauss-points.
%
% \return Magnetic energy per unit length within element.

    B = B_gauss(:);
    det_J = det_J_gauss(:);
    weights = gauss_weights(:);
    
    triangle_area = 1/2 * det_J' * gauss_weights;

    w_mag = 1/2 * B.^2 / (mu_r_element * 4e-7 * pi);
    W_elem = 1/2 * (w_mag .* det_J)' * weights * sign(triangle_area);
    
    if W_elem < 0
        keyboard
    end
end


function W_elem = W_elem_lin_rotsym(...
    gauss_weights, ...
    mu_r_element, ...
    B_gauss, ...
    det_J_gauss, ...
    r_gauss)

% \brief Calculates the magnetic energy within a finite element containing
%        a linear material for a axissymmetric problem.
%
% \details See handwritten documentation for further details.
%
% \param gauss-weights Column-vector containing the Gauss-weights.
% \param mu_r_element Relative permeability within element.
% \param B_gauss Flux-density magnitude values at Gauss-points.
% \param det_J_gauss Jacobian-determinant-values of current element at
%        Gauss-points.
% \param r_gauss Radius at Gauss-points
%
% \return Total magnetic energy within element.

    B = B_gauss(:);
    r = r_gauss(:);
    det_J = det_J_gauss(:);
    weights = gauss_weights(:);
    
    triangle_area = 1/2 * (det_J)' * weights;
    w_mag = 1/2 * B.^2 / (mu_r_element * 4e-7 * pi);
    
    % Division by 2 from Gauss-integration already considered!
    W_elem = pi * (w_mag .* det_J .* r)' * weights * sign(triangle_area);
end


function w = w_mag_nl(B, BH_curve)
% \brief Calculates the nonlinear-magnetic energy-density for a given
%        material-curve and flux-density magnitude.
% \details See handwritten documentation for further details.
% 
% \param B Flux-density magnitude
% \param BH_curve Structure containig B/H-curve data.

    NO_OF_INTEGRATION_POINTS = 1000;
    
    
    H = B * slv.nuInterpolation(B, BH_curve);
    
    % Get equally spaced integration points
    H_integrate = logspace(log10(0.1), log10(H), NO_OF_INTEGRATION_POINTS);
    mu_interp = slv.muRInterpolation(H_integrate, BH_curve) * 4e-7 * pi;

    integrant = mu_interp .* H_integrate;
    
    w = H*B - trapz(H_integrate, integrant);
end

