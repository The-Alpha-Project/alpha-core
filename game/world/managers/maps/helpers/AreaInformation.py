from dataclasses import dataclass


@dataclass
class AreaInformation:
    zone_id: int
    area_number: int
    flags: int
    level: int
    explore_bit: int
