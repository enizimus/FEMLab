function [dir_nodes, n_sys] = get_dirichlet_nodes(elements, elemsRegion, n_nodes, sRegions)
dir_nodes = zeros(1,n_nodes);
codes = sRegions.dir_codes;
for i=1:length(codes)
    indices = find( elemsRegion == codes(i) );
    for i_el=indices
        dir_nodes([elements(i_el).nodes]) = codes(i);
    end
end
n_sys = sum(dir_nodes == 0);
end