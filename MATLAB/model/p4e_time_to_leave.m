function tl = p4e_time_to_leave(t, F, thr, win)
%P4E_TIME_TO_LEAVE  For each row of F (e4F, nM, sampled at times t in h), the first time at which the moving average over
%   win samples exceeds thr; NaN if it never does. Use win = 1 for a deterministic trajectory.
tl = nan(size(F, 1), 1);
for r = 1:size(F, 1)
    if win > 1, f = movmean(F(r, :), win); else, f = F(r, :); end
    i = find(f > thr, 1); if ~isempty(i), tl(r) = t(i); end
end
end
