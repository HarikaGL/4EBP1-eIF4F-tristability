%% M10  Supplementary Table 3, Fig 7, Supplementary Fig 4 and the examples of Supplementary Fig 3: all parameters sampled together (Sections 2.9, 2.12, 2.13).
%  Ensembles (Methods 4.5; Supplementary Note 4), read from data/ensemble_samples.mat (the parameter sets used for the manuscript):
%    theta_fold2, theta_fold3, theta_fold10 : every primitive quantity within 2-, 3- or 10-fold of the reference set
%                                             (Latin hypercube sampling in 42 dimensions; p4e_prim, p4e_to_params);
%    exp_kf, exp_kb, exp_tot                : every quantity independently over its whole experimental range;
%    theta_scaffold                         : only the scaffold affinities K_D18, K_D19, K_D20 and the ratios
%                                             e4G_T/e4E_T, e4A_T/e4E_T over their measured ranges (10 000 sets).
%  Every set is thermodynamically consistent by construction (p4e_to_params). For every set the curve e4F against
%  kin_T is traced from 1 to 5000 nM and classified from its two axes (p4e_attribute, Section 2.9) by the number of
%  saddle-node points and the largest number of coexisting steady states (p4e_class4); a pair of saddle-node points
%  too close to give three steady states at any resolved kin_T counts as monostable, as in the manuscript.
%  Supplementary Fig 4 uses three classes: monostable, bistable and tristable (coexisting and separate loops together).
%  Output per ensemble: percent monostable, bistable, tristable with coexisting and with separate loops, and of the
%  reference type (tristable, coexisting, SN4 < SN2 < SN1 < SN3), with Wilson 95% intervals (Supplementary Table 3, Fig 7A, D);
%  widths of the range with at least three steady states and with three stable states coexisting (Fig 7C);
%  representative curves of each class (Fig 7B, Supplementary Fig 3); for every rate constant and total, Michaelis constant and
%  dissociation constant, the 5, 25, 50, 75 and 95th percentiles in each class (Supplementary Fig 4); the scaffold check of
%  Section 2.12 (200 random tristable sets of the <=3-fold ensemble, with and without the scaffold).
%  With FRESH = true new sets are drawn (p4e_sample_ensemble; not available for the experimental-range ensemble)
%  instead of reading the stored ones; the percentages then agree with Supplementary Table 3 within the sampling error.
%  Run time: about 93 000 continuations in total (roughly 0.5-1 s each in MATLAB). The loops use parfor, which runs
%  in parallel when the Parallel Computing Toolbox is available and as an ordinary loop otherwise. Choose ENS (e.g.
%  ENS = {'fold3'}) to run one ensemble, NMAX to run the first NMAX sets of each, or QUICK = true (200 sets each).
%  Output: printed, Results/M10_<ensemble>.mat, Results/M10_SuppTable3.csv.
clearvars -except QUICK ENS NMAX FRESH; here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e(); DATA = fullfile(here, '..', 'data');
if ~exist('ENS', 'var'), ENS = {'fold2', 'fold3', 'fold10', 'exp', 'scaffold'}; end
if exist('QUICK', 'var') && QUICK, NMAX = 200; end
if ~exist('NMAX', 'var'), NMAX = Inf; end
D = load(fullfile(DATA, 'ensemble_samples.mat')); P0 = p4e_ref();
fid = fopen(fullfile(RES, 'M10_SuppTable3.csv'), 'w');   % rewritten on every run
fprintf(fid, 'ensemble,sets,monostable %%,bistable %%,tristable coexisting %%,tristable separate %%,reference type %%\n');
for e = 1:numel(ENS)
    nm = ENS{e};
    switch nm
        case 'exp', n = size(D.exp_kf, 1); TH = nan(n, 1);
        otherwise
            TH = D.(['theta_' nm]);
            if exist('FRESH', 'var') && FRESH
                wd = struct('fold2', log10(2), 'fold3', log10(3), 'fold10', 1, 'scaffold', 0);
                kind = 'local'; if strcmp(nm, 'scaffold'), kind = 'scaffold'; end
                TH = p4e_sample_ensemble(kind, round(1.15*size(TH, 1)), D.theta_ref, wd.(nm), 11);
            end
            n = size(TH, 1);
    end
    n = min(n, NMAX); cls = cell(n, 1); ord = cell(n, 1); SN = nan(n, 4); w3 = nan(n, 1); w5 = nan(n, 1); V = nan(n, 49 + 16);
    parfor s = 1:n
        if strcmp(nm, 'exp')
            P = P0; P.kf = D.exp_kf(s, :); P.kb = D.exp_kb(s, :); P.tot = D.exp_tot(s, :);
        else
            P = p4e_to_params(TH(s, :));
        end
        [A, C] = p4e_attribute(P); c = p4e_class4(numel(A.SN_K), A.nSS);
        cls{s} = c; ord{s} = A.order; sn = nan(1, 4); k = min(4, numel(A.SN_K)); sn(1:k) = A.SN_K(1:k); SN(s, :) = sn;
        a3 = NaN; a5 = NaN; if ~isempty(C) && ~isempty(C.kin), [a3, a5] = p4e_widths(C, 1, 5000); end; w3(s) = a3; w5(s) = a5;
        Km = zeros(1, 8); KM = [1 2; 3 4; 9 10; 11 12; 5 6; 7 8; 13 14; 15 16];
        for q = 1:8, Km(q) = (P.kb(KM(q, 1)) + P.kf(KM(q, 2)))/P.kf(KM(q, 1)); end
        KD = [P.kf(17)/P.kb(17), P.kb(18:22)./P.kf(18:22)];
        V(s, :) = [P.kf, P.kb, P.tot, Km, KD, 0, 0];
    end
    isc = @(c) cellfun(@(x) strcmp(x, c), cls);
    nmono = sum(isc('mono')); nbi = sum(isc('bi')); ntri = sum(isc('tri')); nsep = sum(isc('sep'));
    nref = sum(isc('tri') & cellfun(@(x) strcmp(x, '4213'), ord));
    pc = @(k) sprintf('%.2f [%.1f, %.1f]', 100*k/n, p4e_wilson(k, n));
    fprintf('\n%s (%d sets): monostable %s; bistable %s; tristable coexisting %s; tristable separate %s; reference type %s (%d sets)\n', ...
            nm, n, pc(nmono), pc(nbi), pc(ntri), pc(nsep), pc(nref), nref);
    fprintf(fid, '%s,%d,%.2f,%.2f,%.2f,%.2f,%.2f\n', nm, n, 100*[nmono nbi ntri nsep nref]/n);
    q3 = p4e_prctile(w3(w3 > 0), [25 50 75]); q5 = p4e_prctile(w5(w5 > 0), [25 50 75]);
    fprintf('  width with >= 3 steady states: median %.1f nM (IQR %.1f-%.1f); three stable states coexisting: median %.1f nM (IQR %.1f-%.1f)\n', ...
            q3(2), q3(1), q3(3), q5(2), q5(1), q5(3));
    % Supplementary Fig 4: parameter distributions in each class
    vn = [arrayfun(@(i) sprintf('kf%d', i), 1:22, 'UniformOutput', false), arrayfun(@(i) sprintf('kb%d', i), 1:22, 'UniformOutput', false), ...
          {'e4E_T', 'BP_T', 'P_T', 'e4G_T', 'e4A_T'}, {'Km_K1', 'Km_K2', 'Km_K3', 'Km_K4', 'Km_P1', 'Km_P2', 'Km_P3', 'Km_P4'}, ...
          {'KD17', 'KD18', 'KD19', 'KD20', 'KD21', 'KD22'}, {'-', '-'}];
    Q = struct();
    grp = {'mono', isc('mono'); 'bi', isc('bi'); 'tristable', isc('tri') | isc('sep')};     % the three classes of Fig 11
    for g = 1:3
        if sum(grp{g, 2}) == 0, continue, end
        Q.(grp{g, 1}) = p4e_prctile(V(grp{g, 2}, :), [5 25 50 75 95]);
    end
    if isfield(Q, 'mono') && isfield(Q, 'tristable')
        for v = {'e4E_T', 'P_T', 'Km_K1', 'Km_P3'}
            j = find(strcmp(vn, v{1})); fprintf('  median %-6s monostable %.3g, tristable %.3g\n', v{1}, Q.mono(3, j), Q.tristable(3, j));
        end
    end
    % representative curves (Supplementary Fig 3, Fig 7B): the first five sets of each class
    EX = struct();
    for cc = {'mono', 'bi', 'sep', 'tri'}
        k = find(isc(cc{1}), 5); EX.(cc{1}) = cell(1, numel(k));
        for t = 1:numel(k)
            if strcmp(nm, 'exp'), P = P0; P.kf = D.exp_kf(k(t), :); P.kb = D.exp_kb(k(t), :); P.tot = D.exp_tot(k(t), :);
            else, P = p4e_to_params(TH(k(t), :)); end
            EX.(cc{1}){t} = p4e_trace(P);
        end
    end
    save(fullfile(RES, ['M10_' nm '.mat']), 'cls', 'ord', 'SN', 'w3', 'w5', 'V', 'vn', 'Q', 'EX', '-v7');
    % scaffold check (Section 2.12): 200 random tristable sets of the <=3-fold ensemble
    if strcmp(nm, 'fold3')
        it = find(isc('tri')); rng(3); it = it(randperm(numel(it), min(200, numel(it)))); up = nan(numel(it), 4);
        for t = 1:numel(it)
            P = p4e_to_params(TH(it(t), :)); Cw = p4e_trace(P, P.links, true); Co = p4e_trace(P, P.links, false);
            if numel(Cw.SN) == 4 && numel(Co.SN) == 4, up(t, :) = Cw.SN./Co.SN - 1; end
        end
        ok3 = ~isnan(up(:, 4)); a13 = abs(up(ok3, 1:3));
        fprintf('  scaffold check: SN4 raised in %d of %d tristable sets (median %.0f%%); SN1-SN3 moved by a median of %.2f%% (largest %.1f%%)\n', ...
                sum(up(:, 4) > 0), sum(ok3), 100*median(up(ok3, 4)), 100*median(a13(:)), 100*max(a13(:)));
    end
end
fclose(fid);
