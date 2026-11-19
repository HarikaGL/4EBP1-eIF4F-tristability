%% M08  Fig 8 and Table 5: one parameter at a time (and one module at a time) by Latin hypercube sampling.
%  One script for all the runs: the same sampler, the same thermodynamic builder (c08_build) and the
%  same classification (p4e_attribute: from the two axes of the bifurcation diagram, kin_T and e4F, only) are used for
%    MODE = 'single'  every rate constant k_f1..k_f22, k_b1..k_b22 and every total (e4E_T, BP_T, P_T, e4G_T, e4A_T)
%                     sampled on its own: 41 Latin hypercube samples, log-uniform over its admissible range, all other
%                     parameters at the reference set (Fig 8, Table 5);
%    MODE = 'module'  all independent rate constants of one module sampled together (MODULE = 'M1', 'M2', 'M1M3',
%                     'M2M3'; 12 000 sets; the module runs of Section 4.2).
%  Classes: tristable, coexisting | tristable, separate (S-S, Z-S) | bistable: M1 switch, M2 switch,
%  other | monostable (see p4e_attribute.m and c08_name.m).
%  Samples: by default the exact samples of the manuscript are read from C08_lhs_samples.mat (the samples
%  used for the manuscript, Latin hypercube, seed 7), so the results reproduce the manuscript. With FRESH = true, new
%  samples are drawn with c08_lhs (Latin hypercube, rng seed 7) over the same ranges.
%  Thermodynamic consistency (c08_build): in every PdP cycle touched by a sampled constant Gamma keeps its
%  reference value; a sampled product-rebinding constant is compensated by the other rebinding constant of its
%  cycle, otherwise the two share the change in their reference ratio; in the scaffold loop k_b21 (k_b18 when R21
%  is sampled) keeps K_D18 K_D19 = K_D20 K_D21. A set is inadmissible when a Michaelis constant leaves 1-1e4 nM or
%  a rebinding constant exceeds 0.1 nM^-1 s^-1.
%  Run time: 'single' about 2 000 continuations; 'module' 12 000 sets. QUICK = true runs 3 samples per parameter.
clearvars -except QUICK MODE MODULE FRESH; quick = exist('QUICK', 'var') && QUICK;
if ~exist('MODE', 'var'), MODE = 'single'; end
if ~exist('MODULE', 'var'), MODULE = 'M1'; end
fresh = exist('FRESH', 'var') && FRESH;
here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e(); DATA = fullfile(here, '..', 'data');
S = load(fullfile(DATA, 'C08_lhs_samples.mat')); P0 = p4e_ref(); CYC = [1 2 7 8; 3 4 5 6; 9 10 15 16; 11 12 13 14];
cellstr_ = @(c) cellfun(@strtrim, cellstr(c), 'UniformOutput', false);

