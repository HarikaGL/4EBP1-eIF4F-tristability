function [P, ok] = p4e_to_params(th)
%P4E_TO_PARAMS  Primitive parameters (p4e_prim order) -> rate constants and totals, with thermodynamic
%   consistency imposed: every PdP cycle has the same ratio Gamma = exp(lnG), the product-rebinding constants
%   are computed from it, and the scaffold loop R18-R21 is detailed-balanced (K_D21 = K_D18*alpha,
%   K_D20 = K_D19/alpha). ok is false when a Michaelis constant leaves 1-1e4 nM or a rebinding constant
%   exceeds 0.1 nM^-1 s^-1.
[names, ~] = p4e_prim(); v = @(n) 10^th(strcmp(names, n));
KR = [1 2; 3 4; 9 10; 11 12]; PR = [5 6; 7 8; 13 14; 15 16]; PAIRS = [1 2; 2 1; 3 4; 4 3];
kf = zeros(1, 22); kb = zeros(1, 22); ok = true;
for s = 1:4
    for kind = 'KP'
        if kind == 'K', R = KR(s, :); else, R = PR(s, :); end
        nm = sprintf('%c%d', kind, s); kon = v(['kon_' nm]); kbb = v(['kb_' nm]); kc = v(['kcat_' nm]);
        kf(R(1)) = kon; kb(R(1)) = kbb; kf(R(2)) = kc;
        Km = (kbb + kc)/kon; ok = ok && Km >= 1 && Km <= 1e4;
    end
end
G = exp(th(strcmp(names, 'lnG'))); u = th(strcmp(names, 'split'));
for q = 1:4
    k = KR(PAIRS(q, 1), :); p = PR(PAIRS(q, 2), :);
    rbp = kf(k(1))*kf(k(2))*kf(p(1))*kf(p(2))/(kb(k(1))*kb(p(1)))/G;
    kb(k(2)) = sqrt(rbp)*10^u; kb(p(2)) = sqrt(rbp)*10^(-u);
    ok = ok && kb(k(2)) <= 0.1 && kb(p(2)) <= 0.1;
end
kf(17) = v('kf17'); kb(17) = v('kf17')/v('KD17'); ok = ok && kb(17) <= 0.1;
kf(22) = v('kon22'); kb(22) = v('KD22')*v('kon22');
KD18 = v('KD18'); KD19 = v('KD19'); al = v('alpha');
KD = [KD18, KD19, KD19/al, KD18*al];
for i = 18:21, kf(i) = v(sprintf('kon%d', i)); kb(i) = KD(i-17)*kf(i); end
ET = v('ET');
P.kf = kf; P.kb = kb; P.tot = [ET, ET*v('BPr'), v('PT'), ET*v('Gr'), ET*v('Ar')];
P.links = [1 2 7 8; 3 4 5 6; 9 10 15 16; 11 12 13 14];
end
