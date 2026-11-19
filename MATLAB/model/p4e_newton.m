function z = p4e_newton(fun, z, tol)
%P4E_NEWTON  Small damped Newton solver with a finite-difference Jacobian (no toolbox needed).
if nargin < 3, tol = 1e-12; end
n = numel(z);
for it = 1:200
    f = fun(z); f = f(:); if max(abs(f)) < tol, return, end
    J = zeros(numel(f), n); for i = 1:n, zq = z; zq(i) = zq(i) + 1e-7; fq = fun(zq); J(:, i) = (fq(:) - f)/1e-7; end
    dz = -(J\f)'; m = max(abs(dz)); if m > 1, dz = dz/m; end; z = z + dz;
end
end
