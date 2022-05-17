clc;

fc = 1485e6;
f1 = 1486e6;
ts = 1/(20e6);
t = 0 : ts : 1/(f1 - fc) - ts;
x_tilde = exp(1j*2*pi*(f1 - fc)*t);
% x_tilde = cos(2*pi*(f1 - fc)*t);

tx = comm.SDRuTransmitter(              ...
              'Platform','B210',        ...
              'SerialNum','3218C97',    ...
              'CenterFrequency',fc,     ...
              'MasterClockRate',1/ts);

for i = 1:10e3
    tx(x_tilde');
end
