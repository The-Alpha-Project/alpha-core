from dataclasses import dataclass


@dataclass
class AttackRollInfo:
    miss_roll: float = 0.0
    miss_roll_needed: float = 0.0
    crit_roll: float = 0.0
    crit_roll_needed: float = 0.0
    dodge_roll: float = 0.0
    dodge_roll_needed: float = 0.0
    parry_roll: float = 0.0
    parry_roll_needed: float = 0.0
    block_roll: float = 0.0
    block_roll_needed: float = 0.0
    stun_roll: float = 0.0
    stun_roll_needed: float = 0.0

