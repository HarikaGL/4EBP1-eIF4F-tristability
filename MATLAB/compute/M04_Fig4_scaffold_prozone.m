%% M04  Fig 4D and Section 3.3 (first part): the scaffold module alone (R18-R21) is graded and biphasic (prozone).
%  The scaffold loop uses no ATP (Eq 2), so all four reactions are at equilibrium at steady state and the steady state
%  is the solution of three conservation equations in the free pools e4E, e4G, e4A:
%     e4E_T = e4E + e4GE + e4F,  e4G_T = e4G + e4GE + e4GA + e4F,  e4A_T = e4A + e4GA + e4F,
%     e4GE = e4E e4G/K_D18,  e4GA = e4G e4A/K_D20,  e4F = e4GE e4A/K_D19.
%  1. e4F against e4G_T (1-10^4 nM) for e4E_T = 1000 nM and e4A_T = 500, 1000, 2000 nM, reference affinities (Fig 4D);
%     e4F at e4G_T = 300 (reference), at the maximum, and at 6000 nM (the three schematic panels A-C).
%  2. Uniqueness: 10^4 sets of affinities and totals drawn from the admissible ranges; for each, the equations are
%     solved from three starting points and the solutions compared (a single steady state in every set).
%  Run time: about a minute. Output: printed, Results/M04_prozone.mat, Results/M04_Fig4D.png.
clearvars -except QUICK; here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e();
P = p4e_ref(); KD = P.kb(18:21)./P.kf(18:21); ET = 1000;
G = logspace(0, 4, 400); AT = [500 1000 2000]; F = zeros(numel(AT), numel(G));
for a = 1:numel(AT)
    z = [];
    for q = 1:numel(G)
        [F(a, q), z] = p4e_scaffold_alone(KD, [ET G(q) AT(a)], z);
    end
end
fig = figure('Color', 'w', 'Position', [50 50 700 450]); plot(G, F', 'LineWidth', 2);
xlabel('e4G_T (nM)'); ylabel('e4F (nM)'); legend('e4A_T = 500', '1000', '2000'); xlim([0 8000]);
print(fig, fullfile(RES, 'M04_Fig4D.png'), '-dpng', '-r150');
a = 3; [Fm, im] = max(F(a, :));
f300 = interp1(G, F(a, :), 300); f6000 = interp1(G, F(a, :), 6000);
fprintf('e4A_T = 2000 nM: e4F = %.0f nM at e4G_T = 300 (reference); maximum %.0f nM at e4G_T = %.0f nM; %.0f nM at 6000 nM\n', ...
        f300, Fm, G(im), f6000);

%% uniqueness over 10^4 random sets (affinities and abundances in the admissible ranges of Section 2.2)
rng(1); n = 10000; if exist('QUICK', 'var') && QUICK, n = 300; end; nmulti = 0;
for s = 1:n
    KDs = [10^(log10(5) + rand*log10(6)), 10^(log10(50) + rand*log10(20)), 10^(log10(50) + rand*log10(20))];  % K_D18 5-30, K_D19, K_D20 50-1000
    KDs(4) = KDs(1)*KDs(2)/KDs(3);                                                                         % Eq 2
    ETs = 10^(log10(50) + rand*log10(20)); tots = [ETs, ETs*10^(log10(0.3) + rand*1), ETs*10^(rand)];
    sols = [];
    for st = [0.01 0.5 0.99]
        [Fs, z] = p4e_scaffold_alone(KDs, tots, log(st*tots));
        E = exp(z(1)); Gf = exp(z(2)); A = exp(z(3)); GE = E*Gf/KDs(1); GA = Gf*A/KDs(3);
        ok = abs((E + GE + Fs)/tots(1) - 1) < 1e-8 && abs((Gf + GE + GA + Fs)/tots(2) - 1) < 1e-8 && abs((A + GA + Fs)/tots(3) - 1) < 1e-8;
        if ok, sols(end+1) = Fs; end %#ok<AGROW>
    end
    if numel(sols) > 1 && (max(sols) - min(sols)) > 1e-6*max(sols), nmulti = nmulti + 1; end
end
fprintf('random scaffold sets with more than one steady state: %d of %d\n', nmulti, n);
save(fullfile(RES, 'M04_prozone.mat'), 'G', 'AT', 'F', '-v7');
