function c = p4e_class4(nLP, nSS)
%P4E_CLASS4  Class of a curve used for Table 6 and Figs 10, 11, from the number of saddle-node points nLP and the largest
%   number of coexisting steady states nSS (p4e_trace): 'tri' (tristable, coexisting: 4 points, 5 steady states),
%   'sep' (tristable, separate: 4 points, at most 3 steady states), 'bi' (3 steady states), 'mono' (1 steady state,
%   including a pair of points too close to give three steady states at any resolved kin_T), 'other'.
if nLP == 4 && nSS == 5, c = 'tri';
elseif nLP == 4 && nSS == 3, c = 'sep';
elseif nSS == 3, c = 'bi';
elseif nSS == 1, c = 'mono';
else, c = 'other'; end
end