if strcmp(MODE, 'single')
    names = cellstr_(S.SINGLE_NAME); kinds = cellstr_(S.SINGLE_KIND); idx = S.SINGLE_IDX; rg = S.SINGLE_RANGE; X = S.SINGLE_X;
    if fresh, rng(7); for s = 1:numel(names), X(s, :) = c08_lhs(rg(s, :), size(X, 2))'; end, end
    if quick, X = X(:, 1:3); end
    OUT = struct('name', {}, 'x', {}, 'dx', {}, 'lo', {}, 'hi', {}, 'A', {});
    for s = 1:numel(names)
        switch kinds{s}, case 'kf', ref = P0.kf(idx(s)); case 'kb', ref = P0.kb(idx(s)); otherwise, ref = P0.tot(idx(s)); end
        xs = sort(X(s, :)); A = cell(1, numel(xs));
        for q = 1:numel(xs)
            [P, ok] = c08_build(P0, kinds(s), idx(s), xs(q), CYC);
            if ok, A{q} = p4e_attribute(P); else, A{q} = struct('cls', 'inadmissible', 'sub', '', 'shape', '', 'dip', false); end
        end
        OUT(end+1) = struct('name', names{s}, 'x', xs, 'dx', xs - log10(ref), 'lo', rg(s, 1) - log10(ref), 'hi', rg(s, 2) - log10(ref), 'A', {A}); %#ok<SAGROW>
        fprintf('%-8s %s\n', names{s}, c08_summary(A));
    end
    save(fullfile(RES, 'C08_lhs_single.mat'), 'OUT', '-v7');

    %% thresholds of every class over each range, SN1-SN4 in separate columns (Table 5 is built from these ranges)
    fid = fopen(fullfile(RES, 'C08_thresholds.csv'), 'w');
    fprintf(fid, 'parameter,class,n,log10 change from,to,SN1 min,SN1 max,SN2 min,SN2 max,SN3 min,SN3 max,SN4 min,SN4 max\n');
    for k = 1:numel(OUT)
        A = OUT(k).A; dx = OUT(k).dx;
        for oc = {'tri', 'SS', 'ZS', 'M1', 'M2', 'general', 'mono', 'inadmissible'}
            sel = false(1, numel(A)); V = nan(0, 4);
            for q = 1:numel(A)
                a = A{q}; c = c08_class(a); if strcmp(c, 'separate'), c = a.shape; end
                if ~strcmp(c, oc{1}), continue, end
                sel(q) = true; v = nan(1, 4);
                if any(strcmp(c, {'tri', 'SS', 'ZS'})), v = a.SN_K(:)';
                elseif any(strcmp(c, {'M1', 'general'})), v(1:2) = sort([a.loops{1, 2} a.loops{1, 3}], 'descend');   % on, off (other: SN1*, SN2*)
                elseif strcmp(c, 'M2'), v(3:4) = sort([a.loops{1, 2} a.loops{1, 3}], 'descend'); end
                V(end+1, :) = v; %#ok<AGROW>
            end
            if ~any(sel), continue, end
            switch oc{1}
                case 'SS', nm = 'tristable, separate: S-S'; case 'ZS', nm = 'tristable, separate: Z-S';
                case 'general', nm = 'bistable: other (SN1*, SN2* in the SN1, SN2 columns)'; otherwise, nm = c08_name(oc{1});
            end
            fprintf(fid, '"%s","%s",%d,%.2f,%.2f', OUT(k).name, nm, sum(sel), min(dx(sel)), max(dx(sel)));
            for j = 1:4
                if all(isnan(V(:, j))), fprintf(fid, ',,'); else, fprintf(fid, ',%.3g,%.3g', min(V(:, j)), max(V(:, j))); end
            end
            fprintf(fid, '\n');
        end
    end
    fclose(fid);

    %% figure: one bar per parameter; samples sorted by value, each colouring the stretch between the midpoints
    %% with its neighbours (the first and last stretch reach the ends of the admissible range)
    COL = containers.Map({'tri', 'M1', 'M2', 'separate', 'general', 'mono', 'inadmissible', 'other', 'fail'}, ...
        {[0.753 0.224 0.169], [0.169 0.549 0.745], [0.192 0.639 0.329], [0.902 0.631 0.255], [0.620 0.604 0.784], [0.851 0.851 0.851], [1 1 1], [1 1 1], [1 1 1]});
    fig = figure('Color', 'w', 'Units', 'inches', 'Position', [0.5 0.5 12 18]); ax = axes('Position', [0.12 0.05 0.7 0.9]); hold(ax, 'on');
    ny = numel(OUT); lab = cell(1, ny);
    for k = 1:ny
        y = ny - k + 1; xs = OUT(k).dx; e = [OUT(k).lo, (xs(1:end-1)+xs(2:end))/2, OUT(k).hi]; cnt = containers.Map();
        for q = 1:numel(xs)
            a = OUT(k).A{q}; c = c08_class(a); col = COL(c);
            rectangle(ax, 'Position', [e(q), y-0.4, max(e(q+1)-e(q), 1e-6), 0.8], 'FaceColor', col, 'EdgeColor', col);
            if strcmp(c, 'inadmissible'), rectangle(ax, 'Position', [e(q), y-0.4, max(e(q+1)-e(q), 1e-6), 0.8], 'EdgeColor', [0.6 0.6 0.6]); end
            if strcmp(c, 'separate') && strcmp(a.shape, 'ZS'), col = [0.549 0.318 0.039]; rectangle(ax, 'Position', [e(q), y-0.4, max(e(q+1)-e(q), 1e-6), 0.8], 'FaceColor', col, 'EdgeColor', col); end
            plot(ax, xs(q), y - 0.47, 'k|', 'MarkerSize', 3);
            if isKey(cnt, c), cnt(c) = cnt(c) + 1; else, cnt(c) = 1; end
        end
        plot(ax, 0, y, 'kd', 'MarkerFaceColor', 'k', 'MarkerSize', 4); lab{y} = strrep(OUT(k).name, '_', '\_');
        kk = keys(cnt); txt = strjoin(cellfun(@(c) sprintf('%s %d', c, cnt(c)), kk, 'UniformOutput', false), '  ');
        text(ax, 7.1, y, txt, 'FontSize', 6.5);
    end
    plot(ax, [0 0], [0.5 ny+0.5], 'k:'); set(ax, 'YTick', 1:ny, 'YTickLabel', lab, 'FontSize', 8, 'Box', 'on'); xlim(ax, [-6 7]); ylim(ax, [0.5 ny+0.5]);
    xlabel(ax, 'log_{10}(value / reference)');
    title(ax, {'red tristable, coexisting | orange tristable, separate: S-S | brown tristable, separate: Z-S', ...
               'blue bistable: M1 switch | green bistable: M2 switch | purple bistable: other | grey monostable | white outside admissible range'}, 'FontSize', 9);
    try, print(fig, fullfile(RES, 'C08_lhs_single.png'), '-dpng', '-r150'); catch err, fprintf('check plot not written: %s\n', err.message); end
