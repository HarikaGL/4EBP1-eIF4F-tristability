% Fig02_modules_bistable: redraws Fig 2. Each phosphorylation module is bistable; the two in series are tristable.
%% Edit freely: every graphics object is drawn by an explicit command below.
% Data: data/Fig02_modules_bistable.mat (exported from the analysis that produced the published figure).
function Fig02_modules_bistable(outdir)
if nargin < 1, outdir = fullfile(fileparts(mfilename('fullpath')), 'Figures'); end
if ~exist(outdir, 'dir'), mkdir(outdir); end
D = load(fullfile(fileparts(mfilename('fullpath')), 'data', 'Fig02_modules_bistable.mat'));
fig = figure('Units', 'inches', 'Position', [0.5 0.5 16.000 4.800], 'Color', 'w', 'PaperUnits', 'inches', 'PaperSize', [16.000 4.800], 'PaperPosition', [0 0 16.000 4.800]);
set(fig, 'DefaultAxesFontWeight', 'bold', 'DefaultTextFontWeight', 'bold', 'DefaultAxesFontName', 'Helvetica', 'DefaultTextFontName', 'Helvetica');
% ---------------- axes 1 
ax = axes(fig, 'Position', [0.0499 0.1363 0.2757 0.7539]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'log', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
patch(ax, D.v1, D.v2, [0.106 0.498 0.231], 'FaceColor', [0.106 0.498 0.231], 'FaceAlpha', 0.18, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
plot(ax, D.v3, D.v4, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v5, D.v6, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 2.25);
plot(ax, D.v7, D.v8, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
text(ax, 0.64567, 0.049986, 'SN_1', 'Units', 'normalized', 'FontSize', 10.0, 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.25676, 0.95204, 'SN_2', 'Units', 'normalized', 'FontSize', 10.0, 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, -0.13, 1.03, '(A)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
plot(ax, D.v9, D.v10, 'Color', [0.122 0.467 0.706], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v11, D.v12, 'Color', [1.000 0.498 0.055], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
xlabel(ax, 'kin_T (nM, log scale)', 'FontSize', 12.0); ylabel(ax, 'free eIF4E (nM)', 'FontSize', 12.0);
title(ax, 'M1 alone: PdP1 + release (R1-R8, R17, R22)', 'FontSize', 11.0);
xlim(ax, [1 1000]); ylim(ax, [-25.1406 553.981]);
set(ax, 'XTick', [1 10 100 1000], 'XTickLabel', {'{10^{0}}', '{10^{1}}', '{10^{2}}', '{10^{3}}'});
set(ax, 'YTick', [0 100 200 300 400 500], 'YTickLabel', {'0', '100', '200', '300', '400', '500'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = patch(ax, NaN, NaN, [0.106 0.498 0.231], 'FaceColor', [0.106 0.498 0.231], 'FaceAlpha', 0.18, 'EdgeColor', [0.106 0.498 0.231]);
lg = legend(ax, hl(1:1), {'bistable (5.3-77.6 nM)'}, 'Location', 'west', 'FontSize', 9.0, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.0538 0.4898 0.1266 0.0469]); catch, end
% ---------------- axes 2 
ax = axes(fig, 'Position', [0.3765 0.1363 0.2757 0.7539]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'log', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
patch(ax, D.v13, D.v14, [0.753 0.224 0.169], 'FaceColor', [0.753 0.224 0.169], 'FaceAlpha', 0.18, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
plot(ax, D.v15, D.v16, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v17, D.v18, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 2.25);
plot(ax, D.v19, D.v20, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
text(ax, 0.89128, 0.011701, 'SN_1', 'Units', 'normalized', 'FontSize', 10.0, 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.52136, 0.90029, 'SN_2', 'Units', 'normalized', 'FontSize', 10.0, 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, -0.13, 1.03, '(B)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
plot(ax, D.v21, D.v22, 'Color', [0.122 0.467 0.706], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v23, D.v24, 'Color', [1.000 0.498 0.055], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
xlabel(ax, 'kin_T (nM, log scale)', 'FontSize', 12.0); ylabel(ax, '', 'FontSize', 12.0);
title(ax, 'M2 alone: PdP2 + release (R9-R16, R17, R22)', 'FontSize', 11.0);
xlim(ax, [1 1000]); ylim(ax, [-25.1406 553.981]);
set(ax, 'XTick', [1 10 100 1000], 'XTickLabel', {'{10^{0}}', '{10^{1}}', '{10^{2}}', '{10^{3}}'});
set(ax, 'YTick', [0 100 200 300 400 500], 'YTickLabel', {'', '', '', '', '', ''});
set(ax, 'YTickLabel', {});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = patch(ax, NaN, NaN, [0.753 0.224 0.169], 'FaceColor', [0.753 0.224 0.169], 'FaceAlpha', 0.18, 'EdgeColor', [0.753 0.224 0.169]);
lg = legend(ax, hl(1:1), {'bistable (32.9-423.3 nM)'}, 'Location', 'west', 'FontSize', 9.0, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.3804 0.4898 0.1375 0.0469]); catch, end
% ---------------- axes 3 
ax = axes(fig, 'Position', [0.7031 0.1363 0.2757 0.7539]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'log', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
patch(ax, D.v25, D.v26, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 0.15, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
patch(ax, D.v27, D.v28, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 0.40, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
plot(ax, D.v29, D.v30, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v31, D.v32, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 2.25);
plot(ax, D.v33, D.v34, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v35, D.v36, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 2.25);
plot(ax, D.v37, D.v38, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
text(ax, 0.65206, -0.0097529, 'SN_1', 'Units', 'normalized', 'FontSize', 10.0, 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.58561, 0.055993, 'SN_2', 'Units', 'normalized', 'FontSize', 10.0, 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.70398, 0.29636, 'SN_3', 'Units', 'normalized', 'FontSize', 10.0, 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.52073, 0.90112, 'SN_4', 'Units', 'normalized', 'FontSize', 10.0, 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, -0.13, 1.03, '(C)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
plot(ax, D.v39, D.v40, 'Color', [0.122 0.467 0.706], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v41, D.v42, 'Color', [1.000 0.498 0.055], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v43, D.v44, 'Color', [0.173 0.627 0.173], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v45, D.v46, 'Color', [0.839 0.153 0.157], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
xlabel(ax, 'kin_T (nM, log scale)', 'FontSize', 12.0); ylabel(ax, '', 'FontSize', 12.0);
title(ax, 'M1 and M2 in series (R1-R17, R22)', 'FontSize', 11.0);
xlim(ax, [1 1000]); ylim(ax, [-25.1406 553.981]);
set(ax, 'XTick', [1 10 100 1000], 'XTickLabel', {'{10^{0}}', '{10^{1}}', '{10^{2}}', '{10^{3}}'});
set(ax, 'YTick', [0 100 200 300 400 500], 'YTickLabel', {'', '', '', '', '', ''});
set(ax, 'YTickLabel', {});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = patch(ax, NaN, NaN, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 0.15, 'EdgeColor', [0.122 0.306 0.612]);
hl(2) = patch(ax, NaN, NaN, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 0.40, 'EdgeColor', [0.122 0.306 0.612]);
lg = legend(ax, hl(1:2), {'\geq{} 2 stable states, SN_4-SN_3 (32.7-116.1 nM)', '3 stable states, SN_2-SN_1 (51.2-81.1 nM)'}, 'Location', 'west', 'FontSize', 9.0, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.7070 0.4692 0.2188 0.0880]); catch, end
print(fig, fullfile(outdir, 'Fig02_modules_bistable.pdf'), '-dpdf', '-painters');
print(fig, fullfile(outdir, 'Fig02_modules_bistable.png'), '-dpng', '-r150');
end
