import math
import random

from game.world.managers.objects.gameobjects.GameObjectLootManager import GameObjectLootManager
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from game.world.managers.objects.units.player import SkillManager
from utils.constants.MiscFlags import GameObjectFlags
from utils.constants.UnitCodes import UnitFlags


# TODO: Chests that have a hostile faction toward the player should make a surrounding call for help upon use.
class ChestManager(GameObjectManager):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        # Chest fields.
        self.restock_time = 0 # TODO: Implement logic?
        self.event_id = 0
        self.linked_trap = 0
        self.quest_id = 0
        self.level_min = 0

        # Mining node fields.
        self.is_mining_node = False
        self.min_restock = 0
        self.max_restock = 0
        self.attempts = 0

    # override
    def initialize_from_gameobject_template(self, gobject_template):
        super().initialize_from_gameobject_template(gobject_template)

        self.lock = self.get_data_field(0, int)

        # Chest fields.
        self.restock_time = self.get_data_field(2, int)
        self.event_id = self.get_data_field(6, int)
        self.linked_trap = self.get_data_field(7, int)
        self.quest_id = self.get_data_field(8, int)
        self.level_min = self.get_data_field(9, int)

        # Mining node detection logic (maxRestock exists and is bigger than minRestock).
        data4 = self.get_data_field(4, int)
        data5 = self.get_data_field(5, int)
        self.is_mining_node = (data4 != 0 and data5 > data4)

        if self.is_mining_node:
            self.min_restock = data4
            self.max_restock = data5

        self.loot_manager = GameObjectLootManager(self)

    # override
    def use(self, unit=None, target=None, from_script=False):
        # Activate chest open animation, while active, it won't let any other player loot.
        self.set_active()
        self.set_flag(GameObjectFlags.IN_USE, True)

        if unit:
            # Player kneels to loot.
            unit.set_unit_flag(UnitFlags.UNIT_FLAG_LOOTING, active=True)

            if unit.is_player():
                # Generate loot if empty.
                if not self.loot_manager.has_loot():
                    self.loot_manager.generate_loot(unit)

                unit.send_loot(self.loot_manager)

                # Chest-only quest logic.
                if not self.is_mining_node and self.quest_id:
                    unit.quest_manager.handle_goober_use(self, self.quest_id)

            # Chest-only script trigger.
            if not self.is_mining_node and not from_script and self.has_script():
                self.trigger_script(unit)

            # Chest-only trap logic.
            if not self.is_mining_node and self.linked_trap:
                self.trigger_linked_trap(self.linked_trap, unit)

        super().use(unit, target, from_script)

    # override
    def handle_loot_release(self, player):
        # If chest: nothing special.
        # If mining node: mining node depletion logic.
        if not self.is_mining_node:
            super().handle_loot_release(self)
            return

        # --- Mining node logic starts here. ---
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

        # Chance-based remaining uses.
        chance_rate = 1.0
        required_value = 175
        if self.unlock_result:
            required_value = self.unlock_result.required_skill_value

        skill_total = player.skill_manager.get_total_skill_value(SkillManager.SkillTypes.MINING) / (required_value + 25)
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
