function J = p4e_jacobian(y, P, kinT)
%P4E_JACOBIAN  Jacobian of the full ODEs (p4e_rhs, 17 states) at y by central differences.
y = y(:); n = numel(y); J = zeros(n);
for i = 1:n
    h = 1e-6*max(abs(y(i)), 1e-3); yp = y; ym = y; yp(i) = yp(i) + h; ym(i) = ym(i) - h;
    J(:, i) = (p4e_rhs(yp, P, kinT) - p4e_rhs(ym, P, kinT))/(2*h);
end
end
