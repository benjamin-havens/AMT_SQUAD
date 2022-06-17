%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% MAKE IMPULSE RESPONSE %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script will produce two impulse responses, h1 and h2, and save them
% to a .mat file. Needs an input csv file with two columns, one channel per
% column. h1 and h2 will be pruned.

%% Clean up
clc; clear; close all;

%% Load needed variables
% You can change the path to what is needed
load soundingSignal-BW10-Fs20.mat;
y_raw = readmatrix('../results/june_16/with_hc/0a.csv');
a_raw = y_raw(:, 1);
b_raw = y_raw(:, 2);
x = xl;

%% Get FFTs
Nfft = 128;
FF = -0.5:1/Nfft:0.5-1/Nfft;
good_idx = 20001:20001+Nfft-1; % A good index to look at where the data is 
                             % normal (arbitrary where exactly)
a = a_raw(good_idx);
b = a_raw(good_idx);
A = fft(a,Nfft);
B = fft(b,Nfft);
X = fft(x,Nfft);

%% Get the transfer functions H1 and H2
divide_idx = [2:32 97:128]; % This is needed because only some of these
                            % points are meaningful to us
H1 = zeros(Nfft,1);
H2 = zeros(Nfft,1);
H1(divide_idx) = A(divide_idx)./X(divide_idx);
H2(divide_idx) = B(divide_idx)./X(divide_idx);

%% Determine where in the period to begin the FFT
max_indices_h1 = zeros(Nfft,1);
h1 = fftshift(ifft(H1,Nfft));
[~,foo] = max(abs(h1));
max_indices_h1(1) = foo;

max_indices_h2 = zeros(Nfft,1);
h2 = fftshift(ifft(H2,Nfft));
[~,foo] = max(abs(h2));
max_indices_h2(1) = foo;

for idx = 1:Nfft-1
    a = a_raw(good_idx + idx);
    b = a_raw(good_idx + idx);
    A = fft(a,Nfft);
    B = fft(b,Nfft);
    H1(divide_idx) = A(divide_idx)./X(divide_idx);
    H2(divide_idx) = B(divide_idx)./X(divide_idx);
    h1 = fftshift(ifft(H1,Nfft));
    h2 = fftshift(ifft(H2,Nfft));
    [~,foo] = max(abs(h1));
    max_indices_h1(idx+1) = foo;
    [~,foo] = max(abs(h2));
    max_indices_h2(idx+1) = foo;
end

%% Find index for best impulse response (where max is at 64)
h1_best = find(max_indices_h1==65);
h2_best = find(max_indices_h2==65);

h1_idx = h1_best(1);
h2_idx = h2_best(1);

a = a_raw(good_idx + h1_idx);
b = a_raw(good_idx + h2_idx);
A = fft(a,Nfft);
B = fft(b,Nfft);
H1(divide_idx) = A(divide_idx)./X(divide_idx);
H2(divide_idx) = B(divide_idx)./X(divide_idx);
h1 = fftshift(ifft(H1,Nfft));
h2 = fftshift(ifft(H2,Nfft));

%% Prune them




%% Save them to appropriate file