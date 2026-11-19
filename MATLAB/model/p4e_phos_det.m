function p = p4e_phos_det(y)
%P4E_PHOS_DET  Mean phosphates per eIF4E-bound 4E-BP1 of a deterministic 17-state vector y.
S = y([17 5 2 10 3]); Cx = y([4 6 7 8 9 11 12 13]);
p = (S(:)'*(0:4)' + Cx(:)'*[0 1 2 1 2 3 4 3]')/(sum(S) + sum(Cx));
end
