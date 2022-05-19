clear;

% Initialize
ts = 1/(20e6);
rxLog = dsp.SignalSink;
rx = comm.SDRuReceiver(                  ...
              'Platform','B210',         ...
              'SerialNum','32339F7',     ...
              'CenterFrequency',1485e6,  ...
              'MasterClockRate',(1/ts),  ...
              'OutputDataType','double', ...
              'Gain',60,                 ...
              'DecimationFactor',1);

% For 20 (arbitrary) periods, grab data from the rx
for counter = 1:20
    data = rx();
    rxLog(data);
end
data = rxLog.Buffer;    % Grab all the data from the buffer
release(rx)
release(rxLog)


