function ci = p4e_wilson(k, n)
%P4E_WILSON  Wilson 95% interval (in percent) for k successes in n trials.
z = 1.959964; p = k/n; d = 1 + z^2/n; c = (p + z^2/(2*n))/d; h = z*sqrt(p*(1-p)/n + z^2/(4*n^2))/d;
ci = 100*[c - h, c + h];
end
