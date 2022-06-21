%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% CHECK MAXES MATCH %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simple script to make sure the maxes match in all mat files h1 and h2

%% Clean up
clc; clear; close all;


%% Needed variables
IR_path = "impulse_responses/";
CSV_path = "../results/june_16/";
csv_names = ["with_hc/0a" "with_hc/0b" "with_hc/10a" "with_hc/10b" ...
             "with_hc/20a" "with_hc/20b" "with_hc/30a" "with_hc/30b" ...
             "with_hc/40a" "with_hc/40b" "with_hc/50a" "with_hc/50b" ...
             "with_hc/60a" "with_hc/60b" "with_hc/70a" "with_hc/70b" ...
             "with_hc/80a" "with_hc/80b" "with_hc/90a" "with_hc/90b" ...
             "wo_hc/0a" "wo_hc/0b" "wo_hc/10a" "wo_hc/10b" ...
             "wo_hc/20a" "wo_hc/20b" "wo_hc/30a" "wo_hc/30b" ...
             "wo_hc/40a" "wo_hc/40b" "wo_hc/50a" "wo_hc/50b" ...
             "wo_hc/60a" "wo_hc/60b" "wo_hc/70a" "wo_hc/70b" ...
             "wo_hc/80a" "wo_hc/80b" "wo_hc/90a" "wo_hc/90b" ...
    ];
Nfft = 128;
good_idx = 20001:20001+Nfft-1;      % A good index to look at where the data is 
                                    % normal (arbitrary where exactly)
divide_idx = [2:32 97:128];         % This is needed because only some of these
                                    % points are meaningful to us
load soundingSignal-BW10-Fs20.mat;
X = fft(xl,Nfft);


%% Check if the max indices in the ffts align, print if not
count = 0;
for k = 1:40
    load(strcat(IR_path, csv_names(k), ".mat"));
    [~, h1_max] = max(h1_pruned);
    [~, h2_max] = max(h2_pruned);
    if h1_max ~= h2_max
        count = count + 1;
        fprintf("For %s.mat, max indices do not align. h1_max = %d, h2_max = %d\n", ...
            csv_names(k), h1_max, h2_max);
    end
    figure(1);
    subplot(211); stem(abs(h1_pruned)); grid on;
    title(csv_names(k), 'Interpreter', 'none');
    subplot(212); stem(abs(h2_pruned)); grid on;
    pause;
end

fprintf("Max indices did not align for %d files.\n", count);






