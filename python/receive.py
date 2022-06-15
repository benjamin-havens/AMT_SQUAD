"""
Receives 1e6 samples and plots them. Provides configurable receive function
"""

# Imports
from plot_samples import *
import csv
import pandas as pd
# from numpy import complex64

# Dumb setup stuff because the API is not set up well and I don't know how to fix it.
# You probably have to create uhd_params and put the path in
import sys
from uhd_params import path_to_uhd_module as path, path_to_csv_location as csv_path

sys.path.insert(0, path)
import uhd


def receive(
    fc=1485e6,
    num_samples=int(1e6),
    sample_rate=20e6,
    channels=[0, 1],
    gain=[50, 50],
    agc=False,
):
    """
    Receives from center frequency fc, with default
    num_samples: 1e6, sample_rate 20e6, and gain 50
    """

    rx = uhd.usrp.MultiUSRP("num_recv_frames=128")
    rx.set_rx_agc(agc, 0)
    rx.set_rx_agc(agc, 1)
    # rx.set_rx_antenna('TX/RX', 0)
    input("Press enter to start receiving. ")
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
    gain = [0, 0]
    agc_st = False
    location = input("Enter Location of test: ")
    polA = "Horizontal" if input("Enter Channel A polarization: ") == 'h' else 'Vertical'
    polB = "Horizontal" if input("Enter Channel B polarization: ") == 'h' else 'Vertical'
    description = input("Enter test description: ")
    samples = receive(num_samples=100000, gain=gain, agc=agc_st)
    plot_two_channels(
        samples, gain, agc_st, location, polA, polB, description, num_to_plot=1e6
    )
    fft_two_channels(samples, gain, agc_st, location, polA, polB, description, n= 128)
    # plot_one_channel(samples, gain, agc_st, location, polA, description, num_to_plot=100)
    # fft_one_channel(samples, gain, agc_st, location, polA, description)

    # Make sure the path ends in /
    csv_name = input("Enter name of csv: ")
    if (csv_name != ''):
        csv_path = "".join([csv_path,csv_name,".csv"])
        with open(csv_path, "w", newline="") as csvfile:
            writer = csv.writer(csvfile)
            writer.writerows(samples)
        # data = pd.DataFrame(samples)
        # data = data.apply(str).str.replace('\(|\)','',regex=False)
        # data.to_csv(csv_path)
