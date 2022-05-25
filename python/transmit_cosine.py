"""
Transmits a pure 1486MHz cosine on B210 USRP, center frequency 1485MHz.
Provides configurable function transmit_cosine
"""

# Imports
from numpy import arange, exp, pi, floor, complex64, array
from suppress_output import suppress_stdout

# Dumb setup stuff because the API is not set up well and I don't know how to fix it.
# You probably have to create uhd_params and put the path in
import sys
from uhd_params import path_to_uhd_module as path

sys.path.insert(0, path)
import uhd


def transmit_cosine(
    fc=1485e6, f1=1486e6, duration=10, sample_rate=20e6, channels=[0], gain=20
):
    """
    Transmits a pure cosine at f1 with center frequency fc for duration seconds,
    with sample_rate, gain, and channels specifiable
    """

    # Generator function for low-pass equivalent signal of a cosine
    sine = lambda n, freq_offset, rate: exp(n * 2j * pi * freq_offset / rate)

    freq_offset = f1 - fc  # Low pass equivalent frequency
    n = arange(int(10 * floor(sample_rate / freq_offset)), dtype=complex64)
    x_tilde = sine(n, freq_offset, sample_rate)  # One period

    tx = uhd.usrp.MultiUSRP()
    print("Transmitting...")
    with suppress_stdout():
        tx.send_waveform(
            waveform_proto=x_tilde,
            duration=duration,
            freq=fc,
            rate=sample_rate,
            channels=channels,
            gain=gain,
        )
    print("\nTransmission complete.")


if __name__ == "__main__":
    transmit_cosine(duration=20, gain=50)
