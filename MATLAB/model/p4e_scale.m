function Q = p4e_scale(P, what, idx, l)
%P4E_SCALE  Multiply part of a parameter set by l: what = 'rates' (kf and kb of reactions idx), 'kf', 'kb' or 'tot'.
Q = P;
switch what
    case 'rates', Q.kf(idx) = l*P.kf(idx); Q.kb(idx) = l*P.kb(idx);
    case 'kf', Q.kf(idx) = l*P.kf(idx);
    case 'kb', Q.kb(idx) = l*P.kb(idx);
    case 'tot', Q.tot(idx) = l*P.tot(idx);
end
end
