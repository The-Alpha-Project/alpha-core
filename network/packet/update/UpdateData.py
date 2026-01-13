from dataclasses import dataclass
from bitarray import bitarray


@dataclass
class UpdateData:
    update_bit_mask: bitarray
    update_field_values: bytearray

    def get_field_bytes(self, index):
        return self.update_field_values[index * 4 : (index + 1) * 4]
