%close all
clear 

%% Electrostatic planar case : Charged sphere
% ----------------------------
load('..\sample_projects\charged_sphere\results\E_line_values.mat')
E_1d = Q;

load('..\sample_projects\charged_sphere\results\V_line_values_1Dy.mat')
V_1d = Q;

N = length(Q);
r = linspace(0, 1, N);
rc = 0.3;

E = vld.calc_exact_E(N, rc, 'sphere');
V = vld.calc_exact_V(N, rc, 'sphere');

fig = figure();
plot(r, E, 'LineWidth', 1.5)
hold on
grid on
plot(r, E_1d, 'LineWidth', 1.5)

title('Magnetostatic planar problem : Wire in plane R = 0.2')
xlabel('r [m]')
ylabel('|B| [T]') 
legend('B-exact', 'B-1D', 'B-2D')

fig = figure();
plot(r, V, 'LineWidth', 1.5)
hold on
grid on
plot(r, V_1d, 'LineWidth', 1.5)

title('Magnetostatic planar problem : Wire in plane R = 0.2')
xlabel('r [m]')
ylabel('V [V]') 
legend('V-exact', 'V-1D', 'V-2D')

print('C:\Users\museljic\Desktop\validation\Field_validation_Estatic_planar_1D_2D', '-dpdf', '-r300')

% -----------------------------

%% Electrostatic planar case : Simple capacitor
% ----------------------------
load('..\sample_projects\simple_capacitor\results\E_line_values_1D.mat')
E_1d = Q;
load('..\sample_projects\simple_capacitor\results\A_line_values_1D.mat')
V_1d = Q;
load('..\sample_projects\simple_capacitor\results\E_line_values_2D.mat')
E_2d = Q;
load('..\sample_projects\simple_capacitor\results\A_line_values_2D.mat')
V_2d = Q;

N = length(Q);
r = linspace(0, 1, N);

E = ones(N,1)*10e3;
V = linspace(0,10,N);

fig = figure();
plot(r, E, 'LineWidth', 1.5)
hold on
grid on
plot(r, E_1d, 'LineWidth', 1.5)
plot(r, E_2d, 'LineWidth', 1.5)

title('Electrostatic planar problem : Capacitor E-Field')
xlabel('y [m]')
ylabel('|E| [V/m]') 
legend('E-exact', 'E-1D', 'E-2D')

print('C:\Users\museljic\Desktop\validation\Field_validation_Estatic_planar_1D_2D_simple_capE', '-dpdf', '-r300')

fig = figure();
plot(r, V, 'LineWidth', 1.5)
hold on
grid on
plot(r, V_1d, 'LineWidth', 1.5)
plot(r, V_2d, 'LineWidth', 1.5)

title('Electrostatic planar problem : Capacitor potential')
xlabel('y [m]')
ylabel('V [V]') 
legend('V-exact', 'V-1D', 'V-2D')

print('C:\Users\museljic\Desktop\validation\Field_validation_Estatic_planar_1D_2D_simple_capV', '-dpdf', '-r300')

% -----------------------------
%% Magnetostatic planar case : 
% ----------------------------
load('..\sample_projects\wire_in_plane\results\B_line_values1Dfiner.mat')
B_1d = Q;
load('..\sample_projects\wire_in_plane\results\B_line_values2Dfiner.mat')
B_2d = Q;

N = length(Q);
r = linspace(0, 1, N);
rc = 0.2;

B = vld.calc_exact_B(N, rc, 'diag');

fig = figure();
plot(r, B, 'LineWidth', 1.5)
hold on
grid on
plot(r, B_1d, 'LineWidth', 1.5)
plot(r, B_2d, 'LineWidth', 1.5)

title('Magnetostatic planar problem : Wire in plane R = 0.2')
xlabel('r [m]')
ylabel('|B| [T]') 
legend('B-exact', 'B-1D', 'B-2D')

print('C:\Users\museljic\Desktop\validation\Field_validation_Mstatic_planar_1D_2D_finer_mesh', '-dpdf', '-r300')

% -----------------------------
%% Magnetostatic rotsym case : 
% ----------------------------
load('..\sample_projects\long_solenoid\results\B_line_values_1D.mat')
B_1d = Q;
load('..\sample_projects\long_solenoid\results\B_line_values.mat')
B_2d = Q;

N = length(Q);
r = linspace(0, 1, N);
rc = 0.2;

B = vld.calc_exact_B(N, rc, 'asd');

fig = figure();
plot(r, B, 'LineWidth', 1.5)
hold on
grid on
plot(r, B_1d, 'LineWidth', 1.5)
plot(r, B_2d, 'LineWidth', 1.5)

legend('B-exact', 'B-1D', 'B-2D')

print('C:\Users\museljic\Desktop\validation\Field_validation_Mstatic_rotsym_1D_2D_finer_mesh', '-dpdf', '-r300')
