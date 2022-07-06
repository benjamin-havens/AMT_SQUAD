%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MAKE BER PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Has data from simulations and plots BER vs N0

%% Data

%%%%%%%%%%%%%%%%%%%
% RESULTS WITH HC %
%%%%%%%%%%%%%%%%%%%

% This is for with_hc/0a.mat 
N0MRC0a = [23 24 25 26 27 28 29 30]; 
BERMRC0a = [4.137e-6 7.02e-5 3.45e-4 1.2e-3 3.8e-3 8.9e-3 1.9e-2 4.1e-2];

% This is for with_hc/0b.mat 
N0MRC0b = [24 25 26 27 28 29 30]; 
BERMRC0b = [6.8e-5 2.85e-4 1.1e-3 3.4e-3 8.1e-3 1.8e-2 3.8e-2];

% This is for with_hc/10a.mat 
N0MRC10a = [23 24 25 26 27 28 29]; 
BERMRC10a = [3.2e-5 2.0e-4 7.0e-4 2.3e-3 6.2e-3 1.5e-2 3.1e-2];

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
N0MRC30a = [22 23 24 25 26 27 28]; 
BERMRC30a = [5.126e-6 3.46e-5 1.68e-4 7.81e-4 2.22e-3 6.18e-3 1.35e-2];

% This is for with_hc/30b.mat
N0MRC30b = [];
BERMRC30b = [];

% This is for with_hc/40a.mat
N0MRC40a = [21 22 23 24 25 26 27];
BERMRC40a = [9.45e-6 8.15e-5 3.54e-4 1.38e-3 3.78e-3 8.88e-3 1.87e-2];

% This is for with_hc/40b.mat
N0MRC40b = [];
BERMRC40b = [];

% This is for with_hc/50a.mat
N0MRC50a = [21 22 23 24 25 26 27];
BERMRC50a = [1.251e-5 8.01e-5 3.3e-4 1.42e-3 3.91e-3 9.28e-3 1.97e-2];

% This is for with_hc/50b.mat
N0MRC50b = [];
BERMRC50b = [];

% This is for with_hc/60a.mat
N0MRC60a = [20 21 22 23 24 25 26];
BERMRC60a = [5.282e-6 4.647e-5 2.239e-4 8.81e-4 2.765e-3 7.083e-3 1.533e-2];

% This is for with_hc/60b.mat
N0MRC60b = [];
BERMRC60b = [];

% This is for with_hc/70a.mat
N0MRC70a = [20 21 22 23 24 25 26];
BERMRC70a = [5.5e-6 3.586e-5 1.811e-4 7.445e-4 2.38e-3 6.133e-3 1.432e-2];

% This is for with_hc/70b.mat
N0MRC70b = [];
BERMRC70b = [];

% This is for with_hc/80a.mat
N0MRC80a = [20 21 22 23 24 25 26];
BERMRC80a = [8.624e-6 6.051e-5 2.859e-4 1.089e-3 3.246e-3 8.188e-3 1.738e-2];

% This is for with_hc/80b.mat
N0MRC80b = [20 21 22 23 24 25 26];
BERMRC80b = [8.975e-6 5.306e-5 2.878e-4 1.023e-3 3.054e-3 7.687e-3 1.661e-2];

% This is for with_hc/90a.mat
N0MRC90a = [21 22 23 24 25 26];
BERMRC90a = [1.455e-5 8.301e-5 4.067e-4 1.478e-3 4.061e-3 1.007e-2]; % 1.174e-6  on 20

% This is for with_hc/90b.mat
N0MRC90b = [21 22 23 24 25 26];
BERMRC90b = [1.506e-5 9.466e-5 4.47e-4 1.508e-3 4.064e-3 9.753e-3];

%%%%%%%%%%%%%%%%%%
% RESULTS W/O HC %
%%%%%%%%%%%%%%%%%%

% This is for wo_hc/0a.mat
N0ML0a = [23 24 25 26 27 28 29 30];
BERML0a = [5.446e-6 5.2e-5 2.6e-4 8.8e-4 2.8e-3 7.6e-3 1.6e-2 0.02965]; %TODO

% This is for wo_hc/0b.mat
N0ML0b = [];
BERML0b = [];

% This is for wo_hc/10a.mat
N0ML10a = [23 24 25 26 27 28 29];
BERML10a = [2.4e-5 1.4e-4 5.7e-4 1.8e-3 5.0e-3 1.2e-2 .02322];

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
N0ML30a = [28 27 26 25 24 23 22]; 
BERML30a = [.01705 .008261 .00321 .001129 .0002883 6.391e-5 8.21e-6];

% This is for wo_hc/30b.mat 
N0ML30b = [28 27 26 25 24 23]; 
BERML30b = [.01475 .007352 .003013 .0009528 .0002628 4.539e-5];

% This is for wo_hc/40a.mat
N0ML40a = [27 26 25 24 23 22 21];
BERML40a = [.01279 .005939 .00217 .0006526 .0001754 2.777e-5 4.25e-6];

