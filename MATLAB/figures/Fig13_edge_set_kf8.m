% Fig13_edge_set_kf8: redraws Fig 13. Stochastic behaviour at the edge of tristability, k_f8 x 8.94.
%% Edit freely: every graphics object is drawn by an explicit command below.
% Data: data/Fig13_edge_set_kf8.mat (exported from the analysis that produced the published figure).
function Fig13_edge_set_kf8(outdir)
if nargin < 1, outdir = fullfile(fileparts(mfilename('fullpath')), 'Figures'); end
if ~exist(outdir, 'dir'), mkdir(outdir); end
D = load(fullfile(fileparts(mfilename('fullpath')), 'data', 'Fig13_edge_set_kf8.mat'));
fig = figure('Units', 'inches', 'Position', [0.5 0.5 18.000 15.500], 'Color', 'w', 'PaperUnits', 'inches', 'PaperSize', [18.000 15.500], 'PaperPosition', [0 0 18.000 15.500]);
set(fig, 'DefaultAxesFontWeight', 'bold', 'DefaultTextFontWeight', 'bold', 'DefaultAxesFontName', 'Helvetica', 'DefaultTextFontName', 'Helvetica');
% ---------------- axes 1 
ax = axes(fig, 'Position', [0.1250 0.6933 0.4593 0.1867]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
patch(ax, D.v1, D.v2, [0.910 0.910 0.910], 'FaceColor', [0.910 0.910 0.910], 'FaceAlpha', 1.00, 'EdgeColor', [0.910 0.910 0.910], 'LineWidth', 1.00, 'LineStyle', '-');
patch(ax, D.v3, D.v4, [0.604 0.604 0.604], 'FaceColor', [0.604 0.604 0.604], 'FaceAlpha', 1.00, 'EdgeColor', [0.604 0.604 0.604], 'LineWidth', 1.00, 'LineStyle', '-');
plot(ax, D.v5, D.v6, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v7, D.v8, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 2.25);
plot(ax, D.v9, D.v10, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v11, D.v12, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 2.25);
plot(ax, D.v13, D.v14, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v15, D.v16, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 2.20);
plot(ax, D.v17, D.v18, 'Color', [0.827 0.329 0.000], 'LineStyle', '--', 'LineWidth', 2.20);
plot(ax, D.v19, D.v20, 'Color', [0.753 0.224 0.169], 'LineStyle', '--', 'LineWidth', 2.20);
text(ax, 130.3, 300, '126.3 nM', 'Units', 'data', 'FontSize', 11.0, 'FontWeight', 'bold', 'Color', [0.133 0.133 0.133], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top', 'Rotation', 90, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 234, 300, '230 nM', 'Units', 'data', 'FontSize', 11.0, 'FontWeight', 'bold', 'Color', [0.827 0.329 0.000], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top', 'Rotation', 90, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 404, 300, '400 nM', 'Units', 'data', 'FontSize', 11.0, 'FontWeight', 'bold', 'Color', [0.753 0.224 0.169], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top', 'Rotation', 90, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 212.383, -12, 'SN_1 212.4', 'Units', 'data', 'FontSize', 10.0, 'FontWeight', 'bold', 'Color', [0.122 0.306 0.612], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 37.2242, -12, 'SN_4 37.2', 'Units', 'data', 'FontSize', 10.0, 'FontWeight', 'bold', 'Color', [0.122 0.306 0.612], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, -0.07, 1.03, '(A)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
plot(ax, D.v21, D.v22, 'Color', [0.122 0.467 0.706], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v23, D.v24, 'Color', [1.000 0.498 0.055], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v25, D.v26, 'Color', [0.173 0.627 0.173], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v27, D.v28, 'Color', [0.839 0.153 0.157], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 7.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
xlabel(ax, 'kin_T (nM)', 'FontSize', 12.0); ylabel(ax, 'e4F (nM)', 'FontSize', 12.0);
title(ax, 'k_{f8} \times{} 8.94 (faster M1 phosphatase): deterministic steady states', 'FontSize', 11.0);
xlim(ax, [0 450]); ylim(ax, [-35 330]);
set(ax, 'XTick', [0 50 100 150 200 250 300 350 400 450], 'XTickLabel', {'0', '50', '100', '150', '200', '250', '300', '350', '400', '450'});
set(ax, 'YTick', [0 50 100 150 200 250 300], 'YTickLabel', {'0', '50', '100', '150', '200', '250', '300'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
% ---------------- axes 2 (inset_axes)
ax = axes(fig, 'Position', [0.3822 0.7493 0.1332 0.0840]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 8.5, 'Layer', 'top');
patch(ax, D.v29, D.v30, [0.604 0.604 0.604], 'FaceColor', [0.604 0.604 0.604], 'FaceAlpha', 1.00, 'EdgeColor', [0.604 0.604 0.604], 'LineWidth', 1.00, 'LineStyle', '-');
plot(ax, D.v31, D.v32, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v33, D.v34, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 1.65);
plot(ax, D.v35, D.v36, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v37, D.v38, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 1.65);
plot(ax, D.v39, D.v40, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v41, D.v42, 'Color', [0.106 0.498 0.231], 'LineStyle', '--', 'LineWidth', 1.80);
plot(ax, D.v43, D.v44, 'Color', [0.122 0.467 0.706], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 5.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v45, D.v46, 'Color', [1.000 0.498 0.055], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 5.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v47, D.v48, 'Color', [0.173 0.627 0.173], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 5.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v49, D.v50, 'Color', [0.839 0.153 0.157], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 5.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
xlabel(ax, 'kin_T (nM)', 'FontSize', 9.0); ylabel(ax, 'e4F (nM)', 'FontSize', 9.0);
title(ax, 'State II: 125.24-127.32 nM only', 'FontSize', 9.5);
xlim(ax, [123 130]); ylim(ax, [-5 260]);
set(ax, 'XTick', [124 126 128 130], 'XTickLabel', {'124', '126', '128', '130'});
set(ax, 'YTick', [0 100 200], 'YTickLabel', {'0', '100', '200'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
% ---------------- axes 3 
ax = axes(fig, 'Position', [0.6704 0.6933 0.2296 0.1867]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
plot(ax, D.v51, D.v52, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 2.50, 'Marker', 'o', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.133 0.133 0.133], 'MarkerEdgeColor', [0.133 0.133 0.133]);
plot(ax, D.v53, D.v54, 'Color', [0.133 0.133 0.133], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'v', 'MarkerSize', 8.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.133 0.133 0.133], 'LineWidth', 1.50);
plot(ax, D.v55, D.v56, 'Color', [0.133 0.133 0.133], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'v', 'MarkerSize', 8.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.133 0.133 0.133], 'LineWidth', 1.50);
plot(ax, D.v57, D.v58, 'Color', [0.541 0.541 0.541], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 's', 'MarkerSize', 8.0, 'MarkerFaceColor', [0.541 0.541 0.541], 'MarkerEdgeColor', [0.541 0.541 0.541], 'LineWidth', 1.50);
plot(ax, D.v59, D.v60, 'Color', [0.541 0.541 0.541], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', '^', 'MarkerSize', 9.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.541 0.541 0.541], 'LineWidth', 1.50);
plot(ax, D.v61, D.v62, 'Color', [0.541 0.541 0.541], 'LineStyle', ':', 'LineWidth', 1.50);
text(ax, 212.383, 0.3, ' SN_1', 'Units', 'data', 'FontSize', 10.0, 'FontWeight', 'bold', 'Color', [0.541 0.541 0.541], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'baseline', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, -0.2, 1.03, '(B)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
plot(ax, D.v63, D.v64, 'Color', [0.133 0.133 0.133], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', '^', 'MarkerSize', 11.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.133 0.133 0.133], 'LineWidth', 2.00);
plot(ax, D.v65, D.v66, 'Color', [0.827 0.329 0.000], 'LineWidth', 2.00, 'LineStyle', '-');
plot(ax, D.v67, D.v68, 'Color', [0.827 0.329 0.000], 'LineStyle', 'none', 'LineWidth', 2.00, 'Marker', '+', 'MarkerSize', 8.0, 'MarkerFaceColor', [0.827 0.329 0.000], 'MarkerEdgeColor', [0.827 0.329 0.000], 'LineWidth', 2.00);
plot(ax, D.v69, D.v70, 'Color', [0.827 0.329 0.000], 'LineStyle', 'none', 'LineWidth', 2.00, 'Marker', '+', 'MarkerSize', 8.0, 'MarkerFaceColor', [0.827 0.329 0.000], 'MarkerEdgeColor', [0.827 0.329 0.000], 'LineWidth', 2.00);
plot(ax, D.v71, D.v72, 'Color', [0.753 0.224 0.169], 'LineWidth', 2.00, 'LineStyle', '-');
plot(ax, D.v73, D.v74, 'Color', [0.753 0.224 0.169], 'LineStyle', 'none', 'LineWidth', 2.00, 'Marker', '+', 'MarkerSize', 8.0, 'MarkerFaceColor', [0.753 0.224 0.169], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v75, D.v76, 'Color', [0.753 0.224 0.169], 'LineStyle', 'none', 'LineWidth', 2.00, 'Marker', '+', 'MarkerSize', 8.0, 'MarkerFaceColor', [0.753 0.224 0.169], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
plot(ax, D.v77, D.v78, 'Color', [0.827 0.329 0.000], 'LineStyle', 'none', 'LineWidth', 2.00, 'Marker', 's', 'MarkerSize', 9.0, 'MarkerFaceColor', [0.827 0.329 0.000], 'MarkerEdgeColor', [0.827 0.329 0.000], 'LineWidth', 2.00);
plot(ax, D.v79, D.v80, 'Color', [0.753 0.224 0.169], 'LineStyle', 'none', 'LineWidth', 2.00, 'Marker', 's', 'MarkerSize', 9.0, 'MarkerFaceColor', [0.753 0.224 0.169], 'MarkerEdgeColor', [0.753 0.224 0.169], 'LineWidth', 2.00);
xlabel(ax, 'kin_T (nM)', 'FontSize', 12.0); ylabel(ax, 'time to leave State I (h)', 'FontSize', 12.0);
xlim(ax, [0 450]); ylim(ax, [0 24]);
set(ax, 'XTick', [0 100 200 300 400], 'XTickLabel', {'0', '100', '200', '300', '400'});
set(ax, 'YTick', [0 5 10 15 20], 'YTickLabel', {'0', '5', '10', '15', '20'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = plot(ax, NaN, NaN, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 2.50, 'Marker', 'o', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.133 0.133 0.133]);
hl(2) = plot(ax, NaN, NaN, 'Color', [0.541 0.541 0.541], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 's', 'MarkerSize', 8.0, 'MarkerFaceColor', [0.541 0.541 0.541]);
hl(3) = plot(ax, NaN, NaN, 'Color', [0.541 0.541 0.541], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', '^', 'MarkerSize', 9.0, 'MarkerFaceColor', [1.000 1.000 1.000]);
lg = legend(ax, hl(1:3), {'deterministic', 'Gillespie (median, range)', 'did not leave State I in 20 h'}, 'Location', 'northeast', 'FontSize', 8.5, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.7703 0.8396 0.1264 0.0366]); catch, end
% ---------------- axes 4 
ax = axes(fig, 'Position', [0.1250 0.4017 0.2848 0.2074]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
plot(ax, D.v81, D.v82, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v83, D.v84, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v85, D.v86, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v87, D.v88, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v89, D.v90, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v91, D.v92, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v93, D.v94, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v95, D.v96, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v97, D.v98, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v99, D.v100, 'Color', [0.133 0.133 0.133], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v101, D.v102, 'Color', [0.000 0.000 0.000], 'LineStyle', ':', 'LineWidth', 2.50);
plot(ax, D.v103, D.v104, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 1.30);
plot(ax, D.v105, D.v106, 'Color', [0.106 0.498 0.231], 'LineStyle', '--', 'LineWidth', 1.30);
plot(ax, D.v107, D.v108, 'Color', [0.753 0.224 0.169], 'LineStyle', '--', 'LineWidth', 1.30);
text(ax, -0.12, 1.03, '(C)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
xlabel(ax, 'time (h)', 'FontSize', 12.0); ylabel(ax, 'e4F (nM)', 'FontSize', 12.0);
title(ax, 'step to kin_T = 126.3 nM, inside the range of State II  (10 runs, 1 fL)', 'FontSize', 11.0);
xlim(ax, [0 20]); ylim(ax, [-5 280]);
set(ax, 'XTick', [0 2.5 5 7.5 10 12.5 15 17.5 20], 'XTickLabel', {'0.0', '2.5', '5.0', '7.5', '10.0', '12.5', '15.0', '17.5', '20.0'});
set(ax, 'YTick', [0 50 100 150 200 250], 'YTickLabel', {'0', '50', '100', '150', '200', '250'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = plot(ax, NaN, NaN, 'Color', [0.000 0.000 0.000], 'LineStyle', ':', 'LineWidth', 2.50, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.000 0.000 0.000]);
lg = legend(ax, hl(1:1), {'deterministic'}, 'Location', 'northwest', 'FontSize', 9.0, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.1285 0.5905 0.0770 0.0145]); catch, end
% ---------------- axes 5 
ax = axes(fig, 'Position', [0.4172 0.4017 0.0712 0.2074]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'log', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 8.0, 'Layer', 'top');
patch(ax, D.v109, D.v110, [0.133 0.133 0.133], 'FaceColor', [0.133 0.133 0.133], 'FaceAlpha', 0.45, 'EdgeColor', 'none', 'LineWidth', 0.10);
plot(ax, D.v111, D.v112, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 1.30);
plot(ax, D.v113, D.v114, 'Color', [0.106 0.498 0.231], 'LineStyle', '--', 'LineWidth', 1.30);
plot(ax, D.v115, D.v116, 'Color', [0.753 0.224 0.169], 'LineStyle', '--', 'LineWidth', 1.30);
plot(ax, D.v117, D.v118, 'Color', [0.000 0.000 0.000], 'LineStyle', '-', 'LineWidth', 1.10);
xlabel(ax, 'fraction of samples', 'FontSize', 9.0); ylabel(ax, '', 'FontSize', 12.0);
xlim(ax, [1e-05 1.5]); ylim(ax, [-5 280]);
set(ax, 'XTick', [0.0001 0.01 1], 'XTickLabel', {'10^{-4}', '10^{-2}', '1'});
set(ax, 'YTick', [0 50 100 150 200 250], 'YTickLabel', {'', '', '', '', '', ''});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
% ---------------- axes 6 
ax = axes(fig, 'Position', [0.5366 0.4017 0.2848 0.2074]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
plot(ax, D.v119, D.v120, 'Color', [0.827 0.329 0.000], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v121, D.v122, 'Color', [0.827 0.329 0.000], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v123, D.v124, 'Color', [0.827 0.329 0.000], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v125, D.v126, 'Color', [0.827 0.329 0.000], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v127, D.v128, 'Color', [0.827 0.329 0.000], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v129, D.v130, 'Color', [0.827 0.329 0.000], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v131, D.v132, 'Color', [0.827 0.329 0.000], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v133, D.v134, 'Color', [0.827 0.329 0.000], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v135, D.v136, 'Color', [0.827 0.329 0.000], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v137, D.v138, 'Color', [0.827 0.329 0.000], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v139, D.v140, 'Color', [0.000 0.000 0.000], 'LineStyle', ':', 'LineWidth', 2.50);
plot(ax, D.v141, D.v142, 'Color', [0.753 0.224 0.169], 'LineStyle', '--', 'LineWidth', 1.30);
text(ax, -0.12, 1.03, '(D)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
xlabel(ax, 'time (h)', 'FontSize', 12.0); ylabel(ax, 'e4F (nM)', 'FontSize', 12.0);
title(ax, 'step to kin_T = 230 nM, just above SN_1  (10 runs, 1 fL)', 'FontSize', 11.0);
xlim(ax, [0 20]); ylim(ax, [-5 280]);
set(ax, 'XTick', [0 2.5 5 7.5 10 12.5 15 17.5 20], 'XTickLabel', {'0.0', '2.5', '5.0', '7.5', '10.0', '12.5', '15.0', '17.5', '20.0'});
set(ax, 'YTick', [0 50 100 150 200 250], 'YTickLabel', {'0', '50', '100', '150', '200', '250'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = plot(ax, NaN, NaN, 'Color', [0.000 0.000 0.000], 'LineStyle', ':', 'LineWidth', 2.50, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.000 0.000 0.000]);
lg = legend(ax, hl(1:1), {'deterministic'}, 'Location', 'northwest', 'FontSize', 9.0, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.5400 0.5905 0.0770 0.0145]); catch, end
% ---------------- axes 7 
ax = axes(fig, 'Position', [0.8288 0.4017 0.0712 0.2074]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'log', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 8.0, 'Layer', 'top');
patch(ax, D.v143, D.v144, [0.827 0.329 0.000], 'FaceColor', [0.827 0.329 0.000], 'FaceAlpha', 0.45, 'EdgeColor', 'none', 'LineWidth', 0.10);
plot(ax, D.v145, D.v146, 'Color', [0.753 0.224 0.169], 'LineStyle', '--', 'LineWidth', 1.30);
plot(ax, D.v147, D.v148, 'Color', [0.000 0.000 0.000], 'LineStyle', '-', 'LineWidth', 1.10);
xlabel(ax, 'fraction of samples', 'FontSize', 9.0); ylabel(ax, '', 'FontSize', 12.0);
xlim(ax, [1e-05 1.5]); ylim(ax, [-5 280]);
set(ax, 'XTick', [0.0001 0.01 1], 'XTickLabel', {'10^{-4}', '10^{-2}', '1'});
set(ax, 'YTick', [0 50 100 150 200 250], 'YTickLabel', {'', '', '', '', '', ''});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
% ---------------- axes 8 
ax = axes(fig, 'Position', [0.1250 0.1100 0.2848 0.2074]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
plot(ax, D.v149, D.v150, 'Color', [0.753 0.224 0.169], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v151, D.v152, 'Color', [0.753 0.224 0.169], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v153, D.v154, 'Color', [0.753 0.224 0.169], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v155, D.v156, 'Color', [0.753 0.224 0.169], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v157, D.v158, 'Color', [0.753 0.224 0.169], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v159, D.v160, 'Color', [0.753 0.224 0.169], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v161, D.v162, 'Color', [0.753 0.224 0.169], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v163, D.v164, 'Color', [0.753 0.224 0.169], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v165, D.v166, 'Color', [0.753 0.224 0.169], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v167, D.v168, 'Color', [0.753 0.224 0.169], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v169, D.v170, 'Color', [0.000 0.000 0.000], 'LineStyle', ':', 'LineWidth', 2.50);
plot(ax, D.v171, D.v172, 'Color', [0.753 0.224 0.169], 'LineStyle', '--', 'LineWidth', 1.30);
text(ax, -0.12, 1.03, '(E)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
xlabel(ax, 'time (h)', 'FontSize', 12.0); ylabel(ax, 'e4F (nM)', 'FontSize', 12.0);
title(ax, 'step to kin_T = 400 nM, far above SN_1  (10 runs, 1 fL)', 'FontSize', 11.0);
xlim(ax, [0 20]); ylim(ax, [-5 280]);
set(ax, 'XTick', [0 2.5 5 7.5 10 12.5 15 17.5 20], 'XTickLabel', {'0.0', '2.5', '5.0', '7.5', '10.0', '12.5', '15.0', '17.5', '20.0'});
set(ax, 'YTick', [0 50 100 150 200 250], 'YTickLabel', {'0', '50', '100', '150', '200', '250'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = plot(ax, NaN, NaN, 'Color', [0.000 0.000 0.000], 'LineStyle', ':', 'LineWidth', 2.50, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.000 0.000 0.000]);
lg = legend(ax, hl(1:1), {'deterministic'}, 'Location', 'northwest', 'FontSize', 9.0, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.1285 0.2989 0.0770 0.0145]); catch, end
% ---------------- axes 9 
ax = axes(fig, 'Position', [0.4172 0.1100 0.0712 0.2074]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'log', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 8.0, 'Layer', 'top');
patch(ax, D.v173, D.v174, [0.753 0.224 0.169], 'FaceColor', [0.753 0.224 0.169], 'FaceAlpha', 0.45, 'EdgeColor', 'none', 'LineWidth', 0.10);
plot(ax, D.v175, D.v176, 'Color', [0.753 0.224 0.169], 'LineStyle', '--', 'LineWidth', 1.30);
plot(ax, D.v177, D.v178, 'Color', [0.000 0.000 0.000], 'LineStyle', '-', 'LineWidth', 1.10);
xlabel(ax, 'fraction of samples', 'FontSize', 9.0); ylabel(ax, '', 'FontSize', 12.0);
xlim(ax, [1e-05 1.5]); ylim(ax, [-5 280]);
set(ax, 'XTick', [0.0001 0.01 1], 'XTickLabel', {'10^{-4}', '10^{-2}', '1'});
set(ax, 'YTick', [0 50 100 150 200 250], 'YTickLabel', {'', '', '', '', '', ''});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
% ---------------- axes 10 
ax = axes(fig, 'Position', [0.5366 0.1100 0.2848 0.2074]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
plot(ax, D.v179, D.v180, 'Color', [0.106 0.498 0.231], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v181, D.v182, 'Color', [0.106 0.498 0.231], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v183, D.v184, 'Color', [0.106 0.498 0.231], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v185, D.v186, 'Color', [0.106 0.498 0.231], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v187, D.v188, 'Color', [0.106 0.498 0.231], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v189, D.v190, 'Color', [0.106 0.498 0.231], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v191, D.v192, 'Color', [0.106 0.498 0.231], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v193, D.v194, 'Color', [0.106 0.498 0.231], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v195, D.v196, 'Color', [0.106 0.498 0.231], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v197, D.v198, 'Color', [0.106 0.498 0.231], 'LineStyle', '-', 'LineWidth', 0.50);
plot(ax, D.v199, D.v200, 'Color', [0.000 0.000 0.000], 'LineStyle', ':', 'LineWidth', 2.50);
plot(ax, D.v201, D.v202, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 1.30);
plot(ax, D.v203, D.v204, 'Color', [0.106 0.498 0.231], 'LineStyle', '--', 'LineWidth', 1.30);
plot(ax, D.v205, D.v206, 'Color', [0.753 0.224 0.169], 'LineStyle', '--', 'LineWidth', 1.30);
text(ax, -0.12, 1.03, '(F)', 'Units', 'normalized', 'FontSize', 17.0, 'FontWeight', 'bold', 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Rotation', 0, 'Interpreter', 'tex', 'Clipping', 'off');
xlabel(ax, 'time (h)', 'FontSize', 12.0); ylabel(ax, 'e4F (nM)', 'FontSize', 12.0);
title(ax, 'start in State II at kin_T = 126.3 nM  (10 runs, 1 fL)', 'FontSize', 11.0);
xlim(ax, [0 20]); ylim(ax, [-5 280]);
set(ax, 'XTick', [0 2.5 5 7.5 10 12.5 15 17.5 20], 'XTickLabel', {'0.0', '2.5', '5.0', '7.5', '10.0', '12.5', '15.0', '17.5', '20.0'});
set(ax, 'YTick', [0 50 100 150 200 250], 'YTickLabel', {'0', '50', '100', '150', '200', '250'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = plot(ax, NaN, NaN, 'Color', [0.000 0.000 0.000], 'LineStyle', ':', 'LineWidth', 2.50, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.000 0.000 0.000]);
lg = legend(ax, hl(1:1), {'deterministic'}, 'Location', 'northwest', 'FontSize', 9.0, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.5400 0.2989 0.0770 0.0145]); catch, end
% ---------------- axes 11 
ax = axes(fig, 'Position', [0.8288 0.1100 0.0712 0.2074]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'log', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 8.0, 'Layer', 'top');
patch(ax, D.v207, D.v208, [0.106 0.498 0.231], 'FaceColor', [0.106 0.498 0.231], 'FaceAlpha', 0.45, 'EdgeColor', 'none', 'LineWidth', 0.10);
plot(ax, D.v209, D.v210, 'Color', [0.133 0.133 0.133], 'LineStyle', '--', 'LineWidth', 1.30);
plot(ax, D.v211, D.v212, 'Color', [0.106 0.498 0.231], 'LineStyle', '--', 'LineWidth', 1.30);
plot(ax, D.v213, D.v214, 'Color', [0.753 0.224 0.169], 'LineStyle', '--', 'LineWidth', 1.30);
plot(ax, D.v215, D.v216, 'Color', [0.000 0.000 0.000], 'LineStyle', '-', 'LineWidth', 1.10);
xlabel(ax, 'fraction of samples', 'FontSize', 9.0); ylabel(ax, '', 'FontSize', 12.0);
xlim(ax, [1e-05 1.5]); ylim(ax, [-5 280]);
set(ax, 'XTick', [0.0001 0.01 1], 'XTickLabel', {'10^{-4}', '10^{-2}', '1'});
set(ax, 'YTick', [0 50 100 150 200 250], 'YTickLabel', {'', '', '', '', '', ''});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
print(fig, fullfile(outdir, 'Fig13_edge_set_kf8.pdf'), '-dpdf', '-painters');
print(fig, fullfile(outdir, 'Fig13_edge_set_kf8.png'), '-dpng', '-r150');
end
