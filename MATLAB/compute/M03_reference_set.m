%% M03  Fig 3, Table 1, Supplementary Table 1 and the numbers of Section 2.4 (reference parameter set, complete network R1-R22).
%  1. Steady-state curve e4F against kin_T (exact reduction + pseudo-arclength continuation, p4e_trace); the four
%     saddle-node points SN1-SN4, numbered along the curve from the repressed branch; the ranges in which each
%     stable state exists (Fig 3B).
%  2. The three states at kin_T = 66 nM: e4F, eIF4E bound to 4E-BP, phosphoforms, released eIF4E, eIF4F/eIF4G.
%  3. Jumps: e4F before and after SN1 (switching on) and SN4 (switching off).
%  4. Supplementary Table 1: inhibition I = 1 - SN/kin0 needed to cross each point from kin0 = 1.5 SN3.
%  5. Table 1: elasticities e = d ln SN / d ln lambda, central differences between lambda = 1.02 and 1/1.02:
%     enzyme groups (all kf and kb of R1-R4, R5-R8, R9-R12, R13-R16 multiplied by lambda; K_m, K_D and Gamma unchanged),
%     rate groups (kf and kb of R17, R22 or R18-R21 together; K_D unchanged), K_D17 (kf17 x lambda; R17 is written
%     as release), K_D22 (kb22 x lambda), all scaffold K_D (kb18-kb21 x lambda, keeps Eq 2), and each total.
%  6. Stability check: every stable branch at 66 nM is checked on the full ODEs (eigenvalues of the Jacobian).
%  Run time: about 30 continuations (under a minute in MATLAB). Output: printed, Results/M03_reference.mat,
%  Results/M03_Fig3.png, Results/M03_Table1.csv.
clearvars -except QUICK; here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e();
P = p4e_ref(); L = P.links;
C = p4e_trace(P, L, true, 0.01, 5000, 60000); SN = C.SN; f = C.folds(:)';
fprintf('SN1-SN4 (nM, in the order met along the curve): %s\n', sprintf('%.1f  ', SN));
fprintf('order along the kin_T axis: SN%s (SN4 < SN2 < SN1 < SN3)\n', C.order);
fprintf('three states coexist for SN2 < kin_T < SN1: %.1f-%.1f nM (width %.1f nM)\n', SN(2), SN(1), SN(1) - SN(2));
fprintf('State I exists for kin_T < SN1 = %.1f; State II for SN2-SN3 = %.1f-%.1f; State III for kin_T > SN4 = %.1f nM\n', SN(1), SN(2), SN(3), SN(4));

%% Fig 3A
fig = figure('Color', 'w', 'Position', [50 50 800 520]); ax = axes; hold(ax, 'on');
patch(ax, [SN(4) SN(3) SN(3) SN(4)], [0 0 260 260], [0.92 0.92 0.92], 'EdgeColor', 'none');
patch(ax, [SN(2) SN(1) SN(1) SN(2)], [0 0 260 260], [0.75 0.75 0.75], 'EdgeColor', 'none');
p4e_draw(ax, C.kin, C.F, C.folds, [0 0 0], 2.5); plot(ax, C.kin(f), C.F(f), 'o', 'Color', [0.75 0.2 0.15], 'MarkerFaceColor', 'w');
for k = 1:4, text(C.kin(f(k)), C.F(f(k)) + 12, sprintf('SN%d %.1f', k, SN(k)), 'HorizontalAlignment', 'center'); end
xlim(ax, [0 200]); ylim(ax, [0 260]); xlabel(ax, 'kin_T (nM)'); ylabel(ax, 'e4F (nM)'); title(ax, 'Fig 3A: reference set');
print(fig, fullfile(RES, 'M03_Fig3.png'), '-dpng', '-r150');

