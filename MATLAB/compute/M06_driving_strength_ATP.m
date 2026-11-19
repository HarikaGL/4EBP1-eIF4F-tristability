%% M06  Section 2.6: how much ATP drive the switch needs.
%  The common ln Gamma of the four PdP cycles is lowered from 19.8 to 0 in steps of 0.1. Binding constants, turnover
%  numbers, the split u of each cycle and the totals stay at the reference values; only the eight product-rebinding
%  constants change (Methods, Step 5: kb_b = sqrt(rho) 10^u, kb_d = sqrt(rho) 10^-u, rho = kf_a kf_b kf_c kf_d /
%  (kb_a kb_c Gamma)). For every value the curve is traced and its saddle-node points counted.
%  Expected: one steady state at ln Gamma = 0 (detailed balance); bistable from ln Gamma = 4.9 (12.6 kJ/mol) and
%  tristable from 10.8 (27.8 kJ/mol); above about 15 the thresholds hardly move.
%  Run time: 199 continuations. Output: printed, Results/M06_drive.mat, Results/M06_drive.png.
clearvars -except QUICK; here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e();
P0 = p4e_ref(); CY = [1 2 7 8; 3 4 5 6; 9 10 15 16; 11 12 13 14]; RT = 8.314*310.15/1000;
lnG = 0:0.1:19.8; if exist('QUICK', 'var') && QUICK, lnG = [0 4.8 4.9 10.7 10.8 15 19.8]; end
SN = nan(numel(lnG), 4); nsn = zeros(size(lnG));
for g = 1:numel(lnG)
    P = P0;
    for c = 1:4
        a = CY(c, 1); b = CY(c, 2); cc = CY(c, 3); d = CY(c, 4); u = 0.5*log10(P0.kb(b)/P0.kb(d));
        rho = P0.kf(a)*P0.kf(b)*P0.kf(cc)*P0.kf(d)/(P0.kb(a)*P0.kb(cc)*exp(lnG(g)));
        P.kb(b) = sqrt(rho)*10^u; P.kb(d) = sqrt(rho)*10^(-u);
    end
    C = p4e_trace(P, P.links, true, 0.01, 5000, 60000); nsn(g) = numel(C.SN); SN(g, 1:min(4, nsn(g))) = C.SN(1:min(4, nsn(g)));
end
ib = find(nsn >= 2, 1); it = find(nsn >= 4, 1);
fprintf('bistable from ln Gamma = %.1f (%.1f kJ/mol); tristable from ln Gamma = %.1f (%.1f kJ/mol)\n', lnG(ib), RT*lnG(ib), lnG(it), RT*lnG(it));
fprintf('reference ln Gamma = 19.8 is %.1f RT above the minimum for tristability\n', 19.8 - lnG(it));
for v = [15 17 19.8], g = find(abs(lnG - v) < 1e-9); if ~isempty(g), fprintf('ln Gamma = %4.1f: SN1-SN4 = %s nM\n', v, sprintf('%.1f ', SN(g, :))); end, end
fig = figure('Color', 'w'); plot(SN, lnG, '.'); xlabel('kin_T at the saddle-node points (nM)'); ylabel('ln \Gamma'); set(gca, 'XScale', 'log');
print(fig, fullfile(RES, 'M06_drive.png'), '-dpng', '-r150');
save(fullfile(RES, 'M06_drive.mat'), 'lnG', 'SN', 'nsn', '-v7');
