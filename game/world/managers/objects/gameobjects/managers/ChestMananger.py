from game.world.managers.objects.gameobjects.GameObjectLootManager import GameObjectLootManager
from utils.constants.MiscFlags import GameObjectFlags
from utils.constants.UnitCodes import UnitFlags
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager


class ChestManager(GameObjectManager):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.restock_time = 0  # TODO.
        self.event_id = 0
        self.linked_trap = 0
        self.quest_id = 0
        self.level_min = 0

    # override
    def initialize_from_gameobject_template(self, gobject_template):
        super().initialize_from_gameobject_template(gobject_template)
        self.lock = self.get_data_field(0, int)
        self.restock_time = self.get_data_field(2, int)
        self.event_id = self.get_data_field(6, int)
        self.linked_trap = self.get_data_field(7, int)
        self.quest_id = self.get_data_field(8, int)
        self.level_min = self.get_data_field(9, int)
        self.loot_manager = GameObjectLootManager(self)

    # override
    def use(self, player=None, target=None, from_script=False):
        # Activate chest open animation, while active, it won't let any other player loot.
        self.set_active()
        self.set_flag(GameObjectFlags.IN_USE, True)

        if player:
            # Player kneel loot.
            player.set_unit_flag(UnitFlags.UNIT_FLAG_LOOTING, active=True)

            # Generate loot if it's empty.
            if not self.loot_manager.has_loot():
                self.loot_manager.generate_loot(player)

            player.send_loot(self.loot_manager)

            if self.quest_id:
                player.quest_manager.handle_goober_use(self, self.quest_id)

            if not from_script:
                self.trigger_script(player)

            if self.linked_trap:
                self.trigger_linked_trap(self.linked_trap, player)

        super().use(player, target, from_script)
