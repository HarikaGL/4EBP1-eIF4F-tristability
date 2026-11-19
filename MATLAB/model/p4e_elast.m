function e = p4e_elast(P, what, idx, h)
%P4E_ELAST  Elasticities of the four saddle-node points, e = d ln SN / d ln lambda, by central differences between
%   lambda = h and 1/h (default h = 1.02), for the change p4e_scale(P, what, idx, lambda). NaN if the number of
%   saddle-node points is not four in both runs.
if nargin < 4, h = 1.02; end
Cu = p4e_trace(p4e_scale(P, what, idx, h), P.links, true, 0.01, 5000, 60000);
Cd = p4e_trace(p4e_scale(P, what, idx, 1/h), P.links, true, 0.01, 5000, 60000);
if numel(Cu.SN) == 4 && numel(Cd.SN) == 4, e = (log(Cu.SN) - log(Cd.SN))/(2*log(h)); else, e = nan(1, 4); end
end
