% Fig03_three_states: redraws Fig 3. Three states of eIF4F at the reference set.
%% Edit freely: every graphics object is drawn by an explicit command below.
% Data: data/Fig03_three_states.mat (exported from the analysis that produced the published figure).
function Fig03_three_states(outdir)
if nargin < 1, outdir = fullfile(fileparts(mfilename('fullpath')), 'Figures'); end
if ~exist(outdir, 'dir'), mkdir(outdir); end
D = load(fullfile(fileparts(mfilename('fullpath')), 'data', 'Fig03_three_states.mat'));
fig = figure('Units', 'inches', 'Position', [0.5 0.5 8.500 9.400], 'Color', 'w', 'PaperUnits', 'inches', 'PaperSize', [8.500 9.400], 'PaperPosition', [0 0 8.500 9.400]);
set(fig, 'DefaultAxesFontWeight', 'bold', 'DefaultTextFontWeight', 'bold', 'DefaultAxesFontName', 'Helvetica', 'DefaultTextFontName', 'Helvetica');
% ---------------- axes 1 
ax = axes(fig, 'Position', [0.1250 0.4747 0.7750 0.4053]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
patch(ax, D.v1, D.v2, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 0.15, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
patch(ax, D.v3, D.v4, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 0.40, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
plot(ax, D.v5, D.v6, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v7, D.v8, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 2.25);
plot(ax, D.v9, D.v10, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v11, D.v12, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 2.25);
plot(ax, D.v13, D.v14, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
annotation(fig, 'arrow', [0.5283 0.5283], [0.4985 0.6174], 'Color', [0.106 0.498 0.231], 'LineWidth', 3.0, 'HeadWidth', 8, 'HeadLength', 8);
annotation(fig, 'arrow', [0.6991 0.6991], [0.7471 0.8374], 'Color', [0.753 0.224 0.169], 'LineWidth', 3.0, 'HeadWidth', 8, 'HeadLength', 8);
annotation(fig, 'arrow', [0.3104 0.3104], [0.8296 0.4961], 'Color', [0.122 0.306 0.612], 'LineWidth', 3.0, 'HeadWidth', 8, 'HeadLength', 8);
text(ax, 0.53729, 0.025564, {'SN_1', '81 nM'}, 'Units', 'normalized', 'FontSize', 9.0, 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.34611, 0.087331, {'SN_2', '51 nM'}, 'Units', 'normalized', 'FontSize', 9.0, 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.75761, 0.63897, {'SN_3', '115 nM'}, 'Units', 'normalized', 'FontSize', 9.0, 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.25613, 0.89358, {'SN_4', '37 nM'}, 'Units', 'normalized', 'FontSize', 9.0, 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 44.2087, 141.425, {'bistable', '(I, III)'}, 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [0.200 0.200 0.200], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 66.0724, 141.425, {'tristable', '(I, II, III)'}, 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [0.067 0.067 0.067], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 98.0719, 141.425, {'bistable', '(II, III)'}, 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [0.200 0.200 0.200], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, -0.12, 1.03, '(A)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
plot(ax, D.v15, D.v16, 'Color', [0.122 0.467 0.706], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v17, D.v18, 'Color', [1.000 0.498 0.055], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v19, D.v20, 'Color', [0.173 0.627 0.173], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v21, D.v22, 'Color', [0.839 0.153 0.157], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
xlabel(ax, 'kin_T (nM)', 'FontSize', 12.0); ylabel(ax, 'e4F (nM)', 'FontSize', 12.0);
xlim(ax, [0 155.526]); ylim(ax, [-9.42835 235.709]);
set(ax, 'XTick', [0 20 40 60 80 100 120 140], 'XTickLabel', {'0', '20', '40', '60', '80', '100', '120', '140'});
set(ax, 'YTick', [0 50 100 150 200], 'YTickLabel', {'0', '50', '100', '150', '200'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = patch(ax, NaN, NaN, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 0.15, 'EdgeColor', [0.122 0.306 0.612]);
hl(2) = patch(ax, NaN, NaN, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 0.40, 'EdgeColor', [0.122 0.306 0.612]);
lg = legend(ax, hl(1:2), {'\geq{} 2 stable states, full hysteresis range (SN_4-SN_3)', '3 stable states, tristable (SN_2-SN_1)'}, 'Location', 'east', 'FontSize', 8.5, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.4560 0.6241 0.4371 0.0417]); catch, end
% ---------------- axes 2 
ax = axes(fig, 'Position', [0.1250 0.1100 0.7750 0.2702]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
plot(ax, D.v23, D.v24, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 9.00);
plot(ax, D.v25, D.v26, 'Color', [0.106 0.498 0.231], 'LineStyle', '-', 'LineWidth', 9.00);
plot(ax, D.v27, D.v28, 'Color', [0.753 0.224 0.169], 'LineStyle', '-', 'LineWidth', 9.00);
plot(ax, D.v29, D.v30, 'Color', [0.533 0.533 0.533], 'LineStyle', ':', 'LineWidth', 1.00);
plot(ax, D.v31, D.v32, 'Color', [0.533 0.533 0.533], 'LineStyle', ':', 'LineWidth', 1.00);
plot(ax, D.v33, D.v34, 'Color', [0.533 0.533 0.533], 'LineStyle', ':', 'LineWidth', 1.00);
plot(ax, D.v35, D.v36, 'Color', [0.533 0.533 0.533], 'LineStyle', ':', 'LineWidth', 1.00);
text(ax, 37.2121, 2.55, {'SN_4', '37'}, 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 51.2053, 2.55, {'SN_2', '51'}, 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 80.9396, 2.55, {'SN_1', '81'}, 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 115.204, 2.55, {'SN_3', '115'}, 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
annotation(fig, 'arrow', [0.5283 0.5283], [0.1516 0.2258], 'Color', [0.106 0.498 0.231], 'LineWidth', 3.0, 'HeadWidth', 8, 'HeadLength', 8);
annotation(fig, 'arrow', [0.6991 0.6991], [0.2287 0.3030], 'Color', [0.753 0.224 0.169], 'LineWidth', 3.0, 'HeadWidth', 8, 'HeadLength', 8);
annotation(fig, 'arrow', [0.3104 0.3104], [0.3000 0.1486], 'Color', [0.122 0.306 0.612], 'LineWidth', 3.0, 'HeadWidth', 8, 'HeadLength', 8);
text(ax, -0.12, 1.03, '(B)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
xlabel(ax, 'kin_T (nM)', 'FontSize', 12.0); ylabel(ax, 'stable state', 'FontSize', 12.0);
xlim(ax, [0 155.526]); ylim(ax, [-0.5 3]);
set(ax, 'XTick', [0 20 40 60 80 100 120 140], 'XTickLabel', {'0', '20', '40', '60', '80', '100', '120', '140'});
set(ax, 'YTick', [0 1 2], 'YTickLabel', {'State I (repressed)', 'State II (partially active)', 'State III (fully active)'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
print(fig, fullfile(outdir, 'Fig03_three_states.pdf'), '-dpdf', '-painters');
print(fig, fullfile(outdir, 'Fig03_three_states.png'), '-dpng', '-r150');
end
