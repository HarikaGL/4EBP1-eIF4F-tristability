function [F, z] = p4e_scaffold_alone(KD, tots, z0)
%P4E_SCAFFOLD_ALONE  Steady state of the scaffold module alone (R18-R21; at equilibrium because the loop uses no ATP).
%   KD = [K_D18 K_D19 K_D20 K_D21], tots = [e4E_T e4G_T e4A_T] (nM). Returns e4F and z = log of the free pools
%   [e4E e4G e4A]. z0: optional starting point.
if nargin < 3 || isempty(z0), z0 = log(tots/2); end
z = p4e_newton(@(zz) res(zz, KD, tots), z0, 1e-12); F = exp(z(1))*exp(z(2))*exp(z(3))/(KD(1)*KD(2));
end
function r = res(z, KD, tots)
E = exp(z(1)); G = exp(z(2)); A = exp(z(3)); GE = E*G/KD(1); GA = G*A/KD(3); F = GE*A/KD(2);
r = [(E + GE + F)/tots(1) - 1, (G + GE + GA + F)/tots(2) - 1, (A + GA + F)/tots(3) - 1];
end
