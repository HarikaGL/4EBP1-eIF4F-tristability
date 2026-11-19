%% M11  Fig 12 and Section 5.1: Gillespie simulations at the reference set, kinase steps from the repressed state.
%  50 replicates (about 1 fL; Section 8.6, Table 7) at kin_T = 60, 95, 117 and 300 nM, each followed for 20 h, e4F
%  recorded every 10 s; deterministic trajectory from the same start. A replicate has left State I when its e4F,
%  averaged over 30 min, first exceeds 25.8 nM; it has reached State III when the average exceeds 160 nM.
%  Fig 12F: deterministic time to leave State I against kin_T, with the Gillespie medians.
%  Run time: each replicate has 1.5e8-6e8 reaction events (20 h); in MATLAB this is roughly 5-30 min per replicate,
%  i.e. one to two days for all 200 replicates on one core (the replicate loop is a parfor). NREP and TEND can be set
%  before running; QUICK = true runs 2 replicates of 10 min per level.
%  Output: printed, Results/M11_reference.mat (all trajectories).
clearvars -except QUICK NREP TEND; here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e();
if ~exist('NREP', 'var'), NREP = 50; end
if ~exist('TEND', 'var'), TEND = 72000; end
if exist('QUICK', 'var') && QUICK, NREP = 2; TEND = 600; end
P = p4e_ref(); C = p4e_trace(P); SN = C.SN; KINS = [60 95 117 300]; OUT = cell(1, numel(KINS));
for i = 1:numel(KINS)
    O = p4e_gillespie_runs(P, KINS(i), NREP, TEND, [], 1000*i);
    tl = p4e_time_to_leave(O.t, O.F, 25.8, min(180, size(O.F, 2))); t3 = p4e_time_to_leave(O.t, O.F, 160, min(180, size(O.F, 2)));
    td = p4e_time_to_leave(O.tdet', O.Fdet', 25.8, 1);
    fprintf('kin_T = %g nM: left State I %d/%d (%.1f-%.1f h, median %.1f h; deterministic %.1f h); reached State III %d/%d (%.1f-%.1f h)\n', ...
            KINS(i), sum(~isnan(tl)), NREP, min(tl), max(tl), p4e_med(tl), td, sum(~isnan(t3)), NREP, min(t3), max(t3));
    last = mean(O.F(:, max(1, end-359):end), 2); fprintf('    mean e4F over the last hour: %.0f-%.0f nM\n', min(last), max(last));
    O.tleave = tl; O.treach3 = t3; O.tdet_leave = td; OUT{i} = O;
end
%% Fig 12F: deterministic time to leave State I against kin_T
KD = [1.03*SN(1) 85 90 95 100 110 117 130 150 200 250 300 400 461]; THOR = 30*3600;
if exist('QUICK', 'var') && QUICK, KD = [300 461]; THOR = 5*3600; end
TL = nan(size(KD));
for i = 1:numel(KD), [t, F] = p4e_det_traj(P, KD(i), [], THOR); TL(i) = p4e_time_to_leave(t'/3600, F', 25.8, 1); end
fprintf('deterministic time to leave State I: %.1f h at %.1f nM (1.03 SN1) ... %.1f h at %g nM\n', TL(1), KD(1), TL(end), KD(end));
save(fullfile(RES, 'M11_reference.mat'), 'OUT', 'KINS', 'SN', 'KD', 'TL', '-v7');
