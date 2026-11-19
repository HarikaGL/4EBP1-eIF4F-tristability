function [r, p] = p4e_prcc(X, y)
%P4E_PRCC  Partial rank correlation of each column of X with y, controlling for the other columns
Z = [rnk(X), rnk(y(:))]; Z = Z - mean(Z, 1); C = (Z'*Z); d = sqrt(diag(C)); C = C./(d*d');
Pm = inv(C); m = size(X, 2); r = -Pm(1:m, end)./sqrt(diag(Pm(1:m, 1:m))*Pm(end, end)); r = r(:)';
n = size(X, 1); dfree = n - 2 - (m - 1); t = r.*sqrt(dfree./max(1 - r.^2, eps)); p = erfc(abs(t)/sqrt(2));
end

function R = rnk(X)
% average ranks of each column (ties share their mean rank)
R = zeros(size(X));
for j = 1:size(X, 2)
    [s, o] = sort(X(:, j)); n = numel(s); rr = zeros(n, 1); i = 1;
    while i <= n
        k = i; while k < n && s(k+1) == s(i), k = k + 1; end
        rr(i:k) = (i + k)/2; i = k + 1;
    end
    R(o, j) = rr;
end
end
