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


num_samples = 128;

mdrIdx = 5000;


% CHANNEL A PLOTS
figure(1);  % This has the pure sines and cosines
plot(mdrIdx : mdrIdx + num_samples - 1, real(data_a(mdrIdx:mdrIdx + num_samples -1)), '.-',        ...
     mdrIdx : mdrIdx + num_samples - 1, imag(data_a(mdrIdx:mdrIdx + num_samples -1)), '.-'); 
title("Channel A"); xlabel("Sample number"); ylabel("Amplitude");
legend("Real", "Imaginary");
grid on;
% print -dpng 'a0.png';

% Prepare to plot fft
Nfft = 128;
FF = -0.5 : 1/Nfft : 0.5-1/Nfft;
X1 = fft(data_a(mdrIdx:mdrIdx+Nfft-1), Nfft);
X2 = fftshift(X1);
[max_val, max_idx] = max(abs(X2));

figure(2);  % Has FFT plot
stem(FF, 20*log10(abs(X2)));
title("Channel A FFT");
xlabel('F normalized frequency (cycles/sample)');
ylabel('magnitude');
mystring = sprintf('   max occurs at F = %4.3f cycles/sample', FF(max_idx));
text(FF(max_idx),max_val,mystring);
grid on;

% CHANNEL B PLOTS
figure(3);  % This has the pure sines and cosines
plot(mdrIdx : mdrIdx + num_samples - 1, real(data_b(mdrIdx:mdrIdx + num_samples -1)), '.-',        ...
     mdrIdx : mdrIdx + num_samples - 1, imag(data_b(mdrIdx:mdrIdx + num_samples -1)), '.-'); 
title("Channel B"); xlabel("Sample number"); ylabel("Amplitude");
legend("Real", "Imaginary");
grid on;


% Prepare to plot fft
X1 = fft(data_b(mdrIdx:mdrIdx+Nfft-1), Nfft);
X2 = fftshift(X1);
[max_val, max_idx] = max(abs(X2));

figure(4);  % Has FFT plot
stem(FF, abs(X2));
title("Channel B FFT");
xlabel('F normalized frequency (cycles/sample)');
ylabel('magnitude');
mystring = sprintf('   max occurs at F = %4.3f cycles/sample', FF(max_idx));
text(FF(max_idx), max_val, mystring);
grid on;

print(figure(1), 'C:\Users\rskir\OneDrive\Pictures\June_16_tests\wiredA.png', '-dpng');
print(figure(2), 'C:\Users\rskir\OneDrive\Pictures\June_16_tests\wiredA_fft.png', '-dpng');
print(figure(3), 'C:\Users\rskir\OneDrive\Pictures\June_16_tests\wiredB.png', '-dpng');
print(figure(4), 'C:\Users\rskir\OneDrive\Pictures\June_16_tests\wiredB_fft.png', '-dpng');