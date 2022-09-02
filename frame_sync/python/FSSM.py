"""
Contains our frame synchronization SM
"""

from numpy import mean, argmax, genfromtxt
from enum import Enum
from buffer import FS_buffer
from params import *
from FS_functions import *
from matplotlib import pyplot

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
            if max_val > 3 * avg_val:                                       #TODO print graph of peaks
                self.state = st.onePeak
                self.last_mhat = tmp_idx
            else:
                self.state = st.coldStart
        elif self.state == st.onePeak:
            avg_val, max_idx, max_val = self.get_peak()
            tmp_idx = self.current_idx - buffer_size + max_idx
            if tmp_idx == self.last_mhat:
                self.state = st.onePeak
            elif abs(tmp_idx - (self.last_mhat + frame_size)) <= 1:         #TODO print graph of peaks
                self.state = st.twoPeaks
                self.llast_mhat = self.last_mhat
                self.last_mhat = tmp_idx
            else:                                                           #TODO print graph of peaks
                self.state = st.weird                                       
                self.weird = self.current_idx - buffer_size + max_idx
        elif self.state == st.twoPeaks:
            avg_val, max_idx, max_val = self.get_peak()
            tmp_idx = self.current_idx - buffer_size + max_idx
            if tmp_idx == self.last_mhat:
                self.state = st.twoPeaks
            elif abs(tmp_idx - (self.last_mhat + frame_size)) <= 1:
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
                if abs(tmp_idx - (self.last_mhat + frame_size)) <= 1:
                    self.state = st.twoPeaks if not self.llast_mhat else st.locked
                    self.llast_mhat = self.last_mhat
                    self.last_mhat = tmp_idx
                elif abs(tmp_idx - (self.weird + frame_size)) <= 1:
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
            elif abs(tmp_idx - (self.last_mhat + frame_size)) <= 1:
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
                if abs(tmp_idx - (self.last_mhat + frame_size)) <= 1:
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
                if (
                    abs(tmp_idx - (self.last_mhat + 2 * frame_size)) <= 1
                    or abs(tmp_idx - (self.last_mhat + frame_size)) <= 1
                ):
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
    # samples = genfromtxt("../MATLAB/data_a_aug25.csv", dtype=complex).flatten()
    last_state = st.init
    count = 0
    last_mhat = None
    weird = None
    for sample in samples:
        # Print every 1000 samples so we know where it's at
        if not count % 1000:
            print(count)
        count += 1
        # Print the state and wait
        if sm.state != last_state:
            last_state = sm.state
            print(sm.state, end="")

            input()
        # Tick
        sm.tick(sample)
        # Print mhats and weirds
        if sm.last_mhat != last_mhat:
            last_mhat = sm.last_mhat
            possible_preamble = L0_temp(samples[last_mhat-256:last_mhat+512])
            x = range(512)
            x = x + last_mhat-256
            max_x = last_mhat
            max_y = max(possible_preamble)
            pyplot.plot(x,possible_preamble[:512])
            pyplot.text(max_x-128, max_y + 500, "max = (" + str(max_x) + "," + str(max_y) + ")") 
            pyplot.grid(True)
            pyplot.show()
            print(f"mhat: {last_mhat}")
        if sm.weird != weird:
            weird = sm.weird
            if weird is not None:
                print(f"weird: {weird}")


if __name__ == "__main__":
    main()
