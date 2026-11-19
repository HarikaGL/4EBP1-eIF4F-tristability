function [w3, w5] = p4e_widths(C, kmin, kmax)
%P4E_WIDTHS  Width of the kinase range (nM) with at least three steady states (w3) and with five (three stable states
%   coexisting, w5) on the curve C from p4e_trace.
if nargin < 2, kmin = 0.01; end
if nargin < 3, kmax = 5000; end
w3 = 0; w5 = 0; if isempty(C.SN), return, end
cuts = sort([kmin kmax C.SN(C.SN > kmin & C.SN < kmax)]);
for i = 1:numel(cuts)-1
    m = (cuts(i) + cuts(i+1))/2; n = sum((C.kin(1:end-1) - m).*(C.kin(2:end) - m) < 0);
    if n >= 3, w3 = w3 + cuts(i+1) - cuts(i); end
    if n >= 5, w5 = w5 + cuts(i+1) - cuts(i); end
end
end
