load '\\wsl.localhost\Ubuntu-20.04\home\pwpre\AMT_lab\AMT_SQUAD\results\june_16\with_hc\0a.csv'
% X0a
y_raw = X0a;
load soundingSignal-BW10-Fs20.mat;
x = xl;

Nfft = 128;
FF = -0.5:1/Nfft:0.5-1/Nfft;
good_idx = 5001:5001+Nfft-1;
y = cast(y_raw(good_idx,1),'double') + 1i * cast(y_raw(good_idx,2),'double');
Y = fft(y,Nfft);
X = fft(x,Nfft);

divide_idx = [2:32 97:128];
H = zeros(Nfft,1);
H(divide_idx) = Y(divide_idx)./X(divide_idx);

figure(1);
clf;
subplot(211);
plot(FF,fftshift(abs(H)));
grid on;
ax1 = gca;

subplot(212);
plot(FF,angle(fftshift(H)));
grid on;
ax2 = gca;

% phi = unwrap(angle(fftshift(H)));
% gd = -[phi(2:end)-phi(1:end-1);0];
% mean_gd = zeros(Nfft,1);
% mean_gd(1) = mean(gd);
idx_max = zeros(Nfft,1);
h = fftshift(ifft(H,Nfft));
[~,foo] = max(abs(h));
idx_max(1) = foo;

for idx = 1:Nfft-1
    y = cast(y_raw(good_idx+idx,1),'double') + 1i * cast(y_raw(good_idx+idx,2),'double');
    Y = fft(y,Nfft);
    H(divide_idx) = Y(divide_idx)./X(divide_idx);
    h = fftshift(ifft(H,Nfft));
    [~,foo] = max(abs(h));
    idx_max(idx+1) = foo;
%     phi = unwrap(angle(fftshift(H)));
%     gd = -[phi(2:end)-phi(1:end-1);0];
%     ax1.Children.YData = phi;
%     ax2.Children.YData = gd;
%     ax1.Title.String = sprintf('index = %d',idx);
%     ax2.Title.String = sprintf('average gd = %f',mean(gd));
%     mean_gd(idx+1) = mean(gd);
%     pause(0.5);
end

% figure(99)
% plot(1:Nfft,mean_gd,'.-');
% grid on;

idx = 1;
y = cast(X0a(good_idx+idx,1),'double') + 1i * cast(X0a(good_idx+idx,2),'double');
Y = fft(y,Nfft);
H(divide_idx) = Y(divide_idx)./X(divide_idx);
h = fftshift(ifft(H));

figure(idx);
subplot(311);
stem(1:Nfft,real(h));
grid on;

subplot(312);
stem(1:Nfft,imag(h));
grid on;

subplot(313);
stem(1:Nfft,abs(h));
grid on;
