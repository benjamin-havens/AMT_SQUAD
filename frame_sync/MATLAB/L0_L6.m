%%%%%%%%%%%
% L0_L6.m %
%%%%%%%%%%%
% Uses the frame synchronizer functions from 

load preambleTemplate.mat
rev_preamble = flip(preamble_template);

%%%%%%
% L0 %
%%%%%%
L0_corr = conv(data_a(50e3:end), conj(rev_preamble));
L0_corr = abs(L0_corr);
L0_corr = L0_corr(1:10000);
% L0_corr = 20*log10(L0_corr);

figure(1); 
subplot(211); plot(L0_corr); grid on;
subplot(212); plot(movmean(L0_corr, 80)); grid on;

%%%%%%%
% L6q %
%%%%%%%
figure(1); 
subplot(211); plot(L0_corr); grid on;
subplot(212); plot(movmean(L0_corr, 80)); grid on;