function compare_solutions(files, N, msh_opt, do_print, print_format)

if(nargin < 5 || isempty(print_format)), print_format = '-dpng'; end
if(nargin < 4 || isempty(do_print)), do_print = 0; end


% N - number of test points on diagonal test line

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

% #1 finding in which triangle the point is

% for i_lp = 1:N
%     xlp = xl(i_lp); ylp = yl(i_lp);
%     for i_tri=1:n_tri
%         x = [nodes(triangles(i_tri, :)).x];
%         y = [nodes(triangles(i_tri, :)).y];
%         
%         w1 = (x(1)*(y(3)-y(1))+(ylp-y(1))*(x(3)-x(1))-xlp*(y(3)-y(1)))/(...
%             (y(2)-y(1))*(x(3)-x(1))-(x(2)-x(1))*(y(3)-y(1)));
%         
%         w2 = (ylp-y(1)-w1*(y(2)-y(1)))/(y(3)-y(1));
%         
%         w12 = w1 + w2;
%         
%         if( w1 >= 0 && w2 >= 0 && w12 <= 1)
%             %plot(xlp,ylp,'m*')
%             B_fem(i_lp) = B(i_tri);
%             break;
%         end
%     end
% end

% #2 finding the nearest B point, if more than one with equal distance
% calculate the mean of their B-fields

% for i_lp = 1:N
%     xlp = xl(i_lp); ylp = yl(i_lp);
%     
%     d = sqrt((xlp - nodes_Bc(:,1)).^2 + ...
%         (ylp - nodes_Bc(:,2)).^2);
%     I = d == min(d);
%     
%     B_fem2(i_lp) = mean(B(I));
% end

B_exact = vld.calc_exact_B(N, xl, yl, r, 'diag', msh_opt);
[B_fem,~,~] = slvr.eval_B(files, xl, yl);
% abserr = [abs(B_exact - B_fem); abs(B_exact - B_fem2)];
abserr = abs(B_exact - B_fem');

figure
plot(r, B_exact, 'linewidth', 1.2)
hold on
grid on
plot(r, B_fem, 'linewidth', 1.2)
title({'Comparison : B field exact values and FEM values', ['N = ', num2str(N)]})
xlabel('r')
ylabel('|B| [T]')
legend('B-exact', 'B-FEM', 'location', 'eastoutside')
xlim([min(r) max(r)])
hold off

if(do_print)
    print(files.pltpth_valid1, print_format)
end

figure
p1 = plot(r, abserr, 'linewidth', 1.2);
grid on
title({'Absolute error between the exact field and the FEM values', ''})
xlabel('r')
ylabel('|B| [T]')
xlim([min(r) max(r)])
legend(p1, ['B-FEM err_sum = ', num2str(sum(abserr(1,:)))], ...
    'interpreter', 'none', 'location', 'southoutside')
hold off
if(do_print)
    print(files.pltpth_valid2, print_format)
end