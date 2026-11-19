function O = p4e_gillespie_runs(P, kin, NREP, TEND, start, seed0)
%P4E_GILLESPIE_RUNS  NREP Gillespie replicates (p4e_ssa) at total kinase kin for TEND seconds, e4F recorded every 10 s.
%   start = [] : all replicates start from the repressed state (all eIF4E bound to unphosphorylated 4E-BP);
%   start = j  : they start from the deterministic steady state on branch segment j of the curve (3 = State II).
%   The volume is about 1 fL, adjusted so that the number of kinase molecules is an integer at exactly kin.
%   The replicate loop is a parfor (parallel with the Parallel Computing Toolbox, an ordinary loop otherwise).
%   O.F: e4F (nM), replicates x time points; O.t: time (h); O.vol: volume (fL); O.tdet, O.Fdet: deterministic trajectory.
NA = 6.02214076e23; DT = 10; nk = round(kin*NA*1e-24); vol = nk/(kin*NA*1e-24); fac = NA*vol*1e-24;
if isempty(start), y0 = []; else, C = p4e_trace(P); y0 = p4e_branch_state(C, P, kin, start); end
x0 = p4e_initial_counts(P, kin, vol, y0); nT = floor(TEND/DT) + 1; F = zeros(NREP, nT);
parfor r = 1:NREP
    R = p4e_ssa(P, kin, vol, x0, TEND, DT, seed0 + r); f = zeros(1, nT); f(1:size(R, 1)) = double(R(:, 23))'/fac; F(r, :) = f;
end
O.kin = kin; O.vol = vol; O.F = F; O.t = (0:nT-1)*DT/3600; [td, Fd] = p4e_det_traj(P, kin, y0, TEND); O.tdet = td/3600; O.Fdet = Fd;
end
