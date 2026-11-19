%% M15  Global sensitivity: partial rank correlation coefficients (PRCC) over the sampled ensembles
%  (Section 2.12, "All parameters together"; Methods 4.8; Supplementary Fig 7).
%  Inputs: the 42 primitive parameters of each set (p4e_prim; data/ensemble_samples.mat), sampled independently by
%  Latin hypercube sampling, which is what PRCC assumes. Primitives that were not varied are left out.
%  Outputs, for the tristable sets (coexisting or separate loops) of each ensemble:
%     W3  width of the kinase range with at least three steady states (nM)
%     W5  width of the range with three stable states together (coexisting loops only, nM)
%     SNk log of each saddle-node point (tristable sets with four saddle-node points)
%  and, over all sets of the ensemble, TRI (1 if tristable, 0 otherwise; a point-biserial PRCC).
%  PRCC: every input and output is rank-transformed (average ranks for ties); the PRCC of input i with output y is the
%  correlation of the residuals of i and y after linear regression on all other inputs, obtained from the inverse of
%  the rank correlation matrix. Two-sided p values from the t statistic (normal approximation, n is large).
%  Needs the output of M10 (Results/M10_<ensemble>.mat). No toolbox needed.
%  Run time: seconds. Output: printed (|PRCC| >= 0.2 and p < 0.001); Results/M15_PRCC.csv; Results/M15_PRCC.png.
clearvars -except QUICK; here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e(); DATA = fullfile(here, '..', 'data');
D = load(fullfile(DATA, 'ensemble_samples.mat')); names = p4e_prim();
ENS = {'fold2', 'fold3', 'fold10'};
fid = fopen(fullfile(RES, 'M15_PRCC.csv'), 'w'); fprintf(fid, 'ensemble,output,n,parameter,PRCC,p\n');
ALL = struct();
for e = 1:numel(ENS)
    nm = ENS{e}; f = fullfile(RES, ['M10_' nm '.mat']);
    if ~exist(f, 'file'), fprintf('%s: Results/M10_%s.mat not found (run M10 first); skipped\n', nm, nm); continue, end
    S = load(f, 'cls', 'w3', 'w5', 'SN'); X = D.(['theta_' nm]);
    var = std(X, 0, 1) > 0; Xv = X(:, var); nv = names(var);
    tri = strcmp(S.cls, 'tri') | strcmp(S.cls, 'sep'); coex = strcmp(S.cls, 'tri');
    four = tri & all(~isnan(S.SN), 2);
    OUT = {'TRI', true(size(tri)), double(tri); 'W3', tri & S.w3 > 0, S.w3; 'W5', coex & S.w5 > 0, S.w5};
    for k = 1:4, OUT(end+1, :) = {sprintf('SN%d', k), four, log(S.SN(:, k))}; end %#ok<SAGROW>
    fprintf('\n%s (%d sets, %d tristable, %d varied primitives)\n', nm, numel(tri), sum(tri), numel(nv));
    R = struct();
    for o = 1:size(OUT, 1)
        sel = OUT{o, 2}; y = OUT{o, 3}(sel); x = Xv(sel, :);
        if numel(y) < size(x, 2) + 10, continue, end
        [r, p] = p4e_prcc(x, y);
        R.(OUT{o, 1}) = struct('r', r, 'p', p, 'n', numel(y));
        [~, ord] = sort(abs(r), 'descend'); ord = ord(abs(r(ord)) >= 0.2 & p(ord) < 1e-3);
        fprintf('  %-4s (n = %5d): %s\n', OUT{o, 1}, numel(y), strjoin(arrayfun(@(i) sprintf('%s %+.2f', nv{i}, r(i)), ...
                ord(1:min(10, numel(ord))), 'UniformOutput', false), ', '));
        for i = 1:numel(nv), fprintf(fid, '%s,%s,%d,%s,%.4f,%.3g\n', nm, OUT{o, 1}, numel(y), nv{i}, r(i), p(i)); end
    end
    R.names = nv; ALL.(nm) = R;
end
fclose(fid);
% figure: PRCC of W3 and of SN1-SN4 in the <=3-fold ensemble
if isfield(ALL, 'fold3') && isfield(ALL.fold3, 'W3')
    R = ALL.fold3; nv = R.names; outs = {'TRI', 'W3', 'SN1', 'SN2', 'SN3', 'SN4'}; outs = outs(isfield(R, outs));
    M = zeros(numel(nv), numel(outs)); for o = 1:numel(outs), M(:, o) = R.(outs{o}).r(:); end
    [~, ord] = sort(max(abs(M), [], 2), 'descend'); ord = ord(1:min(20, numel(ord)));
    fig = figure('Color', 'w', 'Position', [50 50 700 650]); imagesc(M(ord, :), [-1 1]);
    cm = [linspace(0.13, 1, 32)', linspace(0.40, 1, 32)', linspace(0.67, 1, 32)'; linspace(1, 0.70, 32)', linspace(1, 0.09, 32)', linspace(1, 0.17, 32)'];
    colormap(cm); colorbar; set(gca, 'YTick', 1:numel(ord), 'YTickLabel', strrep(nv(ord), '_', '\_'), 'XTick', 1:numel(outs), 'XTickLabel', outs);
    title('PRCC, \leq3-fold ensemble (20 strongest parameters)');
    for i = 1:numel(ord), for o = 1:numel(outs), text(o, i, sprintf('%.2f', M(ord(i), o)), 'HorizontalAlignment', 'center', 'FontSize', 7); end, end
    try, print(fig, fullfile(RES, 'M15_PRCC.png'), '-dpng', '-r150'); catch, end
end
save(fullfile(RES, 'M15_PRCC.mat'), 'ALL', '-v7');

