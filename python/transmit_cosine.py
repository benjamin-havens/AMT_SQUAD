"""
Transmits a pure 1486MHz cosine on B210 USRP, center frequency 1485MHz.
Provides configurable function transmit_cosine
"""

# Dumb setup stuff because the API is not set up well and I don't know how to fix it
import sys
from uhd_params import path_to_uhd_module as path
from numpy import exp, arange, pi

sys.path.insert(0, path)
import uhd


def transmit_cosine(
    fc=1485e6, f1=1486e6, duration=10, sample_rate=20e6, channels=[0], gain=20
):
    """
    Transmits a pure cosine at f1 with center frequency fc for duration seconds,
    with sample_rate, gain, and channels specifiable
    """

    lpef = f1 - fc  # Low pass equivalent frequency
    ts = 1 / sample_rate
    t = arange(0, 1 / lpef, ts)
    x_tilde = exp(1j * 2 * pi * lpef * t)

    radio = uhd.usrp.MultiUSRP()
    radio.send_waveform(
        waveform_proto=x_tilde,
        duration=duration,
        freq=fc,
        rate=sample_rate,
        channels=channels,
        gain=gain,
    )


if __name__ == "__main__":
    transmit_cosine()