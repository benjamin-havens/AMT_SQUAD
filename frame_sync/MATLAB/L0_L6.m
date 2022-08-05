%%%%%%%%%%%
% L0_L6.m %
%%%%%%%%%%%
% Uses the frame synchronizer functions from Rice-McMurdie 2016
% Needs a variable data_a

load preambleTemplate.mat
rev_preamble = flip(preamble_template);

%%%%%%
% L0 %
%%%%%%
L0_res = conv(data_a(50e3:end), conj(rev_preamble));
L0_res = abs(L0_res);
L0_res = L0_res(1:10000);
% L0_corr = 20*log10(L0_corr);

% figure(1); 
% subplot(211); plot(L0_res); grid on;
% subplot(212); plot(movmean(L0_res, 80)); grid on;

%%%%%%%
% L6q %
%%%%%%%
L6q_res = zeros(1e6, 1);
for m = 1:3328
    L6q_res(m) = L6q_corr(m, data_a(50e3 + 1:50e3 + 3328));
end
L6q_res = L6q_res(1e5:1.1e5);

figure(6);
subplot(211); plot(L6q_res); grid on;
subplot(212); plot(movmean(L6q_res, 100)); grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION DECLARATIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%

function L6q = L6q_corr(m, data_in)
    L1 = [0,8,16,24];
    L2 = [4,20];
    L3 = [2,10,14,22];
    L4 = [6,18,26,30];
    L5 = [1,7,9,15,17,23,25,31];
    L6 = [3,5,11,12,13,19,21,27,28,29];
    L7 = [1,3,9,11,12,13,15,21,23];
    L8 = [5,7,17,19,25,27,28,29,31];
    data_r = real(data_in);
    data_i = imag(data_in);
    res = 0;
    for i = 0:7
        I = sum(data_r(L1 + 32*i + m)) + ...
            -sum(data_r(L2 + 32*i + m)) + ...
            sum(data_i(L3 + 32*i + m)) + ...
            -sum(data_i(L4 + 32*i + m)) + ...
            1/sqrt(2)*( ...
            sum(data_r(L5 + 32*i + m)) + ...
            -sum(data_r(L6 + 32*i + m)) + ...
            sum(data_i(L7 + 32*i + m)) + ...
            -sum(data_i(L8 + 32*i + m)) ...
            );
        Q = sum(data_i(L1 + 32*i + m)) + ...
            -sum(data_i(L2 + 32*i + m)) + ...
            sum(data_r(L3 + 32*i + m)) + ...
            -sum(data_r(L4 + 32*i + m)) + ...
            1/sqrt(2)*( ...
            sum(data_i(L5 + 32*i + m)) + ...
            -sum(data_i(L6 + 32*i + m)) + ...
            sum(data_r(L7 + 32*i + m)) + ...
            -sum(data_r(L8 + 32*i + m)) ...
            );
        res = res + I^2 + Q^2;
    end
    L6q = res;
end




