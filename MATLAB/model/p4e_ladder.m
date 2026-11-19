function [S, Ck, Cp] = p4e_ladder(x, P, links)
%P4E_LADDER  eIF4E-bound 4E-BP phosphoforms S (S0..Sn) and the kinase and phosphatase complexes of each link at the
%   reduced point x = [lnK lnP lnE lnBP ...] (exact steady-state reduction, as p4e_species).
kf = P.kf; kb = P.kb; K = exp(x(1)); Pp = exp(x(2)); E = exp(x(3)); BP = exp(x(4)); nl = size(links, 1);
S = zeros(1, nl+1); S(1) = BP*E*kf(22)/kb(22); Ck = zeros(1, nl); Cp = zeros(1, nl);
for j = 1:nl
    r = links(j, :); a = kf(r(1))*kf(r(2))/(kb(r(1))+kf(r(2))); c = kb(r(1))*kb(r(2))/(kb(r(1))+kf(r(2)));
    d = kf(r(3))*kf(r(4))/(kb(r(3))+kf(r(4))); b = kb(r(3))*kb(r(4))/(kb(r(3))+kf(r(4)));
    S(j+1) = S(j)*(K*a + Pp*b)/(K*c + Pp*d);
end
for j = 1:nl
    r = links(j, :);
    Ck(j) = K*(kf(r(1))*S(j) + kb(r(2))*S(j+1))/(kb(r(1))+kf(r(2)));
    Cp(j) = Pp*(kf(r(3))*S(j+1) + kb(r(4))*S(j))/(kb(r(3))+kf(r(4)));
end
end
