function NLMagneticSolver(app)
close all
clc

if strcmp(app.settings.problemClass, app.MagnetostaticButton.Text)
    fprintf("Using nonlinear magnetic solver.\n")
    app.settings.isNonlinear = 1;
    solve(app);
    W = slv.calcWmagNL(app.files, app.settings);
    if strcmp(app.settings.symmetry, 'Axis symmetric')
        fprintf("Total magnetic energy is %e J\n", W);
    elseif strcmp(app.settings.symmetry, 'Axis symmetric')
        fprintf("Magnetig energy per unit length is %e J\n", W);
    end

else
    uialert(app.FEMLabUIFigure, ...
        "Solver can only be used for magnetostatic problems.", ...
        "Wrong problem type.")
end

end

function solve(app)
bgcolor = [169,169,169] / 255;


% Get hysteresis data
% Load here and not in updateMaterialData to avoid loading in every
% iteration
BHCurveData = jsondecode(fileread(fullfile("AppFiles", "nlSolverBHCurves", ...
    "muRCurves.json")));

% Prepare everything for solver-algorithm
nlSolverSetup(app);



% Iterate until solution converges
iteration_counter = 0;
converging = false;
while(~converging)
    
    fprintf("================================================================================\n")
    fprintf("                               Iteration %-5u\n", ...
        iteration_counter)
    fprintf("================================================================================\n")
    
    % Store data from previous iteration for termination condition.
    S = load(app.files.respth, "mu_r");
    mu_r_old = S.mu_r;
    save(app.files.respth, "mu_r_old", "-append");
    
    msh.prepFieldData(app.files, app.settings);
    updateMaterialData(app, BHCurveData);
    
    slv.calcA(app.files, app.settings);
    A = slv.evalA(app.files, app.settings);
    save(app.files.respth, 'A', '-append');
    slv.calcBH(app.files, app.settings);
    
    selectedButton = app.FieldTButtonGroup.SelectedObject;
    app.plotSettings.field = selectedButton.Text;
    
    [converging, delta_mu_r_rel] = convergenceCondition(app);
    
    figure()
    
    S = load(app.files.respth, "H_abs_mean", "triangles", "mu_r", "x", "y");
    mu = 4e-7 * pi * S.mu_r;
    [N_triangles, N_triangle_nodes] = size(S.triangles);
    xi_center = 1/3;
    eta_center = 1/3;
    
    
    
    if N_triangle_nodes == 3
        xi_nodes = [0,1,0];
        eta_nodes = [0,0,1];
        plot_node_idx = [1,2,3];
    elseif N_triangle_nodes == 6
        xi_nodes = [0,1,0,0.5,0.5,0];
        eta_nodes = [0,0,1,0,0.5,0.5];
        plot_node_idx = [1,4,2,5,3,6];
    else
        error('Unsupported element types')
    end
    
    
    [x_nodes, y_nodes] = slv.getXYFromXiEta(app.files, app.settings, 1:N_triangles, xi_nodes, eta_nodes);
    
    [x_center, y_center] = slv.getXYFromXiEta(app.files, app.settings, 1 : N_triangles, xi_center, eta_center);
    
    x_max = max(S.x);
    x_min = min(S.x);
    y_max = max(S.y);
    y_min = min(S.y);
    
    delta_y_axis = y_max - y_min;
    delta_x_axis = x_max - x_min;
    
    delta_axis_max = max([delta_y_axis, delta_x_axis]);
    
    x_lim_low = x_min;
    x_lim_up = x_min + delta_axis_max;
    
    y_lim_low = y_min;
    y_lim_up = y_min + delta_axis_max;
    
    B_abs_mean = S.H_abs_mean .* mu;
    
    subplot(221)
    hold on
    for k = 1 : N_triangles
        patch(x_nodes(k,plot_node_idx), y_nodes(k,plot_node_idx), ...
            ones(N_triangle_nodes, 1) * S.H_abs_mean(k), S.H_abs_mean(k))
    end
    scatter3(x_center, y_center, S.H_abs_mean, 10, S.H_abs_mean, 'filled')
    xlabel("x- or r-axis in m")
    ylabel("y- or z-axis in m")
    title(sprintf("H_{mean} per element, i = %d", iteration_counter))
    colorbar
    view(2)
    xlim([x_lim_low, x_lim_up])
    ylim([y_lim_low, y_lim_up])
    
    subplot(222)
    hold on
    for k = 1 : N_triangles
        patch(x_nodes(k,plot_node_idx), y_nodes(k,plot_node_idx), ...
            ones(N_triangle_nodes, 1) * B_abs_mean(k), B_abs_mean(k))
    end
    scatter3(x_center, y_center, B_abs_mean, 10, B_abs_mean, 'filled')
    xlabel("x- or r-axis in m")
    ylabel("y- or z-axis in m")
    title(sprintf("B_{mean} per element, i = %d", iteration_counter))
    colorbar
    view(2)
    xlim([x_lim_low, x_lim_up])
    ylim([y_lim_low, y_lim_up])
    
    
    subplot(223)
    hold on
    for k = 1 : N_triangles
        patch(x_nodes(k,plot_node_idx), y_nodes(k,plot_node_idx), ...
            ones(N_triangle_nodes, 1) * S.mu_r(k), S.mu_r(k))
    end
    scatter3(x_center, y_center, S.mu_r, 10, S.mu_r, 'filled')
    xlabel("x- or r-axis in m")
    ylabel("y- or z-axis in m")
    title(sprintf("|\\mu_r| per element, i = %d", iteration_counter))
    colorbar
    view(2)
    xlim([x_lim_low, x_lim_up])
    ylim([y_lim_low, y_lim_up])
    
    
    subplot(224)
    histogram(abs(delta_mu_r_rel) * 100)
    grid minor
    xlabel("\Delta \mu_{r,rel} in % ")
    title("Histogram of \Delta \mu_{r,rel}")
    
    iteration_counter = iteration_counter + 1;
    
