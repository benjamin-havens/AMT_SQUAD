% PLOT FROM CSV
%  - update this filename:
filename = 'results/5-18-22_test1.csv';
%  - with a relative path to plot different data.

% First, read the csv file
data = readmatrix('results/5-18-22_test1.csv');

% Plot it, assuming real and imaginary parts are columns 1 and 2
% (can change the labels and title to change this assumption)
figure(1);
plot(data);
legend('Real', 'Imaginary');
title('Cable Test Rx Output--Cosine @ 1486MHz');
xlabel('Sample number');
ylabel('Amplitude');