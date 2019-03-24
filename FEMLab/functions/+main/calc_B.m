function calc_B(files, prob_opt)

disp('-Calculating magnetic field ...')
tic

slvr.calc_tri_B(files, prob_opt)
slvr.calc_weighted_B(files)

disp(['  Finished (Elapsed time : ', num2str(toc) ' s)'])