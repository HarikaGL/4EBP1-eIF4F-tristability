%% M01  Table 3 (reference parameter set, Methods 4.1), the thermodynamic checks of Section 2.2 and Methods 4.2, and Supplementary Table 4
%       (stochastic rate constants of the 44 Gillespie channels).
%  1. Reference rate constants and totals (p4e_ref) with the derived Michaelis and dissociation constants.
%  2. For each of the four PdP cycles: the half-cycle constants K_kin = kf_a kf_b/(kb_a kb_b), K_P = kf_c kf_d/(kb_c kb_d),
%     ln Gamma = ln(K_kin K_P) (must be 19.8 for all four), and the product-rebinding constants recomputed from Gamma
%     and the split u (Methods, Step 5): rho = kf_a kf_b kf_c kf_d/(kb_a kb_c Gamma), kb_b = sqrt(rho) 10^u,
%     kb_d = sqrt(rho) 10^-u.
%  3. Scaffold loop (Methods, Step 6): K_D21 = K_D18 K_D19 / K_D20 = 111 nM, and the loop ratio (must be 1).
%  4. Supplementary Table 4: c_mu = k_mu (first order) or k_mu/fac (second order), fac = N_A V 1e-24 molecules per nM, V = 1 fL.
%  Runs in under a second. Output: printed, and Results/M01_parameters.csv, Results/M01_SuppTable4.csv.
clearvars -except QUICK; here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e();
P = p4e_ref(); kf = P.kf; kb = P.kb; RT = 8.314*310.15/1000;          % kJ/mol at 37 C
step = {'BPe4E + kin <-> C1', 'C1 <-> BPe4Ep + kin', 'BPe4Ep + kin <-> C2', 'C2 <-> BPe4Epp + kin', ...
        'BPe4Epp + P <-> C3', 'C3 <-> BPe4Ep + P', 'BPe4Ep + P <-> C4', 'C4 <-> BPe4E + P', ...
        'BPe4Epp + kin <-> C5', 'C5 <-> BPe4Ep3 + kin', 'BPe4Ep3 + kin <-> C6', 'C6 <-> BPe4Ep4 + kin', ...
        'BPe4Ep4 + P <-> C7', 'C7 <-> BPe4Ep3 + P', 'BPe4Ep3 + P <-> C8', 'C8 <-> BPe4Epp + P', ...
        'BPe4Ep4 <-> e4E + BPp4', 'e4E + e4G <-> e4GE', 'e4GE + e4A <-> e4F', 'e4G + e4A <-> e4GA', ...
        'e4GA + e4E <-> e4F', 'BP + e4E <-> BPe4E'};
bind = [1 3 5 7 9 11 13 15]; cat = bind + 1;                          % enzyme binding steps and their catalytic steps
fid = fopen(fullfile(RES, 'M01_parameters.csv'), 'w'); fprintf(fid, 'reaction,step,kf,kb,derived\n');
fprintf('\nTable 1. Reference parameter set\n%-4s %-26s %10s %12s   %s\n', 'R', 'step', 'kf', 'kb', 'derived');
for i = 1:22
    if any(i == bind), d = sprintf('Km = %.3g nM', (kb(i) + kf(i+1))/kf(i));
    elseif any(i == cat), d = 'kcat; kb from Eq 1';
    elseif i == 17, d = sprintf('KD = kf/kb = %.3g nM', kf(i)/kb(i));      % R17 is written as release
    else, d = sprintf('KD = kb/kf = %.3g nM', kb(i)/kf(i)); end           % R18-R22 are written as binding
    fprintf('R%-3d %-26s %10.4g %12.4g   %s\n', i, step{i}, kf(i), kb(i), d);
    fprintf(fid, 'R%d,%s,%.6g,%.6g,%s\n', i, step{i}, kf(i), kb(i), d);
end
fclose(fid);
fprintf('Totals (nM): e4E_T %g, BP_T %g, P_T %g, e4G_T %g, e4A_T %g\n', P.tot);

%% the four PdP cycles: (a, b, c, d) = kinase binding, kinase catalysis, phosphatase binding, phosphatase catalysis
CY = [1 2 7 8; 3 4 5 6; 9 10 15 16; 11 12 13 14]; G = exp(19.8);
fprintf('\nCycle          ln K_kin  ln K_P  ln Gamma   rho           u       kb_b (recomputed)  kb_d (recomputed)\n');
for c = 1:4
    a = CY(c, 1); b = CY(c, 2); cc = CY(c, 3); d = CY(c, 4);
    Kk = kf(a)*kf(b)/(kb(a)*kb(b)); Kp = kf(cc)*kf(d)/(kb(cc)*kb(d));
    rho = kf(a)*kf(b)*kf(cc)*kf(d)/(kb(a)*kb(cc)*G); u = 0.5*log10(kb(b)/kb(d));
    fprintf('R%d,%d | R%d,%d  %7.3f  %7.3f  %7.3f   %.4g  %6.3f   %.4g         %.4g\n', a, b, cc, d, log(Kk), log(Kp), ...
            log(Kk*Kp), rho, u, sqrt(rho)*10^u, sqrt(rho)*10^(-u));
end
fprintf('Delta G_c = RT ln Gamma = %.2f kJ/mol (RT = %.4f kJ/mol)\n', RT*19.8, RT);

%% scaffold loop
KD = @(i) kb(i)/kf(i);
fprintf('\nScaffold: K_D18 %.4g, K_D19 %.4g, K_D20 %.4g nM; K_D21 = K_D18 K_D19/K_D20 = %.4g nM (table: %.4g)\n', ...
        KD(18), KD(19), KD(20), KD(18)*KD(19)/KD(20), KD(21));
fprintf('Loop ratio K_D20 K_D21/(K_D18 K_D19) = %.6f (must be 1)\n', KD(20)*KD(21)/(KD(18)*KD(19)));

%% Supplementary Table 4: stochastic rate constants at V = 1 fL
fac = 6.02214076e23*1*1e-24;
[Atab, ~] = p4e_ssa_tables(); fid = fopen(fullfile(RES, 'M01_SuppTable4.csv'), 'w');
fprintf(fid, 'channel,order,c_mu at 1 fL,unit\n'); fprintf('\nTable 7 (fac = %.4f molecules per nM at 1 fL)\n', fac);
for i = 1:22
    for dirn = 1:2
        if dirn == 1, k = kf(i); nm = sprintf('R%df', i); else, k = kb(i); nm = sprintf('R%db', i); end
        ch = 2*(i-1) + dirn; second = Atab(ch, 2) > 0;
        if second, c = k/fac; un = 'molec^-1 s^-1'; else, c = k; un = 's^-1'; end
        fprintf('%-5s %s %10.3g %s\n', nm, char('1' + second), c, un);
        fprintf(fid, '%s,%d,%.4g,%s\n', nm, 1 + second, c, un);
    end
end
fclose(fid);
