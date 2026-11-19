%% M02  Fig 2 and Section 3.1: each phosphorylation module alone is bistable, the two in series are tristable;
%       and the two ingredients of the switch (distributive multisite phosphorylation, enzyme sequestration).
%  (A) M1 (R1-R8) with release and rebinding (R17, R22); (B) M2 (R9-R16) with R17, R22; (C) both modules in series
%  (R1-R17, R22). No scaffold. Free eIF4E against total kinase, 0.01-5000 nM.
%  Numbers of Section 3.1: the saddle-node points of each panel; free eIF4E before and after each jump of (C); the
%  fraction of eIF4E bound to 4E-BP and the fraction of it doubly phosphorylated after the first jump.
%  Ingredient tests: (i) a single phosphorylation site per cycle (one link only, with release) has one steady state
%  for every kin_T; (ii) with free kinase and phosphatase held fixed (no sequestration in complexes), free eIF4E is a
%  monotone function of free kinase, i.e. no bistability, for M1, M2 and both in series.
%  Run time: a few seconds (MATLAB), under a minute (Octave). Output: printed, Results/M02_modules.mat,
%  Results/M02_Fig2.png.
clearvars -except QUICK; here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e();
P = p4e_ref(); L = P.links;
cases = {L(1:2, :), 'M1 alone: R1-R8, R17, R22'; L(3:4, :), 'M2 alone: R9-R16, R17, R22'; L, 'M1 and M2 in series: R1-R17, R22'};
fig = figure('Color', 'w', 'Position', [50 50 1500 430]); C = cell(1, 3);
for k = 1:3
    C{k} = p4e_trace(P, cases{k, 1}, false, 0.01, 5000, 60000);
    fprintf('%-36s saddle-node points (kin_T, nM): %s\n', cases{k, 2}, sprintf('%.1f  ', C{k}.SN));
    ax = subplot(1, 3, k); p4e_draw(ax, C{k}.kin, C{k}.E, C{k}.folds, [0 0 0], 2);
    plot(ax, C{k}.kin(C{k}.folds), C{k}.E(C{k}.folds), 'ro', 'MarkerFaceColor', 'r');
    set(ax, 'XScale', 'log'); xlim(ax, [1 1000]); xlabel(ax, 'kin_T (nM, log scale)'); ylabel(ax, 'free eIF4E (nM)'); title(ax, cases{k, 2});
end
print(fig, fullfile(RES, 'M02_Fig2.png'), '-dpng', '-r150');

%% the two jumps of (C): free eIF4E before and after, and how much eIF4E stays on 4E-BP after the first jump
c = C{3}; f = c.folds(:)';
fprintf('first jump at SN1 = %.1f nM: free eIF4E %.3g -> %.3g nM\n', c.SN(1), c.E(f(1)), p4e_branch_value(c, c.E, 3, c.SN(1)));
fprintf('second jump at SN3 = %.1f nM: free eIF4E %.3g -> %.3g nM\n', c.SN(3), c.E(f(3)), p4e_branch_value(c, c.E, 5, c.SN(3)));
[S, Ck, Cp] = p4e_ladder(p4e_point(c, 3, c.SN(1)), P, L);      % State II just after the first jump
bound = sum(S) + sum(Ck) + sum(Cp);
fprintf('after the first jump: %.0f%% of eIF4E bound to 4E-BP; doubly phosphorylated form %.0f%% of the bound eIF4E\n', ...
        100*bound/P.tot(1), 100*S(3)/bound);

%% ingredient (i): a single phosphorylation site per cycle (one link, with release; no scaffold)
for j = [1 3]
    c1 = p4e_trace(P, L(j, :), false, 0.01, 5000, 60000);
    fprintf('single site (R%d,R%d | R%d,R%d) with release: %d saddle-node points, %d steady state(s)\n', L(j, :), numel(c1.SN), c1.nSS);
end
%% ingredient (ii): free kinase and phosphatase held fixed (no sequestration): at every free kinase level the two
%  remaining conservation equations (eIF4E, 4E-BP) have a single solution, found from five different starting points
names = {'M1', 'M2', 'M1 and M2'}; LL = {L(1:2, :), L(3:4, :), L};
starts = [log(1e-3) log(P.tot(2)); log(1) log(P.tot(2)-P.tot(1)); log(10) log(100); log(300) log(10); log(900) log(1)];
for k = 1:3
    Ks = logspace(-3, 4, 120); nsol = zeros(size(Ks));
    for q = 1:numel(Ks)
        f2 = @(zz) p4e_species([log(Ks(q)) log(P.tot(3)) zz(1) zz(2) 0], P, LL{k}, false);
        g2 = @(zz) p4e_pick(f2(zz), 2:3);
        E = zeros(1, size(starts, 1));
        for s0 = 1:size(starts, 1)
            z = p4e_newton(g2, starts(s0, :)); if max(abs(g2(z))) < 1e-9, E(s0) = exp(z(1)); else, E(s0) = NaN; end
        end
        E = E(~isnan(E)); nsol(q) = numel(unique(round(log(E)*1e6)));
    end
    fprintf('free kinase and phosphatase clamped, %s: number of steady states at each kinase level = %s\n', names{k}, mat2str(unique(nsol)));
end
save(fullfile(RES, 'M02_modules.mat'), 'C', '-v7');
