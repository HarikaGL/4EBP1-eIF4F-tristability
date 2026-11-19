% Fig06_eIF4E_knockdown: redraws Fig 6. Model counterpart of the eIF4E knockdown.
%% Edit freely: every graphics object is drawn by an explicit command below.
% Data: data/Fig06_eIF4E_knockdown.mat (exported from the analysis that produced the published figure).
function Fig06_eIF4E_knockdown(outdir)
if nargin < 1, outdir = fullfile(fileparts(mfilename('fullpath')), 'Figures'); end
if ~exist(outdir, 'dir'), mkdir(outdir); end
D = load(fullfile(fileparts(mfilename('fullpath')), 'data', 'Fig06_eIF4E_knockdown.mat'));
fig = figure('Units', 'inches', 'Position', [0.5 0.5 14.000 5.200], 'Color', 'w', 'PaperUnits', 'inches', 'PaperSize', [14.000 5.200], 'PaperPosition', [0 0 14.000 5.200]);
set(fig, 'DefaultAxesFontWeight', 'bold', 'DefaultTextFontWeight', 'bold', 'DefaultAxesFontName', 'Helvetica', 'DefaultTextFontName', 'Helvetica');
% ---------------- axes 1 
ax = axes(fig, 'Position', [0.0587 0.1295 0.4108 0.7240]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
plot(ax, D.v1, D.v2, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v3, D.v4, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 2.25);
plot(ax, D.v5, D.v6, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v7, D.v8, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 2.25);
plot(ax, D.v9, D.v10, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v11, D.v12, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v13, D.v14, 'Color', [0.753 0.224 0.169], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v15, D.v16, 'Color', [0.753 0.224 0.169], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v17, D.v18, 'Color', [0.122 0.306 0.612], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v19, D.v20, 'Color', [0.122 0.306 0.612], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v21, D.v22, 'Color', [0.106 0.498 0.231], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v23, D.v24, 'Color', [0.106 0.498 0.231], 'LineStyle', '-', 'LineWidth', 3.00);
text(ax, -0.13, 1.03, '(A)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
plot(ax, D.v25, D.v26, 'Color', [0.122 0.467 0.706], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v27, D.v28, 'Color', [1.000 0.498 0.055], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v29, D.v30, 'Color', [0.173 0.627 0.173], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v31, D.v32, 'Color', [0.839 0.153 0.157], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
xlabel(ax, 'kin_T (nM)', 'FontSize', 12.0); ylabel(ax, 'eIF4F (nM)', 'FontSize', 12.0);
xlim(ax, [0 300]); ylim(ax, [-10.3228 220.967]);
set(ax, 'XTick', [0 50 100 150 200 250 300], 'XTickLabel', {'0', '50', '100', '150', '200', '250', '300'});
set(ax, 'YTick', [0 50 100 150 200], 'YTickLabel', {'0', '50', '100', '150', '200'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = plot(ax, NaN, NaN, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.133 0.133 0.133]);
hl(2) = plot(ax, NaN, NaN, 'Color', [0.753 0.224 0.169], 'LineStyle', '-', 'LineWidth', 3.00, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.753 0.224 0.169]);
hl(3) = plot(ax, NaN, NaN, 'Color', [0.122 0.306 0.612], 'LineStyle', '-', 'LineWidth', 3.00, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.122 0.306 0.612]);
hl(4) = plot(ax, NaN, NaN, 'Color', [0.106 0.498 0.231], 'LineStyle', '-', 'LineWidth', 3.00, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.106 0.498 0.231]);
lg = legend(ax, hl(1:4), {'control', 'eIF4E 10%', 'eIF4E 10% + 4E-BP 10%', 'eIF4E 10% + 4E-BP 30%'}, 'Location', 'east', 'FontSize', 9.0, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.3129 0.4158 0.1520 0.1515]); catch, end
% ---------------- axes 2 
ax = axes(fig, 'Position', [0.5405 0.1295 0.4108 0.7240]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 8.5, 'Layer', 'top');
patch(ax, D.v33, D.v34, [0.541 0.541 0.541], 'FaceColor', [0.541 0.541 0.541], 'FaceAlpha', 1.00, 'EdgeColor', 'none', 'LineWidth', 1.00, 'LineStyle', '-');
patch(ax, D.v35, D.v36, [0.541 0.541 0.541], 'FaceColor', [0.541 0.541 0.541], 'FaceAlpha', 1.00, 'EdgeColor', 'none', 'LineWidth', 1.00, 'LineStyle', '-');
patch(ax, D.v37, D.v38, [0.541 0.541 0.541], 'FaceColor', [0.541 0.541 0.541], 'FaceAlpha', 1.00, 'EdgeColor', 'none', 'LineWidth', 1.00, 'LineStyle', '-');
patch(ax, D.v39, D.v40, [0.541 0.541 0.541], 'FaceColor', [0.541 0.541 0.541], 'FaceAlpha', 1.00, 'EdgeColor', 'none', 'LineWidth', 1.00, 'LineStyle', '-');
text(ax, -0.13, 1.03, '(B)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
xlabel(ax, '', 'FontSize', 12.0); ylabel(ax, 'eIF4F (nM)', 'FontSize', 12.0);
xlim(ax, [-0.59 3.59]); ylim(ax, [0 220.801]);
set(ax, 'XTick', [0 1 2 3], 'XTickLabel', {'control', 'eIF4E 10%', 'eIF4E 10% + 4E-BP 10%', 'eIF4E 10% + 4E-BP 30%'});
set(ax, 'XTickLabelRotation', 12);
set(ax, 'YTick', [0 25 50 75 100 125 150 175 200], 'YTickLabel', {'0', '25', '50', '75', '100', '125', '150', '175', '200'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = patch(ax, NaN, NaN, [0.541 0.541 0.541], 'FaceColor', [0.541 0.541 0.541], 'FaceAlpha', 1.00, 'EdgeColor', 'none');
hl(2) = patch(ax, NaN, NaN, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 1.00, 'EdgeColor', 'none');
lg = legend(ax, hl(1:2), {'eIF4F (nM) at kin_T = 300 nM', '% of eIF4E in eIF4F'}, 'Location', 'north', 'FontSize', 8.5, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.5978 0.9171 0.2962 0.0409]); catch, end
% ---------------- axes 3 
ax = axes(fig, 'Position', [0.5405 0.1295 0.4108 0.7240]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
set(ax, 'YAxisLocation', 'right', 'Color', 'none');
set(ax, 'Color', 'none');
patch(ax, D.v41, D.v42, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 1.00, 'EdgeColor', 'none', 'LineWidth', 1.00, 'LineStyle', '-');
patch(ax, D.v43, D.v44, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 1.00, 'EdgeColor', 'none', 'LineWidth', 1.00, 'LineStyle', '-');
patch(ax, D.v45, D.v46, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 1.00, 'EdgeColor', 'none', 'LineWidth', 1.00, 'LineStyle', '-');
patch(ax, D.v47, D.v48, [0.122 0.306 0.612], 'FaceColor', [0.122 0.306 0.612], 'FaceAlpha', 1.00, 'EdgeColor', 'none', 'LineWidth', 1.00, 'LineStyle', '-');
xlabel(ax, '', 'FontSize', 12.0); ylabel(ax, '% of eIF4E in eIF4F', 'FontSize', 12.0);
xlim(ax, [-0.59 3.59]); ylim(ax, [0 70]);
set(ax, 'XTick', [0 1 2 3], 'XTickLabel', {'control', 'eIF4E 10%', 'eIF4E 10% + 4E-BP 10%', 'eIF4E 10% + 4E-BP 30%'});
set(ax, 'XTickLabel', {});
set(ax, 'YTick', [0 10 20 30 40 50 60 70], 'YTickLabel', {'0', '10', '20', '30', '40', '50', '60', '70'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
print(fig, fullfile(outdir, 'Fig06_eIF4E_knockdown.pdf'), '-dpdf', '-painters');
print(fig, fullfile(outdir, 'Fig06_eIF4E_knockdown.png'), '-dpng', '-r150');
end
