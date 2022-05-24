% filename = '5-18-22_test1.csv';
% M = csvread(filename,10,0);
M = data;

figure(1); 
plot(0:99,real(M(1:100)),'.-',0:99,imag(M(1:100)),'.-'); 
grid on;

figure(2);
plot(M(1:100,1),'.-'); grid on;

Nfft = 400;
FF = -0.5:1/Nfft:0.5-1/Nfft;
x = M;
X1 = fft(x,Nfft);
X2 = fftshift(X1);

[val,idx] = max(abs(X2));

figure(3);
plot(FF,abs(X2)); grid on;
xlabel('F normalized frequency (cycles/sample)');
ylabel('magnitude');
mystring = sprintf('   max occurs at F = %4.3f cycles/sample',FF(idx));
text(FF(idx),val,mystring);
