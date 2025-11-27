import time

from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager


class TrapManager(GameObjectManager):
    TRIGGERED_BY_CREATURES = {
        3355  # zzOldSnare Trap Effect (Snare Trap 1499)
    }

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.level_min = 0
        self.radius = 0
        # Can only be 0 (Infinite Trigger) or 1 (Should despawn after trigger).
        self.charges = 0
        self.cooldown = 0
        self.auto_close_secs = 0
        self.start_delay = 0
        self.total_cooldown = 0

    # override
    def initialize_from_gameobject_template(self, gobject_template):
        super().initialize_from_gameobject_template(gobject_template)
        self.lock = self.get_data_field(0, int)
        self.level_min = self.get_data_field(1, int)
        self.radius = self.get_data_field(2, float) / 2.0
        self.spell_id = self.get_data_field(3, int)
        # Can only be 0 (Infinite Trigger) or 1 (Should despawn after trigger).
        self.charges = self.get_data_field(4, int)
        self.cooldown = self.get_data_field(5, int)
        self.auto_close_secs = self.get_data_field(6, int)
        self.start_delay = self.get_data_field(7, int)
        self.total_cooldown = time.time() + self.cooldown + self.start_delay

    # override
    def update(self, now):
        if now > self.last_tick > 0:
            if self.is_active_object():
                self._update()

        super().update(now)

    def _update(self):
        if not self._is_triggered_by_proximity():
            return

        if not self.spell_id:
            return

        # Infinite trigger, set go as ready until triggered.
        if not self.charges and not self.is_ready():
            self.set_ready()

        # If the trap should be triggered by creatures, search for them along with players.
        if self.spell_id in TrapManager.TRIGGERED_BY_CREATURES:
            creatures, players = self.get_map().get_surrounding_units_by_location(self.location, self.map_id,
                                                                                  self.instance_id, self.radius,
                                                                                  include_players=True)
            units = creatures | players
        else:
            # This trap can only be triggered by players.
            units = self.get_map().get_surrounding_players_by_location(self.location, self.map_id, self.instance_id,
                                                                       self.radius)

        for unit in units.values():
            if not self.use(unit=unit):
                break

    # override
    def use(self, unit=None, target=None, from_script=False):
        if not super().check_cooldown(time.time()):
            return False

        self.set_active()
        self.cast_spell(self.spell_id, unit)
        if self.has_custom_animation():
            self.send_custom_animation(0)
        if self.charges == 1:
            self.despawn()
            return False

        super().use(unit, target, from_script)
        return True

    # override
    def get_auto_close_time(self):
        return self.auto_close_secs / 0x10000

    # override
    def get_cooldown(self):
        return self.total_cooldown

    # override
    def set_cooldown(self, now):
        self.total_cooldown = now + self.cooldown + self.start_delay

    def _is_triggered_by_proximity(self):
        return self.radius > 0
