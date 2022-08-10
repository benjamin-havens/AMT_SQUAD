"""
Contains parameters for frame synchronization
"""

from numpy import genfromtxt

data_bits = 3200
preamble_bits = 128
samples_per_bit = 2
buffer_size = (data_bits + 2 * preamble_bits - 1) * samples_per_bit
preamble_template = genfromtxt("preambleTemplate.csv", dtype=complex)
