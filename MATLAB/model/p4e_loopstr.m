function s = p4e_loopstr(v)
%P4E_LOOPSTR  A loop (vector of reaction coefficients) as text, e.g. '+R1 +R2 +R7 +R8'.
s = '';
for j = find(v)
    if abs(v(j)) == 1, c = ''; else, c = sprintf('%d', abs(v(j))); end
    if v(j) > 0, sg = '+'; else, sg = '-'; end
    s = [s sprintf('%s%sR%d ', sg, c, j)]; %#ok<AGROW>
end
s = strtrim(s);
end
