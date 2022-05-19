% SDR PLOT
% Plots the data after Rx is run.
% Note: this assumes a 20MHz sampling rate

% Grab the part of the data we want
ts = 1/(20e6);
samples_to_plot = 80;
t = 0:ts:(samples_to_plot - 1)*ts;
to_plot = data(1:samples_to_plot);

% Plot real and imaginary parts
plot(t, real(to_plot), t, imag(to_plot))
title('Rx Amplitude');
xlabel('Time (s)'); 
ylabel('Amplitude');