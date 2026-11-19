%% M17  Reaction loops of the network and their thermodynamic classification (Supplementary Note 3,
%  Supplementary Figs 9 and 11, Supplementary Table 8). The same calculation is in the
%  Mathematica notebook Mathematica/Thermodynamics_4EBP.nb, Sections 9-11.
%  1. Stoichiometric matrix S of R1-R22 (22 reactions x 23 species, rows = reactions; p4e_ssa_tables), its rank,
%     the number of conservation relations (23 - rank) and of independent loops (22 - rank).
%  2. Loops by row reduction of [S | I] (Stanbury and Hoffman): rows whose S-part is zero; their I-part is a loop.
%  3. Every reaction is reversible (all backward constants finite), so every loop has a finite cycle ratio Gamma.
%  4. ATP, ADP and Pi written explicitly into the catalytic steps: the loops that remain use no net ATP.
%  5. ln(Gamma) of every loop with the reference constants: 19.8 for the PdP cycles, 0 for ATP-free loops.
%  6. Deficiency (complexes - linkage classes - rank).
%  Run time: seconds. Output: printed; Results/M17_loops.png/.pdf (Suppl. Fig 9), M17_cycle_ratios.png/.pdf (Suppl. Fig 11).
clearvars; here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e();
[A, St] = p4e_ssa_tables();                       % St: 23 species x 44 channels (forward channel of R_j = 2j-1)
S = St(:, 1:2:end)';                             % 22 reactions x 23 species
r = rank(S); fprintf('S is %d x %d, rank %d: %d conservation relations, %d independent loops\n', size(S), r, 23 - r, 22 - r);
L = p4e_loops(S);
IRR = [2 4 6 8 10 12 14 16];                     % catalytic steps (hatched in the figure)
P = p4e_ref(); lnK = log(P.kf./P.kb);
fprintf('All 22 reactions reversible (every kb > 0): %d; smallest kb = %.3g\n', all(P.kb > 0), min(P.kb));
fprintf('\nLoops of R1-R22 (row reduction of [S | I]):\n');
for i = 1:size(L, 1)
    fprintf('  L%d: %-34s ln Gamma = %8.4f\n', i, p4e_loopstr(L(i, :)), L(i, :)*lnK');
end
% ATP, ADP and Pi explicit (columns 24-26)
S2 = [S, zeros(22, 3)]; S2([2 4 10 12], 24) = -1; S2([2 4 10 12], 25) = 1; S2([6 8 14 16], 26) = 1;
F = p4e_loops(S2);
fprintf('\nWith ATP, ADP and Pi explicit: rank %d, %d loops (none hydrolyses net ATP):\n', rank(S2), size(F, 1));
for i = 1:size(F, 1)
    fprintf('  F%d: %-60s ln Gamma = %8.4f (required 0)\n', i, p4e_loopstr(F(i, :)), F(i, :)*lnK');
end
% deficiency
cx = {}; edges = zeros(22, 2);
for j = 1:22
    for d = 0:1
        a = sort(A(2*j - 1 + d, A(2*j - 1 + d, :) > 0)); key = mat2str(a);
        k = find(strcmp(cx, key)); if isempty(k), cx{end+1} = key; k = numel(cx); end %#ok<SAGROW>
        edges(j, d + 1) = k;
    end
end
n = numel(cx); lab = 1:n;                         % linkage classes by union-find
for it = 1:n, for j = 1:22, m = min(lab(edges(j, :))); lab(lab == lab(edges(j, 1)) | lab == lab(edges(j, 2))) = m; end, end
l = numel(unique(lab)); fprintf('\nComplexes %d, linkage classes %d, rank %d: deficiency %d\n', n, l, r, n - l - r);
% figure (Supplementary Fig 9)
fig = figure('Color', 'w', 'Position', [50 50 1100 520]);
M = {L, F}; ttl = {'A  loops of R1-R22', 'B  loops with ATP, ADP and P_i explicit'}; nm = {'L', 'F'};
for p = 1:2
    subplot(2, 1, p); X = M{p}; hold on
    for i = 1:size(X, 1)
        for j = 1:22
            col = [1 1 1]; if X(i, j) > 0, col = [0.16 0.40 0.69]; elseif X(i, j) < 0, col = [0.85 0.45 0.10]; end
            rectangle('Position', [j - 0.45, i - 0.45, 0.9, 0.9], 'FaceColor', col, 'EdgeColor', [0.7 0.7 0.7]);
        end
        text(23.2, i, sprintf('ln\\Gamma = %.1f', X(i, :)*lnK'), 'FontSize', 8);
    end
    for j = IRR, plot([j j], [0.4 size(X, 1) + 0.6], ':', 'Color', [0.3 0.3 0.3]); end
    set(gca, 'YDir', 'reverse', 'XTick', 1:22, 'XTickLabel', arrayfun(@(j) sprintf('R%d', j), 1:22, 'UniformOutput', false), ...
        'YTick', 1:size(X, 1), 'YTickLabel', arrayfun(@(i) sprintf('%s%d', nm{p}, i), 1:size(X, 1), 'UniformOutput', false));
    xlim([0.4 25.5]); ylim([0.4 size(X, 1) + 0.6]); title(ttl{p}); box on
end
try, print(fig, fullfile(RES, 'M17_loops.png'), '-dpng', '-r200'); print(fig, fullfile(RES, 'M17_loops.pdf'), '-dpdf'); catch, end
% figure (Supplementary Fig 11): ln Gamma of every loop, and the Haldane split of each PdP cycle
fig2 = figure('Color', 'w', 'Position', [50 50 1000 360]);
subplot(1, 2, 1); g = [L*lnK'; F(1:3, :)*lnK']; bar(g, 0.65); hold on; plot([0.5 numel(g)+0.5], [19.8 19.8], 'k:');
set(gca, 'XTickLabel', [arrayfun(@(i) sprintf('L%d', i), 1:size(L, 1), 'UniformOutput', false), {'F1', 'F2', 'F3'}]);
ylabel('ln \Gamma (reference set)'); title('a  ln \Gamma of every loop'); box off
subplot(1, 2, 2); cyc = [1 2 7 8; 3 4 5 6; 9 10 15 16; 11 12 13 14]; KK = zeros(4, 2);
for q = 1:4, KK(q, :) = [lnK(cyc(q, 1)) + lnK(cyc(q, 2)), lnK(cyc(q, 3)) + lnK(cyc(q, 4))]; end
barh(4:-1:1, KK, 'stacked'); hold on; plot([19.8 19.8], [0.5 4.5], 'k:');
set(gca, 'YTick', 1:4, 'YTickLabel', {'cycle 4', 'cycle 3', 'cycle 2', 'cycle 1'}); xlabel('ln K');
legend('ln K^{kin}', 'ln K^{P}', 'Location', 'southoutside', 'Orientation', 'horizontal'); title('b  Haldane split of the ATP drive'); box off
fprintf('\nHaldane split (ln Kkin, ln KP, sum):\n'); disp([KK, sum(KK, 2)]);
try, print(fig2, fullfile(RES, 'M17_cycle_ratios.png'), '-dpng', '-r200'); print(fig2, fullfile(RES, 'M17_cycle_ratios.pdf'), '-dpdf'); catch, end
