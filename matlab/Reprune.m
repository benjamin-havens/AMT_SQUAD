%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% REPRUNE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check frequency domain of h1 and h2, and pruned h1 and h2. Make sure no
% overriding deviation occurs


%% Clean up
clc; clear; close all;


%% Needed values
IR_path = "impulse_responses/";
CSV_path = "../results/june_16/";
test_names = ["with_hc/0a" "with_hc/0b" "with_hc/10a" "with_hc/10b" ...
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
mdr_indices = [1 15;
               5 15;
               5 15;
               1 16;
               1 17;
               5 19;
               4 16;
               5 15;
               3 16;
               5 15;
               4 16;
               5 23;
               9 19;
               1 19;
               9 19;
               1 19;
               1 19;
               5 23;
               5 23;
               1 19;
               53 79;
               9 27;
               49 64;
               11 37;
               9 33;
               11 39;
               21 51;
               7 33;
               5 23;
               40 67;
               47 81;
               16 36;
               47 73;
               22 48;
               1 21;
               9 25;
               5 19;
               9 25;
               1 25;
               1 23;];


%% Load each one and plot FFTs
Nfft = 128;
FF = -0.5:1/Nfft:0.5-1/Nfft;

for k = 1:40
    st_idx = mdr_indices(k, 1);
    end_idx = mdr_indices(k, 2);
    load(strcat(IR_path, test_names(k), ".mat"));

    h1_pruned_old = h1_pruned;
    h2_pruned_old = h2_pruned;
    h1_pruned = h1_pruned(st_idx:end_idx);
    h2_pruned = h2_pruned(st_idx:end_idx);
%     figure(1); sgtitle(test_names(k), 'Interpreter', 'none');
%     ax1 = subplot(321); plot(FF, fftshift(abs(fft(h1, Nfft)))); title('h1');
%     xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
%     ax3 = subplot(323); plot(FF, fftshift(abs(fft(h1_pruned, Nfft))));
%     xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
%     ax5 = subplot(325); plot(FF, fftshift(abs(fft(h1_pruned(st_idx:end_idx), Nfft))));
%     xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
%     ax2 = subplot(322); plot(FF, fftshift(abs(fft(h2, Nfft)))); title('h2');
%     xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
%     ax4 = subplot(324); plot(FF, fftshift(abs(fft(h2_pruned, Nfft))));
%     xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
%     ax6 = subplot(326); plot(FF, fftshift(abs(fft(h2_pruned(st_idx:end_idx), Nfft))));
%     xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
%     linkaxes([ax1, ax3, ax5]);
%     linkaxes([ax2, ax4, ax6]);
%     figure(2); sgtitle(test_names(k), 'Interpreter', 'none');
%     ax1 = subplot(321); stem(abs(h1)); title('h1');
%     xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
%     ax3 = subplot(323); stem(abs(h1_pruned));
%     xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
%     ax5 = subplot(325); stem(abs(h1_pruned(st_idx:end_idx)));
%     xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
%     ax2 = subplot(322); stem(abs(h2)); title('h2');
%     xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
%     ax4 = subplot(324); stem(abs(h2_pruned));
%     xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
%     ax6 = subplot(326); stem(abs(h2_pruned(st_idx:end_idx)));
%     xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
%     pause;
end



