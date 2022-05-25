"""
Provides plotting functions for samples obtained from B210 SDR
"""

import matplotlib.pyplot as plt
from numpy import real, imag, arange
from numpy.fft import fft, fftshift, fftfreq


def plot_two_channels(samples, num_to_plot=None):
    """
    Plots real and imaginary part of channel A and B
    """

    n = len(samples[0, :])
    if not num_to_plot or num_to_plot >= n:
        num_to_plot = n - 1
    ch_a = samples[0, :num_to_plot]
    ch_b = samples[1, :num_to_plot]

    fig, ax = plt.subplots(nrows=1, ncols=2)
    ax[0].plot(real(ch_a), label="real")
    ax[0].plot(imag(ch_a), label="imaginary")
    ax[1].plot(real(ch_b), label="real")
    ax[1].plot(imag(ch_b), label="imaginary")
    ax[0].set_title("Channel A")
    ax[0].set_xlabel("Sample")
    ax[0].set_ylabel("Amplitude")
    ax[1].set_title("Channel B")
    ax[1].set_xlabel("Sample")
    ax[1].set_ylabel("Amplitude")
    plt.legend()
    plt.tight_layout()
    plt.show()


def plot_one_channel(samples, num_to_plot=None):
    """
    Plots real and imaginary part of channel A
    """

    n = len(samples[0, :])
    if not num_to_plot or num_to_plot >= n:
        num_to_plot = n - 1

    fig, ax = plt.subplots()
    ax.plot(real(samples[0, :num_to_plot]), label="real")
    ax.plot(imag(samples[0, :num_to_plot]), label="imaginary")
    ax.set_title("Channel A")
    ax.set_xlabel("Sample")
    ax.set_ylabel("Amplitude")
    plt.legend()
    plt.tight_layout()
    plt.show()


def fft_two_channels(samples, n=None):
    """
    Plots the fft magnitude for two channels.
    """

    ch_a = samples[0, :]
    ch_b = samples[1, :]

    Nfft = n or 512
    FF = sorted(fftfreq(Nfft))
    fft_a = abs(fftshift(fft(ch_a, n=Nfft)))
    fft_b = abs(fftshift(fft(ch_b, n=Nfft)))

    fig, ax = plt.subplots(nrows=1, ncols=2)
    ax[0].plot(FF, fft_a)
    ax[1].plot(FF, fft_b)
    ax[0].set_title("Channel A")
    ax[0].set_xlabel("Sample")
    ax[0].set_ylabel("Normalized Frequency")
    ax[1].set_title("Channel B")
    ax[1].set_xlabel("Normalized Frequency")
    ax[1].set_ylabel("Amplitude")
    plt.tight_layout()
    plt.show()


def fft_one_channel(samples, n=None):
    """
    Plots the fft magnitude for one channel.
    """

    ch_a = samples[0, :]

    Nfft = n or 512
    FF = sorted(fftfreq(Nfft))
    fft_a = abs(fftshift(fft(ch_a, n=Nfft)))

    fig, ax = plt.subplots()
    ax.plot(FF, fft_a)
    ax.set_title("Channel A")
    ax.set_xlabel("Sample")
    ax.set_ylabel("Normalized Frequency")
    plt.tight_layout()
    plt.show()
