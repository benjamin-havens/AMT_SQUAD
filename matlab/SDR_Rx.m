%% Initialize
ts = 1/(20e6);
if(~(exist('rx', 'var')))
    rx = comm.SDRuReceiver();
    rx.Platform = "B210";
    rx.SerialNum = '3218C97';
    rx.ChannelMapping = [1 2];
    rx.CenterFrequency = 1485e6;
    rx.MasterClockRate = (1/ts);
    rx.Gain = 20;
    rx.DecimationFactor = 1;
end
rx.SamplesPerFrame = 1e6;

%% Receive
rxLog = dsp.SignalSink;
disp('receiving')
data = rx();
info(rx)
rxLog(data);
data = rxLog.Buffer;
data_a = data(:, 1);
data_b = data(:, 2);
release(rxLog)
writematrix(data, 'C:\Users\rskir\OneDrive\Pictures\June_16_tests\wo_hc\90b.csv');

%% Clean up
release(rx)


