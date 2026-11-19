function c = c08_class(a)
% Class code of one sample (p4e_attribute): 'tri' (tristable, coexisting), 'separate' (tristable, separate),
% 'M1', 'M2' (bistable with an M1 or an M2 switch), 'general' (bistable, other), 'mono', 'inadmissible'.
% c08_name gives the class in words.
c = a.cls;
if strcmp(c, 'bi'), c = a.sub; end
end
