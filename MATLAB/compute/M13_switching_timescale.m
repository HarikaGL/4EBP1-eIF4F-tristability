%% M13  Switching time-scale (Results, Section 2.8 "The switches can act within minutes"; Methods 4.7;
%  Supplementary Fig 8).
%  Question: can the switches act in minutes, as mTORC1 inhibition does in cells, with every constant inside its
%  admissible range, Eq (1) satisfied, and tristability kept?
%
%  Switching times (model/p4e_switch_times.m). With SN_hi the highest and SN_lo the lowest saddle-node point of a set:
%    switch on : from the repressed state at kin_T = 2 SN_hi, the time at which e4F reaches half of the e4F of the
%                active steady state there;
%    switch off: from the end of that run, kin_T lowered to SN_lo/2, the time at which e4F has fallen half-way to the
%                e4F of the repressed steady state there.
%  Each ODE run lasts TEND hours (default 24) and is stopped after 60 s of computing time; a set that has not
%  switched by then gets NaN ("not switching"). Sets whose active state has e4F < 1 nM or < 2 x the repressed e4F have
%  no measurable eIF4F switch: they are counted and left out.
%
%  A. Reference set. The turnover numbers of both enzymes of PdP cycles 1 and 3 (which contain the slow first
%     catalytic steps R2 and R10) are multiplied by lambda = 1, 2, 5, 10, 20, 40, 100, keeping every Michaelis constant
%     (k_b of the enzyme-substrate complex lowered) and Gamma (model/p4e_speedup.m); cycles 2 and 4 are already fast
%     and are left unchanged. lambda is capped by the admissible ranges (k_b >= 1e-3 s^-1, k_cat <= 31.6 s^-1), at
%     38.6 for cycle 1 and 21.7 for cycle 3. Printed: thresholds and switching times for each lambda.
%  B. Ensembles. Every tristable set (coexisting or separate loops; classes from Results/M10_<ensemble>.mat, else
%     recomputed) of the <=2-, <=3- and <=10-fold ensembles and of the experimental-range ensemble is timed.
%     Printed per ensemble: number timed, without a measurable switch, not switching within TEND; medians and 5-95%
%     ranges of the two times; number and percentage switching both ways within 30 and 60 min; the fastest set.
%  C. Search. From the reference set and the fastest tristable sets of part B, an adaptive random walk in the 42
%     primitive quantities (model/p4e_prim.m; every value inside its admissible range, Eq (1) imposed by
%     p4e_to_params) accepts a step if the set stays tristable with a measurable switch and the slower of its two
%     switching times decreases. Printed: the ten fastest sets found and the quantities that changed most.
%
%  Options (set before running; defaults in brackets):
%    PARTS ('ABC')   which parts to run; part C needs part B (it is run automatically).
%    ENS   ({'fold2','fold3','fold10','exp'})   ensembles of part B (part C uses fold2, fold3 and fold10 if present).
%    NSUB  (Inf)     time a random sample of NSUB tristable sets per ensemble instead of all of them.
%    TEND  (24)      hours per ODE run.
%    NSEED (20)      starting sets of part C (the reference set plus the NSEED-1 fastest sets of part B).
%    NIT   (200)     steps per search chain.
%    RESUME (false)  if true, ensembles of part B already saved in Results/M13_B_<ensemble>.mat are loaded, not redone.
%    QUICK (false)   test mode: lambda = 1 and 10, 20 sets per ensemble, 2 chains of 5 steps.
%  Run time with 64 workers (MATLAB): A a few minutes (serial); B about 1 h per 10 000 sets; C about NIT x 10 s.
%  Output: printed and copied to Results/M13_log.txt; Results/M13_timescale.mat (all parts, saved after each part);
%  Results/M13_B_<ensemble>.mat (each ensemble of part B as soon as it is done); Results/M13_timescale.csv (sets found
%  by the search); Results/M13_timescale.png and .pdf (Supplementary Fig 8; figures/SuppFig8_switching_timescale.m redraws it).
%  Run on the server, for example:  matlab -batch "parpool; M13_switching_timescale"
clearvars -except QUICK NSEED NIT PARTS NSUB TEND ENS RESUME
here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e(); DATA = fullfile(here, '..', 'data');
if ~exist('QUICK', 'var'), QUICK = false; end
if ~exist('PARTS', 'var'), PARTS = 'ABC'; end
if ~exist('ENS', 'var'), ENS = {'fold2', 'fold3', 'fold10', 'exp'}; end
if ~exist('NSUB', 'var'), NSUB = Inf; end
if ~exist('TEND', 'var'), TEND = 24; end
if ~exist('NSEED', 'var'), NSEED = 20; end
if ~exist('NIT', 'var'), NIT = 200; end
if ~exist('RESUME', 'var'), RESUME = false; end
if QUICK, NSEED = 2; NIT = 5; end
if any(PARTS == 'C') && ~any(PARTS == 'B'), PARTS = [PARTS 'B']; end
TE = TEND*3600;
diary(fullfile(RES, 'M13_log.txt')); diary on
fprintf('M13 started %s; PARTS %s; ensembles %s; NSUB %g; TEND %g h; NSEED %d; NIT %d\n', datestr(now), PARTS, ...
        strjoin(ENS, ','), NSUB, TEND, NSEED, NIT);
