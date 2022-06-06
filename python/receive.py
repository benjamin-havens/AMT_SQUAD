"""
Receives 1e6 samples and plots them. Provides configurable receive function
"""

# Imports
from plot_samples import *
import csv

# Dumb setup stuff because the API is not set up well and I don't know how to fix it.
# You probably have to create uhd_params and put the path in
import sys
from uhd_params import path_to_uhd_module as path, path_to_csv_location as csv_path

sys.path.insert(0, path)
import uhd


def receive(
    fc=1485e6, num_samples=int(1e6), sample_rate=20e6, channels=[0, 1], gain=[50, 50]
):
    """
    Receives from center frequency fc, with default
    num_samples: 1e6, sample_rate 20e6, and gain 50
    """

    rx = uhd.usrp.MultiUSRP("num_recv_frames=128")
    rx.set_rx_agc(False, 0)
    rx.set_rx_agc(False, 1)
    print("Receiving...")
    samples = rx.recv_num_samps(
        num_samps=num_samples,
        freq=fc,
        rate=sample_rate,
        channels=channels,
        gain=gain,
    )
    print("Receiving complete.")

    return samples


if __name__ == "__main__":
    samples = receive(num_samples=1000, gain=[40, 40])
    plot_two_channels(samples, num_to_plot=100)
    fft_two_channels(samples, dB=False)
    # plot_one_channel(samples, num_to_plot=100)
    # fft_one_channel(samples)
    with open(csv_path, "w", newline="") as csvfile:
        writer = csv.writer(csvfile)
        writer.writerows(samples)
