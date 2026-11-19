% FigS08_switching_timescale: redraws Supplementary Fig 8 (switching times) from Results/M13_timescale.mat.
%% Edit freely: every graphics object is drawn by an explicit command below.
% Data: Results/M13_timescale.mat, written by compute/M13_switching_timescale.m (parts A, B and C).
% Run time: seconds. Output: figures/Figures/FigS08_switching_timescale.png and .pdf
function FigS08_switching_timescale(outdir)
here = fileparts(mfilename('fullpath'));
if nargin < 1, outdir = fullfile(here, 'Figures'); end
if ~exist(outdir, 'dir'), mkdir(outdir); end
S = load(fullfile(here, '..', 'Results', 'M13_timescale.mat')); OUT = S.OUT;
fig = figure('Color', 'w', 'Units', 'inches', 'Position', [0.5 0.5 11 4.4], 'PaperUnits', 'inches', ...
             'PaperSize', [11 4.4], 'PaperPosition', [0 0 11 4.4]);
% ---------------- A: reference set, cycles 1 and 3 faster
ax = axes(fig, 'Position', [0.07 0.15 0.38 0.75]); hold(ax, 'on'); box(ax, 'on');
h1 = plot(ax, OUT.A.lam, OUT.A.on, '-o', 'Color', [0.000 0.447 0.741], 'LineWidth', 1.5, 'MarkerSize', 6);
h2 = plot(ax, OUT.A.lam, OUT.A.off, '-s', 'Color', [0.850 0.325 0.098], 'LineWidth', 1.5, 'MarkerSize', 6);
h3 = plot(ax, [0.8 150], [30 30], 'k:');
set(ax, 'XScale', 'log', 'YScale', 'log', 'FontSize', 10); xlim(ax, [0.8 150]); ylim(ax, [2 500]);
xlabel(ax, '\lambda (turnover of cycles 1 and 3, capped at 38.6 and 21.7)'); ylabel(ax, 'time (min)');
legend(ax, [h1 h2 h3], {'switch on (to 2 SN_{hi})', 'switch off (to SN_{lo}/2)', '30 min'}, 'Location', 'northeast');
title(ax, 'A  reference set, K_m and \Gamma kept');
% ---------------- B: every tristable set of the ensembles, and the search
ax = axes(fig, 'Position', [0.56 0.15 0.40 0.75]); hold(ax, 'on'); box(ax, 'on');
nm = {'fold2', 'fold3', 'fold10', 'exp'}; lab = {'\leq2-fold', '\leq3-fold', '\leq10-fold', 'experimental'};
col = [0.000 0.447 0.741; 0.850 0.325 0.098; 0.929 0.694 0.125; 0.494 0.184 0.556]; h = []; lg = {};
for e = 1:numel(nm)
    if ~isfield(OUT.B, nm{e}), continue, end
    b = OUT.B.(nm{e}); ms = 4; if strcmp(nm{e}, 'exp'), ms = 14; end
    h(end+1) = plot(ax, b.on, b.off, '.', 'Color', col(e, :), 'MarkerSize', ms); %#ok<AGROW>
    lg{end+1} = sprintf('%s (%d)', lab{e}, sum(~isnan(b.on) & ~isnan(b.off))); %#ok<AGROW>
end
if isfield(OUT, 'C')
    h(end+1) = plot(ax, OUT.C.on, OUT.C.off, 'kp', 'MarkerFaceColor', 'y', 'MarkerSize', 9); lg{end+1} = 'search';
end
set(ax, 'XScale', 'log', 'YScale', 'log', 'FontSize', 10); xlim(ax, [0.1 1e4]); ylim(ax, [0.01 1e4]);
plot(ax, [30 30], [0.01 1e4], 'k:'); plot(ax, [0.1 1e4], [30 30], 'k:');
xlabel(ax, 'switch on (min)'); ylabel(ax, 'switch off (min)'); legend(ax, h, lg, 'Location', 'northwest');
title(ax, 'B  tristable sets of the ensembles');
print(fig, fullfile(outdir, 'FigS08_switching_timescale.png'), '-dpng', '-r300');
print(fig, fullfile(outdir, 'FigS08_switching_timescale.pdf'), '-dpdf', '-r300');
end
