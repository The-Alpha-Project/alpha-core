from dataclasses import dataclass
from typing import Optional

from database.dbc.DbcModels import Spell
from game.world.managers.objects.units.UnitManager import UnitManager


@dataclass
class PendingSpellCast:
    spell: Optional[Spell] = None
    target: Optional[UnitManager] = None
    autocast: bool = False
    required_range: float = 0.0

    def reset(self):
        self.spell = None
        self.target = None
        self.autocast = False
        self.required_range = 0.0

    def clear_spell(self):
        self.spell = None
        self.target = None
        self.autocast = False
        self.required_range = 0.0
