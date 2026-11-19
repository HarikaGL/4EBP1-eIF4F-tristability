function s = c08_name(c)
% Class code (c08_class) in words, as used in the manuscript.
switch c
    case 'tri', s = 'tristable, coexisting';
    case 'separate', s = 'tristable, separate';
    case 'M1', s = 'bistable: M1 switch';
    case 'M2', s = 'bistable: M2 switch';
    case 'general', s = 'bistable: other';
    case 'mono', s = 'monostable';
    otherwise, s = c;
end
end
