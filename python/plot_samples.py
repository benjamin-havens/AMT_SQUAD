"""
Provides plotting functions for samples obtained from B210 SDR
"""

import matplotlib.pyplot as plt
from numpy import real, imag


def plot_two_channels(samples):
    """Plots real and imaginary part of channel A and B"""
    fig, ax = plt.subplots(nrows=1, ncols=2)
    ax[0].plot(real(samples[0, :]), label="real")
    ax[0].plot(imag(samples[0, :]), label="imaginary")
    ax[1].plot(real(samples[1, :]), label="real")
    ax[1].plot(imag(samples[1, :]), label="imaginary")
    ax[0].set_title("Channel A")
    ax[0].set_xlabel("Sample")
    ax[0].set_ylabel("Amplitude")
    ax[1].set_title("Channel B")
    ax[1].set_xlabel("Sample")
    ax[1].set_ylabel("Amplitude")
    plt.legend()
    plt.tight_layout()
    plt.show()


def plot_one_channel(samples):
    """Plots real and imaginary part of channel A"""
    fig, ax = plt.subplots()
    ax.plot(real(samples[0, :]), label="real")
    ax.plot(imag(samples[0, :]), label="imaginary")
    ax.set_title("Channel A")
    ax.set_xlabel("Sample")
    ax.set_ylabel("Amplitude")
    plt.legend()
    plt.tight_layout()
    plt.show()