end

gfx.display(app.files, app.settings, 'B', 'type', 'abstri',...
    'savePlot', false, 'fieldLinesOn', true, ...
    'nCont', app.plotSettings.nCont, 'res', app.plotSettings.res, 'format', app.plotSettings.format)



end

function nlSolverSetup(app)
ProjectData = load(app.files.respth);
nTriangles = length(ProjectData.triangles);

Ap = zeros(ProjectData.nNodes, 1);
mu_r_old = ones(nTriangles, 1);
mu_r = Inf * ones(nTriangles, 1);
isNonlinearMaterial = boolean(ones(nTriangles, 1));

save(app.files.respth, ...
    "Ap", ...
    "mu_r", ...
    "mu_r_old", ...
    "isNonlinearMaterial", ...
    '-append');

end

function updateMaterialData(app, material_data)
% \brief Caluclate mean-values of magnetic-flux-densities in single
%        elements and derive the relative permeability in each element
%        from B-H-curve of corresponding material curve.
%
%


S = load(app.files.respth, "x", ...          % x-coordinates of nodes (r-coordinate for rotation symmetric problems)
    "y", ...          % y-coordinates of nodes
    "Ap", ...         % Node potentials
    "triangles", ...  % Triangle nodes
    "regsTris", ...   % Region tags of triangles
    "regSet", ...     % Region data (material, source, ...)
    "mu_r" ...        % Relative permeability from previous iteration
    );


x_nodes = S.x;
y_nodes = S.y;
triangle_nodes = S.triangles;
[N_triangles, ~] = size(triangle_nodes);
triangle_region_tags = S.regsTris;
regions = S.regSet;
mu_r_old = S.mu_r;


% Calculate flux-density mean-values within each triangle
H_abs_mean = calculate_field_strength_means(app.files, app.settings, ...
    x_nodes, y_nodes, mu_r_old, triangle_nodes);

% =========== Derive relative permeability via material-curve =============
surface_regions = regions([regions.dim] == 2);
N_surface_regions = length(surface_regions);

mu_r = zeros(N_triangles, 1); % Allocation of material data
isNonlinearMaterial = boolean(zeros(N_triangles, 1));

