function [names, bounds] = p4e_prim()
%P4E_PRIM  Names and admissible bounds (log10 units; lnG in natural-log units) of the primitive parameters
%   used for the ensembles and the one-at-a-time scans (Methods 4.5; Supplementary Note 4).
%   For each enzyme step (kinase K1-K4 = R1/R2, R3/R4, R9/R10, R11/R12; phosphatase P1-P4 = R5/R6, R7/R8,
%   R13/R14, R15/R16): kon (association, nM^-1 s^-1), kb (dissociation, s^-1), kcat (s^-1).
%   Then kf17, KD17 (= kf17/kb17, nM), kon22, KD22, kon18-kon21, KD18, KD19, alpha (= log10(KD19/KD20)),
%   Gr = e4G_T/e4E_T, Ar = e4A_T/e4E_T, ET = e4E_T, BPr = BP_T/e4E_T, PT = P_T, lnG (common cycle ratio, ln),
%   split (how the product-rebinding constant of each cycle is shared between its kinase and phosphatase).
names = {}; bounds = [];
for s = {'K1', 'K2', 'K3', 'K4', 'P1', 'P2', 'P3', 'P4'}
    names = [names, {['kon_' s{1}], ['kb_' s{1}], ['kcat_' s{1}]}]; %#ok<AGROW>
    bounds = [bounds; -4 -1; -3 2; -3 1.5]; %#ok<AGROW>
end
extra = {'kf17', [-3 1]; 'KD17', [2 5]; 'kon22', [-4 -1]; 'KD22', [log10(5) log10(60)]; 'kon18', [-4 -1]; 'kon19', [-4 -1];
         'kon20', [-4 -1]; 'kon21', [-4 -1]; 'KD18', [log10(5) log10(30)]; 'KD19', [log10(50) 3]; 'alpha', [-1 1];
         'Gr', [log10(0.3) log10(3)]; 'Ar', [0 1]; 'ET', [1.7 3.0]; 'BPr', [log10(0.3) log10(5)]; 'PT', [1.0 2.7];
         'lnG', [8 20]; 'split', [-1 1]};
for i = 1:size(extra, 1), names{end+1} = extra{i, 1}; bounds(end+1, :) = extra{i, 2}; end %#ok<AGROW>
end
