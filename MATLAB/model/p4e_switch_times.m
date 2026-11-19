function T = p4e_switch_times(P, fon, foff, tend)
%P4E_SWITCH_TIMES  Deterministic switching times of one parameter set (M13, Section "Switching time-scale").
%   The steady-state curve is traced and classified (p4e_attribute, p4e_class4). With SN_hi the highest and SN_lo the
%   lowest saddle-node point:
%     switch on : from the repressed state (all eIF4E bound to unphosphorylated 4E-BP) at kin_T = fon*SN_hi, the time
%                 at which e4F reaches half of its steady-state value there (the value on the last branch of the
%                 curve, from the continuation);
%     switch off: from the end of that trajectory, kin_T is lowered to SN_lo/foff; the time at which e4F has fallen
%                 half-way from its starting value to the steady state there (first branch of the curve).
%   A time is NaN if the trajectory has not crossed half-way by tend, or if the set has no measurable eIF4F switch (e4F of
%   the active state below 1 nM or less than twice that of the repressed state; T.cls then ends in '-flat'). Each ODE run uses ode15s (RelTol 1e-6, AbsTol 1e-9,
%   enough for times in minutes) and is stopped after WALL = 60 s of computing time, so that a single very stiff
%   parameter set cannot hold up a whole parfor loop; a run stopped this way gives NaN.
%   Defaults fon = foff = 2 (a two-fold step beyond the threshold), tend = 100 h. Times in minutes.
%   T.cls ('mono','bi','sep','tri','other'), T.SN (curve order), T.on, T.off (min), T.Fon, T.Foff (final e4F, nM).
if nargin < 2 || isempty(fon), fon = 2; end
if nargin < 3 || isempty(foff), foff = 2; end
if nargin < 4 || isempty(tend), tend = 100*3600; end
T = struct('cls', 'fail', 'SN', [], 'on', NaN, 'off', NaN, 'Fon', NaN, 'Foff', NaN, 'kon', NaN, 'koff', NaN);
try
    [A, C] = p4e_attribute(P);
catch
    return
end
if isempty(A.SN_K) || isempty(C), T.cls = 'mono'; return, end
T.cls = p4e_class4(numel(A.SN_K), A.nSS); T.SN = A.SN_K(:)';
T.kon = fon*max(A.SN_K); T.koff = min(A.SN_K)/foff;
nseg = numel(C.folds) + 1;
Fhi = p4e_branch_value(C, C.F, nseg, T.kon); Flo = p4e_branch_value(C, C.F, 1, T.koff);
if isnan(Fhi) || isnan(Flo), return, end
if ~(Fhi > 1 && Fhi > 2*Flo), T.cls = [T.cls '-flat']; return, end   % no measurable eIF4F switch (active state < 1 nM or < 2x repressed)
try
    [t, F, y] = traj(P, T.kon, [], tend);
    T.Fon = F(end); T.on = first_cross(t, F, 0.5*Fhi, +1)/60;
    if isnan(T.on) || t(end) < 0.99*tend || F(end) < 0.5*Fhi, return, end   % active state not reached: no switch-off time
    [t2, F2] = traj(P, T.koff, y(end, :)', tend);
    if t2(end) < 0.99*tend, return, end
    T.Foff = F2(end); T.off = first_cross(t2, F2, F2(1) - 0.5*(F2(1) - Flo), -1)/60;
catch
end
end

function tc = first_cross(t, F, thr, dirn)
if dirn > 0, i = find(F >= thr, 1); else, i = find(F <= thr, 1); end
if isempty(i) || i == 1, tc = NaN;           % never crossed, or already past half-way at t = 0: no transition timed
else, tc = t(i-1) + (thr - F(i-1))*(t(i) - t(i-1))/(F(i) - F(i-1)); end
end

function [t, F, y] = traj(P, kin, y0, tend)
% ode15s with a wall-clock limit (see above); y0 = [] is the repressed state
WALL = 60;
if isempty(y0), y0 = [zeros(16, 1); min(P.tot(1), P.tot(2))]; end
t0 = tic; stopfun = @(tt, yy, flag) toc(t0) > WALL;
opt = odeset('RelTol', 1e-6, 'AbsTol', 1e-9, 'OutputFcn', stopfun);
if exist('OCTAVE_VERSION', 'builtin')
    [t, y] = ode23s(@(tt, yy) p4e_rhs(yy, P, kin), [0 tend], y0(:), opt);
else
    [t, y] = ode15s(@(tt, yy) p4e_rhs(yy, P, kin), [0 tend], y0(:), opt);
end
F = y(:, 1);
end
