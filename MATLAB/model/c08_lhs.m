function X = c08_lhs(rg, N)
% Latin hypercube sample of N points on log10 ranges rg (d x 2): each range is cut into N equal strata, one point
% is drawn uniformly in every stratum, and the strata are permuted independently for every dimension.
d = size(rg, 1); X = zeros(N, d);
for j = 1:d
    u = (randperm(N)' - rand(N, 1))/N; X(:, j) = rg(j, 1) + (rg(j, 2) - rg(j, 1))*u;
end
end
