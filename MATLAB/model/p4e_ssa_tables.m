function [A, S, isbi] = p4e_ssa_tables()
%P4E_SSA_TABLES  Reactant table A (44x2) and stoichiometry S (23x44) of the 44 elementary reactions.
RX = {[7 1],13; 13,[8 1]; [8 1],14; 14,[9 1]; [9 2],15; 15,[8 2]; [8 2],16; 16,[7 2]; ...
      [9 1],17; 17,[10 1]; [10 1],18; 18,[11 1]; [11 2],19; 19,[10 2]; [10 2],20; 20,[9 2]; ...
      11,[3 12]; [3 5],21; [21 6],23; [5 6],22; [22 3],23; [4 3],7};
A = zeros(44, 2); S = zeros(23, 44); isbi = zeros(44, 1);
for j = 1:22
    re = RX{j, 1}; pr = RX{j, 2};
    for d = 0:1
        r = 2*j - 1 + d; if d == 0, a = re; b = pr; else, a = pr; b = re; end
        A(r, 1:numel(a)) = a; isbi(r) = numel(a) == 2;
        for s = a, S(s, r) = S(s, r) - 1; end
        for s = b, S(s, r) = S(s, r) + 1; end
    end
end
end
