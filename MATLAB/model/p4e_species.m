function o = p4e_species(x, P, links, scaff)
%P4E_SPECIES  Exact steady-state reduction. x = [lnK lnP lnE lnBP lnG] (free pools, nM).
%   At steady state every phosphorylation link carries zero net flux, so all species follow from
%   the free pools. o = [res_P res_E res_BP res_G kinT e4F e4E S_last BPp4].
kf = P.kf; kb = P.kb; tot = P.tot;
K = exp(x(1)); Pp = exp(x(2)); E = exp(x(3)); BP = exp(x(4));
nl = size(links, 1); S = zeros(1, nl+1); S(1) = BP*E*kf(22)/kb(22);
Ck = 0; Cp = 0;
for j = 1:nl
    r = links(j, :);
    a = kf(r(1))*kf(r(2))/(kb(r(1))+kf(r(2))); c = kb(r(1))*kb(r(2))/(kb(r(1))+kf(r(2)));
    d = kf(r(3))*kf(r(4))/(kb(r(3))+kf(r(4))); b = kb(r(3))*kb(r(4))/(kb(r(3))+kf(r(4)));
    S(j+1) = S(j)*(K*a + Pp*b)/(K*c + Pp*d);
end
for j = 1:nl
    r = links(j, :);
    Ck = Ck + K*(kf(r(1))*S(j) + kb(r(2))*S(j+1))/(kb(r(1))+kf(r(2)));
    Cp = Cp + Pp*(kf(r(3))*S(j+1) + kb(r(4))*S(j))/(kb(r(3))+kf(r(4)));
end
Sl = S(end); BPp = Sl*(kf(17)/kb(17))/E; ladder = sum(S) + Ck + Cp;
if scaff
    G = exp(x(5)); K18 = kb(18)/kf(18); K19 = kb(19)/kf(19); K20 = kb(20)/kf(20);
    A = tot(5)/(1 + G/K20 + G*E/(K18*K19)); GE = E*G/K18; F = GE*A/K19; GA = G*A/K20;
    resG = (G + GE + GA + F)/tot(4) - 1;
else
    GE = 0; F = 0; resG = 0;
end
o = [(Pp + Cp)/tot(3) - 1, (E + ladder + GE + F)/tot(1) - 1, (BP + ladder + BPp)/tot(2) - 1, resG, K + Ck, F, E, Sl, BPp];
end
