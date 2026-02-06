from dataclasses import dataclass
from typing import Optional

from game.world.managers.objects.units.AttackRollInfo import AttackRollInfo


@dataclass
class AttackRoundAdvancedLogging:
    roll_info: Optional[AttackRollInfo] = None
    min_damage: int = 0
    max_damage: int = 0
    armor_reduction: int = 0
    delay_time: int = 0
    since_last_swing: int = 0
    net_damage_multiplier: float = 1.0
    scaled_damage: float = 0.0
    scaled_armor_reduction: float = 0.0
    max_damage_reduction: float = 0.0
    dps_scaler: float = 1.0
    mod_damage_taken: float = 1.0
    mod_damage_done: float = 1.0

