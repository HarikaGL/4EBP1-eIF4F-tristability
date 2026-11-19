function [A, C] = p4e_attribute(P)
%P4E_ATTRIBUTE  Trace the steady-state curve (e4F against kin_T) and classify it from its two axes only
%   (manuscript Section 4.1, "Classification of a bifurcation diagram").
%   No species other than e4F and no statistical model is used.
%
%   Step 1, number of steady states = number of saddle-node points + 1:
%       0 saddle-node points  monostable (1);  2  bistable (3);  4  tristable (5);  6  seven steady states.
%   Step 2, tristable curves: the loops occupy the kinase ranges SN2..SN1 and SN4..SN3.
%       ranges overlap      -> tristable, coexisting (three stable states at one kin_T)
%       ranges do not       -> tristable, separate: 'staircase' if e4F rises at the first switch,
%                              'mushroom' (mushroom-like) if it falls.
%   Step 3, bistable curves: with s = e4F at the switch-on point / maximal e4F (start) and
%       e = e4F reached on switching on / maximal e4F (end), and the two levels of the reference tristable curve
%       L1 = 0.0469 (e4F at SN2 / max) and L2 = 0.7266 (e4F at SN3 / max):
%       e <= L2              M1 switch (low -> intermediate; SN1 on, SN2 off)
%       e >  L2 and s >= L1  M2 switch (intermediate -> high; SN3 on, SN4 off)
%       e >  L2 and s <  L1  other     (low -> high directly; SN1* on, SN2* off)
%
%   Output. A.name: the class in words. For the other scripts the internal codes are kept:
%     A.cls = 'mono' | 'bi' | 'tri' | 'other' | 'fail', where 'tri' = tristable, coexisting;
%     A.cls = 'bi' with A.sub = 'separate' = tristable, separate (A.shape = 'staircase' | 'mushroom');
%     A.cls = 'bi' with A.sub = 'M1' | 'M2' | 'general' = bistable with an M1, an M2 or an other switch.
%   A.SN_K, A.SN_F: kin_T and e4F at the saddle-node points, numbered along the curve. A.Fmax: maximal e4F.
%   A.up(j): e4F reached on switching on at loop j. A.start, A.stop: s and e of the first loop. A.loops: one row per
%   loop {type, kin_low, kin_high, e4F at its two saddle-node points}. A.nSS: largest number of steady states at one
%   kin_T. A.order: ordering of the saddle-node points along kin_T.
L1 = 0.0469; L2 = 0.7266;
A = struct('cls', 'fail', 'sub', '', 'shape', '', 'name', 'failed', 'nSS', 0, 'order', '', 'SN_K', [], 'SN_F', [], ...
           'Fmax', NaN, 'up', [], 'start', NaN, 'stop', NaN, 'dip', false, 'land', NaN); A.loops = cell(0, 5);
C = []; try, C = p4e_trace(P); catch, return, end
if isempty(C.kin), return, end
A.nSS = C.nSS; A.order = C.order; f = C.folds(:)'; n = numel(f); A.SN_K = C.kin(f)'; A.SN_F = C.F(f)'; A.Fmax = max(C.F);
cut = [1 f numel(C.kin)];
for j = 1:floor(n/2)                                   % e4F reached on switching on at loop j
    seg = cut(2*j+1):cut(2*j+2); A.up(j) = branch_at(C.kin(seg), C.F(seg), C.kin(f(2*j-1)));
end
if n == 0
    A.cls = 'mono'; A.name = 'monostable';
elseif n == 2
    A.cls = 'bi'; A.start = A.SN_F(1)/A.Fmax; A.stop = A.up(1)/A.Fmax; A.land = A.stop;
    if A.stop <= L2, A.sub = 'M1'; A.name = 'bistable: M1 switch';
    elseif A.start >= L1, A.sub = 'M2'; A.name = 'bistable: M2 switch';
    else, A.sub = 'general'; A.name = 'bistable: other'; end
    A.loops(1, :) = {A.sub, min(A.SN_K), max(A.SN_K), A.SN_F(1), A.SN_F(2)};
elseif n == 4
    K = A.SN_K; r1 = [min(K(1:2)) max(K(1:2))]; r2 = [min(K(3:4)) max(K(3:4))];
    A.start = A.SN_F(1)/A.Fmax; A.stop = A.up(1)/A.Fmax; A.dip = A.up(1) < A.SN_F(1);
    if r1(1) < r2(2) && r2(1) < r1(2), A.cls = 'tri'; A.sub = 'coexisting'; A.name = 'tristable, coexisting';
    else
        A.cls = 'bi'; A.sub = 'separate';
        if A.up(1) >= A.SN_F(1), A.shape = 'staircase'; A.name = 'tristable, separate: staircase';
        else, A.shape = 'mushroom'; A.name = 'tristable, separate: mushroom-like'; end
    end
    A.loops(1, :) = {'first', r1(1), r1(2), A.SN_F(1), A.SN_F(2)}; A.loops(2, :) = {'second', r2(1), r2(2), A.SN_F(3), A.SN_F(4)};
else
    A.cls = 'other'; A.name = sprintf('%d saddle-node points', n);
end
end

function v = branch_at(k, F, K)
% e4F on a stable branch (points k, F) at the kinase total K; the nearest end of the branch if K lies outside it.
[k, o] = sort(k(:)); F = F(o); F = F(:); [k, u] = unique(k); F = F(u);
if numel(k) < 2, v = F(1); elseif K <= k(1), v = F(1); elseif K >= k(end), v = F(end); else, v = interp1(k, F, K); end
end
