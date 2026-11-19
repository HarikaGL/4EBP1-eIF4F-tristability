function p4e_draw(ax, x, y, folds, col, lw)
%P4E_DRAW  Draw a steady-state curve: stable segments solid, unstable dashed (stability alternates at the folds).
%   x, y: the curve (e.g. C.kin, C.F); folds: indices of the saddle-node points (C.folds).
if nargin < 5, col = [0 0 0]; end
if nargin < 6, lw = 2; end
seg = [1, folds(:)', numel(x)]; hold(ax, 'on');
for s = 1:numel(seg)-1
    i = seg(s):seg(s+1); if mod(s, 2) == 1, ls = '-'; else, ls = '--'; end
    plot(ax, x(i), y(i), ls, 'Color', col, 'LineWidth', lw);
end
end
