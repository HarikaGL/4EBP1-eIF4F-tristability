% Fig04_prozone: redraws Fig 4. Prozone effect in eIF4F assembly (panel D computed; A-C schematic).
%% Edit freely: every graphics object is drawn by an explicit command below.
% Data: data/Fig04_prozone.mat (exported from the analysis that produced the published figure).
function Fig04_prozone(outdir)
if nargin < 1, outdir = fullfile(fileparts(mfilename('fullpath')), 'Figures'); end
if ~exist(outdir, 'dir'), mkdir(outdir); end
D = load(fullfile(fileparts(mfilename('fullpath')), 'data', 'Fig04_prozone.mat'));
fig = figure('Units', 'inches', 'Position', [0.5 0.5 11.000 10.500], 'Color', 'w', 'PaperUnits', 'inches', 'PaperSize', [11.000 10.500], 'PaperPosition', [0 0 11.000 10.500]);
set(fig, 'DefaultAxesFontWeight', 'bold', 'DefaultTextFontWeight', 'bold', 'DefaultAxesFontName', 'Helvetica', 'DefaultTextFontName', 'Helvetica');
% ---------------- axes 1 
ax = axes(fig, 'Position', [0.0300 0.5000 0.9400 0.4900]); hold(ax, 'on'); box(ax, 'on');
axis(ax, 'off');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
image(ax, 'XData', [0 1179], 'YData', [0 749], 'CData', D.v1);
text(ax, 0.165, 0.115, {'e4G_T = 300 nM', 'e4F = 233 nM'}, 'Units', 'normalized', 'FontSize', 10.5, 'FontWeight', 'bold', 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off', 'BackgroundColor', [1.000 1.000 1.000], 'Margin', 1);
text(ax, 0.455, 0.115, {'e4G_T = 1449 nM', 'e4F = 668 nM'}, 'Units', 'normalized', 'FontSize', 10.5, 'FontWeight', 'bold', 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off', 'BackgroundColor', [1.000 1.000 1.000], 'Margin', 1);
text(ax, 0.765, 0.115, {'e4G_T = 6000 nM', 'e4F = 123 nM'}, 'Units', 'normalized', 'FontSize', 10.5, 'FontWeight', 'bold', 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off', 'BackgroundColor', [1.000 1.000 1.000], 'Margin', 1);
xlabel(ax, '', 'FontSize', 12.0); ylabel(ax, '', 'FontSize', 12.0);
xlim(ax, [-0.5 1179.5]); ylim(ax, [-0.5 749.5]);
set(ax, 'YDir', 'reverse');
set(ax, 'XTick', [0 200 400 600 800 1000], 'XTickLabel', {'0', '200', '400', '600', '800', '1000'});
set(ax, 'YTick', [0 100 200 300 400 500 600 700], 'YTickLabel', {'0', '100', '200', '300', '400', '500', '600', '700'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
% ---------------- axes 2 
ax = axes(fig, 'Position', [0.1000 0.0600 0.8600 0.3800]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
patch(ax, D.v2, D.v3, [0.933 0.933 0.933], 'FaceColor', [0.933 0.933 0.933], 'FaceAlpha', 1.00, 'EdgeColor', [0.933 0.933 0.933], 'LineWidth', 1.00, 'LineStyle', '-');
plot(ax, D.v4, D.v5, 'Color', [0.620 0.792 0.882], 'LineStyle', '-', 'LineWidth', 2.50);
plot(ax, D.v6, D.v7, 'Color', [0.259 0.573 0.776], 'LineStyle', '-', 'LineWidth', 2.50);
plot(ax, D.v8, D.v9, 'Color', [0.031 0.188 0.420], 'LineStyle', '-', 'LineWidth', 2.50);
plot(ax, D.v10, D.v11, 'Color', [0.122 0.467 0.706], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.753 0.224 0.169], 'MarkerEdgeColor', [0.000 0.000 0.000], 'LineWidth', 1.50);
plot(ax, D.v12, D.v13, 'Color', [1.000 0.498 0.055], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.753 0.224 0.169], 'MarkerEdgeColor', [0.000 0.000 0.000], 'LineWidth', 1.50);
plot(ax, D.v14, D.v15, 'Color', [0.173 0.627 0.173], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.753 0.224 0.169], 'MarkerEdgeColor', [0.000 0.000 0.000], 'LineWidth', 1.50);
annotation(fig, 'line', [0.2161 0.1323], [0.1451 0.1734], 'Color', [0.753 0.224 0.169], 'LineWidth', 1.0);
text(ax, 1276.65, 166.322, {'(A) e4G_T = 300 nM', '     e4F = 233 nM'}, 'FontSize', 10.0, 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Interpreter', 'tex');
text(ax, 0.20162, 0.81735, {'(B) e4G_T = 1449 nM', '     e4F = 668 nM'}, 'Units', 'normalized', 'FontSize', 10.0, 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
annotation(fig, 'line', [0.8386 0.7450], [0.1908 0.1201], 'Color', [0.753 0.224 0.169], 'LineWidth', 1.0);
text(ax, 6895.6, 234.809, {'(C) e4G_T = 6000 nM', '     e4F = 123 nM'}, 'FontSize', 10.0, 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Interpreter', 'tex');
text(ax, 3050, 740, '\leftarrow{} reported range, e4G_T/e4E_T = 0.3-3', 'Units', 'data', 'FontSize', 9.0, 'FontWeight', 'bold', 'Color', [0.541 0.541 0.541], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, -0.08, 1.03, '(D)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
xlabel(ax, 'e4G_T (nM)', 'FontSize', 12.0); ylabel(ax, 'e4F (nM)', 'FontSize', 12.0);
title(ax, 'Scaffold module alone (R18-R21), e4E_T = 1000 nM', 'FontSize', 11.0);
xlim(ax, [0 8000]); ylim(ax, [0 780]);
set(ax, 'XTick', [0 1000 2000 3000 4000 5000 6000 7000 8000], 'XTickLabel', {'0', '1000', '2000', '3000', '4000', '5000', '6000', '7000', '8000'});
set(ax, 'YTick', [0 100 200 300 400 500 600 700], 'YTickLabel', {'0', '100', '200', '300', '400', '500', '600', '700'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = plot(ax, NaN, NaN, 'Color', [0.620 0.792 0.882], 'LineStyle', '-', 'LineWidth', 2.50, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.620 0.792 0.882]);
hl(2) = plot(ax, NaN, NaN, 'Color', [0.259 0.573 0.776], 'LineStyle', '-', 'LineWidth', 2.50, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.259 0.573 0.776]);
hl(3) = plot(ax, NaN, NaN, 'Color', [0.031 0.188 0.420], 'LineStyle', '-', 'LineWidth', 2.50, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.031 0.188 0.420]);
lg = legend(ax, hl(1:3), {'e4A_T = 500 nM', 'e4A_T = 1000 nM', 'e4A_T = 2000 nM'}, 'Location', 'northeast', 'FontSize', 9.0, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.8107 0.3755 0.1436 0.0586]); catch, end
print(fig, fullfile(outdir, 'Fig04_prozone.pdf'), '-dpdf', '-painters');
print(fig, fullfile(outdir, 'Fig04_prozone.png'), '-dpng', '-r150');
end
