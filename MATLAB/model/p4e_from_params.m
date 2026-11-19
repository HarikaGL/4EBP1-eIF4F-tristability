function th = p4e_from_params(P)
%P4E_FROM_PARAMS  Rate constants and totals -> primitive parameters (inverse of p4e_to_params).
[names, ~] = p4e_prim(); th = zeros(1, numel(names)); kf = P.kf; kb = P.kb; tot = P.tot; L = @log10;
KR = [1 2; 3 4; 9 10; 11 12]; PR = [5 6; 7 8; 13 14; 15 16];
for s = 1:4
    for kind = 'KP'
        if kind == 'K', R = KR(s, :); else, R = PR(s, :); end
        nm = sprintf('%c%d', kind, s);
        th(strcmp(names, ['kon_' nm])) = L(kf(R(1))); th(strcmp(names, ['kb_' nm])) = L(kb(R(1))); th(strcmp(names, ['kcat_' nm])) = L(kf(R(2)));
    end
end
th(strcmp(names, 'lnG')) = log(kf(1)*kf(2)*kf(7)*kf(8)/(kb(1)*kb(2)*kb(7)*kb(8)));
th(strcmp(names, 'split')) = 0.5*L(kb(2)/kb(8));
th(strcmp(names, 'kf17')) = L(kf(17)); th(strcmp(names, 'KD17')) = L(kf(17)/kb(17));
th(strcmp(names, 'kon22')) = L(kf(22)); th(strcmp(names, 'KD22')) = L(kb(22)/kf(22));
for i = 18:21, th(strcmp(names, sprintf('kon%d', i))) = L(kf(i)); end
th(strcmp(names, 'KD18')) = L(kb(18)/kf(18)); th(strcmp(names, 'KD19')) = L(kb(19)/kf(19));
th(strcmp(names, 'alpha')) = L((kb(19)/kf(19))/(kb(20)/kf(20)));
th(strcmp(names, 'ET')) = L(tot(1)); th(strcmp(names, 'BPr')) = L(tot(2)/tot(1)); th(strcmp(names, 'PT')) = L(tot(3));
th(strcmp(names, 'Gr')) = L(tot(4)/tot(1)); th(strcmp(names, 'Ar')) = L(tot(5)/tot(1));
end
