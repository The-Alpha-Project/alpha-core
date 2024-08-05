from dataclasses import dataclass
from bitarray import bitarray
from game.world.managers.objects.ObjectManager import ObjectManager


@dataclass
class UpdateData:
    update_bit_mask: bitarray
    update_field_values: list
    world_object: ObjectManager
