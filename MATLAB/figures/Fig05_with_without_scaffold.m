% Fig05_with_without_scaffold: redraws Fig 5. Tristability with and without the scaffold.
%% Edit freely: every graphics object is drawn by an explicit command below.
% Data: data/Fig05_with_without_scaffold.mat (exported from the analysis that produced the published figure).
function Fig05_with_without_scaffold(outdir)
if nargin < 1, outdir = fullfile(fileparts(mfilename('fullpath')), 'Figures'); end
if ~exist(outdir, 'dir'), mkdir(outdir); end
D = load(fullfile(fileparts(mfilename('fullpath')), 'data', 'Fig05_with_without_scaffold.mat'));
fig = figure('Units', 'inches', 'Position', [0.5 0.5 14.000 8.600], 'Color', 'w', 'PaperUnits', 'inches', 'PaperSize', [14.000 8.600], 'PaperPosition', [0 0 14.000 8.600]);
set(fig, 'DefaultAxesFontWeight', 'bold', 'DefaultTextFontWeight', 'bold', 'DefaultAxesFontName', 'Helvetica', 'DefaultTextFontName', 'Helvetica');
% ---------------- axes 1 
ax = axes(fig, 'Position', [0.0600 0.4000 0.4200 0.5500]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
patch(ax, D.v1, D.v2, [0.827 0.329 0.000], 'FaceColor', [0.827 0.329 0.000], 'FaceAlpha', 0.15, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
patch(ax, D.v3, D.v4, [0.827 0.329 0.000], 'FaceColor', [0.827 0.329 0.000], 'FaceAlpha', 0.40, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
plot(ax, D.v5, D.v6, 'Color', [0.827 0.329 0.000], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v7, D.v8, 'Color', [0.827 0.329 0.000], 'LineStyle', '--', 'LineWidth', 2.25);
plot(ax, D.v9, D.v10, 'Color', [0.827 0.329 0.000], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v11, D.v12, 'Color', [0.827 0.329 0.000], 'LineStyle', '--', 'LineWidth', 2.25);
plot(ax, D.v13, D.v14, 'Color', [0.827 0.329 0.000], 'LineStyle', '-', 'LineWidth', 3.00);
text(ax, 0.540566, 0.42, {'SN_1', '81.1'}, 'Units', 'normalized', 'FontSize', 8.5, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off', 'BackgroundColor', [1.000 1.000 1.000], 'Margin', 1);
text(ax, 0.341598, 0.3, {'SN_2', '51.2'}, 'Units', 'normalized', 'FontSize', 8.5, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off', 'BackgroundColor', [1.000 1.000 1.000], 'Margin', 1);
text(ax, 0.773757, 0.42, {'SN_3', '116.1'}, 'Units', 'normalized', 'FontSize', 8.5, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off', 'BackgroundColor', [1.000 1.000 1.000], 'Margin', 1);
text(ax, 0.218211, 0.3, {'SN_4', '32.7'}, 'Units', 'normalized', 'FontSize', 8.5, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off', 'BackgroundColor', [1.000 1.000 1.000], 'Margin', 1);
text(ax, -0.13, 1.03, '(A)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
plot(ax, D.v15, D.v16, 'Color', [0.122 0.467 0.706], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v17, D.v18, 'Color', [1.000 0.498 0.055], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v19, D.v20, 'Color', [0.173 0.627 0.173], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v21, D.v22, 'Color', [0.839 0.153 0.157], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
xlabel(ax, 'kin_T (nM)', 'FontSize', 12.0); ylabel(ax, 'free eIF4E (nM)', 'FontSize', 12.0);
title(ax, 'no scaffold: free eIF4E (R1-R17, R22)', 'FontSize', 11.0);
xlim(ax, [0 150]); ylim(ax, [-25.084 552.794]);
set(ax, 'XTick', [0 20 40 60 80 100 120 140], 'XTickLabel', {'0', '20', '40', '60', '80', '100', '120', '140'});
set(ax, 'YTick', [0 100 200 300 400 500], 'YTickLabel', {'0', '100', '200', '300', '400', '500'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = patch(ax, NaN, NaN, [0.827 0.329 0.000], 'FaceColor', [0.827 0.329 0.000], 'FaceAlpha', 0.15, 'EdgeColor', [0.827 0.329 0.000]);
hl(2) = patch(ax, NaN, NaN, [0.827 0.329 0.000], 'FaceColor', [0.827 0.329 0.000], 'FaceAlpha', 0.40, 'EdgeColor', [0.827 0.329 0.000]);
lg = legend(ax, hl(1:2), {'\geq{} 2 stable states, full hysteresis range (SN_4-SN_3)', '3 stable states, tristable (SN_2-SN_1)'}, 'Location', 'southeast', 'FontSize', 8.5, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.2104 0.4069 0.2654 0.0456]); catch, end
% ---------------- axes 2 
ax = axes(fig, 'Position', [0.5600 0.4000 0.4200 0.5500]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
patch(ax, D.v23, D.v24, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 0.15, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
patch(ax, D.v25, D.v26, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 0.40, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
plot(ax, D.v27, D.v28, 'Color', [0.122 0.306 0.612], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v29, D.v30, 'Color', [0.122 0.306 0.612], 'LineStyle', '--', 'LineWidth', 2.25);
plot(ax, D.v31, D.v32, 'Color', [0.122 0.306 0.612], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v33, D.v34, 'Color', [0.122 0.306 0.612], 'LineStyle', '--', 'LineWidth', 2.25);
plot(ax, D.v35, D.v36, 'Color', [0.122 0.306 0.612], 'LineStyle', '-', 'LineWidth', 3.00);
text(ax, 0.539597, 0.42, {'SN_1', '80.9'}, 'Units', 'normalized', 'FontSize', 8.5, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off', 'BackgroundColor', [1.000 1.000 1.000], 'Margin', 1);
text(ax, 0.341368, 0.3, {'SN_2', '51.2'}, 'Units', 'normalized', 'FontSize', 8.5, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off', 'BackgroundColor', [1.000 1.000 1.000], 'Margin', 1);
text(ax, 0.768029, 0.42, {'SN_3', '115.2'}, 'Units', 'normalized', 'FontSize', 8.5, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off', 'BackgroundColor', [1.000 1.000 1.000], 'Margin', 1);
text(ax, 0.248081, 0.3, {'SN_4', '37.2'}, 'Units', 'normalized', 'FontSize', 8.5, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off', 'BackgroundColor', [1.000 1.000 1.000], 'Margin', 1);
text(ax, -0.13, 1.03, '(B)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
plot(ax, D.v37, D.v38, 'Color', [0.122 0.467 0.706], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v39, D.v40, 'Color', [1.000 0.498 0.055], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v41, D.v42, 'Color', [0.173 0.627 0.173], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v43, D.v44, 'Color', [0.839 0.153 0.157], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
xlabel(ax, 'kin_T (nM)', 'FontSize', 12.0); ylabel(ax, 'eIF4F (nM)', 'FontSize', 12.0);
title(ax, 'with scaffold: eIF4F (R1-R22)', 'FontSize', 11.0);
xlim(ax, [0 150]); ylim(ax, [-7.32128 220.824]);
set(ax, 'XTick', [0 20 40 60 80 100 120 140], 'XTickLabel', {'0', '20', '40', '60', '80', '100', '120', '140'});
set(ax, 'YTick', [0 50 100 150 200], 'YTickLabel', {'0', '50', '100', '150', '200'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = patch(ax, NaN, NaN, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 0.15, 'EdgeColor', [0.122 0.306 0.612]);
hl(2) = patch(ax, NaN, NaN, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 0.40, 'EdgeColor', [0.122 0.306 0.612]);
lg = legend(ax, hl(1:2), {'\geq{} 2 stable states, full hysteresis range (SN_4-SN_3)', '3 stable states, tristable (SN_2-SN_1)'}, 'Location', 'southeast', 'FontSize', 8.5, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.7104 0.4069 0.2654 0.0456]); catch, end
% ---------------- axes 3 
ax = axes(fig, 'Position', [0.0600 0.0700 0.9200 0.2200]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
patch(ax, D.v45, D.v46, [0.827 0.329 0.000], 'FaceColor', [0.827 0.329 0.000], 'FaceAlpha', 0.25, 'EdgeColor', 'none', 'LineWidth', 1.00, 'LineStyle', '-');
patch(ax, D.v47, D.v48, [0.827 0.329 0.000], 'FaceColor', [0.827 0.329 0.000], 'FaceAlpha', 0.80, 'EdgeColor', 'none', 'LineWidth', 1.00, 'LineStyle', '-');
patch(ax, D.v49, D.v50, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 0.25, 'EdgeColor', 'none', 'LineWidth', 1.00, 'LineStyle', '-');
patch(ax, D.v51, D.v52, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 0.80, 'EdgeColor', 'none', 'LineWidth', 1.00, 'LineStyle', '-');
text(ax, 31.7317, 1, 'SN_4 = 32.7', 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 117.064, 1, 'SN_3 = 116.1', 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 66.1623, 1, 'tristable 51.2-81.1', 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [1.000 1.000 1.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 36.2121, 0, 'SN_4 = 37.2', 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 116.204, 0, 'SN_3 = 115.2', 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 66.0724, 0, 'tristable 51.2-80.9', 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [1.000 1.000 1.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
annotation(fig, 'arrow', [0.2650 0.2882], [0.1800 0.1800], 'Color', [0.000 0.000 0.000], 'LineWidth', 2.0, 'HeadWidth', 8, 'HeadLength', 8);
text(ax, 34.9719, 0.62, '\Delta{} = 4.5 nM', 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, -0.05, 1.03, '(C)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
xlabel(ax, 'kin_T (nM)', 'FontSize', 12.0); ylabel(ax, '', 'FontSize', 12.0);
xlim(ax, [0 150]); ylim(ax, [-0.6 1.6]);
set(ax, 'XTick', [0 20 40 60 80 100 120 140], 'XTickLabel', {'0', '20', '40', '60', '80', '100', '120', '140'});
set(ax, 'YTick', [0 1], 'YTickLabel', {'with scaffold', 'without scaffold'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
print(fig, fullfile(outdir, 'Fig05_with_without_scaffold.pdf'), '-dpdf', '-painters');
print(fig, fullfile(outdir, 'Fig05_with_without_scaffold.png'), '-dpng', '-r150');
end
