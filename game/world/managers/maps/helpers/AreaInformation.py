from dataclasses import dataclass


@dataclass
class AreaInformation(object):
    zone_id: int
    area_number: int
    flags: int
    level: int
    explore_bit: int
