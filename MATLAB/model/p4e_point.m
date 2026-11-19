function x = p4e_point(C, j, K)
%P4E_POINT  Reduced variables x (row) on branch segment j of curve C at kin_T = K (linear interpolation).
seg = [1, C.folds(:)', numel(C.kin)]; kk = C.kin(seg(j):seg(j+1));
q = find((kk(1:end-1)-K).*(kk(2:end)-K) <= 0, 1) + seg(j) - 1;
if isempty(q), x = []; return, end
w = (K - C.kin(q))/(C.kin(q+1) - C.kin(q)); x = C.X(q, :) + w*(C.X(q+1, :) - C.X(q, :));
end
