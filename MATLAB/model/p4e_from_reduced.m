function y = p4e_from_reduced(x, P)
%P4E_FROM_REDUCED  Full 17-species state (TrannslationPIC.m order) from reduced x = [lnK lnP lnE lnBP lnG].
%   y = [e4F BPe4Epp BPe4Ep4 C1 BPe4Ep C2 C3 C4 C5 BPe4Ep3 C6 C7 C8 BPp4 e4GE e4GA BPe4E]
kf = P.kf; kb = P.kb; tot = P.tot; L = P.links;
K = exp(x(1)); Pp = exp(x(2)); E = exp(x(3)); BP = exp(x(4)); G = exp(x(5));
S = zeros(1, 5); S(1) = BP*E*kf(22)/kb(22);
for j = 1:4
    r = L(j, :); a = kf(r(1))*kf(r(2))/(kb(r(1))+kf(r(2))); c = kb(r(1))*kb(r(2))/(kb(r(1))+kf(r(2)));
    d = kf(r(3))*kf(r(4))/(kb(r(3))+kf(r(4))); b = kb(r(3))*kb(r(4))/(kb(r(3))+kf(r(4)));
    S(j+1) = S(j)*(K*a + Pp*b)/(K*c + Pp*d);
end
ck = @(j) K*(kf(L(j,1))*S(j) + kb(L(j,2))*S(j+1))/(kb(L(j,1))+kf(L(j,2)));
cp = @(j) Pp*(kf(L(j,3))*S(j+1) + kb(L(j,4))*S(j))/(kb(L(j,3))+kf(L(j,4)));
C1 = ck(1); C2 = ck(2); C5 = ck(3); C6 = ck(4); C4 = cp(1); C3 = cp(2); C8 = cp(3); C7 = cp(4);
K18 = kb(18)/kf(18); K19 = kb(19)/kf(19); K20 = kb(20)/kf(20);
A = tot(5)/(1 + G/K20 + G*E/(K18*K19)); GE = E*G/K18; F = GE*A/K19; GA = G*A/K20; BPp4 = S(5)*(kf(17)/kb(17))/E;
y = [F S(3) S(5) C1 S(2) C2 C3 C4 C5 S(4) C6 C7 C8 BPp4 GE GA S(1)];
end
