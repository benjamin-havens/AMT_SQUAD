% This is for 0b.mat (without the hybrid combiner) using MLcombiner
% with KCMA = 25;

N0 = [22 23 24 25 26 27 28];
BER = [4.054e-6 7.297e-5 3.122e-4 1.05e-3 2.948e-3 7.385e-3 1.539e-2];

figure(100);
semilogy(-N0,BER,'o-'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';

% This is for 40a.mat (with the hybrid combiner) using MRCcombiner
% with KCMA = 15;

N0c = [18 19 20 21 22 23 24];
BERc = [4.054e-6 2.838e-5 1.581e-4 7.906e-4 2.023e-3 5.5595e-3 1.287e-2];

figure(101);
semilogy(-N0c,BERc,'o-'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';

% This is for 40a.mat (with the hybrid combiner) using MRCcombiner
% with KCMA = 25;
N0c2 = [20 21 22 23 24 25];
BERc2 = [4.054e-5 1.824e-4 7.216e-4 2.4e-3 6.1e-3 1.4e-2];

figure(102);
semilogy(-N0c2,BERc2,'o-'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';

% This is for 50a.mat (without the hybrid combiner) using MLcombiner
% with KCMA = 25;

N02 = [22 23 24 25 26 27 28];
BER2 = [8.108e-6 7.297e-5 3.892e-4 1.184e-3 3.13e-3 7.739e-3 1.628e-2];

figure(103);
semilogy(-N02,BER2,'o-'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';

figure(200);
semilogy(-N0,BER,'s-',-N0c,BERc,'o-',-N0c2,BERc2,'o-',-N02,BER2,'s-'); grid on;
ax = gca;
ax.FontName = 'Times New Roman';
ax.XLabel.Interpreter = 'LaTeX';
ax.XLabel.String = '$1/N_0$ (dB)';
ax.YLabel.Interpreter = 'LaTeX';
ax.YLabel.String = 'BER';
