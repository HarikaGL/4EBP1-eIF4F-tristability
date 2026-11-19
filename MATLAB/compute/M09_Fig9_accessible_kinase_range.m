%% M09  Fig 9: are the switches within the accessible kinase range (10-500 nM)?
%  Classes from p4e_attribute (two axes of the bifurcation diagram only).
%  1. Elasticity of SN1-SN4 to every rate constant of M1 (R1-R8) and M2 (R9-R16) at the reference set,
%     e = d ln SN / d ln p (central difference, +-2%), with the thermodynamic builder c08_build (as C08).
%  2. For each switch the three parameters with the largest |e| summed over its own pair (M1: SN1+SN2; M2: SN3+SN4).
%  3. For each of them, its 41 Latin hypercube samples (C08_lhs_samples.mat, the samples of Fig 8) are classified;
%     kept are the tristable sample with coexisting loops whose pair moves farthest from the reference (Fig 9) and
%     the tristable sample with separate loops whose pair moves farthest (not shown in the manuscript).
%  4. The bifurcation diagrams (e4F against kin_T, linear axes) of these samples are drawn over the reference, with
%     the accessible kinase range KIN shaded; saddle-node points outside it are marked (mathematically present,
%     biologically inaccessible).
%  5. If the full single-parameter run of M08 is available (Results/C08_lhs_single.mat): the counts of Section 4.3
%     (for each switch and class, how many samples have a threshold outside the accessible range), and
%     for each switch, the three parameters that most often leave it as the only switch (bistable: M1 switch,
%     bistable: M2 switch), each at the sample whose thresholds moved farthest (loops narrower than 10% skipped).
%  KIN: 10-500 nM, the generic abundance range of signalling proteins used for the phosphatase total (Milo et al.
%  2010); a single-cell estimate of 2e4 mTOR per cell (Szymanska et al. 2015) is about 11 nM in a 3 pL cell.
%  Run time: about 64 + 246 continuations. Output: Results/C09_accessible_range.mat, .csv, .png.
clearvars -except KIN; if ~exist('KIN', 'var'), KIN = [10 500]; end
here = fileparts(mfilename('fullpath')); if isempty(here), here = pwd; end
addpath(fullfile(here, '..')); RES = setup_p4e(); DATA = fullfile(here, '..', 'data');
P0 = p4e_ref(); CYC = [1 2 7 8; 3 4 5 6; 9 10 15 16; 11 12 13 14]; S = load(fullfile(DATA, 'C08_lhs_samples.mat'));
names = cellfun(@strtrim, cellstr(S.SINGLE_NAME), 'UniformOutput', false); kinds = cellfun(@strtrim, cellstr(S.SINGLE_KIND), 'UniformOutput', false);
A0 = p4e_attribute(P0); REF = A0.SN_K; h = log10(1.02);
SW = {'M1', 1:8, [1 2]; 'M2', 9:16, [3 4]}; SEL = struct('sw', {}, 'name', {}, 'e', {}, 'x', {}, 'dx', {}, 'SN', {}, 'C', {}); SELANY = SEL;
for w = 1:2
    R = SW{w, 2}; pr = SW{w, 3}; sc = []; nm = {}; ix = [];
    tk = strcmp(kinds, 'tot'); for s = find(ismember(S.SINGLE_IDX(:)', R) & ~tk(:)')
        k = kinds{s}; i = S.SINGLE_IDX(s); if strcmp(k, 'kf'), r = log10(P0.kf(i)); else, r = log10(P0.kb(i)); end
        Pu = c08_build(P0, {k}, i, r + h, CYC); Pd = c08_build(P0, {k}, i, r - h, CYC);
        Au = p4e_attribute(Pu); Ad = p4e_attribute(Pd);
        if ~strcmp(Au.cls, 'tri') || ~strcmp(Ad.cls, 'tri'), continue, end
        e = (log(Au.SN_K) - log(Ad.SN_K))/(2*log(1.02));
        sc(end+1) = sum(abs(e(pr))); nm{end+1} = names{s}; ix(end+1) = s; %#ok<AGROW>
        fprintf('%s %-5s e = %s\n', SW{w, 1}, names{s}, mat2str(round(e*1000)/1000));
    end
    [~, o] = sort(sc, 'descend');
    for t = o(1:3)
        s = ix(t); k = kinds{s}; i = S.SINGLE_IDX(s); if strcmp(k, 'kf'), r = log10(P0.kf(i)); else, r = log10(P0.kb(i)); end
        best = -1; bestN = -1;
        for q = 1:size(S.SINGLE_X, 2)
            [P, ok] = c08_build(P0, {k}, i, S.SINGLE_X(s, q), CYC); if ~ok, continue, end
            A = p4e_attribute(P); th = c09_own(A, SW{w, 1}, pr); if isempty(th), continue, end
            d = max(abs(log10(th./REF(pr))));
            if strcmp(A.cls, 'tri')
                if d > best, best = d; bx = S.SINGLE_X(s, q); bSN = A.SN_K; bP = P; end
            elseif strcmp(A.sub, 'separate') && d > bestN, bestN = d; nx = S.SINGLE_X(s, q); nSN = A.SN_K; nP = P; ncl = A.sub; end
        end
        SEL(end+1) = struct('sw', SW{w, 1}, 'name', nm{t}, 'e', sc(t), 'x', bx, 'dx', bx - r, 'SN', bSN, 'C', p4e_trace(bP)); %#ok<SAGROW>
        fprintf('  %s %s: change x%.3g, SN = %s\n', SW{w, 1}, nm{t}, 10^(bx - r), mat2str(round(bSN*10)/10));
        if bestN >= 0
            SELANY(end+1) = struct('sw', SW{w, 1}, 'name', nm{t}, 'e', sc(t), 'x', nx, 'dx', nx - r, 'SN', nSN, 'C', p4e_trace(nP)); %#ok<SAGROW>
            fprintf('  %s %s tristable, separate (%s): change x%.3g, SN = %s\n', SW{w, 1}, nm{t}, ncl, 10^(nx - r), mat2str(round(nSN*10)/10));
        else, fprintf('  %s %s: no tristable sample with separate loops\n', SW{w, 1}, nm{t}); end
    end
end
C0 = p4e_trace(P0); save(fullfile(RES, 'C09_accessible_range.mat'), 'SEL', 'SELANY', 'C0', 'KIN', 'REF', '-v7');
fid = fopen(fullfile(RES, 'C09_accessible_range.csv'), 'w'); fprintf(fid, 'switch,parameter,fold change,SN1,SN2,SN3,SN4,outside accessible range\n');
for k = 1:numel(SEL)
    out = SEL(k).SN < KIN(1) | SEL(k).SN > KIN(2); lab = strjoin(arrayfun(@(j) sprintf('SN%d', j), find(out), 'UniformOutput', false), ' ');
    fprintf(fid, '%s,%s,%.3g,%.3g,%.3g,%.3g,%.3g,%s\n', SEL(k).sw, SEL(k).name, 10^SEL(k).dx, SEL(k).SN, lab);
end
fclose(fid);

%% figures (Fig 9; and the same for tristable samples with separate loops)
c09_plot(SEL, SW, C0, KIN, ''); c09_plot(SELANY, SW, C0, KIN, '_any');

%% Counts over all single-parameter samples (Section 4.3: 1317 of 1329) (needs the full C08 run, MODE = 'single', QUICK = false)
f8 = fullfile(RES, 'C08_lhs_single.mat');
if exist(f8, 'file')
    L = load(f8); fid = fopen(fullfile(RES, 'C09_all_samples.csv'), 'w');
    fprintf(fid, 'switch,class,samples with the switch,threshold outside accessible range\n');
    for w = 1:2
        for g = {'tristable, coexisting', 'tristable, separate', 'bistable, one switch'}
            n = 0; o = 0;
            for k = 1:numel(L.OUT)
                for q = 1:numel(L.OUT(k).A)
                    A = L.OUT(k).A{q}; if ~isfield(A, 'SN_K'), continue, end
                    if strcmp(A.cls, 'tri'), gg = 'tristable, coexisting'; elseif strcmp(A.sub, 'separate'), gg = 'tristable, separate'; else, gg = 'bistable, one switch'; end
                    if ~strcmp(gg, g{1}), continue, end
                    th = c09_own(A, SW{w, 1}, SW{w, 3}); if isempty(th), continue, end
                    n = n + 1; o = o + any(th < KIN(1) | th > KIN(2));
                end
            end
            fprintf(fid, '%s,"%s",%d,%d\n', SW{w, 1}, g{1}, n, o);
        end
    end
    fclose(fid);

    %% Each switch on its own (Section 4.2, 'The two switches differ in kind')
    SELLONE = SEL([]);
    for w = 1:2
        sw = SW{w, 1}; pr = SW{w, 3}; d = []; who = []; nmL = {}; cnt = [];
        for k = 1:numel(L.OUT)
            bestk = -1; nk = 0;
            for q = 1:numel(L.OUT(k).A)
                A = L.OUT(k).A{q}; if ~(strcmp(A.cls, 'bi') && strcmp(A.sub, sw)), continue, end
                nk = nk + 1; th = c09_own(A, sw, pr); if th(1)/th(2) < 1.1, continue, end
                dd = max(abs(log10(th./REF(pr))));
                if dd > bestk, bestk = dd; bq = q; end
            end
            if bestk >= 0, d(end+1) = bestk; who(end+1, :) = [k bq]; nmL{end+1} = L.OUT(k).name; cnt(end+1) = nk; end %#ok<AGROW>
        end
        [~, o] = sort(cnt, 'descend');      % the parameters that most often leave this switch alone
        for t = o(1:min(3, numel(o)))
            k = who(t, 1); q = who(t, 2); s = find(strcmp(names, L.OUT(k).name));
            [P, ok] = c08_build(P0, kinds(s), S.SINGLE_IDX(s), L.OUT(k).x(q), CYC);
            SELLONE(end+1) = struct('sw', sw, 'name', nmL{t}, 'e', d(t), 'x', L.OUT(k).x(q), 'dx', L.OUT(k).dx(q), 'SN', [], 'C', p4e_trace(P)); %#ok<SAGROW>
            fprintf('  %s alone: %s change x%.3g\n', sw, nmL{t}, 10^L.OUT(k).dx(q));
        end
    end
    save(fullfile(RES, 'C09_accessible_range_lone.mat'), 'SELLONE', '-v7');
    SS = SELLONE; tag = '_lone'; c09_plot(SS, SW, C0, KIN, tag);
else, fprintf('Counts over all samples: run M08 (MODE = ''single'') first.\n'); end
