class TrapManager:
    TRIGGERED_BY_CREATURES = {
        3355  # zzOldSnare Trap Effect (Snare Trap 1499)
    }

    def __init__(self, trap_object):
        self.trap_object = trap_object
        self.lock = trap_object.gobject_template.data0
        self.level_min = trap_object.gobject_template.data1
        self.radius = trap_object.gobject_template.data2 / 2.0
        self.spell_id = trap_object.gobject_template.data3
        # Can only be 0 (Infinite Trigger) or 1 (Should despawn after trigger).
        self.charges = trap_object.gobject_template.data4
        self.cooldown = 1 if not trap_object.gobject_template.data5 else trap_object.gobject_template.data5
        self.start_delay = trap_object.gobject_template.data7
        self.remaining_cooldown = self.start_delay

    def is_ready(self):
        return self.remaining_cooldown == 0

    def _is_triggered_by_proximity(self):
        return self.radius > 0

    def update(self, elapsed):
        if not self._is_triggered_by_proximity():
            return

        if not self.is_ready():
            # Infinite trigger, set go as ready until triggered.
            if not self.charges:
                self.trap_object.set_ready()
            self.remaining_cooldown = max(0, self.remaining_cooldown - elapsed)
            return

        # If the trap should be triggered by creatures, search for them along with players.
        if self.spell_id in TrapManager.TRIGGERED_BY_CREATURES:
            surrounding_creatures, surrounding_players = self.trap_object.get_map().get_surrounding_units_by_location(
                self.trap_object.location, self.trap_object.map_id, self.trap_object.instance_id,
                self.radius, include_players=True)
            surrounding_units = surrounding_creatures | surrounding_players
        else:
            # This trap can only be triggered by players.
            surrounding_units = self.trap_object.get_map().get_surrounding_players_by_location(
                self.trap_object.location, self.trap_object.map_id, self.trap_object.instance_id, self.radius)

        for unit in surrounding_units.values():
            # Keep looping until we find a valid unit.
            if not self.trap_object.can_attack_target(unit):
                continue
            self.trigger(unit)
            break

        self.remaining_cooldown = self.cooldown

    def trigger(self, who):
        self.trap_object.set_active()
        self.trap_object.cast_spell(self.spell_id, who)
        if self.charges == 1:
            self.trap_object.despawn()
