%%%%%%%%%%%
% L0_L6.m %
%%%%%%%%%%%
% Uses the frame synchronizer functions from Rice-McMurdie 2016
% Needs a variable data_a

load preambleTemplate.mat

start_idx = 50e3; % Because sometimes the first samples in data_a are garbage

%%%%%%
% L0 %
%%%%%%
L0_res = zeros(1e6-255-start_idx, 1);
for m = start_idx:1e6 - 255
    L0_res(m-start_idx+1) = abs(dot(data_a(m:m+255), preamble_template));
end

figure(10); 
plot(L0_res); title('L0 Results'); grid on;


%%%%%%
% L6 %
%%%%%%
L6_res = zeros(1e6-255-start_idx, 1);
for m = start_idx:1e6 - 255
    first = abs(dot(data_a(m:m+127), preamble_template(1:128)));
    second = abs(dot(data_a(m+128:m+255), preamble_template(129:256)));
    L6_res(m-start_idx+1) = first + second;
end

figure(60);
plot(L6_res); title('L6 Results'); grid on;


%%%%%%%
% L6q %
%%%%%%%
% L6q_res = zeros(1e6-255-start_idx, 1);
% for m = start_idx:1e6 - 255
%     L6q_res(m-start_idx+1) = L6q_corr(data_a(m:m+255));
% end
% 
% figure(61);
% plot(L6q_res); title('L6q Results'); grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION DECLARATIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%

function L6q = L6q_corr(data_in)
    L1 = [0,8,16,24] + 1;
    L2 = [4,20] + 1;
    L3 = [2,10,14,22] + 1;
    L4 = [6,18,26,30] + 1;
    L5 = [1,7,9,15,17,23,25,31] + 1;
    L6 = [3,5,11,12,13,19,21,27,28,29] + 1;
    L7 = [1,3,9,11,12,13,15,21,23] + 1;
    L8 = [5,7,17,19,25,27,28,29,31] + 1;
    data_r = real(data_in);
    data_i = imag(data_in);
    res = 0;
    for i = 0:7
        I = sum(data_r(L1 + 32*i)) + ...
            -sum(data_r(L2 + 32*i)) + ...
            sum(data_i(L3 + 32*i)) + ...
            -sum(data_i(L4 + 32*i)) + ...
            1/sqrt(2)*( ...
            sum(data_r(L5 + 32*i)) + ...
            -sum(data_r(L6 + 32*i)) + ...
            sum(data_i(L7 + 32*i)) + ...
            -sum(data_i(L8 + 32*i)) ...
            );
        Q = sum(data_i(L1 + 32*i)) + ...
            -sum(data_i(L2 + 32*i)) + ...
            sum(data_r(L3 + 32*i)) + ...
            -sum(data_r(L4 + 32*i)) + ...
            1/sqrt(2)*( ...
            sum(data_i(L5 + 32*i)) + ...
            -sum(data_i(L6 + 32*i)) + ...
            sum(data_r(L7 + 32*i)) + ...
            -sum(data_r(L8 + 32*i)) ...
            );
        res = res + I^2 + Q^2;
    end
    L6q = res;
end




