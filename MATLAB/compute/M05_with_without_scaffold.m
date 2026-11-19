%% M05  Fig 4 and Section 2.5 (second part): in the complete network the scaffold moves only the switch-off threshold.
%  1. Saddle-node points without the scaffold (R1-R17, R22; free eIF4E) and with it (R1-R22; eIF4F) (Fig 4A-C).
%  2. SN4 with eIF4G doubled and halved.
%  3. Excess eIF4G: SN1-SN4 for e4G_T up to 20 e4E_T; the range in which the three states coexist disappears when
%     SN4 rises above SN1, and at the largest excess one switch remains.
%  4. The prozone inside the switch: at kin_T = 66 nM, eIF4F of each of the three stable states against e4G_T.
%  Run time: about 60 continuations. Output: printed, Results/M05_scaffold.mat, Results/M05_Fig4.png.
clearvars -except QUICK; here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e();
P = p4e_ref(); L = P.links;
C0 = p4e_trace(P, L, false, 0.01, 5000, 60000); C1 = p4e_trace(P, L, true, 0.01, 5000, 60000);
fprintf('without scaffold (R1-R17, R22): SN1-SN4 = %s nM\n', sprintf('%.1f ', C0.SN));
fprintf('with scaffold    (R1-R22):      SN1-SN4 = %s nM\n', sprintf('%.1f ', C1.SN));
fprintf('SN4 raised by %.0f%% (%.1f -> %.1f nM)\n', 100*(C1.SN(4)/C0.SN(4) - 1), C0.SN(4), C1.SN(4));
fig = figure('Color', 'w', 'Position', [50 50 1500 430]);
ax = subplot(1, 3, 1); p4e_draw(ax, C0.kin, C0.E, C0.folds); xlim(ax, [0 200]); xlabel(ax, 'kin_T (nM)'); ylabel(ax, 'free eIF4E (nM)'); title(ax, '(A) without scaffold');
ax = subplot(1, 3, 2); p4e_draw(ax, C1.kin, C1.F, C1.folds); xlim(ax, [0 200]); xlabel(ax, 'kin_T (nM)'); ylabel(ax, 'e4F (nM)'); title(ax, '(B) with scaffold');
ax = subplot(1, 3, 3); hold(ax, 'on'); plot(ax, C0.SN, 1:4, 'ks', C1.SN, 1:4, 'ro'); set(ax, 'YTick', 1:4, 'YTickLabel', {'SN1', 'SN2', 'SN3', 'SN4'});
xlabel(ax, 'kin_T (nM)'); legend(ax, 'without', 'with scaffold'); title(ax, '(C) saddle-node points');
print(fig, fullfile(RES, 'M05_Fig4.png'), '-dpng', '-r150');

%% eIF4G doubled and halved
for l = [2 0.5]
    C = p4e_trace(p4e_scale(P, 'tot', 4, l), L, true, 0.01, 5000, 60000);
    fprintf('e4G_T x %g: SN1-SN4 = %s nM\n', l, sprintf('%.1f ', C.SN));
end
%% excess eIF4G
GT = [300 600 1000 1500 2000 2500 3000 4000 6000 10000 20000]; SNG = nan(numel(GT), 4); nsn = zeros(size(GT));
for g = 1:numel(GT)
    Q = P; Q.tot(4) = GT(g); C = p4e_trace(Q, L, true, 0.01, 5000, 60000); nsn(g) = numel(C.SN);
    SNG(g, 1:min(4, nsn(g))) = C.SN(1:min(4, nsn(g)));
    fprintf('e4G_T = %5d nM (%.1f e4E_T): %d saddle-node points %s; three states coexist: %d\n', GT(g), GT(g)/P.tot(1), nsn(g), ...
            sprintf('%.1f ', C.SN), C.nSS == 5);
end
%% prozone inside the switch: eIF4F of each state at kin_T = 66 nM against e4G_T
GG = logspace(log10(30), log10(6000), 25); F3 = nan(numel(GG), 3);
for g = 1:numel(GG)
    Q = P; Q.tot(4) = GG(g); C = p4e_trace(Q, L, true, 0.01, 5000, 60000);
    if numel(C.SN) == 4, for s = 1:3, F3(g, s) = p4e_branch_value(C, C.F, 2*s - 1, 66); end, end
end
for s = 1:3
    [m, i] = max(F3(:, s)); fprintf('State %s at 66 nM: e4F maximal (%.0f nM) at e4G_T = %.0f nM (biphasic: %d)\n', ...
        repmat('I', 1, s), m, GG(i), i > 1 && i < find(~isnan(F3(:, s)), 1, 'last'));
end
save(fullfile(RES, 'M05_scaffold.mat'), 'C0', 'C1', 'GT', 'SNG', 'GG', 'F3', '-v7');
