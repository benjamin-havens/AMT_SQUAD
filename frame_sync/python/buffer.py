from numpy import zeros, vstack


class FS_buffer:
    def __init__(self, capacity):
        self.capacity = capacity
        self.storage = zeros(capacity)
        self.insert_loc = 0
        self.size = 0

    def insert(self, newSample):
        self.storage[self.insert_loc] = newSample
        self.insert_loc = (
            self.insert_loc + 1 if self.insert_loc < self.capacity - 1 else 0
        )
        if self.size != self.capacity:
            self.size += 1

    def is_full(self):
        return self.size == self.capacity

    def get_data(self):
        return vstack(
            (self.storage[self.insert_loc :], self.storage[0 : self.insert_loc])
        ).flatten()
