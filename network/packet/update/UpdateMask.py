from struct import pack

from bitarray import bitarray

BLOCK_SIZE = 32


class UpdateMask(object):
    def __init__(self):
        self.update_mask = None
        self.block_count = 0
        self.field_count = 0

    def set_bit(self, index):
        self.update_mask[index] = 1

    def unset_bit(self, index):
        self.update_mask[index] = 0

    def is_set(self, index):
        return self.update_mask[index] != 0

    def to_bytes(self):
        mask_part = 0
        data_bytes = b''

        j = 0
        for i in range(0, self.block_count * BLOCK_SIZE):
            if self.is_set(i):
                mask_part |= 1 << j

            j += 1
            if j == BLOCK_SIZE:
                data_bytes += pack('<I', mask_part)
                mask_part = 0
                j = 0

        return data_bytes

    def clear(self):
        self.update_mask.setall(0)

    def set_count(self, values_count):
        self.field_count = values_count
        self.block_count = int((values_count + BLOCK_SIZE - 1) / BLOCK_SIZE)
        self.update_mask = bitarray(self.block_count * BLOCK_SIZE, endian='little')
        self.clear()
