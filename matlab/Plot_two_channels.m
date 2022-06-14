%%%%%%%%%%%%%%%%%%%%%%
% PLOT BOTH CHANNELS %
%%%%%%%%%%%%%%%%%%%%%%
% With data_a and data_b in the workspace, this will plot three plots for
% both of them (the three Dr Rice gave us code for)

% Uncomment if you are reading from a csv file
% filename = '5-18-22_test1.csv';
% M = readmatrix(filename);
% data_a = M(:, 1);
% data_b = M(:, 2);


num_samples = 1000;

mdrIdx = 50001;


% CHANNEL A PLOTS
figure(1);  % This has the pure sines and cosines
plot(mdrIdx : mdrIdx + num_samples - 1, real(data_a(mdrIdx:mdrIdx + num_samples -1)), '.-',        ...
     mdrIdx : mdrIdx + num_samples - 1, imag(data_a(mdrIdx:mdrIdx + num_samples -1)), '.-'); 
title("Channel A"); xlabel("Sample number"); ylabel("Amplitude");
legend("Real", "Imaginary");
grid on;

% figure(2);  % Plots real vs imaginary to see periodicity
% plot(data_a(1:100), '.-'); 
% grid on;

% Prepare to plot fft
Nfft = 128;
FF = -0.5 : 1/Nfft : 0.5-1/Nfft;
X1 = fft(data_a(mdrIdx:mdrIdx+Nfft-1), Nfft);
X2 = fftshift(X1);
[max_val, max_idx] = max(abs(X2));

figure(3);  % Has FFT plot
stem(FF, abs(X2));
title("Channel A FFT");
xlabel('F normalized frequency (cycles/sample)');
ylabel('magnitude');
mystring = sprintf('   max occurs at F = %4.3f cycles/sample', FF(max_idx));
text(FF(max_idx),max_val,mystring);
grid on;

return;

% CHANNEL B PLOTS
figure(4);  % This has the pure sines and cosines
plot(0 : num_samples - 1, real(data_b(1:num_samples)), '.-',        ...
     0 : num_samples - 1, imag(data_b(1:num_samples)), '.-'); 
title("Channel B"); xlabel("Sample number"); ylabel("Amplitude");
legend("Real", "Imaginary");
grid on;

figure(5);  % Plots real vs imaginary to see periodicity
plot(data_b(1:num_samples) ,'.-'); 
grid on;

% Prepare to plot fft
X1 = fft(data_b, Nfft);
X2 = fftshift(X1);
[max_val, max_idx] = max(abs(X2));

figure(6);  % Has FFT plot
plot(FF, abs(X2));
title("Channel B FFT");
xlabel('F normalized frequency (cycles/sample)');
ylabel('magnitude');
mystring = sprintf('   max occurs at F = %4.3f cycles/sample', FF(max_idx));
text(FF(max_idx), max_val, mystring);
grid on;