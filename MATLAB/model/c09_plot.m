function c09_plot(SS, SW, C0, KIN, tag)
% Bifurcation diagrams of the selected samples over the reference (C09), accessible kinase range KIN shaded;
% saddle-node points outside it marked with crosses.
COL = {[0.031 0.318 0.612], [0.192 0.510 0.741], [0.620 0.792 0.882]; [0 0.427 0.173], [0.192 0.639 0.329], [0.631 0.851 0.608]};
fig = figure('Color', 'w', 'Units', 'inches', 'Position', [0.5 0.5 14 6.5]);
for w = 1:2
    % linear axes as in Fig 3 (kin_T 0-155.5 nM, e4F -9.4-235.7 nM); kin_T widened only if this panel's points need it
    sel = find(strcmp({SS.sw}, SW{w, 1})); m = max(C0.kin(C0.folds));
    for t = 1:numel(sel), m = max([m; SS(sel(t)).C.kin(SS(sel(t)).C.folds(:))]); end
    if m <= 140, xm = 155.5; else, xm = ceil(m*1.12/50)*50; end
    ax = subplot(1, 2, w); hold(ax, 'on'); xlim(ax, [0 xm]); ylim(ax, [-9.43 235.7]);
    patch(ax, [KIN(1) min(KIN(2), xm) min(KIN(2), xm) KIN(1)], [-9.43 -9.43 235.7 235.7], [0.992 0.831 0.620], 'FaceAlpha', 0.5, 'EdgeColor', 'none');
    c08_branches(ax, C0, [0 0 0], 3); plot(ax, C0.kin(C0.folds), C0.F(C0.folds), 'ko', 'MarkerFaceColor', 'w', 'MarkerSize', 7);
    for t = 1:numel(sel)
        s = SS(sel(t)); col = COL{w, t}; c08_branches(ax, s.C, col, 2);
        for j = 1:numel(s.C.folds)
            v = s.C.kin(s.C.folds(j)); f = s.C.F(s.C.folds(j));
            if v < KIN(1) || v > KIN(2), plot(ax, v, f, 'kx', 'MarkerSize', 12, 'LineWidth', 2);
            else, plot(ax, v, f, 'o', 'Color', col, 'MarkerFaceColor', col, 'MarkerSize', 6); end
        end
        text(ax, 0.78*xm, 190 - 15*t, sprintf('%s x%.3g', s.name, 10^s.dx), 'Color', col, 'FontSize', 9);
    end
    xlabel(ax, 'kin_T (nM)'); ylabel(ax, 'e4F (nM)'); box(ax, 'on');
    title(ax, sprintf('%s switch: SN%d, SN%d (x: outside %g-%g nM)', SW{w, 1}, SW{w, 3}(1), SW{w, 3}(2), KIN(1), KIN(2)));
end
print(fig, fullfile(setup_p4e(), ['C09_accessible_range' tag '.png']), '-dpng', '-r150');
end
