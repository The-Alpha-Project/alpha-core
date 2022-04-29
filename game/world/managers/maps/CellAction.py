from __future__ import annotations

from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
    from game.world.managers.objects.units.player.PlayerManager import PlayerManager


class CellAction:

    # override
    def on_player_in_cell(self, player: PlayerManager):
        pass

    # override
    def on_creature_in_cell(self, creature: CreatureManager):
        pass
