function TH = p4e_sample_ensemble(kind, n, th_ref, w, seed)
%P4E_SAMPLE_ENSEMBLE  Draw a new ensemble of primitive parameter vectors (p4e_prim order) by Latin hypercube sampling.
%   kind = 'local': every primitive within +-w decades of th_ref (w = log10 of the fold: 0.301, 0.477, 1), lnG within
%          +-w ln10 natural-log units, the split u within +-0.3, kf17 fixed; clipped to the admissible bounds.
%   kind = 'scaffold': only K_D18 (5-30 nM), K_D19 (50-1000 nM), K_D20 (50-1000 nM), e4G_T/e4E_T (0.3-3) and
%          e4A_T/e4E_T (1-10) are drawn over their measured ranges; everything else at the reference set.
%   Sets that p4e_to_params marks as inadmissible, and local sets with K_D20 outside 50-1000 nM, are removed.
[names, B] = p4e_prim(); rng(seed); ix = @(s) find(strcmp(names, s));
switch kind
    case 'local'
        vary = find(~strcmp(names, 'kf17')); U = lhs_(n, numel(vary)); TH = repmat(th_ref(:)', n, 1);
        for jj = 1:numel(vary)
            i = vary(jj); half = w; if strcmp(names{i}, 'lnG'), half = w*log(10); elseif strcmp(names{i}, 'split'), half = 0.3; end
            TH(:, i) = th_ref(i) + (2*U(:, jj) - 1)*half;
        end
        TH = min(max(TH, repmat(B(:, 1)', n, 1)), repmat(B(:, 2)', n, 1));
    case 'scaffold'
        U = lhs_(n, 5); TH = repmat(th_ref(:)', n, 1);
        KD18 = log10(5) + U(:, 1)*(log10(30) - log10(5)); KD19 = log10(50) + U(:, 2)*(3 - log10(50)); KD20 = log10(50) + U(:, 3)*(3 - log10(50));
        TH(:, ix('KD18')) = KD18; TH(:, ix('KD19')) = KD19; TH(:, ix('alpha')) = KD19 - KD20;
        TH(:, ix('Gr')) = log10(0.3) + U(:, 4)*(log10(3) - log10(0.3)); TH(:, ix('Ar')) = U(:, 5);
end
keep = true(n, 1);
for k = 1:n
    [~, ok] = p4e_to_params(TH(k, :)); KD20 = 10^(TH(k, ix('KD19')) - TH(k, ix('alpha')));
    keep(k) = ok && (strcmp(kind, 'scaffold') || (KD20 >= 50 && KD20 <= 1000));
end
TH = TH(keep, :);
end
function U = lhs_(n, d)
U = zeros(n, d); for j = 1:d, U(:, j) = (randperm(n)' - rand(n, 1))/n; end
end
