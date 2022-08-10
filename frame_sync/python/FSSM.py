"""
Contains our frame synchronization SM
"""

from numpy import mean
from enum import Enum
from buffer import FS_buffer
from params import *
from FS_functions import *

st = Enum(
    "FSSM_st",
    "init coldStart onePeak twoPeaks locked oneMissed twoMissed",
)


class FSSM:
    def __init__(self, corr="L0"):
        self.state = st.init
        self.data = FS_buffer(capacity=buffer_size)
        self.current_idx = 0
        self.last_mhat = None
        if corr == "L0":
            self.corr = L0
        else:
            self.corr = L6

    def tick(self, newSample):
        self.data.insert(newSample)
        self.current_idx += 1

        # State update first
        if self.state == st.init:
            if self.data.size < self.data.capacity - 1:
                self.state = st.init
            else:
                self.state = st.coldStart
        elif self.state == st.coldStart:
            correlations = self.corr(self.data.get_data())
            avg_val = mean(correlations)
            max_val = max(correlations)
            if max_val > 4 * avg_val:
                self.state = st.onePeak
                self.last_mhat = self.current_idx
            else:
                self.state = st.coldStart
        elif self.state == st.onePeak:
            correlations = self.corr(self.data.get_data())
            avg_val = mean(correlations)
            max_val = max(correlations)
            if max_val > 4 * avg_val:
                if abs(self.current_idx - self.last_mhat - 6656) <= 1:
                    self.state = st.twoPeaks
                    self.last_mhat = self.current_idx
                else:
                    self.state = st.onePeak
            else:
                self.state = st.onePeak
        elif self.state == st.twoPeaks:
            correlations = self.corr(self.data.get_data())
            avg_val = mean(correlations)
            max_val = max(correlations)
            if max_val > 4 * avg_val:
                if abs(self.current_idx - self.last_mhat - 6656) <= 1:
                    self.state = st.locked
                    self.last_mhat = self.current_idx
                else:
                    self.state = st.twoPeaks
            else:
                self.state = st.twoPeaks
        elif self.state == st.locked:
            correlations = self.corr(self.data.get_data())
            avg_val = mean(correlations)
            max_val = max(correlations)
            if max_val > 4 * avg_val:
                if abs(self.current_idx - self.last_mhat - 6656) <= 1:
                    self.state = st.locked
                    self.last_mhat = self.current_idx
                else:
                    self.state = st.twoPeaks
            else:
                self.state = st.twoPeaks
        elif self.state == st.oneMissed:
            pass
        elif self.state == st.twoMissed:
            pass
        else:
            print("Error state")

        # State actions
        if self.state == st.init:
            pass
        elif self.state == st.coldStart:
            pass
        elif self.state == st.onePeak:
            pass
        elif self.state == st.twoPeaks:
            pass
        elif self.state == st.locked:
            pass
        elif self.state == st.oneMissed:
            pass
        elif self.state == st.twoMissed:
            pass
        else:
            print("Error state")


def main():
    sm = FSSM()
    samples = 0  # TODO: get samples here
    for sample in samples:
        sm.tick(sample)


if __name__ == "__main__":
    main()