%% the three states at kin_T = 66 nM
K66 = 66; nm = {'I (repressed)', 'II (partially active)', 'III (fully active)'}; br = [1 3 5];
fprintf('\nStates at kin_T = %g nM\n', K66);
for s = 1:3
    x = p4e_point(C, br(s), K66); [S, Ck, Cp] = p4e_ladder(x, P, L); o = p4e_species(x, P, L, true);
    b = sum(S) + sum(Ck) + sum(Cp); E = exp(x(3)); F = o(6);
    fprintf(['State %-22s e4F %6.1f nM (%.0f%% of eIF4G); eIF4E bound to 4E-BP %5.1f%%; released %5.1f%%;\n', ...
             '      phosphoforms of free eIF4E-bound 4E-BP (S0..S4, %% of their sum): %s\n'], nm{s}, F, 100*F/P.tot(4), ...
            100*b/P.tot(1), 100*(1 - b/P.tot(1)), sprintf('%.0f ', 100*S/sum(S)));
    y = p4e_from_reduced(x, P); ev = eig(p4e_jacobian(y, P, K66));
    fprintf('      largest real part of the Jacobian eigenvalues (full ODEs): %.3g s^-1 (stable if < 0)\n', max(real(ev)));
end
fprintf('eIF4F in State II / State III: %.2f\n', p4e_branch_value(C, C.F, 3, K66)/p4e_branch_value(C, C.F, 5, K66));

%% jumps
fprintf('\nSwitching on at SN1: e4F %.2f -> %.1f nM (%.0f-fold)\n', C.F(f(1)), p4e_branch_value(C, C.F, 3, SN(1)), ...
        p4e_branch_value(C, C.F, 3, SN(1))/C.F(f(1)));
fprintf('Switching on at SN3: e4F %.1f -> %.1f nM\n', C.F(f(3)), p4e_branch_value(C, C.F, 5, SN(3)));
fprintf('Switching off at SN4: e4F %.1f -> %.2f nM (%.0f-fold)\n', C.F(f(4)), p4e_branch_value(C, C.F, 1, SN(4)), ...
        C.F(f(4))/p4e_branch_value(C, C.F, 1, SN(4)));
fprintf('e4F at SN2 and SN3 as a fraction of the maximal e4F (levels of the classification): %.4f, %.4f\n', C.F(f(2))/max(C.F), C.F(f(3))/max(C.F));

%% Supplementary Table 1
kin0 = 1.5*SN(3); fprintf('\nTable 3: kin0 = 1.5 SN3 = %.1f nM\n', kin0);
for k = 1:4, fprintf('SN%d = %6.1f nM   I = 1 - SN/kin0 = %.2f\n', k, SN(k), 1 - SN(k)/kin0); end

%% Table 1: elasticities
rows = {}; E = [];
grp = {'M1 kinase, all rate constants (R1-R4)', 1:4; 'M1 phosphatase, all rate constants (R5-R8)', 5:8; ...
       'M2 kinase, all rate constants (R9-R12)', 9:12; 'M2 phosphatase, all rate constants (R13-R16)', 13:16; ...
       'Release R17, rate', 17; 'Rebinding R22, rate', 22; 'Scaffold R18-R21, rate', 18:21};
for g = 1:size(grp, 1), rows{end+1} = grp{g, 1}; E(end+1, :) = p4e_elast(P, 'rates', grp{g, 2}); end %#ok<SAGROW>
rows{end+1} = 'K_D17 (kf17 x lambda; R17 is written as release)'; E(end+1, :) = p4e_elast(P, 'kf', 17);
rows{end+1} = 'K_D22 (kb22 x lambda)'; E(end+1, :) = p4e_elast(P, 'kb', 22);
rows{end+1} = 'Scaffold, all K_D (kb18-kb21 x lambda)'; E(end+1, :) = p4e_elast(P, 'kb', 18:21);
tn = {'e4E_T', 'BP_T', 'P_T', 'e4G_T', 'e4A_T'};
for t = [3 1 2 4 5], rows{end+1} = tn{t}; E(end+1, :) = p4e_elast(P, 'tot', t); end %#ok<SAGROW>
fid = fopen(fullfile(RES, 'M03_Table1.csv'), 'w'); fprintf(fid, 'scaled quantity,SN1,SN2,SN3,SN4\n');
fprintf('\nTable 2: elasticities of SN1-SN4 (|e| < 0.05 is shown as 0 in the manuscript)\n');
for r = 1:numel(rows)
    fprintf('%-46s %7.2f %7.2f %7.2f %7.2f\n', rows{r}, E(r, :)); fprintf(fid, '"%s",%.3f,%.3f,%.3f,%.3f\n', rows{r}, E(r, :));
end
fclose(fid);
save(fullfile(RES, 'M03_reference.mat'), 'C', 'SN', 'rows', 'E', '-v7');
