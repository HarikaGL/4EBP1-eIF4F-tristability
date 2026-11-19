% Fig6_accessible_range: redraws Fig 6. The most influential parameters of each switch against the accessible kinase range.
%% Edit freely: every graphics object is drawn by an explicit command below.
% Data: data/Fig6_accessible_range.mat (exported from the analysis that produced the published figure).
function Fig6_accessible_range(outdir)
if nargin < 1, outdir = fullfile(fileparts(mfilename('fullpath')), 'Figures'); end
if ~exist(outdir, 'dir'), mkdir(outdir); end
D = load(fullfile(fileparts(mfilename('fullpath')), 'data', 'Fig6_accessible_range.mat'));
fig = figure('Units', 'inches', 'Position', [0.5 0.5 15.000 6.600], 'Color', 'w', 'PaperUnits', 'inches', 'PaperSize', [15.000 6.600], 'PaperPosition', [0 0 15.000 6.600]);
set(fig, 'DefaultAxesFontWeight', 'bold', 'DefaultTextFontWeight', 'bold', 'DefaultAxesFontName', 'Helvetica', 'DefaultTextFontName', 'Helvetica');
% ---------------- axes 1 
ax = axes(fig, 'Position', [0.0600 0.1000 0.4129 0.7400]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
patch(ax, D.v1, D.v2, [0.992 0.831 0.620], 'FaceColor', [0.992 0.831 0.620], 'FaceAlpha', 0.55, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
patch(ax, D.v3, D.v4, [0.851 0.851 0.851], 'FaceColor', [0.851 0.851 0.851], 'FaceAlpha', 0.35, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
patch(ax, D.v5, D.v6, [0.851 0.851 0.851], 'FaceColor', [0.851 0.851 0.851], 'FaceAlpha', 0.35, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
plot(ax, D.v7, D.v8, 'Color', [0.000 0.000 0.000], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v9, D.v10, 'Color', [0.000 0.000 0.000], 'LineStyle', '--', 'LineWidth', 3.00);
plot(ax, D.v11, D.v12, 'Color', [0.000 0.000 0.000], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v13, D.v14, 'Color', [0.000 0.000 0.000], 'LineStyle', '--', 'LineWidth', 3.00);
plot(ax, D.v15, D.v16, 'Color', [0.000 0.000 0.000], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v17, D.v18, 'Color', [0.031 0.318 0.612], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v19, D.v20, 'Color', [0.031 0.318 0.612], 'LineStyle', '--', 'LineWidth', 2.20);
plot(ax, D.v21, D.v22, 'Color', [0.031 0.318 0.612], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v23, D.v24, 'Color', [0.031 0.318 0.612], 'LineStyle', '--', 'LineWidth', 2.20);
plot(ax, D.v25, D.v26, 'Color', [0.031 0.318 0.612], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v27, D.v28, 'Color', [0.192 0.510 0.741], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v29, D.v30, 'Color', [0.192 0.510 0.741], 'LineStyle', '--', 'LineWidth', 2.20);
plot(ax, D.v31, D.v32, 'Color', [0.192 0.510 0.741], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v33, D.v34, 'Color', [0.192 0.510 0.741], 'LineStyle', '--', 'LineWidth', 2.20);
plot(ax, D.v35, D.v36, 'Color', [0.192 0.510 0.741], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v37, D.v38, 'Color', [0.620 0.792 0.882], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v39, D.v40, 'Color', [0.620 0.792 0.882], 'LineStyle', '--', 'LineWidth', 2.20);
plot(ax, D.v41, D.v42, 'Color', [0.620 0.792 0.882], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v43, D.v44, 'Color', [0.620 0.792 0.882], 'LineStyle', '--', 'LineWidth', 2.20);
plot(ax, D.v45, D.v46, 'Color', [0.620 0.792 0.882], 'LineStyle', '-', 'LineWidth', 2.20);
text(ax, 0.33671, 0.0111, 'SN_1', 'Units', 'normalized', 'FontSize', 9.0, 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.2183, 0.089688, 'SN_2', 'Units', 'normalized', 'FontSize', 9.0, 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.47432, 0.622, 'SN_3', 'Units', 'normalized', 'FontSize', 9.0, 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.16231, 0.89365, 'SN_4', 'Units', 'normalized', 'FontSize', 9.0, 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.16088, 0.014479, 'SN_1', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.031 0.318 0.612], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.11196, 0.063361, 'SN_2', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.031 0.318 0.612], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.46776, 0.63036, 'SN_3', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.031 0.318 0.612], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.16006, 0.89427, 'SN_4', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.031 0.318 0.612], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.86074, 0.013048, 'SN_1', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.192 0.510 0.741], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.51216, 0.36907, 'SN_2', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.192 0.510 0.741], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.5205, 0.52104, 'SN_3', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.192 0.510 0.741], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.16011, 0.89393, 'SN_4', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.192 0.510 0.741], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.82396, 0.012814, 'SN_1', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.620 0.792 0.882], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.58191, 0.31276, 'SN_2', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.620 0.792 0.882], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.58832, 0.45674, 'SN_3', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.620 0.792 0.882], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.16032, 0.89389, 'SN_4', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.620 0.792 0.882], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
plot(ax, D.v47, D.v48, 'Color', [0.122 0.467 0.706], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 8.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.000 0.000 0.000], 'LineWidth', 1.80);
plot(ax, D.v49, D.v50, 'Color', [1.000 0.498 0.055], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 8.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.000 0.000 0.000], 'LineWidth', 1.80);
plot(ax, D.v51, D.v52, 'Color', [0.173 0.627 0.173], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 8.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.000 0.000 0.000], 'LineWidth', 1.80);
plot(ax, D.v53, D.v54, 'Color', [0.839 0.153 0.157], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 8.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.000 0.000 0.000], 'LineWidth', 1.80);
plot(ax, D.v55, D.v56, 'Color', [0.031 0.318 0.612], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.031 0.318 0.612], 'MarkerEdgeColor', [0.031 0.318 0.612], 'LineWidth', 1.50);
plot(ax, D.v57, D.v58, 'Color', [0.031 0.318 0.612], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.031 0.318 0.612], 'MarkerEdgeColor', [0.031 0.318 0.612], 'LineWidth', 1.50);
plot(ax, D.v59, D.v60, 'Color', [0.031 0.318 0.612], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.031 0.318 0.612], 'MarkerEdgeColor', [0.031 0.318 0.612], 'LineWidth', 1.50);
plot(ax, D.v61, D.v62, 'Color', [0.031 0.318 0.612], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.031 0.318 0.612], 'MarkerEdgeColor', [0.031 0.318 0.612], 'LineWidth', 1.50);
plot(ax, D.v63, D.v64, 'Color', [0.192 0.510 0.741], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.192 0.510 0.741], 'MarkerEdgeColor', [0.192 0.510 0.741], 'LineWidth', 1.50);
plot(ax, D.v65, D.v66, 'Color', [0.192 0.510 0.741], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.192 0.510 0.741], 'MarkerEdgeColor', [0.192 0.510 0.741], 'LineWidth', 1.50);
plot(ax, D.v67, D.v68, 'Color', [0.192 0.510 0.741], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.192 0.510 0.741], 'MarkerEdgeColor', [0.192 0.510 0.741], 'LineWidth', 1.50);
plot(ax, D.v69, D.v70, 'Color', [0.192 0.510 0.741], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.192 0.510 0.741], 'MarkerEdgeColor', [0.192 0.510 0.741], 'LineWidth', 1.50);
plot(ax, D.v71, D.v72, 'Color', [0.620 0.792 0.882], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.620 0.792 0.882], 'MarkerEdgeColor', [0.620 0.792 0.882], 'LineWidth', 1.50);
plot(ax, D.v73, D.v74, 'Color', [0.620 0.792 0.882], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.620 0.792 0.882], 'MarkerEdgeColor', [0.620 0.792 0.882], 'LineWidth', 1.50);
plot(ax, D.v75, D.v76, 'Color', [0.620 0.792 0.882], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.620 0.792 0.882], 'MarkerEdgeColor', [0.620 0.792 0.882], 'LineWidth', 1.50);
plot(ax, D.v77, D.v78, 'Color', [0.620 0.792 0.882], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.620 0.792 0.882], 'MarkerEdgeColor', [0.620 0.792 0.882], 'LineWidth', 1.50);
xlabel(ax, 'kin_T (nM)', 'FontSize', 12.0); ylabel(ax, 'e4F (nM)', 'FontSize', 12.0);
text(ax, 0, 1.01, '(A) M1 switch (hypophosphorylation): SN_1, SN_2', 'Units', 'normalized', 'FontSize', 13.0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom');
xlim(ax, [0 250]); ylim(ax, [-9.43 235.7]);
set(ax, 'XTick', [0 50 100 150 200 250], 'XTickLabel', {'0', '50', '100', '150', '200', '250'});
set(ax, 'YTick', [0 50 100 150 200], 'YTickLabel', {'0', '50', '100', '150', '200'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = plot(ax, NaN, NaN, 'Color', [0.000 0.000 0.000], 'LineStyle', '-', 'LineWidth', 3.00, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.000 0.000 0.000]);
hl(2) = plot(ax, NaN, NaN, 'Color', [0.031 0.318 0.612], 'LineStyle', '-', 'LineWidth', 2.20, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.031 0.318 0.612]);
hl(3) = plot(ax, NaN, NaN, 'Color', [0.192 0.510 0.741], 'LineStyle', '-', 'LineWidth', 2.20, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.192 0.510 0.741]);
hl(4) = plot(ax, NaN, NaN, 'Color', [0.620 0.792 0.882], 'LineStyle', '-', 'LineWidth', 2.20, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.620 0.792 0.882]);
lg = legend(ax, hl(1:4), {'reference', 'k_{f2} \times{}4.1', 'k_{f8} \times{}8.9', 'k_{f6} \times{}8.5'}, 'Location', 'best', 'FontSize', 10.0, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.3846 0.4027 0.0837 0.1346]); catch, end
% ---------------- axes 2 
ax = axes(fig, 'Position', [0.5721 0.1000 0.4129 0.7400]); hold(ax, 'on'); box(ax, 'on');
set(ax, 'XScale', 'linear', 'YScale', 'linear', 'TickDir', 'in', 'LineWidth', 3.0, 'FontSize', 12.0, 'Layer', 'top');
patch(ax, D.v79, D.v80, [0.992 0.831 0.620], 'FaceColor', [0.992 0.831 0.620], 'FaceAlpha', 0.55, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
patch(ax, D.v81, D.v82, [0.851 0.851 0.851], 'FaceColor', [0.851 0.851 0.851], 'FaceAlpha', 0.35, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
patch(ax, D.v83, D.v84, [0.851 0.851 0.851], 'FaceColor', [0.851 0.851 0.851], 'FaceAlpha', 0.35, 'EdgeColor', 'none', 'LineWidth', 0.10, 'LineStyle', '-');
plot(ax, D.v85, D.v86, 'Color', [0.000 0.000 0.000], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v87, D.v88, 'Color', [0.000 0.000 0.000], 'LineStyle', '--', 'LineWidth', 3.00);
plot(ax, D.v89, D.v90, 'Color', [0.000 0.000 0.000], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v91, D.v92, 'Color', [0.000 0.000 0.000], 'LineStyle', '--', 'LineWidth', 3.00);
plot(ax, D.v93, D.v94, 'Color', [0.000 0.000 0.000], 'LineStyle', '-', 'LineWidth', 3.00);
plot(ax, D.v95, D.v96, 'Color', [0.000 0.427 0.173], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v97, D.v98, 'Color', [0.000 0.427 0.173], 'LineStyle', '--', 'LineWidth', 2.20);
plot(ax, D.v99, D.v100, 'Color', [0.000 0.427 0.173], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v101, D.v102, 'Color', [0.000 0.427 0.173], 'LineStyle', '--', 'LineWidth', 2.20);
plot(ax, D.v103, D.v104, 'Color', [0.000 0.427 0.173], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v105, D.v106, 'Color', [0.192 0.639 0.329], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v107, D.v108, 'Color', [0.192 0.639 0.329], 'LineStyle', '--', 'LineWidth', 2.20);
plot(ax, D.v109, D.v110, 'Color', [0.192 0.639 0.329], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v111, D.v112, 'Color', [0.192 0.639 0.329], 'LineStyle', '--', 'LineWidth', 2.20);
plot(ax, D.v113, D.v114, 'Color', [0.192 0.639 0.329], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v115, D.v116, 'Color', [0.631 0.851 0.608], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v117, D.v118, 'Color', [0.631 0.851 0.608], 'LineStyle', '--', 'LineWidth', 2.20);
plot(ax, D.v119, D.v120, 'Color', [0.631 0.851 0.608], 'LineStyle', '-', 'LineWidth', 2.20);
plot(ax, D.v121, D.v122, 'Color', [0.631 0.851 0.608], 'LineStyle', '--', 'LineWidth', 2.20);
plot(ax, D.v123, D.v124, 'Color', [0.631 0.851 0.608], 'LineStyle', '-', 'LineWidth', 2.20);
text(ax, 0.53316, 0.0111, 'SN_1', 'Units', 'normalized', 'FontSize', 9.0, 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.34278, 0.089688, 'SN_2', 'Units', 'normalized', 'FontSize', 9.0, 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.7544, 0.622, 'SN_3', 'Units', 'normalized', 'FontSize', 9.0, 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.25277, 0.89365, 'SN_4', 'Units', 'normalized', 'FontSize', 9.0, 'Color', [0.000 0.000 0.000], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.53026, 0.014316, 'SN_1', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.000 0.427 0.173], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.30599, 0.17634, 'SN_2', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.000 0.427 0.173], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.30701, 0.22751, 'SN_3', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.000 0.427 0.173], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.045315, 0.89925, 'SN_4', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.000 0.427 0.173], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.52787, 0.014561, 'SN_1', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.192 0.639 0.329], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.29644, 0.29229, 'SN_2', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.192 0.639 0.329], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.30851, 0.50009, 'SN_3', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.192 0.639 0.329], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.11005, 0.88266, 'SN_4', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.192 0.639 0.329], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.5304, 0.014631, 'SN_1', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.631 0.851 0.608], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.31442, 0.33561, 'SN_2', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.631 0.851 0.608], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.32859, 0.60734, 'SN_3', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.631 0.851 0.608], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
text(ax, 0.10158, 0.90251, 'SN_4', 'Units', 'normalized', 'FontSize', 8.5, 'Color', [0.631 0.851 0.608], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Interpreter', 'tex', 'Clipping', 'off');
plot(ax, D.v125, D.v126, 'Color', [0.122 0.467 0.706], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 8.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.000 0.000 0.000], 'LineWidth', 1.80);
plot(ax, D.v127, D.v128, 'Color', [1.000 0.498 0.055], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 8.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.000 0.000 0.000], 'LineWidth', 1.80);
plot(ax, D.v129, D.v130, 'Color', [0.173 0.627 0.173], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 8.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.000 0.000 0.000], 'LineWidth', 1.80);
plot(ax, D.v131, D.v132, 'Color', [0.839 0.153 0.157], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 8.0, 'MarkerFaceColor', [1.000 1.000 1.000], 'MarkerEdgeColor', [0.000 0.000 0.000], 'LineWidth', 1.80);
plot(ax, D.v133, D.v134, 'Color', [0.000 0.427 0.173], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.000 0.427 0.173], 'MarkerEdgeColor', [0.000 0.427 0.173], 'LineWidth', 1.50);
plot(ax, D.v135, D.v136, 'Color', [0.000 0.427 0.173], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.000 0.427 0.173], 'MarkerEdgeColor', [0.000 0.427 0.173], 'LineWidth', 1.50);
plot(ax, D.v137, D.v138, 'Color', [0.000 0.427 0.173], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.000 0.427 0.173], 'MarkerEdgeColor', [0.000 0.427 0.173], 'LineWidth', 1.50);
plot(ax, D.v139, D.v140, 'Color', [0.000 0.427 0.173], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'x', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.000 0.427 0.173], 'MarkerEdgeColor', [0.000 0.000 0.000], 'LineWidth', 1.50);
plot(ax, D.v141, D.v142, 'Color', [0.192 0.639 0.329], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.192 0.639 0.329], 'MarkerEdgeColor', [0.192 0.639 0.329], 'LineWidth', 1.50);
plot(ax, D.v143, D.v144, 'Color', [0.192 0.639 0.329], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.192 0.639 0.329], 'MarkerEdgeColor', [0.192 0.639 0.329], 'LineWidth', 1.50);
plot(ax, D.v145, D.v146, 'Color', [0.192 0.639 0.329], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.192 0.639 0.329], 'MarkerEdgeColor', [0.192 0.639 0.329], 'LineWidth', 1.50);
plot(ax, D.v147, D.v148, 'Color', [0.192 0.639 0.329], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.192 0.639 0.329], 'MarkerEdgeColor', [0.192 0.639 0.329], 'LineWidth', 1.50);
plot(ax, D.v149, D.v150, 'Color', [0.631 0.851 0.608], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.631 0.851 0.608], 'MarkerEdgeColor', [0.631 0.851 0.608], 'LineWidth', 1.50);
plot(ax, D.v151, D.v152, 'Color', [0.631 0.851 0.608], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.631 0.851 0.608], 'MarkerEdgeColor', [0.631 0.851 0.608], 'LineWidth', 1.50);
plot(ax, D.v153, D.v154, 'Color', [0.631 0.851 0.608], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.631 0.851 0.608], 'MarkerEdgeColor', [0.631 0.851 0.608], 'LineWidth', 1.50);
plot(ax, D.v155, D.v156, 'Color', [0.631 0.851 0.608], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.631 0.851 0.608], 'MarkerEdgeColor', [0.631 0.851 0.608], 'LineWidth', 1.50);
xlabel(ax, 'kin_T (nM)', 'FontSize', 12.0); ylabel(ax, 'e4F (nM)', 'FontSize', 12.0);
text(ax, 0, 1.01, '(B) M2 switch (hyperphosphorylation): SN_3, SN_4', 'Units', 'normalized', 'FontSize', 13.0, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom');
xlim(ax, [0 155.5]); ylim(ax, [-9.43 235.7]);
set(ax, 'XTick', [0 20 40 60 80 100 120 140], 'XTickLabel', {'0', '20', '40', '60', '80', '100', '120', '140'});
set(ax, 'YTick', [0 50 100 150 200], 'YTickLabel', {'0', '50', '100', '150', '200'});
set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');
hl(1) = plot(ax, NaN, NaN, 'Color', [0.000 0.000 0.000], 'LineStyle', '-', 'LineWidth', 3.00, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.000 0.000 0.000]);
hl(2) = plot(ax, NaN, NaN, 'Color', [0.000 0.427 0.173], 'LineStyle', '-', 'LineWidth', 2.20, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.000 0.427 0.173]);
hl(3) = plot(ax, NaN, NaN, 'Color', [0.192 0.639 0.329], 'LineStyle', '-', 'LineWidth', 2.20, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.192 0.639 0.329]);
hl(4) = plot(ax, NaN, NaN, 'Color', [0.631 0.851 0.608], 'LineStyle', '-', 'LineWidth', 2.20, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.631 0.851 0.608]);
lg = legend(ax, hl(1:4), {'reference', 'k_{f14} ÷8.8', 'k_{f10} \times{}6.3', 'k_{f11} \times{}6.9'}, 'Location', 'best', 'FontSize', 10.0, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.8967 0.1105 0.0837 0.1346]); catch, end
% figure-level legend
ax = axes(fig, 'Position', [0 0 1 1], 'Visible', 'off'); hold(ax, 'on');
hl(1) = patch(ax, NaN, NaN, [0.992 0.831 0.620], 'FaceColor', [0.992 0.831 0.620], 'FaceAlpha', 0.55, 'EdgeColor', [0.992 0.831 0.620]);
hl(2) = patch(ax, NaN, NaN, [0.851 0.851 0.851], 'FaceColor', [0.851 0.851 0.851], 'FaceAlpha', 0.35, 'EdgeColor', [0.851 0.851 0.851]);
hl(3) = plot(ax, NaN, NaN, 'Color', [0.502 0.502 0.502], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'o', 'MarkerSize', 9.0, 'MarkerFaceColor', [0.502 0.502 0.502]);
hl(4) = plot(ax, NaN, NaN, 'Color', [0.502 0.502 0.502], 'LineStyle', 'none', 'LineWidth', 1.50, 'Marker', 'x', 'MarkerSize', 10.0, 'MarkerFaceColor', [0.502 0.502 0.502]);
hl(5) = plot(ax, NaN, NaN, 'Color', [0.000 0.000 0.000], 'LineStyle', '-', 'LineWidth', 1.50, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.000 0.000 0.000]);
hl(6) = plot(ax, NaN, NaN, 'Color', [0.000 0.000 0.000], 'LineStyle', '--', 'LineWidth', 1.50, 'Marker', 'none', 'MarkerSize', 6.0, 'MarkerFaceColor', [0.000 0.000 0.000]);
lg = legend(ax, hl(1:6), {'experimentally accessible kinase total (10-500 nM)', 'kinase total outside the accessible range', 'saddle-node point inside the accessible range (large: the switch''s own points)', 'outside the accessible range: mathematically present, biologically inaccessible', 'stable', 'unstable'}, 'Location', 'north', 'FontSize', 10.5, 'Interpreter', 'tex'); clear hl
try, set(lg, 'Units', 'normalized', 'Position', [0.0538 0.9160 0.8925 0.0729]); catch, end
legend(ax, 'boxoff');
print(fig, fullfile(outdir, 'Fig6_accessible_range.pdf'), '-dpdf', '-painters');
print(fig, fullfile(outdir, 'Fig6_accessible_range.png'), '-dpng', '-r150');
end
