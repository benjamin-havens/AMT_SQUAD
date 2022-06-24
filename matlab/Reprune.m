 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% REPRUNE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check frequency domain of h1 and h2, and pruned h1 and h2. Make sure no
% overriding deviation occurs


%% Clean up
clc; clear; close all;


%% Needed values
IR_path = "impulse_responses/new/";
CSV_path = "../results/june_23/";
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
bdh_indices = [1 27;
               9 31;
               5 31;
               1 27;
               1 25;
               1 24;
               1 27;
               1 27;
               10 31;
               1 27;
               1 35;
               34 68;
               1 40;
               39 73;
               41 73;
               43 84;
               11 47;
               45 81;
               5 27;
               1 28;
               5 19; % begin wo_hc
               5 19;
               1 13;
               1 16;
               5 19;
               1 15;
               5 19;
               1 19;
               1 28;
               1 21;
               47 78;
               5 39;
               46 80;
               41 80;
               36 73;
               37 79;
               42 90;
               48 92;
               32 79;
               37 82
    ];


%% Load each one and plot FFTs
Nfft = 128;
FF = -0.5:1/Nfft:0.5-1/Nfft;

for k = 1:40
    load(strcat(IR_path, test_names(k), ".mat"));
    
    H1 = fftshift(abs(fft(h1, Nfft)));
    H2 = fftshift(abs(fft(h2, Nfft)));
    H1_PO = fftshift(abs(fft(h1_pruned_old, Nfft)));
    H2_PO = fftshift(abs(fft(h2_pruned_old, Nfft)));
    H1_P = fftshift(abs(fft(h1_pruned, Nfft)));
    H2_P = fftshift(abs(fft(h2_pruned, Nfft)));

    figure(1); sgtitle(test_names(k), 'Interpreter', 'none');
    ax1 = subplot(321); plot(FF, H1); title('h1');
    xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
    ax3 = subplot(323); plot(FF, H1_PO);
    xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
    ax5 = subplot(325); plot(FF, H1_P);
    xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
    ax2 = subplot(322); plot(FF, H2); title('h2');
    xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
    ax4 = subplot(324); plot(FF, H2_PO);
    xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
    ax6 = subplot(326); plot(FF, H2_P);
    xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
    linkaxes([ax1, ax3, ax5]);
    linkaxes([ax2, ax4, ax6]);

    figure(2); sgtitle(test_names(k), 'Interpreter', 'none');
    ax1 = subplot(321); stem(abs(h1)); title('h1');
    xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
    ax3 = subplot(323); stem(abs(h1_pruned_old));
    xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
    ax5 = subplot(325); stem(abs(h1_pruned));
    xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
    ax2 = subplot(322); stem(abs(h2)); title('h2');
    xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
    ax4 = subplot(324); stem(abs(h2_pruned_old));
    xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
    ax6 = subplot(326); stem(abs(h2_pruned));
    xlabel('Normalized Frequency (cycles/sample)'); ylabel('Magnitude');
    pause;
end




