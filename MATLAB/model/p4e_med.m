function m = p4e_med(v)
%P4E_MED  Median of the non-NaN values of v; NaN if there are none.
v = v(~isnan(v)); if isempty(v), m = NaN; else, m = median(v); end
end
