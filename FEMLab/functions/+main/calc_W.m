function calc_W(files, region)
load(files.respth, 'B', 'elements', 'elements_r', 'n_elemenets', 'elem_offset')

for i_e = elem_offset:n_elements
    if(elements_r(i_e) == region)
        W = W + 1/2*mean(B([elements(i_e).nodes]));