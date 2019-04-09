function compare_solutions(files, N, prob_opt, msh_opt, do_print, print_format)

if(nargin < 6 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 5 || isempty(do_print)), do_print = 0; end

if(strcmp(prob_opt.type, 'planar'))
    if(strcmp(msh_opt.edge, 'circ'))
        msh_r = 0.5; % radius of circular mesh
        phi = pi/4;
        r = linspace(0, msh_r, N);
        xl = r*cos(phi);
        yl = r*sin(phi);
    elseif(strcmp(msh_opt.edge, 'rect'))
        xl = linspace(0, 1, N);
        yl = xl;
        r = sqrt(xl.^2 + yl.^2);
    end
else
    
    xl = linspace(0, 2, N);
    r = xl;
    yl = ones(size(xl));
end

B_exact = vld.calc_exact_B(N, xl, yl, r, prob_opt.valid, msh_opt);
[B_fem,~,~] = slv.eval_B(files, xl, yl);

abserr = abs(B_exact - B_fem)./B_exact * 100;

figure
plot(r, B_exact, 'linewidth', 1.2)
hold on
grid on
plot(r, B_fem, 'linewidth', 1.2)
title({'Comparison : B field exact values and FEM values', ['N = ', num2str(N)]})
xlabel('r')
ylabel('|B| [T]')
legend('B-exact', 'B-FEM', 'B-elefant', 'location', 'eastoutside')
xlim([min(r) max(r)])
hold off

if(do_print)
    print(files.pltpth_valid1, print_format)
end

figure
p1 = plot(r, abserr, 'linewidth', 1.2);
grid on
title({'Relative error between the exact field and the FEM values', ''})
xlabel('r')
ylabel('Error [%]')
xlim([min(r) max(r)])
legend(p1, ['B-FEM err_sum = ', num2str(sum(abserr(1,:)))], ...
    'interpreter', 'none', 'location', 'southoutside')
hold off
if(do_print)
    print(files.pltpth_valid2, print_format)
end