else
    kinds = cellstr_(S.(['MOD_' MODULE '_KIND'])); idx = S.(['MOD_' MODULE '_IDX']); rg = S.(['MOD_' MODULE '_RANGE']); X = S.(['MOD_' MODULE '_X']);
    if fresh, rng(7); X = c08_lhs(rg, size(X, 1)); end
    if quick, X = X(1:20, :); end
    A = cell(size(X, 1), 1); KF = nan(size(X, 1), 22); KB = KF;
    for q = 1:size(X, 1)
        [P, ok] = c08_build(P0, kinds, idx, X(q, :), CYC);
        if ok, A{q} = p4e_attribute(P); KF(q, :) = P.kf; KB(q, :) = P.kb; else, A{q} = struct('cls', 'inadmissible', 'sub', '', 'shape', '', 'dip', false); end
    end
    save(fullfile(RES, ['C08_lhs_module_' MODULE '.mat']), 'A', 'X', 'KF', 'KB', 'kinds', 'idx', '-v7');
    fprintf('%s: %s\n', MODULE, c08_summary(A'));

    %% thresholds of every class (module runs): median, 10th-90th percentile, minimum-maximum
    fid = fopen(fullfile(RES, ['C08_lhs_module_' MODULE '_thresholds.csv']), 'w');
    fprintf(fid, 'class,sets,threshold,median,p10,p90,min,max\n');
    cl = cellfun(@c08_class, A, 'UniformOutput', false);
    for oc = {'tri', 'M1', 'M2', 'separate', 'general', 'mono'}
        sel = find(strcmp(cl, oc{1})); if isempty(sel), continue, end
        if any(strcmp(oc{1}, {'tri', 'separate'})), T = cell2mat(cellfun(@(a) a.SN_K(:)', A(sel), 'UniformOutput', false)); nm = c08_sn_names(oc{1});
        elseif strcmp(oc{1}, 'mono'), fprintf(fid, '%s,%d,,,,,,\n', c08_name(oc{1}), numel(sel)); continue
        else, T = cell2mat(cellfun(@(a) sort([a.loops{1, 2} a.loops{1, 3}], 'descend'), A(sel), 'UniformOutput', false)); nm = c08_sn_names(oc{1}); end
        for j = 1:numel(nm)
            v = sort(T(:, j)); q = @(p) interp1(linspace(0, 100, numel(v)), v, p);
            if numel(v) == 1, pr = [v v v]; else, pr = [q(50) q(10) q(90)]; end
            fprintf(fid, '%s,%d,%s,%.3g,%.3g,%.3g,%.3g,%.3g\n', c08_name(oc{1}), numel(sel), nm{j}, pr(1), pr(2), pr(3), v(1), v(end));
        end
    end
    fclose(fid);
end
