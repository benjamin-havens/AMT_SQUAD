%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MAKE BER PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Has data from simulations and plots BER vs N0

%% Data

%%%%%%%%%%%%%%%%%%%
% RESULTS WITH HC %
%%%%%%%%%%%%%%%%%%%

% This is for with_hc/0a.mat
N0MRC0a = [];
BERMRC0a = [];

% This is for with_hc/0b.mat
N0MRC0b = [];
BERMRC0b = [];

% This is for with_hc/10a.mat
N0MRC10a = [];
BERMRC10a = [];

% This is for with_hc/10b.mat
N0MRC10b = [];
BERMRC10b = [];

% This is for with_hc/20a.mat
N0MRC20a = [28 29 30 31 32 33 34]; % 82 on 28
BERMRC20a = [8.43e-6 4.4e-5 2.5e-4 9.5e-4 3.6e-3 7.5e-3 1.7e-2];

% This is for with_hc/20b.mat
N0MRC20b = [28 29 30 31 32];
BERMRC20b = [4e-6 2.37e-5 1.45e-4 6e-4 2e-3];

% This is for with_hc/30a.mat
N0MRC30a = [28 29 30 31 32];
BERMRC30a = [3.1e-6 1.45e-5 9.5e-5 4.04e-4 1.49e-3];

% This is for with_hc/30b.mat
N0MRC30b = [29 30 31 32 33 34];
BERMRC30b = [3.18e-5 1.41e-4 6.53e-4 2e-3 6.63e-3 1.266e-2];

% This is for with_hc/40a.mat
N0MRC40a = [29 30 31 32 33];
BERMRC40a = [7.5e-5 3.45e-4 1.53e-3 3.74e-3 1.06e-2];

% This is for with_hc/40b.mat
N0MRC40b = [29];
BERMRC40b = [8.3e-5];

% This is for with_hc/50a.mat
N0MRC50a = [];
BERMRC50a = [];

% This is for with_hc/50b.mat
N0MRC50b = [];
BERMRC50b = [];

% This is for with_hc/60a.mat
N0MRC60a = [];
BERMRC60a = [];

% This is for with_hc/60b.mat
N0MRC60b = [];
BERMRC60b = [];

% This is for with_hc/70a.mat
N0MRC70a = [25 26 27 28 29];
BERMRC70a = [4.945e-5 2.571e-4 9.679e-4 2.916e-3 1.574e-2];

% This is for with_hc/70b.mat
N0MRC70b = [25 26 27 28 29 30];
BERMRC70b = [2.259e-5 1.421e-4 5.449e-4 1.853e-3 4.946e-3 1.158e-2];

% This is for with_hc/80a.mat
N0MRC80a = [23 24 25 26 27 28];
BERMRC80a = [7.479e-6 5.092e-5 2.431e-4 9.442e-4 2.757e-3 6.625e-3 6.764e-2];

% This is for with_hc/80b.mat
N0MRC80b = [24 25 26 27 28 29];
BERMRC80b = [2.039e-5 1.259e-4 5.483e-4 1.805e-3 4.792e-3 1.1e-2];

% This is for with_hc/90a.mat
N0MRC90a = [22 23 24 25 26 27 28];
BERMRC90a = [4.575e-6 3.48e-5 1.626e-4 7.07e-4 2.307e-3 5.75e-3 1.306e-2];

% This is for with_hc/90b.mat
N0MRC90b = [21 22 23 24 25 26 27]; %21 still needs to be done
BERMRC90b = [1.15e-6 1.5e-5 9.534e-5 4.537e-4 1.33e-3 3.931e-3 9.627e-3];

%%%%%%%%%%%%%%%%%%
% RESULTS W/O HC %
%%%%%%%%%%%%%%%%%%

% This is for wo_hc/0a.mat
N0ML0a = [];
BERML0a = [];

% This is for wo_hc/0b.mat
N0ML0b = [];
BERML0b = [];

% This is for wo_hc/10a.mat
N0ML10a = [];
BERML10a = [];

% This is for wo_hc/10b.mat
N0ML10b = [];
BERML10b = [];

% This is for wo_hc/20a.mat
N0ML20a = [];
BERML20a = [];

% This is for wo_hc/20b.mat
N0ML20b = [];
BERML20b = [];

% This is for wo_hc/30a.mat
N0ML30a = [];
BERML30a = [];

% This is for wo_hc/30b.mat
N0ML30b = [];
BERML30b = [];

% This is for wo_hc/40a.mat
N0ML40a = [];
BERML40a = [];

% This is for wo_hc/40b.mat
N0ML40b = [];
BERML40b = [];

% This is for wo_hc/50a.mat
N0ML50a = [];
BERML50a = [];

% This is for wo_hc/50b.mat
N0ML50b = [];
BERML50b = [];

% This is for wo_hc/60a.mat
N0ML60a = [];
BERML60a = [];

% This is for wo_hc/60b.mat
N0ML60b = [];
BERML60b = [];

% This is for wo_hc/70a.mat
N0ML70a = [];
BERML70a = [];

% This is for wo_hc/70b.mat
N0ML70b = [];
BERML70b = [];

% This is for wo_hc/80a.mat
N0ML80a = [];
BERML80a = [];

% This is for wo_hc/80b.mat
N0ML80b = [];
BERML80b = [];

% This is for wo_hc/90a.mat
N0ML90a = [];
BERML90a = [];

% This is for wo_hc/90b.mat
N0ML90b = [];
BERML90b = [];


%% Plots (TODO)

% Plot 20a with hc
figure(221);
semilogy(-N0MRC20a,BERMRC20a,'o-'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';

% Plot 20b with hc
figure(222);
semilogy(-N0MRC20b,BERMRC20b,'o-'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';


