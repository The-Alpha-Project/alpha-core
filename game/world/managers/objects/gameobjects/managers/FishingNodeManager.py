import time
from random import randint

from game.world.managers.objects.gameobjects.GameObjectLootManager import GameObjectLootManager
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import GameObjectStates
from utils.constants.OpCodes import OpCode

FISHING_CHANNEL_TIME = 30  # Extracted from SpellDuration.dbc (with ID 9).
FISHING_REACTION_TIME = 2.0  # TODO: Reaction time, guessed value.


class FishingNodeManager(GameObjectManager):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # TODO: Is this the correct approach for splash generation?
        self.fishing_timer = randint(1, int(FISHING_CHANNEL_TIME - FISHING_REACTION_TIME))
        self.became_active_time = 0
        self.hook_result = False
        self.got_away = False

    # override
    def initialize_from_gameobject_template(self, gobject_template):
        super().initialize_from_gameobject_template(gobject_template)
        self.loot_manager = GameObjectLootManager(self)

    # override
    def update(self, now):
        if now > self.last_tick > 0:
            if self.is_active_object():
                elapsed = now - self.last_tick
                self._update(elapsed)
        super().update(now)

    def _update(self, elapsed):
        if not self.fishing_timer:
            return
        self.fishing_timer = max(0, self.fishing_timer - elapsed)
        if self.fishing_timer:
            return
        # Became active this tick, activate fishing node.
        self.became_active_time = time.time()
        self.set_active(force=True)  # Since hook is time sensitive, force the update immediately.
        self.send_custom_animation(0)

    # override
    def use(self, player=None, target=None, from_script=False):
        # Generate loot if it's empty.
        if not self.loot_manager.has_loot():
            self.loot_manager.generate_loot(player)

        if player:
            if self.try_hook_attempt(player):
                player.send_loot(self.loot_manager)
            # Remove cast.
            player.spell_manager.remove_cast_by_id(self.spell_id)

        super().use(player, target, from_script)

    def try_hook_attempt(self, player):
        if self.state != GameObjectStates.GO_STATE_ACTIVE:
            self.hook_result = False
        elif self.fishing_timer > 0:
            self.hook_result = False
        elif not self.loot_manager.has_loot() or not FishingNodeManager.roll_chance(player):
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

    # override
    def handle_loot_release(self, player):
        # On loot release, always despawn the fishing bobber regardless of it still having loot or not.
        self.despawn()

    @staticmethod
    def roll_chance(player):
        return player.skill_manager.handle_fishing_attempt_chance()

    @staticmethod
    def _notify_got_away(player):
        player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FISH_ESCAPED))

    @staticmethod
    def _notify_not_hooked(player):
        player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FISH_NOT_HOOKED))