for k = 1 : N_surface_regions
    current_region_tag = surface_regions(k).id;
    current_material_curve = surface_regions(k).matProp;
    BH_curve = material_data.data(current_material_curve);
    
    idx = triangle_region_tags == current_region_tag;
    tmp = slv.muRInterpolation(H_abs_mean(idx), BH_curve);
    if any(isnan(tmp))
        keyboard
    end
    
    if any(tmp < 0)
        keyboard
    end
    mu_r(idx) = tmp;
    
    if current_material_curve > 1
        isNonlinearMaterial(idx) = 1;
    end
end
save(app.files.respth, "mu_r", "H_abs_mean", "isNonlinearMaterial", "-append")
end

function H_abs_mean = calculate_field_strength_means(files, optProb, ...
    x_nodes, y_nodes, mu_r, triangle_nodes)

N_triangles = size(triangle_nodes, 1);
mu = 4e-7 * pi * mu_r;

if strcmp(optProb.symmetry, "Axis symmetric")
    problem_type = 2;
elseif strcmp(optProb.symmetry, "Plane symmetric")
    problem_type = 1;
else
    error("Unsupported problem type");
end

% Gauss-integration parameters
gauss_integration_data = slv.gaussIntData2();
gauss_weights = gauss_integration_data(:, 3);
gauss_xi = gauss_integration_data(:, 1);
gauss_eta = gauss_integration_data(:, 2);

% Get B-field magnitude in gauss-points
[~, ~, B] = slv.evalBXiEta(files, optProb, 1:N_triangles, ...
    gauss_xi, gauss_eta);

if any(B < 0, 'all')
    keyboard
end

% Get radius at Gauss-points required for integration in axissymmetric case
if problem_type == 2
    [r_gauss, ~] = slv.getXYFromXiEta(files, ...
        optProb, ...
        1:N_triangles, ...
        gauss_xi, ...
        gauss_eta);
end

% Allocat memory for caluclation results
B_abs_mean = zeros(N_triangles, 1);

for k = 1 : N_triangles
    % Element node coordinates.
    % In axissymmetric case: x-> r, y -> z
    xe = x_nodes(triangle_nodes(k,:));
    ye = y_nodes(triangle_nodes(k,:));
    
    det_J_gauss = slv.calcDetJXiEta(optProb, gauss_xi, gauss_eta, xe, ye);
    
    if problem_type == 1
        % Area of triangle
        area_triangle = 1 / 2 * det_J_gauss' * gauss_weights;
        
        % Integrated B-field magnitude
        B_int_k = 1 / 2 * (B(k,:) .* det_J_gauss)' * gauss_weights;
        
    elseif problem_type == 2
        area_triangle = 1 / 2 * (r_gauss(k,:)' .* det_J_gauss)' * gauss_weights;
        B_int_k = 1 / 2 * (B(k,:)' .* r_gauss(k,:)' .* det_J_gauss)' * gauss_weights;
    end
    
    % Mean value of B-field magnitude per triangle
    B_abs_mean(k) = B_int_k / area_triangle;
    
    
    
end

% Mean-value of H-field magnitude per triangle
H_abs_mean = B_abs_mean ./ mu;
end

function [ret, delta_mu_r_rel] = convergenceCondition(app)
S = load(app.files.respth, "mu_r_old", "mu_r", "isNonlinearMaterial");

mu_r = S.mu_r(S.isNonlinearMaterial);
mu_r_old = S.mu_r_old(S.isNonlinearMaterial);

delta_mu_r =  mu_r - mu_r_old;
delta_mu_r_rel = delta_mu_r ./ mu_r_old;
p = quantile(abs(delta_mu_r_rel), 0.95);
p_limit = 0.05;

fprintf("\nNL-solver stats:\n")
fprintf("----------------\n")
fprintf("\tp-quantile of |delta_mu_r_rel| = %5.2f %%\n", p*100)
fprintf("\t(Limit is %5.2f %%)\n\n",p_limit*100)


ret =  p < p_limit;
end

