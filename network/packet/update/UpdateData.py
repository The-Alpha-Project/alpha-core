from dataclasses import dataclass
from bitarray import bitarray


@dataclass
class UpdateData:
    update_bit_mask: bitarray
    update_field_values: list
