"""
Contains our frame synchronization SM
"""

from numpy import mean, argmax, genfromtxt
from enum import Enum
from buffer import FS_buffer
from params import *
from FS_functions import *

st = Enum(
    "FSSM_st",
    "init coldStart onePeak twoPeaks weird locked oneMissed twoMissed",
)


class FSSM:
    def __init__(self, corr="L0"):
        self.state = st.init
        self.data = FS_buffer(capacity=buffer_size)
        self.current_idx = -1
        self.last_mhat = None
        self.llast_mhat = None
        self.weird = None
        if corr == "L0":
            self.corr = L0
        elif corr == "L6":
            self.corr = L6
        else:
            print("Unsupported correlation function")

    def get_peak(self):
        correlations = self.corr(self.data.get_data())
        avg_val = mean(correlations)
        max_idx = argmax(correlations)
        max_val = correlations[max_idx]
        return avg_val, max_idx, max_val

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
            avg_val, max_idx, max_val = self.get_peak()
            tmp_idx = self.current_idx - buffer_size + max_idx
            if max_val > 3 * avg_val:
                self.state = st.onePeak
                self.last_mhat = tmp_idx
            else:
                self.state = st.coldStart
        elif self.state == st.onePeak:
            avg_val, max_idx, max_val = self.get_peak()
            tmp_idx = self.current_idx - buffer_size + max_idx
            if tmp_idx == self.last_mhat:
                self.state = st.onePeak
            elif tmp_idx - (self.last_mhat + frame_size) <= 1:
                self.state = st.twoPeaks
                self.llast_mhat = self.last_mhat
                self.last_mhat = tmp_idx
            else:
                self.state = st.weird
                self.weird = self.current_idx - buffer_size + max_idx
        elif self.state == st.twoPeaks:
            avg_val, max_idx, max_val = self.get_peak()
            tmp_idx = self.current_idx - buffer_size + max_idx
            if tmp_idx == self.last_mhat:
                self.state = st.twoPeaks
            elif tmp_idx - (self.last_mhat + frame_size) <= 1:
                self.state = st.locked
                self.llast_mhat = self.last_mhat
                self.last_mhat = tmp_idx
            else:
                self.state = st.weird
                self.weird = tmp_idx
        elif self.state == st.weird:
            if self.current_idx < self.weird + frame_size:
                self.state == st.weird
            else:
                avg_val, max_idx, max_val = self.get_peak()
                tmp_idx = self.current_idx - buffer_size + max_idx
                if tmp_idx - (self.last_mhat + frame_size) <= 1:
                    self.state = st.twoPeaks
                    self.llast_mhat = self.last_mhat
                    self.last_mhat = tmp_idx
                elif tmp_idx - (self.weird + frame_size) <= 1:
                    self.state = st.twoPeaks
                    self.llast_mhat = self.weird
                    self.last_mhat = tmp_idx
                else:
                    self.state = st.onePeak
                    self.last_mhat = tmp_idx
                    self.llast_mhat = None
                self.weird = None
        elif self.state == st.locked:
            avg_val, max_idx, max_val = self.get_peak()
            tmp_idx = self.current_idx - buffer_size + max_idx
            if tmp_idx == self.last_mhat:
                self.state = st.locked
            elif tmp_idx - (self.last_mhat + frame_size) <= 1:
                self.state = st.locked
                self.llast_mhat = self.last_mhat
                self.last_mhat = tmp_idx
            else:
                self.state = st.oneMissed
                self.weird = tmp_idx
        elif self.state == st.oneMissed:
            if self.current_idx < self.weird + frame_size:
                self.state == st.oneMissed
            else:
                avg_val, max_idx, max_val = self.get_peak()
                tmp_idx = self.current_idx - buffer_size + max_idx
                if tmp_idx - (self.last_mhat + frame_size) <= 1:
                    self.state = st.locked
                    self.llast_mhat = self.last_mhat
                    self.last_mhat = tmp_idx
                    self.weird = None
                else:
                    self.state = st.twoMissed
                    self.weird = tmp_idx
        elif self.state == st.twoMissed:
            if self.current_idx < self.weird + frame_size:
                self.state == st.twoMissed
            else:
                avg_val, max_idx, max_val = self.get_peak()
                tmp_idx = self.current_idx - buffer_size + max_idx
                if tmp_idx - (self.last_mhat + 2 * frame_size) <= 1:
                    self.state = st.locked
                    self.llast_mhat = self.last_mhat
                    self.last_mhat = tmp_idx
                    self.weird = None
                else:
                    self.state = st.onePeak
                    self.last_mhat = tmp_idx
                    self.llast_mhat = None
                    self.weird = None
        else:
            print("Error state")


def main():
    sm = FSSM()
    samples = genfromtxt("../data/9_Aug_Wired.csv", dtype=complex).flatten()
    last_state = st.init
    count = 0
    for sample in samples:
        if not count % 1000:
            print(count)
        count += 1
        if sm.state != last_state:
            last_state = sm.state
            print(sm.state, end="")
            input()
        sm.tick(sample)


if __name__ == "__main__":
    main()
