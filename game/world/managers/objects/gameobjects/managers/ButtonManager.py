import time

from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from utils.constants.MiscCodes import GameObjectStates
from utils.constants.MiscFlags import GameObjectFlags


class ButtonManager(GameObjectManager):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.start_open_state = False
        self.auto_close_secs = 0
        self.linked_trap = 0
        self.total_cooldown = 0

    # override
    def update(self, now):
        if now > self.last_tick > 0:
            if self.is_active_object():
                # Check if we need to reset the original button state.
                if self.is_active() and super().check_cooldown(now):
                    self.reset_button_state()
            super().update(now)

    # override
    def initialize_from_gameobject_template(self, gobject_template):
        super().initialize_from_gameobject_template(gobject_template)
        self.start_open_state = self.get_data_field(0, bool)
        self.lock = self.get_data_field(1, int)
        self.auto_close_secs = self.get_data_field(2, int)  # (65536 * seconds) (e.g. open after 5min = 19660800)
        self.linked_trap = self.get_data_field(3, int)

    # override
    def use(self, player=None, target=None, from_script=False):
        if not super().check_cooldown(time.time()):
            return

        self.switch_button_state(True)
        self.set_cooldown(time.time())

        if not from_script:
            self.trigger_script(player)

        if self.linked_trap and player:
            self.trigger_linked_trap(self.linked_trap, player)

        super().use(player, target, from_script)

    def reset_button_state(self):
        self.switch_button_state(active=False)
        self.total_cooldown = 0

    def switch_button_state(self, active=True, alternative=False):
        self.set_flag(GameObjectFlags.IN_USE, active)

        if self.state == GameObjectStates.GO_STATE_READY:  # Closed
            self.set_active(alternative=alternative)
        else:
            self.set_ready()

    # override
    def get_auto_close_time(self):
        return self.auto_close_secs / 0x10000

    # override
    def set_cooldown(self, now):
        self.total_cooldown = now + self.get_auto_close_time()

    # override
    def get_cooldown(self):
        return self.total_cooldown