% This is for wo_hc/40b.mat
N0ML40b = [];
BERML40b = [];

% This is for wo_hc/50a.mat
N0ML50a = [27 26 25 24 23 22 21];
BERML50a = [.01423 .006482 .002486 .0008081 .0002069 3.843e-5 5.054e-6];

% This is for wo_hc/50b.mat
N0ML50b = [];
BERML50b = [];

% This is for wo_hc/60a.mat
N0ML60a = [26 25 24 23 22 21 20];
BERML60a = [0.02192 0.0107 0.004636 0.001631 0.0004673 0.0001096 1.731e-5];

% This is for wo_hc/60b.mat
N0ML60b = [];
BERML60b = [];

% This is for wo_hc/70a.mat
N0ML70a = [26 25 24 23 22 21 20];
BERML70a = [0.01983 0.009655 0.003979 0.001446 0.0003864 8.758e-5 1.392e-5];

% This is for wo_hc/70b.mat
N0ML70b = [];
BERML70b = [];

% This is for wo_hc/80a.mat 
N0ML80a = [26 25 24 23 22 21 20]; 
BERML80a = [0.0186 0.00848 0.003525 0.001213 0.0003253 6.526e-5 1.133e-5];

% This is for wo_hc/80b.mat 
N0ML80b = []; 
BERML80b = [];

% This is for wo_hc/90a.mat 
N0ML90a = [26 25 24 23 22 21]; 
BERML90a = [0.01151 0.004927 0.001775 0.0005332 0.0001314 2.275e-5];

% This is for wo_hc/90b.mat 
N0ML90b = [27 26 25 24 23 22]; 
BERML90b = [0.01672 0.007438 0.003006 0.001013 0.0002559 5.21e-5];


%% Plots

% PLOT ALL A's
figure(1);
semilogy(-N0MRC0a, BERMRC0a, '-o'); hold on;
semilogy(-N0MRC10a, BERMRC10a, '-o'); 
semilogy(-N0MRC20a, BERMRC20a, '-o'); 
semilogy(-N0MRC30a, BERMRC30a, '-o'); 
semilogy(-N0MRC40a, BERMRC40a, '-o'); 
semilogy(-N0MRC50a, BERMRC50a, '-o'); 
semilogy(-N0MRC60a, BERMRC60a, '-o'); 
semilogy(-N0MRC70a, BERMRC70a, '-o'); 
semilogy(-N0MRC80a, BERMRC80a, '-o'); 
semilogy(-N0MRC90a, BERMRC90a, '-o');
semilogy(-N0ML0a, BERML0a, '-s'); 
semilogy(-N0ML10a, BERML10a, '-s'); 
semilogy(-N0ML20a, BERML20a, '-s'); 
semilogy(-N0ML30a, BERML30a, '-s'); 
semilogy(-N0ML40a, BERML40a, '-s'); 
semilogy(-N0ML50a, BERML50a, '-s'); 
semilogy(-N0ML60a, BERML60a, '-s'); 
semilogy(-N0ML70a, BERML70a, '-s'); 
semilogy(-N0ML80a, BERML80a, '-s'); 
semilogy(-N0ML90a, BERML90a, '-s');
grid on; hold off;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';


% PLOT A and B NEXT TO EACH OTHER

