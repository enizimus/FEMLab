function mu_r_sim = muRInterpolation(H_sim, BH_curve)

    H_curve = BH_curve.H;
    max_H_curve = max(H_curve);
    mu_r_curve = BH_curve.muR;

    % Use linear interpolation instead of spline, as for low-resulution
    % B/H-curves, over- and undershoots might occur in splines.
    % Tests showed that this can lead do limit cycles in the NL-solver.
    mu_r_sim = interp1(H_curve, mu_r_curve, H_sim);
    
    
    
    if any(H_sim > max_H_curve)
        % mu_r is extrapolated linearily
        k = (mu_r_curve(end) - mu_r_curve(end-1)) / ...
            (H_curve(end) - H_curve(end-1));
        
        d = mu_r_curve(end) - k * H_curve(end);
        
        idx = H_sim > max_H_curve;
        mu_r_sim(idx) = k * H_sim(idx) + d;
        if any(mu_r_sim < 0)
            %keyboard
        end
        mu_r_sim(mu_r_sim < 0) = 1;
    end
end