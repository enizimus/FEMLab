function nu_sim = nuInterpolation(B_sim, BH_curve)

    B_curve = BH_curve.B;
    max_B_curve = max(B_curve);
    nu_curve = 1 ./ (4e-7 * pi * BH_curve.muR);

    % Use linear interpolation instead of spline, as for low-resulution
    % B/H-curves, over- and undershoots might occur in splines.
    % Tests showed that this can lead do limit cycles in the NL-solver.
    nu_sim = interp1(B_curve, nu_curve, B_sim);
    
    
    
    if any(B_sim > max_B_curve)
        % mu_r is extrapolated linearily
        k = (nu_curve(end) - nu_curve(end-1)) / ...
            (B_curve(end) - B_curve(end-1));
        
        d = nu_curve(end) - k * B_curve(end);
        
        idx = B_sim > max_B_curve;
        nu_sim(idx) = k * B_sim(idx) + d;
    end
end