% % Plot 0 a&b with hc
% figure(100);
% semilogy(-N0MRC0a,BERMRC0a,'o-'); hold on; 
% semilogy(-N0MRC0b,BERMRC0b,'o-'); grid on; hold off;
% ax = gca;
% ax.FontName = 'Times New Roman';
% ax.XLabel.Interpreter = 'LaTeX';
% ax.XLabel.String = '$1/N_0$ (dB)';
% ax.YLabel.Interpreter = 'LaTeX';
% ax.YLabel.String = 'BER';
% 
% % Plot 10 a&b with hc
% figure(110);
% semilogy(-N0MRC10a,BERMRC10a,'o-'); hold on; 
% semilogy(-N0MRC10b,BERMRC10b,'o-'); grid on; hold off;
% ax = gca;
% ax.FontName = 'Times New Roman';
% ax.XLabel.Interpreter = 'LaTeX';
% ax.XLabel.String = '$1/N_0$ (dB)';
% ax.YLabel.Interpreter = 'LaTeX';
% ax.YLabel.String = 'BER';
% 
% % Plot 20 a&b with hc
% figure(120);
% semilogy(-N0MRC20a,BERMRC20a,'o-'); hold on; 
% dsemilogy(-N0MRC20b,BERMRC20b,'o-'); grid on; hold off;
% ax = gca;
% ax.FontName = 'Times New Roman';
% ax.XLabel.Interpreter = 'LaTeX';
% ax.XLabel.String = '$1/N_0$ (dB)';
% ax.YLabel.Interpreter = 'LaTeX';
% ax.YLabel.String = 'BER';
% 
% % Plot 30 a&b with hc
% figure(130);
% semilogy(-N0MRC30a,BERMRC30a,'o-'); hold on; 
% semilogy(-N0MRC30b,BERMRC30b,'o-'); grid on; hold off;
% ax = gca;
% ax.FontName = 'Times New Roman';
% ax.XLabel.Interpreter = 'LaTeX';
% ax.XLabel.String = '$1/N_0$ (dB)';
% ax.YLabel.Interpreter = 'LaTeX';
% ax.YLabel.String = 'BER';
% 
% % Plot 20 a&b wo hc
% figure(220);
% semilogy(-N0ML20a,BERML20a,'o-'); hold on; 
% semilogy(-N0ML20b,BERML20b,'o-'); grid on; hold off;
% ax = gca;
% ax.FontName = 'Times New Roman';
% ax.XLabel.Interpreter = 'LaTeX';
% ax.XLabel.String = '$1/N_0$ (dB)';
% ax.YLabel.Interpreter = 'LaTeX';
% ax.YLabel.String = 'BER';
% 
% % Plot 30 a&b wo hc
% figure(230);
% semilogy(-N0ML30a,BERML30a,'o-'); hold on; 
% semilogy(-N0ML30b,BERML30b,'o-'); grid on; hold off;
% ax = gca;
% ax.FontName = 'Times New Roman';
% ax.XLabel.Interpreter = 'LaTeX';
% ax.XLabel.String = '$1/N_0$ (dB)';
% ax.YLabel.Interpreter = 'LaTeX';
% ax.YLabel.String = 'BER';
% 
% % Plot 80 a&b wo hc
% figure(280);
% semilogy(-N0ML80a,BERML80a,'o-'); hold on; 
% semilogy(-N0ML80b,BERML80b,'o-'); grid on; hold off;
% ax = gca;
% ax.FontName = 'Times New Roman';
% ax.XLabel.Interpreter = 'LaTeX';
% ax.XLabel.String = '$1/N_0$ (dB)';
% ax.YLabel.Interpreter = 'LaTeX';
% ax.YLabel.String = 'BER';
% 
% % Plot 90 a&b wo hc
% figure(290);
% semilogy(-N0ML90a,BERML90a,'o-'); hold on; 
% semilogy(-N0ML90b,BERML90b,'o-'); grid on; hold off;
% ax = gca;
% ax.FontName = 'Times New Roman';
% ax.XLabel.Interpreter = 'LaTeX';
% ax.XLabel.String = '$1/N_0$ (dB)';
% ax.YLabel.Interpreter = 'LaTeX';
% ax.YLabel.String = 'BER';



% COMPARE WITH_HC and WO_HC

% Plot 0a with and without hc
figure(300);
semilogy(-N0MRC0a, BERMRC0a, '-o', -N0ML0a, BERML0a, '-s'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';
legend(["MRC", "ML"]); title(['Tx: 0' char(176)]);

% Plot 10a with and without hc
figure(310);
semilogy(-N0MRC10a, BERMRC10a, '-o', -N0ML10a, BERML10a, '-s'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';
legend(["MRC", "ML"]); title(['Tx: 10' char(176)]);

% Plot 20a with and without hc
figure(320);
semilogy(-N0MRC20a, BERMRC20a, '-o', -N0ML20a, BERML20a, '-s'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';
legend(["MRC", "ML"]); title(['Tx: 20' char(176)]);

% Plot 30a with and without hc
figure(330);
semilogy(-N0MRC30a, BERMRC30a, '-o', -N0ML30a, BERML30a, '-s'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';
legend(["MRC", "ML"]); title(['Tx: 30' char(176)]);

% Plot 40a with and without hc
figure(340);
semilogy(-N0MRC40a, BERMRC40a, '-o', -N0ML40a, BERML40a, '-s'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';
legend(["MRC", "ML"]); title(['Tx: 40' char(176)]);

% Plot 50a with and without hc
figure(350);
semilogy(-N0MRC50a, BERMRC50a, '-o', -N0ML50a, BERML50a, '-s'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';
legend(["MRC", "ML"]); title(['Tx: 50' char(176)]);

% Plot 60a with and without hc
figure(360);
semilogy(-N0MRC60a, BERMRC60a, '-o', -N0ML60a, BERML60a, '-s'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';
legend(["MRC", "ML"]); title(['Tx: 60' char(176)]);

% Plot 70a with and without hc
figure(370);
semilogy(-N0MRC70a, BERMRC70a, '-o', -N0ML70a, BERML70a, '-s'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';
legend(["MRC", "ML"]); title(['Tx: 70' char(176)]);

% Plot 80a with and without hc
figure(380);
semilogy(-N0MRC80a, BERMRC80a, '-o', -N0ML80a, BERML80a, '-s'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';
legend(["MRC", "ML"]); title(['Tx: 80' char(176)]);

% Plot 90a with and without hc
figure(390);
semilogy(-N0MRC90a, BERMRC90a, '-o', -N0ML90a, BERML90a, '-s'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';
legend(["MRC", "ML"]); title(['Tx: 90' char(176)]);






