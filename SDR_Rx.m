%% Initialize
ts = 1/(20e6);
if(~(exist('rx', 'var')))
    rx = comm.SDRuReceiver();
    rx.Platform = "B210";
    rx.SerialNum = '32339F7';
    rx.ChannelMapping = [1 2];
    rx.CenterFrequency = 1485e6;
    rx.MasterClockRate = (1/ts);
    rx.Gain = 60;
    rx.DecimationFactor = 1;
end
rx.SamplesPerFrame = 1e6;
rxLog = dsp.SignalSink;

%% Receive
disp('receiving')
data = rx();
rxLog(data);
data = rxLog.Buffer;
data_a = data(:, 1);
data_b = data(:, 2);

%% Clean up
release(rx)
release(rxLog)