P0 = p4e_ref(); D = load(fullfile(DATA, 'ensemble_samples.mat')); OUT = struct('TEND', TEND, 'NSUB', NSUB);
outfile = fullfile(RES, 'M13_timescale.mat');

%% A. reference set: cycles 1 and 3 faster, Michaelis constants and Gamma kept
if any(PARTS == 'A')
    tA = tic; LAM = [1 2 5 10 20 40 100]; if QUICK, LAM = [1 10]; end
    [~, cap] = p4e_speedup(P0, 1e6);
    fprintf('\nA. Reference set. Largest factor admissible for each PdP cycle (Michaelis constants kept): %s\n', sprintf('%.3g  ', cap));
    fprintf('   only cycles 1 and 3 are made faster (cycles 2 and 4 already turn over fast)\n');
    A = struct('lam', LAM, 'applied', nan(numel(LAM), 4), 'cls', {cell(numel(LAM), 1)}, 'SN', nan(numel(LAM), 4), ...
               'on', nan(numel(LAM), 1), 'off', nan(numel(LAM), 1));
    for i = 1:numel(LAM)
        [Q, l] = p4e_speedup(P0, [LAM(i) 1 LAM(i) 1]); T = p4e_switch_times(Q, 2, 2, TE);
        A.applied(i, :) = l; A.cls{i} = T.cls; k = min(4, numel(T.SN)); A.SN(i, 1:k) = T.SN(1:k); A.on(i) = T.on; A.off(i) = T.off;
        fprintf('   lambda %5g (applied %s): %-4s SN = %s nM; on %.1f min, off %.1f min\n', LAM(i), mat2str(l, 3), T.cls, ...
                sprintf('%.1f ', T.SN), T.on, T.off);
    end
    dsn = 100*max(abs(A.SN./A.SN(1, :) - 1), [], 2);
    fprintf('   largest change of a threshold relative to lambda = 1: %s %%\n', sprintf('%.2f ', dsn));
    fprintf('   part A done in %.1f min\n', toc(tA)/60);
    OUT.A = A; save(outfile, 'OUT', '-v7');
end

