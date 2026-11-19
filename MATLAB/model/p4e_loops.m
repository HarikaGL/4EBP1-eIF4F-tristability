function L = p4e_loops(S)
%P4E_LOOPS  Independent reaction loops by the row reduction of Stanbury and Hoffman (Supplementary Note 3):
%   row-reduce [S | I] (S: reactions x species); the rows whose S-part is zero give, in their I-part, the loops.
%   Each loop is scaled to integer coefficients with the first nonzero coefficient positive.
[nr, ns] = size(S); R = rref([S, eye(nr)]);
z = all(abs(R(:, 1:ns)) < 1e-9, 2); L = R(z, ns+1:end);
for i = 1:size(L, 1)
    v = L(i, :); nz = v(abs(v) > 1e-9); v = v/min(abs(nz)); v = round(v);
    f = find(v, 1); if v(f) < 0, v = -v; end; L(i, :) = v;
end
end
