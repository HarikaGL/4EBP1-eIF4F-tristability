function x = p4e_initial_counts(P, kinT, vol, y)
%P4E_INITIAL_COUNTS  Molecule numbers from a deterministic 17-state steady state y (nM),
%   or the repressed state (all eIF4E bound to unphosphorylated 4E-BP) if y is empty.
fac = 6.02214076e23*vol*1e-24; tot = P.tot; x = zeros(23, 1);
if nargin < 4 || isempty(y)
    nE = round(tot(1)*fac); nBP = round(tot(2)*fac);
    x(1) = round(kinT*fac); x(2) = round(tot(3)*fac); x(5) = round(tot(4)*fac); x(6) = round(tot(5)*fac);
    nb = min(nE, nBP); x(7) = nb; x(3) = nE - nb; x(4) = nBP - nb; return
end
mp = [23 1; 9 2; 11 3; 13 4; 8 5; 14 6; 15 7; 16 8; 17 9; 10 10; 18 11; 19 12; 20 13; 12 14; 21 15; 22 16; 7 17];
for q = 1:size(mp, 1), x(mp(q, 1)) = round(y(mp(q, 2))*fac); end
x(1) = round(kinT*fac) - (x(13)+x(14)+x(17)+x(18));
x(2) = round(tot(3)*fac) - (x(15)+x(16)+x(19)+x(20));
x(3) = round(tot(1)*fac) - (sum(x(7:11)) + sum(x(13:20)) + x(21) + x(23));
x(4) = round(tot(2)*fac) - (sum(x(7:12)) + sum(x(13:20)));
x(5) = round(tot(4)*fac) - (x(21)+x(22)+x(23)); x(6) = round(tot(5)*fac) - (x(22)+x(23));
if x(4) < 0, x(12) = x(12) + x(4); x(4) = 0; end
x(1:3) = max(x(1:3), 0);
end
