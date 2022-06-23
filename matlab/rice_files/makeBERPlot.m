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
N0MRC30a = [];
BERMRC30a = [];

% This is for with_hc/30b.mat
N0MRC30b = [];
BERMRC30b = [];

% This is for with_hc/40a.mat
N0MRC40a = [];
BERMRC40a = [];

% This is for with_hc/40b.mat
N0MRC40b = [];
BERMRC40b = [];

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
N0MRC70a = [];
BERMRC70a = [];

% This is for with_hc/70b.mat
N0MRC70b = [];
BERMRC70b = [];

% This is for with_hc/80a.mat
N0MRC80a = [];
BERMRC80a = [];

% This is for with_hc/80b.mat
N0MRC80b = [];
BERMRC80b = [];

% This is for with_hc/90a.mat
N0MRC90a = [];
BERMRC90a = [];

% This is for with_hc/90b.mat
N0MRC90b = [];
BERMRC90b = [];

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
figure(120);
semilogy(-N0MRC20a,BERMRC20a,'o-'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';




