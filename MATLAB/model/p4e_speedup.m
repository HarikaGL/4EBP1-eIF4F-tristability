function [Q, lam] = p4e_speedup(P, lam)
%P4E_SPEEDUP  Speed up the PdP cycles without moving their Michaelis constants (M13, part A).
%   lam(q) (q = 1..4, the four PdP cycles, rows of P.links = [kinase binding, kinase catalysis, phosphatase binding,
%   phosphatase catalysis]) multiplies the turnover numbers of BOTH enzymes of cycle q, so that the ratio of kinase
%   to phosphatase turnover is unchanged. Each Michaelis constant K_m = (k_b + k_cat)/k_on is kept by lowering the
%   dissociation constant k_b of the enzyme-substrate complex; k_on is not changed. The factor is capped so that
%   k_b stays >= 1e-3 s^-1 and k_cat <= 10^1.5 s^-1 (the admissible ranges, Section 2.2). The two product-rebinding
%   constants of the cycle are rescaled together so that Gamma (Eq 1) and the split between them are unchanged.
%   Returns the new parameter set Q and the factors actually applied.
if isscalar(lam), lam = lam*ones(1, 4); end
Q = P; KBMIN = 1e-3; KCMAX = 10^1.5;
for q = 1:4
    r = P.links(q, :); G0 = cyc(P, r);
    cap = Inf;
    for e = [1 3]
        b = r(e); c = r(e+1); Km = (P.kb(b) + P.kf(c))/P.kf(b);
        cap = min([cap, (Km*P.kf(b) - KBMIN)/P.kf(c), KCMAX/P.kf(c)]);
    end
    lam(q) = max(1, min(lam(q), cap));
    for e = [1 3]
        b = r(e); c = r(e+1); Km = (P.kb(b) + P.kf(c))/P.kf(b);
        Q.kf(c) = lam(q)*P.kf(c); Q.kb(b) = Km*P.kf(b) - Q.kf(c);
    end
    g = sqrt(cyc(Q, r)/G0); Q.kb(r(2)) = Q.kb(r(2))*g; Q.kb(r(4)) = Q.kb(r(4))*g;
end
end

function G = cyc(P, r)
G = prod(P.kf(r))/prod(P.kb(r));
end
