function [t, F, y] = p4e_det_traj(P, kin, y0, tend)
%P4E_DET_TRAJ  Deterministic trajectory of the full ODEs (p4e_rhs) from y0 (17 states; [] = repressed state, all eIF4E
%   bound to unphosphorylated 4E-BP) for tend seconds. Returns time (s), e4F (nM) and the full state y (rows = times).
if isempty(y0), y0 = [zeros(16, 1); min(P.tot(1), P.tot(2))]; end
if exist('OCTAVE_VERSION', 'builtin')
    [t, y] = ode23s(@(tt, yy) p4e_rhs(yy, P, kin), [0 tend], y0(:), odeset('RelTol', 1e-6, 'AbsTol', 1e-8));
else
    [t, y] = ode15s(@(tt, yy) p4e_rhs(yy, P, kin), [0 tend], y0(:), odeset('RelTol', 1e-8, 'AbsTol', 1e-10));
end
F = y(:, 1);
end
