from utils.constants.SpellCodes import SpellTargetMask


class TrapManager:
    TRIGGERED_BY_CREATURES = {
        3355  # zzOldSnare Trap Effect
    }

    def __init__(self, trap_object):
        self.trap_object = trap_object
        self.spell_id = trap_object.gobject_template.data3
        # Can only be 0 (infinite triggering) or 1 (should despawn after the trigger).
        self.charges = trap_object.gobject_template.data4
        self.cooldown = trap_object.gobject_template.data5
        # If cooldown was 0, initialize to 1.
        self.cooldown = 1 if not self.cooldown else self.cooldown
        self.start_delay = trap_object.gobject_template.data7
        self.remaining_cooldown = self.start_delay
        self.radius = trap_object.gobject_template.data2 / 2.0
        # If no diameter is defined, use 2.5 yd as radius by default as it seems to be the most common value among traps
        # that have one defined.
        self.radius = 2.5 if not self.radius else self.radius  # If radius was 0, initialize to 2.5.

    def is_ready(self):
        return self.remaining_cooldown == 0

    def update(self, elapsed):
        if not self.is_ready():
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

            # Valid target found, trigger the trap. In case charges = 1, despawn the trap.
            if self.trigger(unit) and self.charges == 1:
                self.trap_object.set_active()
                self.trap_object.despawn()
            break

    def trigger(self, who):
        self.trap_object.spell_manager.handle_cast_attempt(self.spell_id, who, SpellTargetMask.UNIT, validate=True)
        self.remaining_cooldown = self.cooldown
        return True

    def reset(self):
        self.remaining_cooldown = self.start_delay
