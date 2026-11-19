function q = p4e_prctile(X, p)
%P4E_PRCTILE  Percentiles p (0-100) of each column of X (linear interpolation; no toolbox needed). NaN values are
%   ignored. A single row is treated as one sample of every column (so a class with one set still works).
q = nan(numel(p), size(X, 2));
for j = 1:size(X, 2)
    x = sort(X(~isnan(X(:, j)), j)); m = numel(x); if m == 0, continue, end
    if m == 1, q(:, j) = x; continue, end
    r = 1 + (m - 1)*p(:)/100; lo = floor(r); hi = min(lo + 1, m); f = r - lo; q(:, j) = x(lo).*(1 - f) + x(hi).*f;
end
end
