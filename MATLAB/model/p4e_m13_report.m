function p4e_m13_report(nm, b)
%P4E_M13_REPORT  Print the part-B summary of M13 for one ensemble (b: struct saved in Results/M13_B_<ensemble>.mat).
sl = max(b.on, b.off); sl(isnan(b.on) | isnan(b.off)) = NaN;   % max() ignores NaN: a set must switch both ways
n = numel(b.idx); ok = ~isnan(sl);
q = @(x) p4e_prctile(x(~isnan(x)), [50 5 95]); qo = q(b.on); qf = q(b.off);
fprintf('B. %-6s %d sets timed: %d without a measurable eIF4F switch (left out), %d not tristable on recomputation (left out);\n', ...
        nm, b.ntimed, b.nflat, b.nother);
fprintf('          %d tristable sets with a switch: %d switching both ways within the run (TEND), %d switching on only, %d not switching on;\n', ...
        n, sum(ok), sum(~isnan(b.on) & isnan(b.off)), sum(isnan(b.on)));
fprintf('          switch on median %.0f min (5-95%%: %.0f-%.0f), switch off median %.0f min (5-95%%: %.0f-%.0f);\n', ...
        qo(1), qo(2), qo(3), qf(1), qf(2), qf(3));
fprintf('          both within 30 min: %d sets (%.1f%%), within 60 min: %d sets (%.1f%%)', ...
        sum(sl <= 30), 100*sum(sl <= 30)/max(n, 1), sum(sl <= 60), 100*sum(sl <= 60)/max(n, 1));
if any(ok), sl(~ok) = Inf; [~, i] = min(sl); fprintf('; fastest set: on %.1f, off %.1f min\n', b.on(i), b.off(i)); else, fprintf('; no set switched within TEND\n'); end
end
