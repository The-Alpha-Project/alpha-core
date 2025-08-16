import math
import random

from game.world.managers.objects.gameobjects.GameObjectLootManager import GameObjectLootManager
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from utils.constants.MiscFlags import GameObjectFlags
from utils.constants.UnitCodes import UnitFlags


class MiningNodeManager(GameObjectManager):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.min_restock = 0
        self.max_restock = 0
        self.level_min = 0
        self.attempts = 0

    # override
    def initialize_from_gameobject_template(self, gobject_template):
        super().initialize_from_gameobject_template(gobject_template)
        self.lock = self.get_data_field(0, int)
        self.min_restock = self.get_data_field(4, int)
        self.max_restock = self.get_data_field(5, int)
        self.level_min = self.get_data_field(9, int)
        self.loot_manager = GameObjectLootManager(self)

    # override
    def use(self, unit=None, target=None, from_script=False):
        # Activate chest open animation, while active, it won't let any other player loot.
        self.set_active()
        self.set_flag(GameObjectFlags.IN_USE, True)

        if unit:
            # Unit kneel loot.
            unit.set_unit_flag(UnitFlags.UNIT_FLAG_LOOTING, active=True)

            if unit.is_player():
                # Generate loot if it's empty.
                if not self.loot_manager.has_loot():
                    self.loot_manager.generate_loot(unit)

                unit.send_loot(self.loot_manager)

    # override
    def handle_loot_release(self, player):
        self.attempts += 1
        amount_rate = 1.0
        min_amount = self.min_restock * amount_rate
        max_amount = self.max_restock * amount_rate

        # Max attempts, despawn.
        if self.attempts >= max_amount:
            self.despawn()
            return

        # 100% chance until min uses.
        if self.attempts < min_amount:
            self.set_ready()
            self.set_flag(GameObjectFlags.IN_USE, False)
            self.loot_manager.generate_loot(player)
            return

        chance_rate = 1.0
        required_value = 175
        if self.unlock_result:
            required_value = self.unlock_result.required_skill_value
        skill_total = player.skill_manager.get_total_skill_value(186) / (required_value + 25)
        chance = math.pow(0.8 * chance_rate, 4 * (1 / self.max_restock) * self.attempts)
        succeed_roll = 100.0 * chance + skill_total > random.uniform(0.0, 99.9999999)

        # Failed chance roll, despawn.
        if not succeed_roll:
            self.despawn()
            return

        # Node still alive, regenerate loot.
        self.set_ready()
        self.set_flag(GameObjectFlags.IN_USE, False)
        self.loot_manager.generate_loot(player)
