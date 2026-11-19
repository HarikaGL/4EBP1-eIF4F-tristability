function c08_branches(ax, C, col, lw)
% Draw a steady-state curve from p4e_trace: stable segments solid, unstable dashed (stability alternates at folds).
seg = [1, C.folds(:)', numel(C.kin)];
for s = 1:numel(seg)-1
    i = seg(s):seg(s+1); if mod(s, 2) == 1, ls = '-'; else, ls = '--'; end
    plot(ax, C.kin(i), C.F(i), ls, 'Color', col, 'LineWidth', lw);
end
end
