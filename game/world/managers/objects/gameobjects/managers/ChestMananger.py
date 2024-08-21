from utils.constants.MiscCodes import GameObjectStates
from utils.constants.UnitCodes import UnitFlags
from utils.constants.UpdateFields import UnitFields


class ChestManager:

    def __init__(self, chest_object):
        self.chest_object = chest_object
        self.lock = chest_object.gobject_template.data0
        self.restock_time = chest_object.gobject_template.data2
        self.min_restock = chest_object.gobject_template.data4
        self.max_restock = chest_object.gobject_template.data5
        self.linked_trap = chest_object.gobject_template.data7
        self.quest_id = chest_object.gobject_template.data8
        self.level_min = chest_object.gobject_template.data9

    def use_chest(self, player):
        # Activate chest open animation, while active, it won't let any other player loot.
        if self.chest_object.state == GameObjectStates.GO_STATE_READY:
            self.chest_object.set_state(GameObjectStates.GO_STATE_ACTIVE)

        # Player kneel loot.
        player.unit_flags |= UnitFlags.UNIT_FLAG_LOOTING
        player.set_uint32(UnitFields.UNIT_FIELD_FLAGS, player.unit_flags)

        # Generate loot if it's empty.
        if not self.chest_object.loot_manager.has_loot():
            self.chest_object.loot_manager.generate_loot(player)

        player.send_loot(self.chest_object.loot_manager)

        if self.quest_id:
            player.quest_manager.handle_goober_use(self.chest_object, self.quest_id)

        if self.linked_trap:
            self.chest_object.trigger_linked_trap(self.linked_trap, player)
