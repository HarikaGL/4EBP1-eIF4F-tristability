function nm = c08_sn_names(c)
% Names of the thresholds of each class. A single switch keeps the numbering of its stage: an M1 switch is bounded
% by SN1 (on) and SN2 (off), an M2 switch by SN3 (on) and SN4 (off); a bistable curve with an other switch (low to high e4F in one step,
% not one of the tristable saddle-node points) by SN1* (on) and SN2* (off). Thresholds of single switches are listed on first, then off.
switch c
    case {'tri', 'separate'}, nm = {'SN1', 'SN2', 'SN3', 'SN4'};
    case 'M1', nm = {'SN1', 'SN2'};
    case 'M2', nm = {'SN3', 'SN4'};
    case 'general', nm = {'SN1*', 'SN2*'};
    otherwise, nm = {};
end
end
