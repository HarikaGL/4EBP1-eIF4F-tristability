function p = p4e_phos_index(X)
%P4E_PHOS_INDEX  Mean number of phosphates on eIF4E-bound 4E-BP1 from SSA records X (rows = time,
%   23 species in p4e_ssa order): free S0..S4 and enzyme complexes C1..C8 weighted by their phosphates.
c = [7:11 13:20]; n = [0 1 2 3 4 0 1 2 1 2 3 4 3];
Xc = double(X(:, c)); p = (Xc*n')./max(sum(Xc, 2), 1);
end
