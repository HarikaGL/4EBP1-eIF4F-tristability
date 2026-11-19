function s = c08_summary(A)
% Counts of outcomes over a set of samples (used by C08).
c = cellfun(@c08_class, A, 'UniformOutput', false); u = unique(c);
s = strjoin(cellfun(@(k) sprintf('%s %d', c08_name(k), sum(strcmp(c, k))), u, 'UniformOutput', false), ', ');
end
