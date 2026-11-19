function th = c09_own(A, sw, pr)
% Thresholds [on off] of switch sw ('M1' or 'M2') in a classified sample A (p4e_attribute), or [] if the switch is
% absent. Tristable (coexisting or separate loops): SN_K(pr), pr = [1 2] (M1) or [3 4] (M2). A single switch keeps the
% numbering of its stage: its on and off thresholds.
th = [];
if strcmp(A.cls, 'tri') || (strcmp(A.cls, 'bi') && strcmp(A.sub, 'separate')), th = A.SN_K(pr);
elseif strcmp(A.cls, 'bi') && strcmp(A.sub, sw), th = sort([A.loops{1, 2} A.loops{1, 3}], 'descend'); end
end
