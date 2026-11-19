function v = p4e_branch_value(C, y, j, K)
%P4E_BRANCH_VALUE  Value of the curve quantity y (e.g. C.F or C.E) on branch segment j of curve C at kin_T = K
%   (segments numbered from the start of the curve: 1 State I, 2 unstable, 3 State II, ...). NaN if K is outside it.
seg = [1, C.folds(:)', numel(C.kin)]; i = seg(j):seg(j+1);
k = C.kin(i); yy = y(i); [k, o] = sort(k(:)); yy = yy(o); [k, u] = unique(k); yy = yy(u);
if K < k(1) || K > k(end), v = NaN; else, v = interp1(k, yy(:), K); end
end
