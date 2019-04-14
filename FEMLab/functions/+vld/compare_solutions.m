function compare_solutions(files, N, prob_opt, msh_opt, do_print, print_format)

if(nargin < 6 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 5 || isempty(do_print)), do_print = 0; end

load(files.respth, 'xlims', 'ylims')

if(strcmp(prob_opt.class, 'Mstatic'))
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
        yl = ones(size(xl))*(ylims(2)/2);
    end
    
    B_exact = vld.calc_exact_B(N, xl, yl, r, prob_opt.valid, msh_opt);
    [B_fem,~,~] = slv.eval_B(files, xl, yl);
    B_ef = vld.get_elefant_B('long_solenoid_0515');
    
    % abserr_fem = abs(B_exact - B_fem);%./B_exact * 100;
    % abserr_elf = abs(B_exact - B_ef);
    %
    % errsum_fem = sum(abserr_fem);
    % errsum_elf = sum(abserr_elf);
    
    figure
    plot(r, B_exact, 'linewidth', 1.2)
    hold on
    grid on
    plot(r, B_fem, 'linewidth', 1.2)
    % plot(r, B_ef, 'linewidth', 1.2)
    title({'Comparison : B field exact values and FEM values', ['N = ', num2str(N)]})
    xlabel('r')
    ylabel('|B| [T]')
    legend('B-Exact', 'B-FEM', 'B-Elefant', 'location', 'eastoutside')
    xlim([min(r) max(r)])
    hold off
    
    if(do_print)
        print(files.pltpth_valid1, print_format)
    end
    
    % figure
    % plot(r, abserr_fem, 'linewidth', 1.2);
    % hold on
    % grid on
    % plot(r, abserr_elf, 'linewidth', 1.2);
    % title({'Relative error between the exact field and the FEM values', ''})
    % xlabel('r')
    % ylabel('Error [%]')
    % xlim([min(r) max(r)])
    % legend(['B-FEM errsum = ' num2str(errsum_fem)],...
    %     ['B-Elefant errsum = ' num2str(errsum_elf)])
    % hold off
    % if(do_print)
    %     print(files.pltpth_valid2, print_format)
    % end
    
    
    
    
else % electrostatic case validation, uniformly charged sphere
    xl = linspace(0, 1, N);
    yl = xl;
    r = sqrt(xl.^2 + yl.^2);
    
    E_exact = vld.calc_exact_E(N, r);
    E_fem = slv.calc_E(files, )
    
    figure
    plot(r, E_exact, 'linewidth', 1.2)
    hold on
    grid on
    plot(r, E_fem, 'linewidth', 1.2)
    % plot(r, B_ef, 'linewidth', 1.2)
    title({'Comparison : B field exact values and FEM values', ['N = ', num2str(N)]})
    xlabel('r')
    ylabel('|B| [T]')
    legend('B-Exact', 'B-FEM', 'B-Elefant', 'location', 'eastoutside')
    xlim([min(r) max(r)])
    hold off
    
    if(do_print)
        print(files.pltpth_valid1, print_format)
    end
end

