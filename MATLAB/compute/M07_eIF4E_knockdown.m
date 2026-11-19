%% M07  Supplementary Fig 2 and Section 2.7: model counterpart of the eIF4E knockdown of Yanagiya et al. (2012).
%  e4E_T at 10% of its reference value with 4E-BP unchanged, and with BP_T also at 10% or 30% (degradation of
%  hypophosphorylated 4E-BP); all other parameters at the reference set. For each: the saddle-node points, eIF4F at
%  kin_T = 300 nM and the percentage of total eIF4E in eIF4F.
%  Run time: four continuations. Output: printed, Results/M07_knockdown.mat, Results/M07_SuppFig2.png.
clearvars -except QUICK; here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e();
P = p4e_ref(); cases = {'control', 1, 1; 'e4E_T 10%', 0.1, 1; 'e4E_T 10%, BP_T 10%', 0.1, 0.1; 'e4E_T 10%, BP_T 30%', 0.1, 0.3};
fig = figure('Color', 'w', 'Position', [50 50 1100 430]); ax = subplot(1, 2, 1); hold(ax, 'on'); col = lines(4); F300 = zeros(1, 4); pct = F300;
for k = 1:4
    Q = P; Q.tot(1) = cases{k, 2}*P.tot(1); Q.tot(2) = cases{k, 3}*P.tot(2);
    C = p4e_trace(Q, Q.links, true, 0.01, 5000, 60000); p4e_draw(ax, C.kin, C.F, C.folds, col(k, :), 2);
    F300(k) = p4e_branch_value(C, C.F, numel(C.folds) + 1, 300); pct(k) = 100*F300(k)/Q.tot(1);
    fprintf('%-22s saddle-node points %-30s eIF4F at 300 nM kinase %.0f nM (%.0f%% of eIF4E)\n', cases{k, 1}, sprintf('%.1f ', C.SN), F300(k), pct(k));
end
xlim(ax, [0 400]); xlabel(ax, 'kin_T (nM)'); ylabel(ax, 'e4F (nM)'); legend(ax, cases(:, 1));
ax = subplot(1, 2, 2); bar(ax, [F300; pct]'); set(ax, 'XTickLabel', cases(:, 1)); legend(ax, 'e4F (nM)', '% of eIF4E in eIF4F');
print(fig, fullfile(RES, 'M07_SuppFig2.png'), '-dpng', '-r150');
save(fullfile(RES, 'M07_knockdown.mat'), 'cases', 'F300', 'pct', '-v7');
