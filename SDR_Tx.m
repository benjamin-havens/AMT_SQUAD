%% Initialize
fc = 1485e6;
f1 = 1486e6;
ts = 1/(20e6);
t = 0 : ts : 1/(f1 - fc) - ts;
t = t';
x_tilde_once = exp(1j*2*pi*(f1 - fc)*t);
x_tilde = repmat(x_tilde_once, [1e5 1]);

if ~(exist('tx', 'var'))
    tx = comm.SDRuTransmitter(              ...
                  'Platform','B210',        ...
                  'SerialNum','3218C97',    ...
                  'CenterFrequency',fc,     ...
                  'MasterClockRate',1/ts,   ...
                  'InterpolationFactor',1);
end
tx.Gain = 20;

%% Transmit until stopped
disp('Transmitting')
while 1
    tx(x_tilde);
end

%% Release the tx (must be run after stopping)
release(tx);

