"""
Receives 1e6 samples and plots them. Provides configurable receive and plot functions
"""

# Dumb setup stuff because the API is not set up well and I don't know how to fix it
import sys
from uhd_params import path_to_uhd_module as path
import matplotlib.pyplot as plt

sys.path.insert(0, path)
import uhd


def receive(
    fc=1485e6, num_samples=int(1e6), sample_rate=20e6, channels=[0, 1], gain=50
):
    """
    Receives from center frequency fc, with default
    num_samples: 1e6, sample_rate 20e6, and gain 50
    """

    rx = uhd.usrp.MultiUSRP("num_recv_frames=1000")
    rx.set_rx_agc(False, 0)

    samples = rx.recv_num_samps(
        num_samps=num_samples,
        freq=fc,
        rate=sample_rate,
        channels=channels,
        gain=gain,
    )

    return samples


def plot(samples):
    fig, ax = plt.subplots()
    ax.plot(samples)


if __name__ == "__main__":
    samples = receive()
    plot(samples)
