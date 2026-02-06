from dataclasses import dataclass


@dataclass
class SpellAdvancedLogging:
    min_damage: int = 0
    max_damage: int = 0
    net_damage_multiplier: float = 1.0
    scaled_damage: float = 0.0
    crit_roll_needed: float = 0.0
    crit_roll: float = 0.0
    max_damage_reduction: float = 0.0
    scaled_armor_reduction: float = 0.0
    aura_effect_id: int = 0
    hit_roll_needed: float = 0.0
    hit_roll: float = 0.0
    damage_type: int = 0
    resistance_coefficient: float = 0.0
