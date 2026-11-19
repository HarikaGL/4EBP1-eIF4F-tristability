function [y, xr] = p4e_branch_state(C, P, kin, j)
%P4E_BRANCH_STATE  Steady state on branch segment j of curve C at kin_T = kin.
%   Segments are numbered from the start of the curve: j = 1 State I (low), 2 first unstable,
%   3 State II, 4 second unstable, 5 State III (reference set). Returns the full 17-state vector y.
segs = [1; C.folds(:); numel(C.kin)]; i0 = segs(j); i1 = segs(j+1);
kk = C.kin(i0:i1); q = find((kk(1:end-1)-kin).*(kk(2:end)-kin) <= 0, 1) + i0 - 1;
if isempty(q), error('kin_T = %g is not on branch %d', kin, j); end
w = (kin - C.kin(q))/(C.kin(q+1) - C.kin(q)); xr = C.X(q, :) + w*(C.X(q+1, :) - C.X(q, :));
for it = 1:60   % Newton polish: reduced residuals + kinT(x) = kin
    o = p4e_species(xr, P, P.links, true); f = [o(1:4) o(5)/kin-1];
    if max(abs(f)) < 1e-12, break, end
    J = zeros(5); for i = 1:5, xq = xr; xq(i) = xq(i) + 1e-7; oq = p4e_species(xq, P, P.links, true); J(:, i) = ([oq(1:4) oq(5)/kin-1] - f)'/1e-7; end
    dx = -(J\f')'; mx = max(abs(dx)); if mx > 0.5, dx = dx*0.5/mx; end
    xr = xr + dx;
end
y = p4e_from_reduced(xr, P);
end