%% B. every tristable set of the ensembles
if any(PARTS == 'B')
    B = struct();
    for e = 1:numel(ENS)
        nm = ENS{e}; fe = fullfile(RES, ['M13_B_' nm '.mat']);
        if RESUME && exist(fe, 'file')
            S = load(fe); B.(nm) = S.b; fprintf('\nB. %s: loaded from %s\n', nm, fe); p4e_m13_report(nm, S.b); continue
        end
        if strcmp(nm, 'exp'), n = size(D.exp_kf, 1); TH = []; else, TH = D.(['theta_' nm]); n = size(TH, 1); end
        f = fullfile(RES, ['M10_' nm '.mat']);
        if exist(f, 'file'), S = load(f, 'cls'); idx = find(strcmp(S.cls, 'tri') | strcmp(S.cls, 'sep'));
        else, idx = (1:n)'; fprintf('   (Results/M10_%s.mat not found: every set is classified here)\n', nm); end
        if QUICK, idx = idx(1:min(20, numel(idx))); end
        if numel(idx) > NSUB, rng(7); idx = sort(idx(randperm(numel(idx), NSUB))); end
        m = numel(idx); on = nan(m, 1); off = nan(m, 1); cl = cell(m, 1); SN = nan(m, 4);
        fprintf('\nB. %s: timing %d tristable sets (started %s) ...\n', nm, m, datestr(now, 'HH:MM')); tB = tic;
        isexp = strcmp(nm, 'exp');
        parfor j = 1:m
            s = idx(j);
            if isexp, P = P0; P.kf = D.exp_kf(s, :); P.kb = D.exp_kb(s, :); P.tot = D.exp_tot(s, :);
            else, P = p4e_to_params(TH(s, :)); end
            T = p4e_switch_times(P, 2, 2, TE); cl{j} = T.cls; on(j) = T.on; off(j) = T.off;
            sn = nan(1, 4); k = min(4, numel(T.SN)); sn(1:k) = T.SN(1:k); SN(j, :) = sn;
        end
        fprintf('   done in %.1f min\n', toc(tB)/60);
        flat = ~cellfun(@isempty, strfind(cl, '-flat'));
        keep = strcmp(cl, 'tri') | strcmp(cl, 'sep');
        b = struct('idx', idx(keep), 'on', on(keep), 'off', off(keep), 'cls', {cl(keep)}, 'SN', SN(keep, :), ...
                   'ntimed', m, 'nflat', sum(flat), 'nother', sum(~keep & ~flat));
        B.(nm) = b; save(fe, 'b', '-v7'); p4e_m13_report(nm, b);
        OUT.B = B; save(outfile, 'OUT', '-v7');
    end
end

