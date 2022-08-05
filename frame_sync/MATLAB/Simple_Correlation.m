rev_preamble = flip(preamble_template);
L0_corr = conv(data_a(50e3:end), conj(rev_preamble));
L0_corr = abs(L0_corr);
L0_corr = L0_corr(1:10000);
L0_corr = 20*log10(L0_corr);

[max_vals, max_idxs] = maxk(L0_corr, 3);

figure(1);
plot(L0_corr);
figure(2);
plot(movmean(L0_corr, 80));