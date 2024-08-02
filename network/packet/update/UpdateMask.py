from multiprocessing import RLock
from typing import Optional
from bitarray import bitarray

BLOCK_SIZE = 32


class UpdateMask(object):
    def __init__(self):
        self.update_mask: Optional[bitarray] = None
        self.block_count = 0
        self.field_count = 0
        self.lock = RLock()  # Reentrant lock.

    def set_bit(self, index):
        with self.lock:
            self.update_mask[index] = 1

    def unset_bit(self, index):
        with self.lock:
            self.update_mask[index] = 0

    def is_set(self, index):
        with self.lock:
            return self.update_mask[index] != 0

    def to_bytes(self):
        with self.lock:
            return self.update_mask.tobytes()

    def copy(self):
        with self.lock:
            return self.update_mask.copy()

    def clear(self):
        with self.lock:
            self.update_mask.setall(0)

    def is_empty(self):
        with self.lock:
            return self.update_mask.count() == 0

    def set_count(self, values_count):
        with self.lock:
            self.field_count = values_count
            self.block_count = int((values_count + BLOCK_SIZE - 1) / BLOCK_SIZE)
            self.update_mask = bitarray(self.block_count * BLOCK_SIZE, endian='little')
            self.clear()
