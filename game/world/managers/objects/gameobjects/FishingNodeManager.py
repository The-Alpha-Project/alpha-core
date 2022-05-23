import time
from random import randint

from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import GameObjectStates
from utils.constants.OpCodes import OpCode


class FishingNodeManager(object):
    def __init__(self, fishing_node):
        self.fishing_node = fishing_node
        self.fishing_timer = randint(1, 21)
        self.became_active_time = 0

    # TODO: Chance, SMSG_FISH_ESCAPED.
    def try_hook_attempt(self, player):
        if self.fishing_node.state != GameObjectStates.GO_STATE_ACTIVE:
            result = False
        elif self.fishing_timer > 0:
            result = False
        else:
            diff = time.time() - self.became_active_time
            result = diff < 1.3  # Reaction time, find proper value.

        # Notify error to player.
        if not result:
            FishingNodeManager._notify_not_hooked(player)

        return result

    @staticmethod
    def _notify_not_hooked(player):
        player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FISH_NOT_HOOKED))

    def update(self, elapsed):
        if self.fishing_timer > 0:
            self.fishing_timer = max(0, self.fishing_timer - elapsed)

            # Activate fishing node.
            if self.fishing_timer <= 0:
                self.fishing_node.send_custom_animation(0)
                self.became_active_time = time.time()
                self.fishing_node.set_active()
