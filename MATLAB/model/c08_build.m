function [P, ok] = c08_build(P0, kinds, idx, x, CYC)
% Set the sampled parameters (kinds{j} = 'kf', 'kb' or 'tot'; idx(j); value 10^x(j)) and restore thermodynamic
% consistency (used by M08, M09 and M13 for single-parameter and module samples).
P = P0; ok = true; R = []; skb = [];
for j = 1:numel(x)
    v = 10^x(j);
    switch kinds{j}
        case 'tot', P.tot(idx(j)) = v;
        case 'kf', P.kf(idx(j)) = v; R(end+1) = idx(j); %#ok<AGROW>
        case 'kb', P.kb(idx(j)) = v; R(end+1) = idx(j); skb(end+1) = idx(j); %#ok<AGROW>
    end
end
for c = 1:size(CYC, 1)
    cy = CYC(c, :); if ~any(ismember(R, cy)), continue, end
    a = cy(1); b = cy(2); cc = cy(3); d = cy(4);
    g0 = prod(P0.kf(cy))/prod(P0.kb(cy));
    pr = P.kf(a)*P.kf(b)*P.kf(cc)*P.kf(d)/(P.kb(a)*P.kb(cc)*g0);          % k_b(b) k_b(d) required by Gamma
    if any(skb == b) && ~any(skb == d), P.kb(d) = pr/P.kb(b);
    elseif any(skb == d) && ~any(skb == b), P.kb(b) = pr/P.kb(d);
    else, sp = P0.kb(b)/P0.kb(d); P.kb(b) = sqrt(pr*sp); P.kb(d) = sqrt(pr/sp); end
    ok = ok && P.kb(b) <= 0.1 && P.kb(d) <= 0.1;
    for q = [a b; cc d]', Km = (P.kb(q(1)) + P.kf(q(2)))/P.kf(q(1)); ok = ok && Km >= 1 && Km <= 1e4; end
end
if any(ismember(R, 18:21))
    K = @(i) P.kb(i)/P.kf(i);
    if any(R == 21), P.kb(18) = P.kf(18)*K(20)*K(21)/K(19); else, P.kb(21) = P.kf(21)*K(18)*K(19)/K(20); end
end
end
