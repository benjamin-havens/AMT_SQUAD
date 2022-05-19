clear;

% Initialize
ts = 1/(20e6);
if(~(exist('rx', 'var')))
    rx = comm.SDRuReceiver(...
                  'Platform','B210', ...
                  'SerialNum','32339F7', ...
                  'CenterFrequency',1485e6, ...
                  'MasterClockRate',(1/ts), ...
                  'OutputDataType','double', ...
                  'Gain',60, ...
                  'DecimationFactor',1);
end
rxLog = dsp.SignalSink;

% Receive for 100 samples
for i = 1:100
    data = rx();
    rxLog(data);
end
data = rxLog.Buffer;

% Clean up
release(rx)
release(rxLog)


