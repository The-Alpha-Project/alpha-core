import time

from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from utils.constants.MiscFlags import GameObjectFlags


class GooberManager(GameObjectManager):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.quest_id = 0
        self.event_id = 0
        self.auto_close_secs = 0
        self._has_custom_animation = False
        self.is_consumable = False
        self.cooldown = 0
        self.page_text = 0
        self.total_cooldown = 0

    # override
    def initialize_from_gameobject_template(self, gobject_template):
        super().initialize_from_gameobject_template(gobject_template)
        self.lock = self.get_data_field(0, int)
        self.quest_id = self.get_data_field(1, int)
        self.event_id = self.get_data_field(2, int)
        self.auto_close_secs = self.get_data_field(3, int)
        self._has_custom_animation = self.get_data_field(4, bool)
        self.is_consumable = self.get_data_field(5, bool)
        self.cooldown = self.get_data_field(6, int)
        self.page_text = self.get_data_field(7, int)
        self.total_cooldown = time.time() + self.cooldown

    # override
    def use(self, player=None, target=None, from_script=False):
        if not super().check_cooldown(time.time()):
            return

        if self.is_consumable:
            self.despawn()

        if player:
            if self.page_text:
                self.send_page_text(player)

            # Check if object needed for given/any quest.
            player.quest_manager.handle_goober_use(self, self.quest_id)

            if not from_script:
                self.trigger_script(player)

        self.set_flag(GameObjectFlags.IN_USE, state=True)

        time_to_restore = self.get_auto_close_time()

        if self.has_custom_animation() or self._has_custom_animation and time_to_restore:
            self.send_custom_animation(0)
        else:
            self.set_active()

        self.cooldown = time_to_restore + time.time()

        if self.spell_id:
            self.cast_spell(self.spell_id, player)

        super().use(player, target, from_script)

    # override
    def has_custom_animation(self):
        if self._has_custom_animation:
            return True
        return super().has_custom_animation()

    # override
    def get_auto_close_time(self):
        return self.auto_close_secs / 0x10000

    # override
    def get_cooldown(self):
        return self.total_cooldown

    # override
    def set_cooldown(self, now):
        self.total_cooldown = now + self.cooldown
