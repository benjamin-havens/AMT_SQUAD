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
path = '../results/june_16/';
csv_name = 'wo_hc/50b';
IR_path = './impulse_responses/';
load soundingSignal-BW10-Fs20.mat;
y_raw = readmatrix(strcat(path, csv_name, '.csv'));
a_raw = y_raw(:, 1);
b_raw = y_raw(:, 2);
x = xl;

%% Get FFTs
Nfft = 128;
FF = -0.5:1/Nfft:0.5-1/Nfft;
good_idx = 20001:20001+Nfft-1; % A good index to look at where the data is 
                             % normal (arbitrary where exactly)
a = a_raw(good_idx);
b = b_raw(good_idx);
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
    b = b_raw(good_idx + idx);
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
b = b_raw(good_idx + h2_idx);
A = fft(a,Nfft);
B = fft(b,Nfft);
H1(divide_idx) = A(divide_idx)./X(divide_idx);
H2(divide_idx) = B(divide_idx)./X(divide_idx);
h1 = fftshift(ifft(H1,Nfft));
h2 = fftshift(ifft(H2,Nfft));

%% Prune them (to only the values that make up 99% of their energy)
en_h1 = sum(abs(h1).^2);
en_h2 = sum(abs(h2).^2);
prune_by = 0.95;

tmp = h1;
h1_pruned = zeros(Nfft, 1);
sum_h1 = 0;
while sum_h1 < prune_by*en_h1
    [val, idx] = max(abs(tmp));
    h1_pruned(idx) = tmp(idx);
    tmp(idx) = 0;
    sum_h1 = sum_h1 + val^2;
end
h1_pruned = h1_pruned(find(h1_pruned,1,'first'):find(h1_pruned,1,'last'));

tmp = h2;
h2_pruned = zeros(Nfft, 1);
sum_h2 = 0;
while sum_h2 < prune_by*en_h2
    [val, idx] = max(abs(tmp));
    h2_pruned(idx) = tmp(idx);
    tmp(idx) = 0;
    sum_h2 = sum_h2 + val^2;
end
h2_pruned = h2_pruned(find(h2_pruned,1,'first'):find(h2_pruned,1,'last'));


h1_size = size(h1_pruned);
h1_size = h1_size(1);
h2_size = size(h2_pruned);
h2_size = h2_size(1);
while h1_size ~= h2_size
    h1_size = size(h1_pruned);
    h1_size = h1_size(1);
    h2_size = size(h2_pruned);
    h2_size = h2_size(1);

    [~, h1_max_idx] = max(abs(h1_pruned));
    [~, h2_max_idx] = max(abs(h2_pruned));

    if h1_size < h2_size
        if h1_max_idx < h2_max_idx
            h1_pruned = [0; h1_pruned];
        else
            h1_pruned = [h1_pruned; 0];
        end
    elseif h2_size < h1_size
        if h2_max_idx < h1_max_idx
            h2_pruned = [0; h2_pruned];
        else
            h2_pruned = [h2_pruned; 0];
        end
    end

end

%% Save them to appropriate file
save(strcat(IR_path, csv_name, '.mat'), "h1_pruned", "h2_pruned");

%% Plot h1 and h2
figure(1); subplot(121); stem(abs(h1));
title('Channel A'); xlabel('Sample'); ylabel('Magnitude');
subplot(122); stem(abs(h1_pruned));
title('Channel A pruned'); xlabel('Sample'); ylabel('Magnitude');
figure(2); subplot(121); stem(abs(h2));
title('Channel B'); xlabel('Sample'); ylabel('Magnitude');
subplot(122); stem(abs(h2_pruned));
title('Channel B pruned'); xlabel('Sample'); ylabel('Magnitude');




