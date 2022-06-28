%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MAKE BER PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Has data from simulations and plots BER vs N0

%% Data

%%%%%%%%%%%%%%%%%%%
% RESULTS WITH HC %
%%%%%%%%%%%%%%%%%%%

% This is for with_hc/0a.mat 
N0MRC0a = [24 25 26 27 28 29 30]; 
BERMRC0a = [7.02e-5 3.45e-4 1.2e-3 3.8e-3 8.9e-3 1.9e-2 4.1e-2];

% This is for with_hc/0b.mat 
N0MRC0b = [24 25 26 27 28 29 30]; 
BERMRC0b = [6.8e-5 2.85e-4 1.1e-3 3.4e-3 8.1e-3 1.8e-2 3.8e-2];

% This is for with_hc/10a.mat 
N0MRC10a = [23 24 25 26 27 28 29]; 
BERMRC10a = [4.2e-5 2.4e-4 8.6e-4 2.4e-3 7.2e-3 1.5e-2 3.4e-2];

% This is for with_hc/10b.mat
N0MRC10b = [];
BERMRC10b = [];

% This is for with_hc/20a.mat 
N0MRC20a = [23 24 25 26 27 28]; 
BERMRC20a = [2.355e-5 1.41e-4 6.0e-4 1.87e-3 5.31e-3 1.26e-2];

% This is for with_hc/20b.mat 
N0MRC20b = [23 24 25 26 27 28]; 
BERMRC20b = [4.28e-5 1.94e-4 7.68e-4 2.41e-3 6.44e-3 1.43e-2];

% This is for with_hc/30a.mat 
N0MRC30a = [23 24 25 26 27 28]; 
BERMRC30a = [3.46e-5 1.68e-4 7.81e-4 2.22e-3 6.18e-3 1.35e-2];

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
N0ML20a = [28 27 26 25 24 23]; 
BERML20a = [.01203 .005327 .00202 .000601 .0001489 2.18e-5];

% This is for wo_hc/20b.mat 
N0ML20b = [28 27 26 25 24 23]; 
BERML20b = [.009732 .004309 .001543 .0004347 9.855e-5 1.508e-5];

% This is for wo_hc/30a.mat 
N0ML30a = [28 27 26 25 24 23]; 
BERML30a = [.01705 .008261 .00321 .001129 .0002883 6.391e-5];

% This is for wo_hc/30b.mat 
N0ML30b = [28 27 26 25 24 23]; 
BERML30b = [.01475 .007352 .003013 .0009528 .0002628 4.539e-5];

% This is for wo_hc/40a.mat
N0ML40a = [27 26 25 24 23];
BERML40a = [.01279 .005939 .00217 .0006526 .0001754];

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
N0ML80a = [26 25 24 23 22 21]; 
BERML80a = [0.0186 0.00848 0.003525 0.00192 0.0003253 6.526e-5];

% This is for wo_hc/80b.mat 
N0ML80b = []; 
BERML80b = [];

% This is for wo_hc/90a.mat 
N0ML90a = [26 25 24 23 22 21]; 
BERML90a = [0.01151 0.004927 0.001775 0.0005332 0.0001314 2.275e-5];

% This is for wo_hc/90b.mat 
N0ML90b = [27 26 25 24 23 22]; 
BERML90b = [0.01672 0.007438 0.003006 0.001013 0.0002559 5.21e-5];


%% Plots (TODO)
% Plot 0 a&b with hc
figure(100);
semilogy(-N0MRC0a,BERMRC0a,'o-'); hold on; semilogy(-N0MRC0b,BERMRC0b,'o-'); grid on; hold off;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';

% Plot 10 a&b with hc
figure(110);
semilogy(-N0MRC10a,BERMRC10a,'o-'); hold on; semilogy(-N0MRC10b,BERMRC10b,'o-'); grid on; hold off;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';

% Plot 20 a&b with hc
figure(120);
semilogy(-N0MRC20a,BERMRC20a,'o-'); hold on; semilogy(-N0MRC20b,BERMRC20b,'o-'); grid on; hold off;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';

% Plot 30 a&b with hc
figure(130);
semilogy(-N0MRC30a,BERMRC30a,'o-'); hold on; semilogy(-N0MRC30b,BERMRC30b,'o-'); grid on; hold off;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';

% Plot 20 a&b wo hc
figure(220);
semilogy(-N0ML20a,BERML20a,'o-'); hold on; semilogy(-N0ML20b,BERML20b,'o-'); grid on; hold off;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';

% Plot 30 a&b wo hc
figure(230);
semilogy(-N0ML30a,BERML30a,'o-'); hold on; semilogy(-N0ML30b,BERML30b,'o-'); grid on; hold off;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';

% Plot 80 a&b wo hc
figure(280);
semilogy(-N0ML80a,BERML80a,'o-'); hold on; semilogy(-N0ML80b,BERML80b,'o-'); grid on; hold off;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';

% Plot 90 a&b wo hc
figure(290);
semilogy(-N0ML90a,BERML90a,'o-'); hold on; semilogy(-N0ML90b,BERML90b,'o-'); grid on; hold off;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';

