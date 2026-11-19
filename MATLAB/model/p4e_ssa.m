function [Rec, x] = p4e_ssa(P, kinT, vol, x0, tfinal, dtrec, seed)
%P4E_SSA  Gillespie direct method (Gillespie 1977) for all 44 elementary reactions of R1-R22 (no reduction).
%   vol in fL; fac = N_A V 1e-24 molecules per nM; first-order constants are used unchanged and second-order
%   constants are divided by fac (Table 7). x0: 23 initial molecule numbers (p4e_initial_counts).
%   Rec: the 23 molecule numbers every dtrec seconds from t = 0 to tfinal (int32, rows = time points).
%   Species: 1 kin, 2 P, 3 e4E, 4 BP, 5 e4G, 6 e4A, 7 BPe4E(S0), 8 S1, 9 S2, 10 S3, 11 S4, 12 BPp4,
%   13..20 C1..C8, 21 e4GE, 22 e4GA, 23 e4F.
%   After each event only the propensities that depend on the species it changed are recomputed.
%   kinT is not used by the algorithm (the kinase total is fixed by x0); it is kept for compatibility.
[A, S, isbi] = p4e_ssa_tables(); fac = 6.02214076e23*vol*1e-24; nr = 44;
k = zeros(nr, 1);
for j = 1:22, k(2*j-1) = P.kf(j)/(fac^isbi(2*j-1)); k(2*j) = P.kb(j)/(fac^isbi(2*j)); end
a1 = A(:, 1); a2 = A(:, 2); has2 = a2 > 0;
chg = cell(nr, 1); dlt = cell(nr, 1); dep = cell(nr, 1);
for r = 1:nr
    chg{r} = find(S(:, r)); dlt{r} = S(chg{r}, r);
    dep{r} = find(ismember(a1, chg{r}) | (has2 & ismember(a2, chg{r})));
end
rng(seed); x = double(x0(:)); t = 0; nrec = floor(tfinal/dtrec) + 1; Rec = zeros(nrec, 23, 'int32');
a = zeros(nr, 1);
for r = 1:nr, if has2(r), a(r) = k(r)*x(a1(r))*x(a2(r)); else, a(r) = k(r)*x(a1(r)); end, end
ir = 1; nexts = 0;
while ir <= nrec
    a0 = sum(a); if a0 <= 0, while ir <= nrec, Rec(ir, :) = x'; ir = ir + 1; end, break, end
    tau = -log(rand)/a0;
    while ir <= nrec && nexts <= t + tau, Rec(ir, :) = x'; ir = ir + 1; nexts = nexts + dtrec; end
    t = t + tau; u = rand*a0; c = 0; r = 0;
    while c < u && r < nr, r = r + 1; c = c + a(r); end
    cs = chg{r}; x(cs) = x(cs) + dlt{r};
    for q = dep{r}'
        if has2(q), a(q) = k(q)*x(a1(q))*x(a2(q)); else, a(q) = k(q)*x(a1(q)); end
    end
end
end
