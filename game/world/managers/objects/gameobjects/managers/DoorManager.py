import time

from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from utils.constants.MiscCodes import GameObjectStates
from utils.constants.MiscFlags import GameObjectFlags
from utils.constants.UpdateFields import GameObjectFields


class DoorManager(GameObjectManager):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.start_open_state = False
        self.auto_close_secs = 0
        self.no_damage_immune = 0
        self.total_cooldown = 0

    # override
    def initialize_from_gameobject_template(self, gobject_template):
        super().initialize_from_gameobject_template(gobject_template)
        self.start_open_state = self.get_data_field(0, bool)
        self.lock = self.get_data_field(1, int)
        self.auto_close_secs = self.get_data_field(2, int)  # (65536 * seconds) (e.g. open after 5min = 19660800)
        self.no_damage_immune = self.get_data_field(3, int)

    # override
    def update(self, now):
        if now > self.last_tick > 0:
            if self.is_active_object():
                # Check if we need to reset the original door state.
                if self.is_active() and super().check_cooldown(now):
                    self.reset_door_state()
        super().update(now)

    # override
    def use(self, player=None, target=None, from_script=False):
        if not super().check_cooldown(time.time()):
            return

        self.switch_door_state(True)
        self.set_cooldown(time.time())

        if not from_script:
            self.trigger_script(player)

        super().use(player, target, from_script)

    def reset_door_state(self):
        self.switch_door_state(active=False)
        self.total_cooldown = 0

    def switch_door_state(self, active=True, alternative=False):
        self.set_flag(GameObjectFlags.IN_USE, active)

        if self.state == GameObjectStates.GO_STATE_READY:  # Closed
            self.set_active(alternative=alternative)
        else:
            self.set_ready()

    # override
    def get_door_state_update_bytes(self):
        if self.state == GameObjectStates.GO_STATE_READY:
            return None
        # Send real GO state for doors after create packet.
        return self.get_single_field_update_bytes(GameObjectFields.GAMEOBJECT_STATE, self.state)

    # override
    def get_auto_close_time(self):
        return self.auto_close_secs / 0x10000

    # override
    def set_cooldown(self, now):
        self.total_cooldown = now + self.get_auto_close_time()

    # override
    def get_cooldown(self):
        return self.total_cooldown
