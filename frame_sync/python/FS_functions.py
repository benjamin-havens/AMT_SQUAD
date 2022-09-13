"""
Contains L0 to L6q from Rice-McMurdie
"""

from numpy import dot, zeros
from params import *


def L0(data):
    result = zeros(buffer_size - 255)
    for m in range(buffer_size - 255):
        result[m] = abs(dot(data[m : m + 256], preamble_template))
    return result

# A version of L0 that can correlate smaller sections of data
def L0_temp(data):
    result = zeros(data.size)
    for m in range(data.size - 255):
        result[m] = abs(dot(data[m : m + 256], preamble_template))
    return result

def L6(data):
    pass
