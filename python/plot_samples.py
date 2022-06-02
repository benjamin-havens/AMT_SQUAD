"""
Provides plotting functions for samples obtained from B210 SDR
"""

import matplotlib.pyplot as plt
from numpy import real, imag, argmax, log10
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
    ax[0].grid()
    ax[1].grid()
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
    plt.grid()
    plt.show()


def fft_two_channels(samples, n=None, dB=True):
    """
    Plots the fft magnitude for two channels.
    """

    ch_a = samples[0, :]
    ch_b = samples[1, :]

    Nfft = n or 512
    FF = sorted(fftfreq(Nfft))
    fft_a = abs(fftshift(fft(ch_a, n=Nfft)))
    fft_b = abs(fftshift(fft(ch_b, n=Nfft)))

    if dB:
        fft_a, fft_b = 20 * log10(fft_a), 20 * log10(fft_b)

    # Get strings for plot
    max_a_loc = argmax(fft_a)
    max_a = fft_a[max_a_loc]
    max_b_loc = argmax(fft_b)
    max_b = fft_b[max_b_loc]
    str_a = f"Max is {max_a:.4f} at {FF[max_a_loc]:.4f} cycles per sample"
    str_b = f"Max is {max_b:.4f} at {FF[max_b_loc]:.4f} cycles per sample"

    fig, ax = plt.subplots(nrows=1, ncols=2)
    ax[0].plot(FF, fft_a)
    ax[1].plot(FF, fft_b)
    ax[0].set_title("Channel A")
    ax[0].set_xlabel("Normalized Frequency")
    ax[0].set_ylabel("Amplitude")
    ax[1].set_title("Channel B")
    ax[1].set_xlabel("Normalized Frequency")
    ax[1].set_ylabel("Amplitude")
    plt.tight_layout()
    ax[0].text(FF[int(max_a_loc * 0.5)], max_a, str_a)
    ax[1].text(FF[int(max_b_loc * 0.5)], max_b, str_b)
    ax[0].grid()
    ax[1].grid()
    plt.show()


def fft_one_channel(samples, n=None, dB=True):
    """
    Plots the fft magnitude for one channel.
    """

    ch_a = samples[0, :]

    Nfft = n or 512
    FF = sorted(fftfreq(Nfft))
    fft_a = abs(fftshift(fft(ch_a, n=Nfft)))

    if dB:
        fft_a = 20 * log10(fft_a)

    # Get string for plot
    max_a_loc = argmax(fft_a)
    max_a = fft_a[max_a_loc]
    str_a = f"Max is {max_a:.4f} at {FF[max_a_loc]:.4f} cycles per sample"

    fig, ax = plt.subplots()
    ax.plot(FF, fft_a)
    ax.set_title("Channel A")
    ax.set_xlabel("Sample")
    ax.set_ylabel("Normalized Frequency")
    plt.tight_layout()
    ax.text(FF[int(max_a_loc * 0.7)], max_a, str_a)
    plt.grid()
    plt.show()
