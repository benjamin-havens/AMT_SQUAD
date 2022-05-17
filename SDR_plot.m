t = 0:ts:4e-6 - ts;

%orig_x = real(data .* exp(1j * 2 * pi * 1485e6 .* t'));


x = cos(2 * pi * 1e6 * t);
temp = data(1:80);
plot(t, real(temp), t, imag(temp))