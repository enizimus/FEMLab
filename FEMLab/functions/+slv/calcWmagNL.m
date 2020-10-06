function W = calcWmagNL(files, optProb)
W = 0;
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


for k = 1 : N_surface_regions
    current_region_tag = surface_regions(k).id;
    current_material_curve = surface_regions(k).matProp;
    idx = S.regsTris == current_region_tag;
    element_BH_curve_ids(idx) = current_material_curve;
end


gauss_integration_data = slv.gaussIntData2();
gauss_weights = gauss_integration_data(:, 3);
gauss_xi = gauss_integration_data(:, 1);
gauss_eta = gauss_integration_data(:, 2);

[~, ~, B] = slv.evalBXiEta(files, optProb, 1:N_triangles, ...
    gauss_xi, gauss_eta);

if problem_type == 2
    [r_gauss, ~] = slv.getXYFromXiEta(files, ...
        optProb, ...
        1:N_triangles, ...
        gauss_xi, ...
        gauss_eta);
    
    if any(any(r_gauss < 0))
        keyboard
    end
end

W_omega = 0;

for k = 1 : N_triangles
    
    
    xe = S.nodes(S.triangles(k,:),1);
    ye = S.nodes(S.triangles(k,:),2);
    
    det_J_gauss = slv.calcDetJXiEta(optProb, gauss_xi, gauss_eta, xe, ye);
    B_gauss = B(k,:);
    
    
    if S.isNonlinearMaterial(k) == 1
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
    else
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
    if isnan(W_omega)
        keyboard
    end
end

W = W_omega;
    
end



function W_elem = W_elem_nl_planar(...
    gauss_weights, ...
    B_gauss, ...
    BH_curve, ...
    det_J_gauss)

    B = B_gauss(:);
    det_J = det_J_gauss(:);
    weights = gauss_weights(:);

    N_gauss_points = length(weights);
    w_mag_gauss_points = zeros(N_gauss_points, 1);
    
    
    for k = 1 : N_gauss_points
        w_mag_gauss_points(k) = w_mag_nl(B(k), BH_curve);
    end
    
    % Depending on node-ordering, area of triangle can be negative due to
    % projection between isoparametric domain and real domain. 
    % In this case, the energy has to be multiplied by (-1).
    area_triangle = 1/2 * det_J' * gauss_weights;
    
    W_elem = 1/2 * (w_mag_gauss_points .* det_J)' * weights * ...
        sign(area_triangle);
    
    if W_elem < 0
        keyboard
    end
end

function W_elem = W_elem_nl_rotsym(...
    gauss_weights, ...
    B_gauss, ...
    BH_curve, ...
    det_J_gauss, ...
    r_gauss)

    B = B_gauss(:);
    r = r_gauss(:);
    det_J = det_J_gauss(:);
    weights = gauss_weights(:);

    N_gauss_points = length(weights);
    w_mag_gauss_points = zeros(N_gauss_points, 1);
    
    for k = 1 : N_gauss_points
        w_mag_gauss_points(k) = w_mag_nl(B(k), BH_curve);
    end
    
    area_triangle = 1/2 * det_J' * gauss_weights; 
    
    % Division by 2 from Gauss-integration already considered!
    W_elem = pi * (w_mag_gauss_points(k) .* det_J .* r)' * ...
        weights * sign(area_triangle);
    
    if W_elem < 0
        keyboard
    end
end

function W_elem = W_elem_lin_planar(...
    gauss_weights, ...
    mu_r_element, ...
    B_gauss, ...
    det_J_gauss)

    B = B_gauss(:);
    det_J = det_J_gauss(:);
    weights = gauss_weights(:);
    
    area_triangle = 1/2 * det_J' * gauss_weights;

    w_mag = 1/2 * B.^2 / (mu_r_element * 4e-7 * pi);
    W_elem = 1/2 * (w_mag .* det_J)' * weights * sign(area_triangle);
    
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

    B = B_gauss(:);
    r = r_gauss(:);
    det_J = det_J_gauss(:);
    weights = gauss_weights(:);
    
    area_triangle = 1/2 * (det_J)' * weights;
    w_mag = 1/2 * B.^2 / (mu_r_element * 4e-7 * pi);
    
    % Division by 2 from Gauss-integration already considered!
    W_elem = pi * (w_mag .* det_J .* r)' * weights * sign(area_triangle);
    
    if W_elem < 0
        keyboard
    end
end


function w = w_mag_nl(B, BH_curve)
    N_integration_points = 1000;
    
    
    H = B * slv.nuInterpolation(B, BH_curve);
    
    % Get equally spaced integration points
    H_integrate = logspace(log10(0.1), log10(H), N_integration_points);
    mu_interp = slv.muRInterpolation(H_integrate, BH_curve) * 4e-7 * pi;

    integrant = mu_interp .* H_integrate;
    
    w = H*B - trapz(H_integrate, integrant);
    if w < 0
        keyboard
    end
end

