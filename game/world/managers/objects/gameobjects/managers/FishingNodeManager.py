import time
from random import randint

from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import GameObjectStates, ObjectTypeFlags
from utils.constants.OpCodes import OpCode


FISHING_CHANNEL_TIME = 30  # Extracted from SpellDuration.dbc (with ID 9).
FISHING_REACTION_TIME = 2.0  # TODO: Reaction time, guessed value.


class FishingNodeManager:
    def __init__(self, fishing_node):
        self.fishing_node = fishing_node
        # TODO: Is this the correct approach for splash generation?
        self.fishing_timer = randint(1, int(FISHING_CHANNEL_TIME - FISHING_REACTION_TIME))
        self.became_active_time = 0
        self.hook_result = False
        self.got_away = False

        # Set channel object update field.
        if fishing_node.summoner and fishing_node.summoner.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            fishing_node.summoner.set_channel_object(fishing_node.guid)

    def fishing_node_use(self, player):
        # Generate loot if it's empty.
        if not self.fishing_node.loot_manager.has_loot():
            self.fishing_node.loot_manager.generate_loot(player)

        if self.fishing_node.fishing_node_manager.try_hook_attempt(player):
            player.send_loot(self.fishing_node.loot_manager)

        # Remove cast.
        player.spell_manager.remove_cast_by_id(self.fishing_node.spell_id)

    def try_hook_attempt(self, player):
        if self.fishing_node.state != GameObjectStates.GO_STATE_ACTIVE:
            self.hook_result = False
        elif self.fishing_timer > 0:
            self.hook_result = False
        elif not self.fishing_node.loot_manager.has_loot() or not FishingNodeManager.roll_chance(player):
            self.got_away = True
            self.hook_result = False
        else:
            diff = time.time() - self.became_active_time
            self.hook_result = diff < FISHING_REACTION_TIME

        # Notify error to player.
        if not self.hook_result:
            if self.got_away:
                FishingNodeManager._notify_got_away(player)
            else:
                FishingNodeManager._notify_not_hooked(player)

        return self.hook_result

    @staticmethod
    def roll_chance(player):
        return player.skill_manager.handle_fishing_attempt_chance()

    @staticmethod
    def _notify_got_away(player):
        player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FISH_ESCAPED))

    @staticmethod
    def _notify_not_hooked(player):
        player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FISH_NOT_HOOKED))

    def update(self, elapsed):
        if not self.fishing_timer:
            return
        self.fishing_timer = max(0, self.fishing_timer - elapsed)
        if self.fishing_timer:
            return
        # Became active this tick, activate fishing node.
        self.fishing_node.send_custom_animation(0)
        self.became_active_time = time.time()
        self.fishing_node.set_active()
