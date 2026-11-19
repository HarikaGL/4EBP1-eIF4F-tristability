function C = p4e_trace(P, links, scaff, kmin, kmax, maxpts)
%P4E_TRACE  Pseudo-arclength continuation of the complete steady-state curve against kin_T
%   (no MATCONT needed; manuscript Section 8.3).
%   C.kin, C.F (eIF4F), C.E (free eIF4E), C.X (reduced variables, rows), C.folds (indices),
%   C.SN (kin_T at the saddle-node points, in curve order), C.nSS (largest number of coexisting
%   steady states), C.order (e.g. '4213'), C.stable (logical, stability alternates at folds).
if nargin < 2 || isempty(links), links = P.links; end
if nargin < 3, scaff = true; end
if nargin < 4, kmin = 1; end
if nargin < 5, kmax = 5000; end
if nargin < 6, maxpts = 40000; end
m = 3 + scaff; n = m + 1; tot = P.tot;
lnK0 = log(kmin*1e-3); ok = false;
for trial = 0:5
    g = zeros(1, 5); fr = [0.9 0.1]; exE = [1e-3 1e-1 10];
    g(2) = log(tot(3)*fr(mod(trial, 2)+1)); g(3) = log(exE(floor(trial/2)+1)*tot(1)/500);
    g(4) = log(max(tot(2)-tot(1), 0.05*tot(2))); g(5) = log(tot(4));
    [x, ok] = solveK(lnK0, g(1:n)); if ok, break, end
end
C = struct('kin', [], 'F', [], 'E', [], 'X', [], 'folds', [], 'SN', [], 'nSS', 0, 'order', '', 'stable', []);
if ~ok, return, end
for rep = 1:40
    o = p4e_species(x, P, links, scaff); if o(5) < kmin, break, end
    lnK0 = lnK0 - 1.5; [x, ok] = solveK(lnK0, x); if ~ok, return, end
end
J = jacn(x); A = zeros(n); A(1:m, :) = J; A(n, 1) = 1; rhs = zeros(n, 1); rhs(n) = 1;
t = (A\rhs)'; t = t/norm(t); ds = 0.02; out = zeros(maxpts, 4+n); k = 0;
while k < maxpts
    o = p4e_species(x, P, links, scaff); k = k + 1; out(k, :) = [o(5) o(6) o(7) o(8) x];
    if o(5) > kmax || x(1) > log(kmax*10), break, end
    accepted = false;
    for att = 1:30
        xp = x + ds*t; conv = false;
        for it = 1:15
            f = res(xp); A(1:m, :) = jacn(xp); A(n, :) = t;
            r = [-f(:); -(dot(xp - x, t) - ds)]; dx = (A\r)'; xp = xp + dx;
            if max(abs(dx)) < 1e-10, conv = true; break, end
        end
        if conv
            A(1:m, :) = jacn(xp); A(n, :) = t; tn = (A\rhs)'; tn = tn/norm(tn); cs = dot(tn, t);
            if cs > 0.95
                x = xp; t = tn; if cs > 0.999, ds = min(ds*1.5, 0.15); end
                accepted = true; break
            end
        end
        ds = ds*0.5; if ds < 1e-9, break, end
    end
    if ~accepted, break, end
end
out = out(1:k, :); C.kin = out(:, 1); C.F = out(:, 2); C.E = out(:, 3); C.X = out(:, 5:end);
d = sign(diff(C.kin)); C.folds = find(d(1:end-1) ~= 0 & d(2:end) ~= 0 & d(1:end-1) ~= d(2:end)) + 1;
C.SN = C.kin(C.folds)';
C.stable = true(k, 1); for q = C.folds', C.stable(q+1:end) = ~C.stable(q+1:end); end
cuts = sort([kmin kmax C.SN(C.SN > kmin & C.SN < kmax)]); mids = (cuts(1:end-1)+cuts(2:end))/2;
for mm = mids, C.nSS = max(C.nSS, sum((C.kin(1:end-1)-mm).*(C.kin(2:end)-mm) < 0)); end
if numel(C.SN) >= 2, [~, o] = sort(C.SN); C.order = sprintf('%d', o); end
    function [x, ok] = solveK(lnK, g)
        x = g; x(1) = lnK; ok = false;
        for it2 = 1:200
            f2 = res(x); if max(abs(f2)) < 1e-11, ok = true; return, end
            J2 = jacn(x); dx2 = -(J2(:, 2:m+1)\f2(:))'; mx = max(abs(dx2)); if mx > 2, dx2 = dx2*2/mx; end
            x(2:m+1) = x(2:m+1) + dx2;
        end
        ok = max(abs(res(x))) < 1e-8;
    end
    function f4 = res(x)
        o4 = p4e_species(x, P, links, scaff); f4 = o4(1:m);
    end
    function J3 = jacn(x)
        f0 = res(x); J3 = zeros(m, n);
        for i = 1:n, xq = x; xq(i) = xq(i) + 1e-7; J3(:, i) = (res(xq) - f0)'/1e-7; end
    end
end
