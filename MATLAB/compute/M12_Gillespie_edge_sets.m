%% M12  Supplementary Figs 5 and 6 and Section 2.15: Gillespie simulations at the two edge sets of Fig 6, where the range in which
%       the three states coexist is narrowest: k_f8 x 8.94 (M1 switch) and k_f14 x 0.114 (M2 switch).
%  The two sets are the farthest tristable samples of Fig 6 (single-parameter samples of Fig 5, rebuilt with the
%  thermodynamic builder c08_build; log10 values of the sampled constant below).
%  For each set: 10 replicates (about 1 fL) for 20 h after a kinase step from the repressed state to a level inside
%  the range of State II, just above SN1 and far above SN1; and 10 replicates started in State II inside its range.
%  Reported: time to leave State I (30-min average above the midpoint between States I and II), and the dwell time in
%  State II (first time the 30-min average leaves the band between the midpoints I|II and II|III), the number of
%  escapes and the mean residence time (time in State II / escapes; with no escape the 95% lower bound, time / 3).
%  Deterministic times to leave State I over a range of kinase levels (panel B).
%  Run time: 80 replicates of 20 h (see M11 for the cost of one replicate); QUICK = true: 2 replicates of 10 min.
%  Output: printed, Results/M12_<set>.mat.
clearvars -except QUICK NREP TEND; here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e();
if ~exist('NREP', 'var'), NREP = 10; end
if ~exist('TEND', 'var'), TEND = 72000; end
if exist('QUICK', 'var') && QUICK, NREP = 2; TEND = 600; end
P0 = p4e_ref(); CYC = [1 2 7 8; 3 4 5 6; 9 10 15 16; 11 12 13 14];
SETS = {'kf8', 8, 0.09757518330159698, [126.3 230 400], 126.3, [126.3 150 215 230 300 400]; ...
        'kf14', 14, -1.564179239633466, [45.92 90 300], 45.92, [45.92 60 82 90 150 300]};
for s = 1:size(SETS, 1)
    [P, ok] = c08_build(P0, {'kf'}, SETS{s, 2}, SETS{s, 3}, CYC); C = p4e_trace(P);
    fprintf('\n%s x %.3g (admissible %d): SN1-SN4 = %s nM; State II exists for %.2f-%.2f nM\n', SETS{s, 1}, ...
            10^SETS{s, 3}/P0.kf(SETS{s, 2}), ok, sprintf('%.2f ', C.SN), C.SN(2), C.SN(3));
    R = struct('steps', {{}}, 'state', [], 'det', []);
    for k = SETS{s, 4}
        O = p4e_gillespie_runs(P, k, NREP, TEND, [], round(100*k) + 7*s);
        LI = p4e_branch_value(C, C.F, 1, k); LII = p4e_branch_value(C, C.F, 3, k);
        thr = 25.8; if ~isnan(LII), thr = (LI + LII)/2; end
        tl = p4e_time_to_leave(O.t, O.F, thr, 180); td = p4e_time_to_leave(O.tdet', O.Fdet', thr, 1);
        fprintf('  step to %g nM: left State I %d/%d', k, sum(~isnan(tl)), NREP);
        if any(~isnan(tl)), fprintf(' (%.1f-%.1f h, median %.1f h)', min(tl), max(tl), p4e_med(tl)); end
        fprintf('; deterministic %.1f h\n', td); O.tleave = tl; O.tdet_leave = td; R.steps{end+1} = O;
    end
    k = SETS{s, 5}; O = p4e_gillespie_runs(P, k, NREP, TEND, 3, 99 + s);
    LI = p4e_branch_value(C, C.F, 1, k); LII = p4e_branch_value(C, C.F, 3, k); LIII = p4e_branch_value(C, C.F, 5, k);
    lo = (LI + LII)/2; hi = (LII + LIII)/2; esc = nan(NREP, 1); dir = zeros(NREP, 1);
    for r = 1:NREP
        f = movmean(O.F(r, :), 180); i = find(f < lo | f > hi, 1);
        if ~isempty(i), esc(r) = O.t(i); dir(r) = sign(f(i) - LII); end
    end
    ttot = sum(min(esc, O.t(end)), 'omitnan') + sum(isnan(esc))*O.t(end);
    if any(~isnan(esc)), res = ttot/sum(~isnan(esc)); rtxt = sprintf('mean residence %.0f h', res);
    else, res = ttot/3; rtxt = sprintf('no escape; mean residence at least %.0f h (time/3)', res); end
    fprintf('  started in State II at %g nM (e4F %.0f nM): %d/%d left State II (to I: %d, to III: %d) after %s h; %s\n', k, LII, ...
            sum(~isnan(esc)), NREP, sum(dir < 0), sum(dir > 0), mat2str(sort(esc(~isnan(esc)))', 3), rtxt);
    O.escape = esc; O.direction = dir; O.residence = res; R.state = O;
    KD = SETS{s, 6}; THOR = 30*3600; if exist('QUICK', 'var') && QUICK, KD = KD(end); THOR = 5*3600; end
    TL = nan(size(KD));
    for i = 1:numel(KD), [t, F] = p4e_det_traj(P, KD(i), [], THOR); TL(i) = p4e_time_to_leave(t'/3600, F', 25.8, 1); end
    fprintf('  deterministic time to leave State I (h) at %s nM: %s\n', mat2str(KD), mat2str(TL, 3)); R.det = [KD; TL];
    R.C = C; R.P = P; save(fullfile(RES, ['M12_' SETS{s, 1} '.mat']), 'R', '-v7');
end