%% C. adaptive random search for fast tristable sets
if any(PARTS == 'C')
    tC = tic; [names, bnd] = p4e_prim(); np = numel(names);
    src = intersect({'fold2', 'fold3', 'fold10'}, fieldnames(B), 'stable');
    cand = [];   % [ensemble number in src, row, slower time]
    for e = 1:numel(src)
        b = B.(src{e}); sl = max(b.on, b.off); sl(isnan(b.on) | isnan(b.off)) = NaN;   % max() ignores NaN
        cand = [cand; e*ones(numel(b.idx), 1), b.idx, sl]; %#ok<AGROW>
    end
    cand = cand(~isnan(cand(:, 3)), :); [~, o] = sort(cand(:, 3)); cand = cand(o(1:min(NSEED - 1, numel(o))), :);
    TH0 = D.theta_ref(:)'; lab = {'reference'};
    for c = 1:size(cand, 1)
        TH0(end+1, :) = D.(['theta_' src{cand(c, 1)}])(cand(c, 2), :); %#ok<SAGROW>
        lab{end+1} = sprintf('%s #%d', src{cand(c, 1)}, cand(c, 2)); %#ok<SAGROW>
    end
    ns = size(TH0, 1); best = nan(ns, np); bestT = nan(ns, 1); bestSN = nan(ns, 4); beston = nan(ns, 1); bestoff = nan(ns, 1);
    bestcls = cell(ns, 1); start = nan(ns, 1); nacc = zeros(ns, 1);
    fprintf('\nC. Search: %d chains of %d steps (started %s) ...\n', ns, NIT, datestr(now, 'HH:MM'));
    parfor c = 1:ns
        th = TH0(c, :); P = p4e_to_params(th); T = p4e_switch_times(P, 2, 2, TE); f = max(T.on, T.off); if isnan(T.off), f = NaN; end; start(c) = f;
        if isnan(f), f = Inf; end
        sig = 0.15; rng(100 + c); acc = 0;
        for it = 1:NIT
            tq = th + sig*randn(1, np); tq = min(max(tq, bnd(:, 1)'), bnd(:, 2)');
            [Pq, ok] = p4e_to_params(tq); if ~ok, sig = max(0.02, sig*0.98); continue, end
            Tq = p4e_switch_times(Pq, 2, 2, TE); fq = max(Tq.on, Tq.off); if isnan(Tq.on) || isnan(Tq.off), fq = NaN; end
            if any(strcmp(Tq.cls, {'tri', 'sep'})) && ~isnan(fq) && fq < f
                th = tq; f = fq; T = Tq; acc = acc + 1; sig = min(0.5, sig*1.2);
            else
                sig = max(0.02, sig*0.98);
            end
        end
        best(c, :) = th; bestT(c) = f; beston(c) = T.on; bestoff(c) = T.off; bestcls{c} = T.cls; nacc(c) = acc;
        sn = nan(1, 4); k = min(4, numel(T.SN)); sn(1:k) = T.SN(1:k); bestSN(c, :) = sn;
        fprintf('   chain %2d done: slower time %.1f -> %.1f min (%d steps accepted)\n', c, start(c), f, acc);
    end
    [~, o] = sort(bestT);
    fprintf('\nC. Fastest tristable sets found (%d chains, %d steps each; done in %.1f min):\n', ns, NIT, toc(tC)/60);
    fprintf('   %-16s %-5s %10s %10s %10s   %s\n', 'start', 'class', 'start min', 'on (min)', 'off (min)', 'SN1-SN4 (nM)');
    for r = o(1:min(10, ns))'
        fprintf('   %-16s %-5s %10.1f %10.1f %10.1f   %s\n', lab{r}, bestcls{r}, start(r), beston(r), bestoff(r), sprintf('%.1f ', bestSN(r, :)));
    end
    d = best(o(1:min(5, ns)), :) - TH0(o(1:min(5, ns)), :); [~, j] = sort(mean(abs(d), 1), 'descend');
    fprintf('   largest changes from the start (log10 units, mean over the five fastest): %s\n', ...
            strjoin(arrayfun(@(i) sprintf('%s %+.2f', names{i}, mean(d(:, i))), j(1:8), 'UniformOutput', false), ', '));
    OUT.C = struct('theta', best, 'theta0', TH0, 'start', start, 'label', {lab}, 'slow', bestT, 'on', beston, ...
                   'off', bestoff, 'cls', {bestcls}, 'SN', bestSN, 'accepted', nacc, 'names', {names});
    fid = fopen(fullfile(RES, 'M13_timescale.csv'), 'w');
    fprintf(fid, 'start,class,start_min,on_min,off_min,SN1,SN2,SN3,SN4,%s\n', strjoin(names, ','));
    for r = o'
        fprintf(fid, '"%s",%s,%.2f,%.2f,%.2f,%s%s\n', lab{r}, bestcls{r}, start(r), beston(r), bestoff(r), ...
                sprintf('%.3f,', bestSN(r, :)), strjoin(arrayfun(@(x) sprintf('%.5f', x), best(r, :), 'UniformOutput', false), ','));
    end
    fclose(fid);
    save(outfile, 'OUT', '-v7');
end

%% figure (Supplementary Fig 8)
fig = figure('Color', 'w', 'Position', [50 50 1050 430]);
if isfield(OUT, 'A')
    subplot(1, 2, 1); loglog(OUT.A.lam, OUT.A.on, '-o', OUT.A.lam, OUT.A.off, '-s', 'LineWidth', 1.5); hold on
    plot([0.8 150], [30 30], 'k:'); xlim([0.8 150]);
    xlabel('\lambda (turnover of cycles 1 and 3, capped at 38.6 and 21.7)'); ylabel('time (min)');
    legend('switch on (to 2 SN_{hi})', 'switch off (to SN_{lo}/2)', '30 min', 'Location', 'northeast');
    title('A  reference set, K_m and \Gamma kept');
end
if isfield(OUT, 'B')
    subplot(1, 2, 2); hold on; nmB = fieldnames(OUT.B); col = lines(numel(nmB)); h = [];
    for e = 1:numel(nmB)
        b = OUT.B.(nmB{e}); h(end+1) = plot(b.on, b.off, '.', 'Color', col(e, :), 'MarkerSize', 5); %#ok<SAGROW>
    end
    lg = nmB;
    if isfield(OUT, 'C'), h(end+1) = plot(OUT.C.on, OUT.C.off, 'kp', 'MarkerFaceColor', 'y', 'MarkerSize', 9); lg{end+1} = 'search'; end
    set(gca, 'XScale', 'log', 'YScale', 'log'); yl = ylim; xl = xlim;
    plot([30 30], yl, 'k:'); plot(xl, [30 30], 'k:');
    xlabel('switch on (min)'); ylabel('switch off (min)'); legend(h, lg, 'Location', 'northwest');
    title('B  tristable sets of the ensembles'); box on
end
try, print(fig, fullfile(RES, 'M13_timescale.png'), '-dpng', '-r200'); print(fig, fullfile(RES, 'M13_timescale.pdf'), '-dpdf', '-bestfit'); catch, end
fprintf('\nM13 finished %s\n', datestr(now)); diary off
